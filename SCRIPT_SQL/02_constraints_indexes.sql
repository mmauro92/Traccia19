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

ALTER TABLE responsibility
    ADD CONSTRAINT fk_responsibility_org
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

-- Indici per performance
CREATE INDEX idx_asset_org_current
    ON asset (organization_id, is_current);

CREATE INDEX idx_service_org_current
    ON service (organization_id, is_current);

CREATE INDEX idx_dependency_org_current
    ON dependency (organization_id, is_current);

CREATE INDEX idx_responsibility_org_current
    ON responsibility (organization_id, is_current);

CREATE INDEX idx_person_org
    ON person (organization_id);

CREATE INDEX idx_third_party_name
    ON third_party (name);
