-- =========================================================
-- QUERY 1: Elenco asset critici per una specifica azienda
-- Obiettivo: ottenere tutti gli asset con criticità "alto"
--            appartenenti all'organizzazione indicata.
-- =========================================================

SELECT 
    a.asset_id,
    a.name AS asset_name,
    a.category,
    a.criticality_level,
    a.location,
    a.status,
    a.valid_from
FROM nis2.asset a
WHERE a.organization_id = 1
  AND a.is_current = TRUE
  AND a.criticality_level = 'alto'
ORDER BY a.category, a.name;



-- =========================================================
-- QUERY 2: Servizi erogati e asset associati
-- Obiettivo: mostrare tutti i servizi attivi dell'azienda
--            e gli asset su cui si basano.
-- =========================================================

SELECT 
    s.service_id,
    s.name AS service_name,
    s.category AS service_category,
    s.criticality_level AS service_criticality,
    s.status AS service_status,
    a.asset_id,
    a.name AS asset_name,
    a.category AS asset_category,
    a.location AS asset_location,
    sa.relation_type
FROM nis2.service s
LEFT JOIN nis2.service_asset sa 
       ON sa.service_id = s.service_id
LEFT JOIN nis2.asset a 
       ON a.asset_id = sa.asset_id 
      AND a.is_current = TRUE
WHERE s.organization_id = 1
  AND s.is_current = TRUE
ORDER BY s.name, a.name;


-- =========================================================
-- QUERY 3: Dipendenze da terze parti
-- Obiettivo: elencare tutte le dipendenze esterne
--            (fornitori terzi) per servizi e asset.
-- =========================================================

SELECT 
    d.dependency_id,
    COALESCE(s.name, a.name) AS element_name,
    CASE 
        WHEN d.service_id IS NOT NULL THEN 'Servizio'
        ELSE 'Asset'
    END AS element_type,
    t.name AS third_party_name,
    t.type AS third_party_type,
    t.country AS third_party_country,
    t.contact_email,
    t.contact_phone,
    d.dependency_type,
    d.description,
    d.valid_from
FROM nis2.dependency d
LEFT JOIN nis2.service s 
       ON s.service_id = d.service_id 
      AND s.is_current = TRUE
LEFT JOIN nis2.asset a 
       ON a.asset_id = d.asset_id 
      AND a.is_current = TRUE
JOIN nis2.third_party t 
       ON t.third_party_id = d.third_party_id
WHERE d.organization_id = 1
  AND d.is_current = TRUE
ORDER BY element_type, element_name, third_party_name;



-- =========================================================
-- QUERY 4: Punti di contatto NIS/ACN
-- Obiettivo: ottenere i referenti ufficiali per la NIS2
--            dell'organizzazione.
-- =========================================================

SELECT 
    p.person_id,
    p.first_name,
    p.last_name,
    p.email,
    p.phone,
    p.role_name
FROM nis2.person p
WHERE p.organization_id = 1
  AND p.is_nis_contact = TRUE
ORDER BY p.last_name, p.first_name;

-- =========================================================
-- QUERY 5 : Mappa completa asset → servizi → terze parti
-- Obiettivo: Mostrare la catena di dipendenze ACN.
-- =========================================================

SELECT
    a.asset_id,
    a.name AS asset_name,
    s.service_id,
    s.name AS service_name,
    t.third_party_id,
    t.name AS third_party_name,
    d.dependency_type
FROM nis2.asset a
LEFT JOIN nis2.service_asset sa 
       ON sa.asset_id = a.asset_id
LEFT JOIN nis2.service s 
       ON s.service_id = sa.service_id AND s.is_current = TRUE
LEFT JOIN nis2.dependency d 
       ON (d.service_id = s.service_id OR d.asset_id = a.asset_id)
      AND d.is_current = TRUE
LEFT JOIN nis2.third_party t 
       ON t.third_party_id = d.third_party_id
WHERE a.organization_id = 1
  AND a.is_current = TRUE
ORDER BY a.name, s.name, t.name;

-- =========================================================
-- QUERY 6 : Gap Analysis sintetica (current vs target)
-- Obiettivo:  Mostrare il valore dello schema ACN.
-- =========================================================

SELECT
    sm.code,
    sm.name AS measure_name,
    mlc.level_value AS current_level,
    mlt.level_value AS target_level,
    (mlt.level_value - mlc.level_value) AS gap,
    tm.deadline
FROM nis2.security_measure sm
LEFT JOIN nis2.current_maturity cm 
       ON cm.measure_id = sm.measure_id AND cm.is_current = TRUE
LEFT JOIN nis2.maturity_level mlc 
       ON mlc.level_id = cm.level_id
LEFT JOIN nis2.target_maturity tm 
       ON tm.measure_id = sm.measure_id AND tm.is_current = TRUE
LEFT JOIN nis2.maturity_level mlt 
       ON mlt.level_id = tm.target_level_id
WHERE sm.measure_id >= 1
ORDER BY gap DESC, sm.code;
