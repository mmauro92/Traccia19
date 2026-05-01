-- -------------------------
-- ORGANIZATION
-- -------------------------
INSERT INTO nis2.organization (name, sector, nis_category, country)
VALUES ('CloudItalia S.p.A.', 'Cloud Services', 'essenziale', 'Italy');


-- -------------------------
-- PERSON 
-- -------------------------
INSERT INTO nis2.person (
    organization_id, first_name, last_name, email, phone, role_name, is_nis_contact
)
VALUES
(1, 'Marco', 'Rossi', 'marco.rossi@clouditalia.it', '+39-333-1111111', 'CISO', TRUE),
(1, 'Laura', 'Bianchi', 'laura.bianchi@clouditalia.it', '+39-333-2222222', 'Service Owner IaaS', FALSE),
(1, 'Giulia', 'Verdi', 'giulia.verdi@clouditalia.it', '+39-333-3333333', 'DB Administrator', FALSE),
(1, 'Paolo', 'Neri', 'paolo.neri@clouditalia.it', '+39-333-4444444', 'Security Analyst', FALSE);


-- -------------------------
-- ASSET 
-- -------------------------
INSERT INTO nis2.asset (
    organization_id, name, description, category,
    criticality_level, location, status
)
VALUES
(1, 'Compute Cluster A', 'Cluster di calcolo primario', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(1, 'Storage Tier-1', 'Storage ad alte prestazioni', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(1, 'Customer Portal', 'Portale clienti per gestione servizi', 'applicazione', 'medio', 'AWS eu-central-1', 'attivo'),
(1, 'Billing DB', 'Database per la fatturazione', 'dato', 'alto', 'AWS eu-central-1', 'attivo'),
(1, 'Backup System', 'Sistema di backup giornaliero', 'processo', 'medio', 'DC Milano', 'attivo');


-- -------------------------
-- SERVICE
-- -------------------------
INSERT INTO nis2.service (
    organization_id, name, description, category,
    criticality_level, status
)
VALUES
(1, 'IaaS Compute', 'Servizio di infrastruttura virtuale', 'IaaS', 'alto', 'attivo'),
(1, 'Managed Database', 'Servizio DB gestito', 'PaaS', 'alto', 'attivo'),
(1, 'Customer Portal Service', 'Servizio applicativo per i clienti', 'SaaS', 'medio', 'attivo');


-- -------------------------
-- SERVICE_ASSET 
-- -------------------------
INSERT INTO nis2.service_asset (service_id, asset_id, relation_type)
VALUES
(1, 1, 'utilizza'),
(1, 2, 'utilizza'),
(2, 4, 'ospitato su'),
(3, 3, 'dipende da'),
(3, 4, 'dipende da');


-- -------------------------
-- THIRD_PARTY (fornitori terzi)
-- -------------------------
INSERT INTO nis2.third_party (name, type, country, contact_email, contact_phone)
VALUES
('AWS', 'cloud provider', 'USA', 'support@aws.amazon.com', '+1-800-123-456'),
('FastWeb', 'telco', 'Italy', 'support@fastweb.it', '+39-02-123456'),
('CyberDefend Srl', 'security provider', 'Italy', 'info@cyberdefend.it', '+39-080-987654');


-- -------------------------
-- DEPENDENCY (dipendenze da terze parti)
-- -------------------------
INSERT INTO nis2.dependency (
    organization_id, third_party_id, service_id, asset_id,
    dependency_type, description
)
VALUES
(1, 1, 1, NULL, 'hosting', 'Compute cluster ospitato su AWS'),
(1, 1, 2, NULL, 'hosting', 'Managed DB ospitato su AWS'),
(1, 2, 3, NULL, 'connettività', 'Connettività per Customer Portal'),
(1, 3, NULL, 5, 'supporto', 'Supporto sicurezza per sistema di backup');


-- -------------------------
-- RESPONSIBILITY
-- -------------------------
INSERT INTO nis2.responsibility (
    organization_id, person_id, service_id, asset_id, responsibility_type
)
VALUES
(1, 1, NULL, 1, 'risk owner'),
(1, 2, 1, NULL, 'owner'),
(1, 3, 2, NULL, 'custodian'),
(1, 4, NULL, 5, 'custodian');

-- -------------------------
-- MATURITY LEVEL
-- -------------------------
INSERT INTO nis2.maturity_level (level_value, name, description)
VALUES
(0, 'Non definito', 'Nessuna pratica implementata'),
(1, 'Iniziale', 'Pratiche sporadiche'),
(2, 'Gestito', 'Pratiche documentate'),
(3, 'Definito', 'Pratiche standardizzate'),
(4, 'Misurato', 'Pratiche misurate e monitorate'),
(5, 'Ottimizzato', 'Pratiche ottimizzate e migliorate');


-- Nota: popolare security_measure con il catalogo ACN (import CSV o INSERT multipli)
-- Esempio minimo:
INSERT INTO nis2.security_measure (code, name, description, category)
VALUES
('IAM', 'Identity & Access Management', 'Gestione identità e accessi', 'Governance'),
('LOG', 'Logging & Monitoring', 'Monitoraggio e raccolta log', 'Operations'),
('PATCH', 'Patch Management', 'Gestione aggiornamenti', 'Operations'),
('BCP', 'Business Continuity', 'Continuità operativa', 'Governance'),
('BACKUP', 'Backup & Recovery', 'Procedure di backup e ripristino', 'Operations');

-- -------------------------
-- CURRENT_MATURITY (Profilo Attuale)
-- -------------------------
INSERT INTO nis2.current_maturity (organization_id, measure_id, level_id, notes)
VALUES
(1, 1, 2, 'IAM documentato ma non completamente automatizzato'),
(1, 2, 3, 'Logging centralizzato su SIEM'),
(1, 3, 2, 'Patch management manuale su alcuni sistemi'),
(1, 4, 1, 'Piano BCP non aggiornato'),
(1, 5, 3, 'Backup giornalieri verificati');

-- -------------------------
-- TARGET_MATURITY (Profilo Target)
-- -------------------------
INSERT INTO nis2.target_maturity (
    organization_id, measure_id, target_level_id, justification, deadline
)
VALUES
(1, 1, 4, 'Richiesto per compliance ACN', '2025-12-31'),
(1, 2, 4, 'Miglioramento capacità di detection', '2025-06-30'),
(1, 3, 3, 'Automatizzare patching critico', '2025-09-30'),
(1, 4, 3, 'Aggiornamento BCP e test annuali', '2025-12-31'),
(1, 5, 4, 'Aumentare resilienza backup', '2025-03-31');

-- -------------------------
-- RESPONSIBILITY IMPROVEMENT_ACTION (Roadmap)
-- -------------------------
INSERT INTO nis2.improvement_action (
    organization_id, measure_id, related_service_id, related_asset_id,
    description, priority, deadline, status
)
VALUES
(1, 1, NULL, NULL, 'Implementare MFA su tutti i sistemi', 'alto', '2025-06-30', 'planned'),
(1, 2, 3, NULL, 'Integrare Customer Portal nel SIEM', 'medio', '2025-04-30', 'in_progress'),
(1, 3, 1, 1, 'Automatizzare patching cluster compute', 'alto', '2025-09-30', 'planned'),
(1, 4, NULL, NULL, 'Aggiornare piano BCP e testare failover', 'alto', '2025-12-31', 'planned'),
(1, 5, NULL, 5, 'Implementare backup immutabili', 'alto', '2025-03-31', 'in_progress');
