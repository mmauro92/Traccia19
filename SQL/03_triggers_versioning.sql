-- =========================================================
-- Trigger per gestire versioning/storico
-- =========================================================

SET search_path TO nis2, public;

-- -------------------------
-- ASSET versioning
-- -------------------------
CREATE OR REPLACE FUNCTION nis2.asset_versioning()
RETURNS TRIGGER AS $$
BEGIN
    -- 1) Chiude la versione precedente
    UPDATE nis2.asset
    SET valid_to = NOW(),
        is_current = FALSE
    WHERE asset_id = OLD.asset_id
      AND valid_to IS NULL
      AND is_current = TRUE;

    -- 2) Inserisce la nuova versione
    INSERT INTO nis2.asset (
        organization_id, name, description, category,
        criticality_level, location, status,
        valid_from, valid_to, is_current
    )
    VALUES (
        OLD.organization_id,
        COALESCE(NEW.name, OLD.name),
        COALESCE(NEW.description, OLD.description),
        COALESCE(NEW.category, OLD.category),
        COALESCE(NEW.criticality_level, OLD.criticality_level),
        COALESCE(NEW.location, OLD.location),
        COALESCE(NEW.status, OLD.status),
        NOW(),
        NULL,
        TRUE
    );

    RETURN NULL; -- impedisce l'UPDATE originale
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_asset_versioning ON nis2.asset;

CREATE TRIGGER trg_asset_versioning
AFTER UPDATE ON nis2.asset
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.asset_versioning();


-- -------------------------
-- SERVICE versioning
-- -------------------------
CREATE OR REPLACE FUNCTION nis2.service_versioning()
RETURNS TRIGGER AS $$
BEGIN
    -- 1) Chiude la versione precedente
    UPDATE nis2.service
    SET valid_to = NOW(),
        is_current = FALSE
    WHERE service_id = OLD.service_id
      AND valid_to IS NULL
      AND is_current = TRUE;

    -- 2) Inserisce la nuova versione
    INSERT INTO nis2.service (
        organization_id, name, description, category,
        criticality_level, status,
        valid_from, valid_to, is_current
    )
    VALUES (
        OLD.organization_id,
        COALESCE(NEW.name, OLD.name),
        COALESCE(NEW.description, OLD.description),
        COALESCE(NEW.category, OLD.category),
        COALESCE(NEW.criticality_level, OLD.criticality_level),
        COALESCE(NEW.status, OLD.status),
        NOW(),
        NULL,
        TRUE
    );

    RETURN NULL; -- impedisce l'UPDATE originale
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS trg_service_versioning ON nis2.service;

CREATE TRIGGER trg_service_versioning
AFTER UPDATE ON nis2.service
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.service_versioning();

-- -------------------------
-- DEPENDENCY versioning
-- -------------------------
CREATE OR REPLACE FUNCTION nis2.dependency_versioning()
RETURNS TRIGGER AS $$
BEGIN
    -- 1) Chiude la versione precedente
    UPDATE nis2.dependency
    SET valid_to = NOW(),
        is_current = FALSE
    WHERE dependency_id = OLD.dependency_id
      AND valid_to IS NULL
      AND is_current = TRUE;

    -- 2) Inserisce la nuova versione
    INSERT INTO nis2.dependency (
        organization_id, third_party_id, service_id, asset_id,
        dependency_type, description,
        valid_from, valid_to, is_current
    )
    VALUES (
        OLD.organization_id,
        COALESCE(NEW.third_party_id, OLD.third_party_id),
        COALESCE(NEW.service_id, OLD.service_id),
        COALESCE(NEW.asset_id, OLD.asset_id),
        COALESCE(NEW.dependency_type, OLD.dependency_type),
        COALESCE(NEW.description, OLD.description),
        NOW(),
        NULL,
        TRUE
    );

    RETURN NULL; -- impedisce l'UPDATE originale
END;
$$ LANGUAGE plpgsql;


DROP TRIGGER IF EXISTS trg_dependency_versioning ON nis2.dependency;

CREATE TRIGGER trg_dependency_versioning
AFTER UPDATE ON nis2.dependency
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.dependency_versioning();


-- -------------------------
-- RESPONSIBILITY versioning
-- -------------------------
CREATE OR REPLACE FUNCTION nis2.responsibility_versioning()
RETURNS TRIGGER AS $$
BEGIN
    -- 1) Chiude la versione precedente
    UPDATE nis2.responsibility
    SET valid_to = NOW(),
        is_current = FALSE
    WHERE responsibility_id = OLD.responsibility_id
      AND valid_to IS NULL
      AND is_current = TRUE;

    -- 2) Inserisce la nuova versione
    INSERT INTO nis2.responsibility (
        organization_id, person_id, service_id, asset_id,
        responsibility_type,
        valid_from, valid_to, is_current
    )
    VALUES (
        OLD.organization_id,
        COALESCE(NEW.person_id, OLD.person_id),
        COALESCE(NEW.service_id, OLD.service_id),
        COALESCE(NEW.asset_id, OLD.asset_id),
        COALESCE(NEW.responsibility_type, OLD.responsibility_type),
        NOW(),
        NULL,
        TRUE
    );

    RETURN NULL; -- blocca l'UPDATE originale
END;
$$ LANGUAGE plpgsql;

--------------------------------------------------------------------------
--CREAZIONE TRIGGER DA ESEGUIRE DOPO AVER LANCIATO LA FUNZIONE
--------------------------------------------------------------------------
DROP TRIGGER IF EXISTS trg_responsibility_versioning ON nis2.responsibility;

CREATE TRIGGER trg_responsibility_versioning
AFTER UPDATE ON nis2.responsibility
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.responsibility_versioning();

