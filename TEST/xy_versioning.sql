--QUERY PER TESTARE IL VERSIONING

--Modifica asset → crea nuova versione
UPDATE nis2.asset
SET criticality_level = 'medio'
WHERE asset_id = 1 AND is_current = TRUE;


--Modifica servizio → crea nuova versione
UPDATE nis2.service
SET status = 'manutenzione'
WHERE service_id = 3 AND is_current = TRUE;

--Modifica dipendenza → nuova versione
UPDATE nis2.dependency
SET dependency_type = 'backup avanzato'
WHERE dependency_id = 1 AND is_current = TRUE;


--Modifica responsabilità → nuova versione
UPDATE nis2.responsibility
SET responsibility_type = 'service owner'
WHERE responsibility_id = 2 AND is_current = TRUE;


--