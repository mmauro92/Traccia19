INSERT INTO nis2.organization (organization_id, name, sector, nis_category, country, created_at)
VALUES
(2, 'SkyCloud Enterprise S.p.A.', 'Cloud & Managed Services', 'essenziale', 'Italy', NOW());

INSERT INTO nis2.asset (
    organization_id, name, description, category,
    criticality_level, location, status
)
VALUES
(2, 'Compute Node C1', 'Nodo compute cluster C', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(2, 'Compute Node C2', 'Nodo compute cluster C', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(2, 'Compute Node D1', 'Nodo compute cluster D', 'infrastruttura', 'medio', 'DC Roma', 'attivo'),
(2, 'Storage SAN-3', 'Storage SAN terziario', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(2, 'Storage SAN-4', 'Storage SAN backup', 'infrastruttura', 'medio', 'DC Roma', 'attivo'),
(2, 'Load Balancer L4', 'Bilanciatore livello 4', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(2, 'API Gateway v2', 'Gateway API nuova versione', 'applicazione', 'alto', 'AWS eu-west-1', 'attivo'),
(2, 'Customer Dashboard v2', 'Dashboard clienti nuova', 'applicazione', 'medio', 'AWS eu-west-1', 'attivo'),
(2, 'Billing Engine v2', 'Motore fatturazione v2', 'applicazione', 'alto', 'Azure westeurope', 'attivo'),
(2, 'Monitoring System v2', 'Monitoraggio avanzato', 'applicazione', 'alto', 'DC Milano', 'attivo'),
(2, 'Backup Vault v2', 'Vault backup immutabili v2', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(2, 'Identity Server v2', 'IAM interno v2', 'applicazione', 'alto', 'DC Milano', 'attivo'),
(2, 'Log Collector v2', 'Sistema raccolta log v2', 'applicazione', 'alto', 'DC Roma', 'attivo'),
(2, 'Kubernetes Cluster v2', 'Cluster Kubernetes v2', 'infrastruttura', 'alto', 'AWS eu-central-1', 'attivo'),
(2, 'Object Storage v2', 'Storage oggetti v2', 'infrastruttura', 'alto', 'AWS eu-central-1', 'attivo'),
(2, 'Data Warehouse v2', 'DW analisi dati v2', 'dato', 'medio', 'Azure westeurope', 'attivo'),
(2, 'CRM System v2', 'CRM interno v2', 'applicazione', 'medio', 'DC Milano', 'attivo'),
(2, 'Email Gateway v2', 'Gateway email v2', 'applicazione', 'medio', 'DC Roma', 'attivo'),
(2, 'VPN Concentrator v2', 'Concentratore VPN v2', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(2, 'Security Scanner v2', 'Scanner vulnerabilità v2', 'applicazione', 'alto', 'DC Milano', 'attivo');

INSERT INTO nis2.service (
    organization_id, name, description, category,
    criticality_level, status
)
VALUES
(2, 'Compute Premium', 'Compute ad alte prestazioni', 'IaaS', 'alto', 'attivo'),
(2, 'Storage Premium', 'Storage enterprise', 'IaaS', 'alto', 'attivo'),
(2, 'Kubernetes Advanced', 'Cluster Kubernetes avanzato', 'PaaS', 'alto', 'attivo'),
(2, 'Managed DB Pro', 'Database gestito premium', 'PaaS', 'alto', 'attivo'),
(2, 'API Gateway Pro', 'API Gateway avanzato', 'PaaS', 'alto', 'attivo'),
(2, 'Monitoring Pro', 'Monitoraggio avanzato', 'SaaS', 'alto', 'attivo'),
(2, 'Logging Pro', 'Logging avanzato', 'SaaS', 'alto', 'attivo'),
(2, 'Customer Dashboard Pro', 'Dashboard clienti avanzata', 'SaaS', 'medio', 'attivo'),
(2, 'Billing Pro', 'Fatturazione avanzata', 'SaaS', 'alto', 'attivo'),
(2, 'Identity Pro', 'IAM avanzato', 'SaaS', 'alto', 'attivo'),
(2, 'Email Security Pro', 'Email sicura avanzata', 'SaaS', 'medio', 'attivo'),
(2, 'Backup Pro', 'Backup avanzato', 'SaaS', 'alto', 'attivo');

INSERT INTO nis2.service_asset (service_id, asset_id, relation_type)
VALUES
(4, 6, 'utilizza'),
(4, 7, 'utilizza'),
(5, 8, 'ospitato su'),
(5, 9, 'ospitato su'),
(6, 10, 'dipende da'),
(6, 13, 'dipende da'),
(7, 14, 'dipende da'),
(7, 12, 'dipende da'),
(8, 8, 'dipende da'),
(9, 9, 'dipende da'),
(10, 12, 'dipende da'),
(11, 18, 'dipende da'),
(12, 11, 'dipende da'),
(13, 15, 'dipende da'),
(14, 16, 'dipende da'),
(15, 17, 'dipende da');

INSERT INTO nis2.third_party (name, type, country, contact_email, contact_phone)
VALUES
('OVHCloud', 'cloud provider', 'France', 'support@ovh.com', '+33-1-111111'),
('ArubaCloud', 'cloud provider', 'Italy', 'support@arubacloud.it', '+39-0575-22222'),
('Hetzner', 'cloud provider', 'Germany', 'support@hetzner.com', '+49-9831-33333'),
('WindTre', 'telco', 'Italy', 'support@windtre.it', '+39-02-444444'),
('Colt', 'telco', 'UK', 'support@colt.net', '+44-20-555555'),
('Zscaler', 'security provider', 'USA', 'support@zscaler.com', '+1-800-777777'),
('TrendMicro', 'security provider', 'Japan', 'support@trendmicro.com', '+81-3-888888'),
('Proofpoint', 'email provider', 'USA', 'support@proofpoint.com', '+1-800-999999'),
('Atlassian', 'software provider', 'Australia', 'support@atlassian.com', '+61-2-111111'),
('Datadog', 'monitoring provider', 'USA', 'support@datadoghq.com', '+1-800-121212'),
('NewRelic', 'monitoring provider', 'USA', 'support@newrelic.com', '+1-800-131313'),
('CrowdStrike', 'security provider', 'USA', 'support@crowdstrike.com', '+1-800-141414'),
('Darktrace', 'security provider', 'UK', 'support@darktrace.com', '+44-20-151515'),
('CheckPoint', 'security provider', 'Israel', 'support@checkpoint.com', '+972-3-161616'),
('Cisco', 'network provider', 'USA', 'support@cisco.com', '+1-800-171717');

INSERT INTO nis2.dependency (
    organization_id, third_party_id, service_id, asset_id,
    dependency_type, description
)
VALUES
(2, 4, 4, NULL, 'hosting', 'Compute Premium ospitato su OVHCloud'),
(2, 5, 4, NULL, 'connettività', 'Linea Colt per Compute Premium'),
(2, 6, 5, NULL, 'security', 'Zscaler per Storage Premium'),
(2, 7, 6, NULL, 'security', 'TrendMicro per Monitoring Pro'),
(2, 8, 11, NULL, 'email', 'Proofpoint per Email Security Pro'),
(2, 9, NULL, 6, 'software', 'Atlassian per gestione asset'),
(2, 10, 6, NULL, 'monitoring', 'Datadog per Monitoring Pro'),
(2, 11, 7, NULL, 'monitoring', 'NewRelic per Logging Pro'),
(2, 12, NULL, 25, 'security', 'CrowdStrike per Security Scanner v2'),
(2, 13, NULL, 24, 'security', 'Darktrace per VPN Concentrator v2'),
(2, 14, 10, NULL, 'security', 'CheckPoint per Identity Pro'),
(2, 15, NULL, 23, 'network', 'Cisco per Email Gateway v2'),
(2, 4, 8, NULL, 'hosting', 'Dashboard Pro su OVHCloud'),
(2, 5, NULL, 17, 'connettività', 'CRM v2 connesso tramite Colt'),
(2, 6, 9, NULL, 'security', 'Zscaler per Billing Pro'),
(2, 7, NULL, 20, 'security', 'TrendMicro per Security Scanner v2'),
(2, 8, 12, NULL, 'email', 'Proofpoint per Backup Pro'),
(2, 9, 13, NULL, 'software', 'Atlassian per API Gateway Pro'),
(2, 10, NULL, 19, 'monitoring', 'Datadog per VPN Concentrator v2'),
(2, 11, NULL, 18, 'monitoring', 'NewRelic per Email Gateway v2'),
(2, 12, 14, NULL, 'security', 'CrowdStrike per Identity Pro'),
(2, 13, 15, NULL, 'security', 'Darktrace per Backup Pro'),
(2, 14, NULL, 22, 'security', 'CheckPoint per Log Collector v2'),
(2, 15, NULL, 21, 'network', 'Cisco per Backup Vault v2'),
(2, 4, NULL, 10, 'hosting', 'Monitoring System v2 su OVHCloud'),
(2, 5, 5, NULL, 'connettività', 'Colt per API Gateway Pro'),
(2, 6, NULL, 14, 'security', 'Zscaler per Kubernetes Cluster v2'),
(2, 7, NULL, 15, 'security', 'TrendMicro per Object Storage v2'),
(2, 8, NULL, 16, 'email', 'Proofpoint per Data Warehouse v2'),
(2, 9, 7, NULL, 'software', 'Atlassian per Logging Pro');

INSERT INTO nis2.person (
    organization_id, first_name, last_name, email, phone, role_name, is_nis_contact
)
VALUES
(2, 'Andrea', 'Colombo', 'a.colombo@skycloud.it', '+39-333-2000001', 'Cloud Engineer', FALSE),
(2, 'Silvia', 'Marini', 's.marini@skycloud.it', '+39-333-2000002', 'Security Engineer', FALSE),
(2, 'Fabio', 'Greco', 'f.greco@skycloud.it', '+39-333-2000003', 'DevOps Lead', FALSE),
(2, 'Elisa', 'Rossi', 'e.rossi@skycloud.it', '+39-333-2000004', 'Product Owner', FALSE),
(2, 'Tommaso', 'Ricci', 't.ricci@skycloud.it', '+39-333-2000005', 'SOC Manager', FALSE),
(2, 'Veronica', 'Lodi', 'v.lodi@skycloud.it', '+39-333-2000006', 'Compliance Specialist', FALSE),
(2, 'Matteo', 'Gallo', 'm.gallo@skycloud.it', '+39-333-2000007', 'Network Architect', FALSE),
(2, 'Serena', 'Pace', 's.pace@skycloud.it', '+39-333-2000008', 'Service Manager', FALSE),
(2, 'Daniele', 'Ferri', 'd.ferri@skycloud.it', '+39-333-2000009', 'DB Architect', FALSE),
(2, 'Roberta', 'Sanna', 'r.sanna@skycloud.it', '+39-333-2000010', 'Incident Responder', FALSE),
(2, 'Gabriele', 'Monti', 'g.monti@skycloud.it', '+39-333-2000011', 'Cloud Architect', FALSE),
(2, 'Chiara', 'Pini', 'c.pini@skycloud.it', '+39-333-2000012', 'Security Analyst', FALSE);

INSERT INTO nis2.responsibility (
    organization_id, person_id, service_id, asset_id, responsibility_type
)
VALUES
(2, 5, 4, NULL, 'owner'),
(2, 6, 5, NULL, 'custodian'),
(2, 7, 6, NULL, 'owner'),
(2, 8, 7, NULL, 'owner'),
(2, 9, 8, NULL, 'custodian'),
(2, 10, 9, NULL, 'custodian'),
(2, 11, 10, NULL, 'owner'),
(2, 12, 11, NULL, 'custodian'),
(2, 13, 12, NULL, 'owner'),
(2, 14, 13, NULL, 'custodian'),
(2, 15, 14, NULL, 'owner'),
(2, 16, 15, NULL, 'custodian'),
(2, 5, NULL, 6, 'custodian'),
(2, 6, NULL, 7, 'custodian'),
(2, 7, NULL, 8, 'owner'),
(2, 8, NULL, 9, 'custodian'),
(2, 9, NULL, 10, 'owner'),
(2, 10, NULL, 11, 'custodian'),
(2, 11, NULL, 12, 'owner'),
(2, 12, NULL, 13, 'custodian'),
(2, 13, NULL, 14, 'owner'),
(2, 14, NULL, 15, 'custodian'),
(2, 15, NULL, 16, 'owner'),
(2, 16, NULL, 17, 'custodian'),
(2, 5, NULL, 18, 'risk owner');

INSERT INTO nis2.security_measure (code, name, description, category)
VALUES
('NETMON', 'Network Monitoring', 'Monitoraggio rete avanzato', 'Operations'),
('SIEM', 'SIEM Integration', 'Integrazione SIEM', 'Security'),
('EDR', 'Endpoint Detection', 'Protezione endpoint', 'Security'),
('MFA', 'Multi-Factor Authentication', 'Autenticazione forte', 'Governance'),
('SEGF', 'Network Segmentation', 'Segmentazione rete', 'Security'),
('TLS', 'TLS Enforcement', 'Cifratura TLS obbligatoria', 'Security'),
('PKI', 'Public Key Infrastructure', 'Gestione certificati', 'Governance'),
('SECREV', 'Security Review', 'Revisioni periodiche', 'Governance'),
('AUDIT', 'Audit Logging', 'Audit log avanzati', 'Operations'),
('ANTISPAM', 'Anti-Spam', 'Protezione email', 'Security'),
('ANTIVIR', 'Anti-Virus', 'Protezione malware', 'Security'),
('HARD', 'Hardening', 'Hardening sistemi', 'Security'),
('NETFW', 'Firewall Management', 'Gestione firewall', 'Security'),
('IDSIPS', 'IDS/IPS', 'Rilevamento intrusioni', 'Security'),
('SAST', 'Static Code Analysis', 'Analisi statica codice', 'Security'),
('DAST', 'Dynamic Code Analysis', 'Analisi dinamica codice', 'Security'),
('SECPOL', 'Security Policies', 'Politiche di sicurezza', 'Governance'),
('SECTRAIN', 'Security Training', 'Formazione avanzata', 'Governance'),
('SECRESP', 'Security Response', 'Risposta incidenti avanzata', 'Security'),
('ZERO', 'Zero Trust', 'Architettura Zero Trust', 'Security');

INSERT INTO nis2.current_maturity (organization_id, measure_id, level_id, notes)
VALUES
(2, 6, 2, 'Monitoraggio rete parziale'),
(2, 7, 3, 'SIEM integrato parzialmente'),
(2, 8, 2, 'EDR su 60% endpoint'),
(2, 9, 3, 'MFA attivo su utenti critici'),
(2, 10, 2, 'Segmentazione rete incompleta'),
(2, 11, 3, 'TLS enforced su servizi principali'),
(2, 12, 2, 'PKI interna non completa'),
(2, 13, 2, 'Security review annuale'),
(2, 14, 3, 'Audit logging attivo'),
(2, 15, 2, 'Anti-spam base'),
(2, 16, 3, 'Anti-virus aggiornato'),
(2, 17, 2, 'Hardening parziale'),
(2, 18, 3, 'Firewall gestito centralmente'),
(2, 19, 2, 'IDS/IPS non completo'),
(2, 20, 2, 'SAST parziale'),
(2, 21, 2, 'DAST parziale'),
(2, 22, 3, 'Security policies aggiornate'),
(2, 23, 2, 'Training annuale'),
(2, 24, 2, 'IR avanzato parziale'),
(2, 25, 2, 'Zero Trust in fase iniziale');

INSERT INTO nis2.target_maturity (
    organization_id, measure_id, target_level_id, justification, deadline
)
VALUES
(2, 6, 4, 'Richiesto per compliance', '2025-12-31'),
(2, 7, 4, 'SIEM completo', '2025-10-31'),
(2, 8, 4, 'EDR su 100% endpoint', '2025-09-30'),
(2, 9, 4, 'MFA totale', '2025-06-30'),
(2, 10, 4, 'Segmentazione Zero Trust', '2025-11-30'),
(2, 11, 4, 'TLS ovunque', '2025-05-31'),
(2, 12, 4, 'PKI completa', '2025-08-31'),
(2, 13, 4, 'Security review trimestrale', '2025-07-31'),
(2, 14, 4, 'Audit logging avanzato', '2025-09-30'),
(2, 15, 4, 'Anti-spam avanzato', '2025-04-30'),
(2, 16, 4, 'Anti-virus avanzato', '2025-03-31'),
(2, 17, 4, 'Hardening completo', '2025-10-31'),
(2, 18, 4, 'Firewall avanzato', '2025-12-31'),
(2, 19, 4, 'IDS/IPS completo', '2025-11-30'),
(2, 20, 4, 'SAST completo', '2025-09-30'),
(2, 21, 4, 'DAST completo', '2025-08-31'),
(2, 22, 4, 'Security policies avanzate', '2025-07-31'),
(2, 23, 4, 'Training trimestrale', '2025-06-30'),
(2, 24, 4, 'IR avanzato', '2025-05-31'),
(2, 25, 4, 'Zero Trust completo', '2025-12-31');

INSERT INTO nis2.improvement_action (
    organization_id, measure_id, related_service_id, related_asset_id,
    description, priority, deadline, status
)
VALUES
(2, 6, 4, NULL, 'Implementare network monitoring avanzato', 'alto', '2025-06-30', 'planned'),
(2, 7, 5, NULL, 'Completare integrazione SIEM', 'alto', '2025-10-31', 'in_progress'),
(2, 8, NULL, 6, 'Installare EDR su tutti gli endpoint', 'alto', '2025-09-30', 'planned'),
(2, 9, 10, NULL, 'Abilitare MFA totale', 'alto', '2025-06-30', 'planned'),
(2, 10, NULL, 7, 'Segmentazione Zero Trust', 'alto', '2025-11-30', 'planned'),
(2, 11, NULL, 8, 'TLS enforcement totale', 'medio', '2025-05-31', 'planned'),
(2, 12, NULL, 9, 'Implementare PKI completa', 'alto', '2025-08-31', 'planned'),
(2, 13, NULL, NULL, 'Introdurre security review trimestrale', 'medio', '2025-07-31', 'planned'),
(2, 14, 7, NULL, 'Abilitare audit logging avanzato', 'alto', '2025-09-30', 'planned'),
(2, 15, 11, NULL, 'Potenziare anti-spam su Email Security Pro', 'medio', '2025-04-30', 'in_progress'),
(2, 16, NULL, 10, 'Rafforzare anti-virus su Monitoring v2', 'medio', '2025-03-31', 'planned'),
(2, 17, NULL, 11, 'Hardening completo Backup Vault v2', 'alto', '2025-10-31', 'planned'),
(2, 18, NULL, 12, 'Ottimizzare gestione firewall IAM v2', 'alto', '2025-12-31', 'planned'),
(2, 19, NULL, 13, 'Abilitare IDS/IPS su Log Collector v2', 'alto', '2025-11-30', 'planned'),
(2, 20, 5, NULL, 'Integrare SAST nella pipeline CI/CD', 'medio', '2025-09-30', 'planned'),
(2, 21, 5, NULL, 'Integrare DAST nella pipeline CI/CD', 'medio', '2025-08-31', 'planned'),
(2, 22, NULL, NULL, 'Aggiornare e formalizzare security policies', 'medio', '2025-07-31', 'planned'),
(2, 23, NULL, NULL, 'Introdurre training sicurezza trimestrale', 'medio', '2025-06-30', 'planned'),
(2, 24, NULL, NULL, 'Definire playbook IR avanzati', 'alto', '2025-05-31', 'planned'),
(2, 25, NULL, 14, 'Estendere modello Zero Trust al cluster v2', 'alto', '2025-12-31', 'planned'),
(2, 6, NULL, 15, 'Monitoraggio rete su Object Storage v2', 'medio', '2025-06-15', 'planned'),
(2, 7, 6, NULL, 'Integrazione SIEM con Monitoring Pro', 'medio', '2025-10-15', 'planned'),
(2, 8, NULL, 16, 'EDR su Data Warehouse v2', 'alto', '2025-09-15', 'planned'),
(2, 9, NULL, 17, 'MFA su CRM System v2', 'alto', '2025-06-15', 'planned'),
(2, 10, NULL, 18, 'Segmentazione per Email Gateway v2', 'medio', '2025-11-15', 'planned'),
(2, 11, NULL, 19, 'TLS obbligatorio su VPN Concentrator v2', 'medio', '2025-05-15', 'planned'),
(2, 12, NULL, 20, 'PKI per Security Scanner v2', 'alto', '2025-08-15', 'planned'),
(2, 13, 8, NULL, 'Security review su Dashboard Pro', 'medio', '2025-07-15', 'planned'),
(2, 14, 9, NULL, 'Audit logging avanzato su Billing Pro', 'alto', '2025-09-15', 'planned'),
(2, 15, 11, NULL, 'Anti-spam avanzato su Email Security Pro', 'medio', '2025-04-15', 'planned');

