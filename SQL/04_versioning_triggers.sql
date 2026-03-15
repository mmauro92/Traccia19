-- -------------------------
-- ASSET TRIGGER
-- -------------------------
DROP TRIGGER IF EXISTS trg_asset_versioning ON nis2.asset;

CREATE TRIGGER trg_asset_versioning
AFTER UPDATE ON nis2.asset
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.asset_versioning();


-- -------------------------
-- SERVICE TRIGGER
-- -------------------------
DROP TRIGGER IF EXISTS trg_service_versioning ON nis2.service;

CREATE TRIGGER trg_service_versioning
AFTER UPDATE ON nis2.service
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.service_versioning();

-- -------------------------
-- DEPENDENCY TRIGGER
-- -------------------------
DROP TRIGGER IF EXISTS trg_dependency_versioning ON nis2.dependency;

CREATE TRIGGER trg_dependency_versioning
AFTER UPDATE ON nis2.dependency
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.dependency_versioning();

-- -------------------------
-- RESPONSIBILITY TRIGGER
-- -------------------------
DROP TRIGGER IF EXISTS trg_responsibility_versioning ON nis2.responsibility;

CREATE TRIGGER trg_responsibility_versioning
AFTER UPDATE ON nis2.responsibility
FOR EACH ROW
WHEN (OLD.is_current = TRUE)
EXECUTE FUNCTION nis2.responsibility_versioning();
