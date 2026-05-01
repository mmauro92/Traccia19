-- =========================================================
-- Funzioni per gestire versioning/storico
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

-- -------------------------
-- CURRENT_MATURITY versioning
-- -------------------------
CREATE OR REPLACE FUNCTION nis2.current_maturity_versioning()
RETURNS TRIGGER AS $$
BEGIN
    -- chiude la versione precedente
    UPDATE nis2.current_maturity
    SET valid_to = NOW(),
        is_current = FALSE
    WHERE current_maturity_id = OLD.current_maturity_id
      AND valid_to IS NULL
      AND is_current = TRUE;

    -- inserisce la nuova versione
    INSERT INTO nis2.current_maturity (
        organization_id, measure_id, level_id, notes,
        valid_from, valid_to, is_current
    )
    VALUES (
        OLD.organization_id,
        COALESCE(NEW.measure_id, OLD.measure_id),
        COALESCE(NEW.level_id, OLD.level_id),
        COALESCE(NEW.notes, OLD.notes),
        NOW(),
        NULL,
        TRUE
    );

    RETURN NULL; -- impedisce l'UPDATE originale
END;
$$ LANGUAGE plpgsql;

-- -------------------------
-- TARGET_MATURITY versioning
-- -------------------------
CREATE OR REPLACE FUNCTION nis2.target_maturity_versioning()
RETURNS TRIGGER AS $$
BEGIN
    -- chiude la versione precedente
    UPDATE nis2.target_maturity
    SET valid_to = NOW(),
        is_current = FALSE
    WHERE target_maturity_id = OLD.target_maturity_id
      AND valid_to IS NULL
      AND is_current = TRUE;

    -- inserisce la nuova versione
    INSERT INTO nis2.target_maturity (
        organization_id, measure_id, target_level_id, justification,
        deadline, valid_from, valid_to, is_current, created_at
    )
    VALUES (
        OLD.organization_id,
        COALESCE(NEW.measure_id, OLD.measure_id),
        COALESCE(NEW.target_level_id, OLD.target_level_id),
        COALESCE(NEW.justification, OLD.justification),
        COALESCE(NEW.deadline, OLD.deadline),
        NOW(),
        NULL,
        TRUE,
        COALESCE(NEW.created_at, OLD.created_at)
    );

    RETURN NULL; -- impedisce l'UPDATE originale
END;
$$ LANGUAGE plpgsql;

-- -------------------------
-- IMPROVEMENT_ACTION versioning
-- -------------------------
CREATE OR REPLACE FUNCTION nis2.improvement_action_updated_at()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;