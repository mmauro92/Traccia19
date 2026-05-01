-- =========================================================
--: vista che produce un export completo dei dati NIS2/ACN, unificando servizi, asset, terze parti e responsabilità in un unico dataset pronto per la generazione del documento CSV richiesto da ACN.
-- =========================================================
DROP VIEW IF EXISTS nis2.acn_profile_export;
CREATE OR REPLACE VIEW nis2.acn_profile_export AS
SELECT
    o.name AS organization_name,
    o.nis_category,
    -- Servizio
    s.service_id,
    s.name AS service_name,
    s.category AS service_category,
    s.criticality_level AS service_criticality,
    -- Asset collegato al servizio
    a.asset_id,
    a.name AS asset_name,
    a.category AS asset_category,
    a.criticality_level AS asset_criticality,
    -- Terza parte collegata al servizio o all’asset
    t.third_party_id,
    t.name AS third_party_name,
    t.type AS third_party_type,
    d.dependency_type,
    -- Punto di contatto
    p.person_id,
    p.first_name || ' ' || p.last_name AS contact_name,
    p.email AS contact_email,
    r.responsibility_type
FROM nis2.organization o
-- Servizi dell’organizzazione
LEFT JOIN nis2.service s
       ON s.organization_id = o.organization_id
      AND s.is_current = TRUE
-- Asset collegati ai servizi
LEFT JOIN nis2.service_asset sa
       ON sa.service_id = s.service_id
LEFT JOIN nis2.asset a
       ON a.asset_id = sa.asset_id
      AND a.is_current = TRUE
-- Dipendenze (sia per servizi che per asset)
LEFT JOIN nis2.dependency d
       ON d.organization_id = o.organization_id
      AND d.is_current = TRUE
      AND (
            d.service_id = s.service_id
         OR d.asset_id = a.asset_id
      )
LEFT JOIN nis2.third_party t
       ON t.third_party_id = d.third_party_id
-- Responsabilità e punti di contatto
LEFT JOIN nis2.responsibility r
       ON r.organization_id = o.organization_id
      AND r.is_current = TRUE
      AND (
            r.service_id = s.service_id
         OR r.asset_id = a.asset_id
      )
LEFT JOIN nis2.person p
       ON p.person_id = r.person_id;


-- =========================================================
-- vista che confronta il livello di maturità attuale e target per ogni misura ACN, calcolando automaticamente il gap e mostrando scadenze e note rilevanti.
-- =========================================================
DROP VIEW IF EXISTS nis2.vw_gap_analysis;
CREATE VIEW nis2.vw_gap_analysis AS
SELECT
    o.organization_id,
    o.name AS organization_name,
    sm.measure_id,
    sm.code,
    sm.name AS measure_name,
    ml_current.level_value AS current_level,
    ml_target.level_value  AS target_level,
    (ml_target.level_value - ml_current.level_value) AS gap,
    tm.deadline AS target_deadline,
    cm.notes AS current_notes,
    tm.justification AS target_justification
FROM nis2.security_measure sm
LEFT JOIN nis2.current_maturity cm
       ON cm.measure_id = sm.measure_id
      AND cm.is_current = TRUE
LEFT JOIN nis2.maturity_level ml_current
       ON ml_current.level_id = cm.level_id
LEFT JOIN nis2.target_maturity tm
       ON tm.measure_id = sm.measure_id
      AND tm.is_current = TRUE
LEFT JOIN nis2.maturity_level ml_target
       ON ml_target.level_id = tm.target_level_id
LEFT JOIN nis2.organization o
       ON o.organization_id = COALESCE(cm.organization_id, tm.organization_id)
ORDER BY gap DESC NULLS LAST, sm.code;

-- =========================================================
-- vista che esporta il Profilo Target ACN completo, includendo misure, livelli target, azioni di miglioramento e relativi collegamenti a servizi, asset e terze parti.
-- =========================================================
DROP VIEW IF EXISTS nis2.profile_target_export;
CREATE VIEW nis2.profile_target_export AS
SELECT
    o.organization_id,
    o.name AS organization_name,
    -- Misura
    sm.measure_id,
    sm.code AS measure_code,
    sm.name AS measure_name,
    -- Target maturity
    ml_target.level_value AS target_level,
    tm.justification,
    tm.deadline AS target_deadline,
    -- Improvement action
    ia.action_id,
    ia.description AS action_description,
    ia.priority,
    ia.deadline AS action_deadline,
    ia.status AS action_status,
    -- Collegamenti
    s.service_id,
    s.name AS related_service,
    a.asset_id,
    a.name AS related_asset,
    tp.third_party_id,
    tp.name AS related_third_party
FROM nis2.target_maturity tm
JOIN nis2.security_measure sm 
       ON sm.measure_id = tm.measure_id
JOIN nis2.maturity_level ml_target 
       ON ml_target.level_id = tm.target_level_id
JOIN nis2.organization o 
       ON o.organization_id = tm.organization_id
LEFT JOIN nis2.improvement_action ia 
       ON ia.organization_id = tm.organization_id
      AND ia.measure_id = tm.measure_id
LEFT JOIN nis2.service s 
       ON s.service_id = ia.related_service_id
      AND s.is_current = TRUE
LEFT JOIN nis2.asset a 
       ON a.asset_id = ia.related_asset_id
      AND a.is_current = TRUE
LEFT JOIN nis2.third_party tp 
       ON tp.third_party_id = ia.related_third_party_id
WHERE tm.is_current = TRUE
ORDER BY sm.code, ia.priority DESC, ia.deadline;

