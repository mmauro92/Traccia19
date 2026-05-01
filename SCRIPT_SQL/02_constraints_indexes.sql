-- =========================================================
-- Vincoli di integrità e indici
-- =========================================================

SET search_path TO nis2, public;

-- FK ORGANIZATION
ALTER TABLE asset
    ADD CONSTRAINT fk_asset_org
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE;

ALTER TABLE service
    ADD CONSTRAINT fk_service_org
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE;

ALTER TABLE dependency
    ADD CONSTRAINT fk_dependency_org
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE;

ALTER TABLE person
    ADD CONSTRAINT fk_person_org
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE;

ALTER TABLE target_maturity
   ADD CONSTRAINT fk_tm_org
   FOREIGN KEY (organization_id)
   REFERENCES organization(organization_id)
   ON DELETE CASCADE;

ALTER TABLE responsibility
    ADD CONSTRAINT fk_responsibility_org
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE;

ALTER TABLE current_maturity
    ADD CONSTRAINT fk_cm_org 
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE;

ALTER TABLE improvement_action
    ADD CONSTRAINT fk_ia_org
    FOREIGN KEY (organization_id)
    REFERENCES organization(organization_id)
    ON DELETE CASCADE;

-- FK SERVICE_ASSET
ALTER TABLE service_asset
    ADD CONSTRAINT fk_service_asset_service
    FOREIGN KEY (service_id)
    REFERENCES service(service_id)
    ON DELETE CASCADE;

ALTER TABLE service_asset
    ADD CONSTRAINT fk_service_asset_asset
    FOREIGN KEY (asset_id)
    REFERENCES asset(asset_id)
    ON DELETE CASCADE;

ALTER TABLE improvement_action
    ADD CONSTRAINT fk_ia_asset
    FOREIGN KEY (related_asset_id)
    REFERENCES asset(asset_id)
    ON DELETE SET NULL;
    
-- FK DEPENDENCY
ALTER TABLE dependency
    ADD CONSTRAINT fk_dependency_third_party
    FOREIGN KEY (third_party_id)
    REFERENCES third_party(third_party_id)
    ON DELETE RESTRICT;

ALTER TABLE dependency
    ADD CONSTRAINT fk_dependency_service
    FOREIGN KEY (service_id)
    REFERENCES service(service_id)
    ON DELETE CASCADE;

ALTER TABLE dependency
    ADD CONSTRAINT fk_dependency_asset
    FOREIGN KEY (asset_id)
    REFERENCES asset(asset_id)
    ON DELETE CASCADE;

-- FK RESPONSIBILITY
ALTER TABLE responsibility
    ADD CONSTRAINT fk_responsibility_person
    FOREIGN KEY (person_id)
    REFERENCES person(person_id)
    ON DELETE CASCADE;

ALTER TABLE responsibility
    ADD CONSTRAINT fk_responsibility_service
    FOREIGN KEY (service_id)
    REFERENCES service(service_id)
    ON DELETE CASCADE;

ALTER TABLE responsibility
    ADD CONSTRAINT fk_responsibility_asset
    FOREIGN KEY (asset_id)
    REFERENCES asset(asset_id)
    ON DELETE CASCADE;

-- FK security_measure
ALTER TABLE current_maturity 
    ADD CONSTRAINT fk_cm_measure
    FOREIGN KEY (measure_id)
    REFERENCES security_measure(measure_id)
    ON DELETE CASCADE;

ALTER TABLE target_maturity
    ADD CONSTRAINT fk_tm_measure
    FOREIGN KEY (measure_id)
    REFERENCES security_measure(measure_id)
    ON DELETE CASCADE;

-- FK maturity_level    
ALTER TABLE current_maturity
    ADD CONSTRAINT fk_cm_level
    FOREIGN KEY (level_id)
    REFERENCES maturity_level(level_id)
    ON DELETE RESTRICT;

ALTER TABLE target_maturity
    ADD CONSTRAINT fk_tm_level
    FOREIGN KEY (target_level_id)
    REFERENCES maturity_level(level_id)
    ON DELETE RESTRICT;

-- FK service
ALTER TABLE improvement_action    
    ADD CONSTRAINT fk_ia_service
    FOREIGN KEY (related_service_id)
    REFERENCES service(service_id)
    ON DELETE SET NULL;

-- FK third_part   
ALTER TABLE improvement_action
    ADD CONSTRAINT fk_ia_thirdparty
    FOREIGN KEY (related_third_party_id)
    REFERENCES third_party(third_party_id)
    ON DELETE SET NULL;

-- Indici per performance
CREATE INDEX IF NOT EXISTS idx_asset_org_current
    ON asset (organization_id, is_current);

CREATE INDEX IF NOT EXISTS idx_service_org_current
    ON service (organization_id, is_current);

CREATE INDEX IF NOT EXISTS idx_dependency_org_current
    ON dependency (organization_id, is_current);

CREATE INDEX IF NOT EXISTS idx_responsibility_org_current
    ON responsibility (organization_id, is_current);

CREATE INDEX IF NOT EXISTS idx_person_org
    ON person (organization_id);

CREATE INDEX IF NOT EXISTS idx_third_party_name
    ON third_party (name);

CREATE INDEX IF NOT EXISTS idx_tm_org_measure
     ON target_maturity (organization_id, measure_id);

CREATE INDEX IF NOT EXISTS idx_cm_org_measure 
    ON current_maturity (organization_id, measure_id);

CREATE INDEX IF NOT EXISTS idx_ia_org_status
    ON improvement_action (organization_id, status);