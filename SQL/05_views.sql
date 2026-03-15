CREATE OR REPLACE VIEW acn_profile_export AS
SELECT
    o.name AS organization_name,
    o.nis_category,
    s.name AS service_name,
    s.category AS service_category,
    a.name AS asset_name,
    a.category AS asset_category,
    t.name AS third_party_name,
    t.type AS third_party_type,
    d.dependency_type,
    p.first_name || ' ' || p.last_name AS contact_name,
    p.email AS contact_email,
    r.responsibility_type
FROM organization o
LEFT JOIN service s ON s.organization_id = o.organization_id AND s.is_current = TRUE
LEFT JOIN service_asset sa ON sa.service_id = s.service_id
LEFT JOIN asset a ON a.asset_id = sa.asset_id AND a.is_current = TRUE
LEFT JOIN dependency d ON d.organization_id = o.organization_id AND d.is_current = TRUE
LEFT JOIN third_party t ON t.third_party_id = d.third_party_id
LEFT JOIN responsibility r ON r.organization_id = o.organization_id AND r.is_current = TRUE
LEFT JOIN person p ON p.person_id = r.person_id;
