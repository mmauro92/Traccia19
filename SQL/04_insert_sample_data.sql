-- -------------------------
-- ORGANIZATION
-- -------------------------
INSERT INTO organization (name, sector, nis_category, country)
VALUES ('CloudItalia S.p.A.', 'Cloud Service Provider', 'essenziale', 'Italy');

-- -------------------------
-- PERSON 
-- -------------------------
INSERT INTO person (organization_id, first_name, last_name, email, phone, role_name, is_nis_contact)
VALUES
(1, 'Luca', 'Bianchi', 'luca.bianchi@clouditalia.it', '+39-080-111111', 'CISO', TRUE),
(1, 'Sara', 'Verdi', 'sara.verdi@clouditalia.it', '+39-080-222222', 'Service Owner IaaS', FALSE),
(1, 'Marco', 'Neri', 'marco.neri@clouditalia.it', '+39-080-333333', 'Service Owner SaaS', FALSE),
(1, 'Giulia', 'Rossi', 'giulia.rossi@clouditalia.it', '+39-080-444444', 'Security Engineer', FALSE),
(1, 'Paolo', 'Gallo', 'paolo.gallo@clouditalia.it', '+39-080-555555', 'Network Engineer', FALSE),
(1, 'Elena', 'Costa', 'elena.costa@clouditalia.it', '+39-080-666666', 'DBA', FALSE),
(1, 'Davide', 'Fontana', 'davide.fontana@clouditalia.it', '+39-080-777777', 'Cloud Architect', FALSE),
(1, 'Chiara', 'Gentile', 'chiara.gentile@clouditalia.it', '+39-080-888888', 'Incident Manager', FALSE),
(1, 'Andrea', 'Sanna', 'andrea.sanna@clouditalia.it', '+39-080-999999', 'Compliance Officer', FALSE),
(1, 'Marta', 'De Luca', 'marta.deluca@clouditalia.it', '+39-080-121212', 'Service Desk Lead', FALSE);

