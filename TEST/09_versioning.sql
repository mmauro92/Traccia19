--QUERY PER TESTARE IL VERSIONING

-- Versioning asset (nuova versione)
UPDATE nis2.asset
SET criticality_level = 'basso'
WHERE asset_id = 6 AND is_current = TRUE;

-- Versioning service (nuova versione)
UPDATE nis2.service
SET status = 'manutenzione programmata'
WHERE service_id = 4 AND is_current = TRUE;

-- Versioning dependency (nuova versione)
UPDATE nis2.dependency
SET dependency_type = 'protezione avanzata'
WHERE dependency_id = 5 AND is_current = TRUE;

-- Versioning responsibility (nuova versione)
UPDATE nis2.responsibility
SET responsibility_type = 'risk owner'
WHERE responsibility_id = 5 AND is_current = TRUE;

-- Versioning current_maturity (nuova versione)
UPDATE nis2.current_maturity
SET notes = 'Aggiornato dopo audit interno'
WHERE current_maturity_id = 6 AND is_current = TRUE;

-- Versioning target_maturity (nuova versione)
UPDATE nis2.target_maturity
SET justification = 'Allineamento a nuove policy ACN'
WHERE target_maturity_id = 6 AND is_current = TRUE;

-- Test trigger updated_at su improvement_action
UPDATE nis2.improvement_action
SET status = 'in_progress'
WHERE action_id = 6;



--Query di verifica post-versioning (per testare gli altri versioning basta sostituire asset sia nel FROM che nella WHERE con le altre tabelle service-dependency-responsability-current-maturity-target_maturity)

--Versioni storiche
SELECT *
FROM nis2.asset
WHERE asset_id = 6
ORDER BY valid_from DESC;

--Solo versioni correnti (in questo caso risulta vuoto perchè asset_id=6 è stato chiuso)
SELECT *
FROM nis2.asset
WHERE asset_id = 6 and is_current = TRUE;

--Versioni Chiuse
SELECT *
FROM nis2.asset
WHERE asset_id = 6 AND is_current = FALSE;
