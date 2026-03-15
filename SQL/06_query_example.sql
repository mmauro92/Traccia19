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
    a.status
FROM nis2.asset a
WHERE a.organization_id = 1
  AND a.is_current = TRUE          -- solo versione attiva
  AND a.criticality_level = 'alto' -- asset critici
ORDER BY a.name;


-- =========================================================
-- QUERY 2: Servizi erogati e asset associati
-- Obiettivo: mostrare tutti i servizi attivi dell'azienda
--            e gli asset su cui si basano.
-- =========================================================

SELECT 
    s.service_id,
    s.name AS service_name,
    s.category AS service_category,
    s.criticality_level,
    a.asset_id,
    a.name AS asset_name,
    sa.relation_type
FROM nis2.service s
LEFT JOIN nis2.service_asset sa 
       ON sa.service_id = s.service_id
LEFT JOIN nis2.asset a 
       ON a.asset_id = sa.asset_id AND a.is_current = TRUE
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
    COALESCE(s.name, a.name) AS element_name, -- servizio o asset
    CASE 
        WHEN d.service_id IS NOT NULL THEN 'Servizio'
        ELSE 'Asset'
    END AS element_type,
    t.name AS third_party_name,
    t.type AS third_party_type,
    d.dependency_type,
    d.description
FROM nis2.dependency d
LEFT JOIN nis2.service s 
       ON s.service_id = d.service_id AND s.is_current = TRUE
LEFT JOIN nis2.asset a 
       ON a.asset_id = d.asset_id AND a.is_current = TRUE
JOIN nis2.third_party t 
       ON t.third_party_id = d.third_party_id
WHERE d.organization_id = 1
  AND d.is_current = TRUE
ORDER BY element_type, element_name;


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