-- -------------------------
-- ASSET 
-- -------------------------
INSERT INTO asset (organization_id, name, description, category, criticality_level, location, status)
VALUES
(1, 'Cluster Compute DC1', 'Cluster di calcolo principale', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(1, 'Cluster Compute DC2', 'Cluster di calcolo secondario', 'infrastruttura', 'alto', 'DC Roma', 'attivo'),
(1, 'Storage SAN DC1', 'Storage SAN per volumi IaaS', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(1, 'Storage SAN DC2', 'Storage SAN per DR', 'infrastruttura', 'medio', 'DC Roma', 'attivo'),
(1, 'Kubernetes Prod', 'Cluster Kubernetes produzione', 'applicazione', 'alto', 'DC Milano', 'attivo'),
(1, 'Kubernetes Stage', 'Cluster Kubernetes staging', 'applicazione', 'medio', 'DC Milano', 'attivo'),
(1, 'DB Configurazioni', 'Database centrale configurazioni', 'dato', 'medio', 'DC Milano', 'attivo'),
(1, 'DB Clienti', 'Database clienti SaaS', 'dato', 'alto', 'DC Milano', 'attivo'),
(1, 'Load Balancer HA', 'Bilanciatori di carico ad alta disponibilità', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(1, 'Firewall Perimetrale', 'Firewall di frontiera', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(1, 'VPN Gateway', 'Gateway VPN per accesso remoto', 'infrastruttura', 'medio', 'DC Milano', 'attivo'),
(1, 'Monitoring System', 'Sistema di monitoraggio centralizzato', 'applicazione', 'medio', 'DC Milano', 'attivo'),
(1, 'Backup Appliance', 'Appliance per backup locale', 'infrastruttura', 'medio', 'DC Roma', 'attivo'),
(1, 'Email Server', 'Server email interno', 'applicazione', 'basso', 'DC Milano', 'attivo'),
(1, 'IAM Platform', 'Piattaforma Identity & Access Management', 'applicazione', 'alto', 'DC Milano', 'attivo');

-- -------------------------
-- SERVICE
-- -------------------------
INSERT INTO service (organization_id, name, description, category, criticality_level, status)
VALUES
(1, 'CloudItalia IaaS', 'Servizio IaaS enterprise', 'IaaS', 'alto', 'attivo'),
(1, 'CloudItalia PaaS', 'Servizio PaaS per container', 'PaaS', 'alto', 'attivo'),
(1, 'CloudItalia SaaS CRM', 'CRM multi-tenant', 'SaaS', 'alto', 'attivo'),
(1, 'CloudItalia Backup', 'Servizio di backup gestito', 'SaaS', 'medio', 'attivo'),
(1, 'CloudItalia Email', 'Servizio email aziendale', 'SaaS', 'medio', 'attivo'),
(1, 'CloudItalia Monitoring', 'Servizio di monitoraggio', 'SaaS', 'medio', 'attivo'),
(1, 'CloudItalia IAM', 'Identity & Access Management', 'SaaS', 'alto', 'attivo'),
(1, 'CloudItalia VPN', 'Servizio VPN per clienti', 'Network', 'alto', 'attivo');

-- -------------------------
-- SERVICE_ASSET 
-- -------------------------
INSERT INTO service_asset VALUES
-- IaaS
(1, 1, 'ospitato su'),
(1, 3, 'utilizza storage'),
(1, 9, 'bilanciato da'),
(1, 10, 'protetto da'),
(1, 15, 'autenticazione tramite'),

-- PaaS
(2, 5, 'ospitato su'),
(2, 6, 'utilizza cluster staging'),
(2, 7, 'utilizza configurazioni'),
(2, 9, 'bilanciato da'),

-- SaaS CRM
(3, 5, 'ospitato su'),
(3, 8, 'utilizza database clienti'),
(3, 9, 'bilanciato da'),
(3, 10, 'protetto da'),

-- Backup
(4, 13, 'backup locale'),
(4, 3, 'backup storage'),

-- Email
(5, 14, 'ospitato su'),
(5, 15, 'autenticazione tramite'),

-- Monitoring
(6, 12, 'ospitato su'),
(6, 15, 'autenticazione tramite'),

-- IAM
(7, 15, 'piattaforma principale'),
(7, 10, 'protetto da'),

-- VPN
(8, 11, 'gateway principale'),
(8, 10, 'protetto da');

-- -------------------------
-- THIRD_PARTY (fornitori terzi)
-- -------------------------
INSERT INTO third_party (name, type, country, contact_email, contact_phone)
VALUES
('GlobalCloud Inc.', 'cloud provider', 'Germany', 'support@globalcloud.com', '+49-111-222333'),
('TelcoNet S.r.l.', 'telco', 'Italy', 'noc@telconet.it', '+39-02-123456'),
('SecureBackup Ltd.', 'backup provider', 'UK', 'help@securebackup.co.uk', '+44-20-555555'),
('MailPro AG', 'email provider', 'Switzerland', 'support@mailpro.ch', '+41-22-333333'),
('AuthMaster GmbH', 'IAM provider', 'Germany', 'info@authmaster.de', '+49-30-777777'),
('MonitorX Corp.', 'monitoring provider', 'USA', 'support@monitorx.com', '+1-555-123456');

-- -------------------------
-- DEPENDENCY (dipendenze da terze parti)
-- -------------------------
INSERT INTO dependency (organization_id, third_party_id, service_id, dependency_type, description)
VALUES
(1, 1, 1, 'cloud backup', 'Backup volumi IaaS su GlobalCloud'),
(1, 2, 1, 'connettività', 'Connettività ridondata verso DC'),
(1, 3, 4, 'backup remoto', 'Replica backup su SecureBackup'),
(1, 4, 5, 'email relay', 'Relay email esterno'),
(1, 5, 7, 'IAM federato', 'Federazione identità con AuthMaster'),
(1, 6, 6, 'monitoring esterno', 'Monitoraggio remoto MonitorX'),
(1, 1, 2, 'hosting cluster', 'Hosting cluster PaaS su GlobalCloud'),
(1, 3, 3, 'backup DB', 'Backup database clienti su SecureBackup'),
(1, 2, 8, 'VPN MPLS', 'Linea MPLS dedicata per VPN'),
(1, 4, 5, 'antispam', 'Servizio antispam MailPro'),
(1, 6, 6, 'alerting', 'Alerting esterno MonitorX'),
(1, 5, 7, 'SSO', 'Single Sign-On esterno'),
(1, 1, 3, 'scalabilità', 'Scalabilità automatica cluster CRM'),
(1, 2, 2, 'peering', 'Peering diretto con TelcoNet'),
(1, 3, 4, 'archiviazione', 'Archiviazione backup a lungo termine');

-- -------------------------
-- RESPONSIBILITY
-- -------------------------
INSERT INTO responsibility (organization_id, person_id, service_id, responsibility_type)
VALUES
(1, 1, 1, 'risk owner'),
(1, 1, 2, 'risk owner'),
(1, 1, 3, 'risk owner'),
(1, 2, 1, 'service owner'),
(1, 3, 3, 'service owner'),
(1, 4, 6, 'security analyst'),
(1, 5, 8, 'network owner'),
(1, 6, 3, 'database owner'),
(1, 7, 2, 'cloud architect'),
(1, 8, 6, 'incident manager'),
(1, 9, 7, 'compliance manager'),
(1, 10, 5, 'service desk lead'),
(1, 4, 7, 'security analyst'),
(1, 5, 1, 'network owner'),
(1, 7, 4, 'cloud architect');

