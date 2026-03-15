INSERT INTO person (organization_id, first_name, last_name, email, phone, role_name, is_nis_contact)
VALUES
(1, 'Alberto', 'Rizzi', 'alberto.rizzi@clouditalia.it', '+39-080-200001', 'SOC Manager', FALSE),
(1, 'Francesca', 'Longo', 'francesca.longo@clouditalia.it', '+39-080-200002', 'DevOps Engineer', FALSE),
(1, 'Gabriele', 'Montanari', 'gabriele.montanari@clouditalia.it', '+39-080-200003', 'Cloud Engineer', FALSE),
(1, 'Ilaria', 'De Santis', 'ilaria.desantis@clouditalia.it', '+39-080-200004', 'Security Auditor', FALSE),
(1, 'Stefano', 'Vitale', 'stefano.vitale@clouditalia.it', '+39-080-200005', 'Backup Specialist', FALSE),
(1, 'Michela', 'Pace', 'michela.pace@clouditalia.it', '+39-080-200006', 'Service Owner Backup', FALSE),
(1, 'Daniele', 'Serafini', 'daniele.serafini@clouditalia.it', '+39-080-200007', 'Network Architect', FALSE),
(1, 'Roberta', 'Ferri', 'roberta.ferri@clouditalia.it', '+39-080-200008', 'Incident Responder', FALSE),
(1, 'Claudio', 'Gentili', 'claudio.gentili@clouditalia.it', '+39-080-200009', 'IAM Specialist', FALSE),
(1, 'Veronica', 'Sala', 'veronica.sala@clouditalia.it', '+39-080-200010', 'Service Desk Operator', FALSE);


INSERT INTO asset (organization_id, name, description, category, criticality_level, location, status)
VALUES
(1, 'Compute Node X1', 'Nodo compute aggiuntivo', 'infrastruttura', 'medio', 'DC Milano', 'attivo'),
(1, 'Compute Node X2', 'Nodo compute ridondante', 'infrastruttura', 'medio', 'DC Milano', 'attivo'),
(1, 'SAN Archive A', 'Storage archivio a lungo termine', 'infrastruttura', 'basso', 'DC Roma', 'attivo'),
(1, 'SAN Archive B', 'Storage archivio secondario', 'infrastruttura', 'basso', 'DC Roma', 'attivo'),
(1, 'Kubernetes Test', 'Cluster Kubernetes test', 'applicazione', 'basso', 'DC Milano', 'attivo'),
(1, 'DB Logs', 'Database log applicativi', 'dato', 'medio', 'DC Milano', 'attivo'),
(1, 'Reverse Proxy', 'Reverse proxy interno', 'applicazione', 'medio', 'DC Milano', 'attivo'),
(1, 'API Gateway 2', 'Secondo nodo API Gateway', 'applicazione', 'alto', 'DC Milano', 'attivo'),
(1, 'Firewall Backup', 'Firewall secondario', 'infrastruttura', 'alto', 'DC Roma', 'attivo'),
(1, 'Monitoring Satellite', 'Nodo monitoraggio remoto', 'applicazione', 'basso', 'DC Roma', 'attivo'),
(1, 'Backup Vault', 'Vault backup cifrato', 'infrastruttura', 'alto', 'DC Milano', 'attivo'),
(1, 'IAM Replica', 'Replica IAM', 'applicazione', 'alto', 'DC Roma', 'attivo'),
(1, 'DNS Secondary', 'DNS secondario', 'infrastruttura', 'medio', 'DC Roma', 'attivo'),
(1, 'Email Relay Node', 'Nodo relay email', 'applicazione', 'basso', 'DC Milano', 'attivo'),
(1, 'Object Storage B', 'Storage oggetti secondario', 'infrastruttura', 'medio', 'DC Milano', 'attivo');


INSERT INTO service (organization_id, name, description, category, criticality_level, status)
VALUES
(1, 'CloudItalia Logs', 'Servizio centralizzato di log', 'SaaS', 'medio', 'attivo'),
(1, 'CloudItalia Archive', 'Archivio dati a lungo termine', 'SaaS', 'basso', 'attivo'),
(1, 'CloudItalia Proxy', 'Reverse proxy gestito', 'PaaS', 'medio', 'attivo'),
(1, 'CloudItalia API Plus', 'API gateway avanzato', 'PaaS', 'alto', 'attivo'),
(1, 'CloudItalia DNS Plus', 'DNS avanzato', 'Network', 'medio', 'attivo'),
(1, 'CloudItalia IAM Replica', 'Replica IAM per HA', 'SaaS', 'alto', 'attivo'),
(1, 'CloudItalia Mail Relay', 'Relay email gestito', 'SaaS', 'basso', 'attivo');


INSERT INTO service_asset VALUES
(9, 21, 'ospitato su'),
(9, 22, 'ospitato su'),
(9, 26, 'utilizza DB log'),

(10, 17, 'archiviazione primaria'),
(10, 18, 'archiviazione secondaria'),
(10, 30, 'object storage'),

(11, 27, 'reverse proxy'),
(11, 29, 'firewall backup'),

(12, 28, 'API gateway'),
(12, 27, 'reverse proxy'),

(13, 23, 'DNS secondario'),
(13, 29, 'firewall backup'),

(14, 24, 'IAM replica'),
(14, 29, 'protetto da firewall'),

(15, 25, 'email relay'),
(15, 27, 'reverse proxy');


INSERT INTO third_party (name, type, country, contact_email, contact_phone)
VALUES
('DataVault Corp.', 'storage provider', 'France', 'support@datavault.fr', '+33-1-555555'),
('NetWave AG', 'network provider', 'Switzerland', 'noc@netwave.ch', '+41-22-777777'),
('SecureMail Ltd.', 'email provider', 'UK', 'help@securemail.uk', '+44-20-666666'),
('CloudScale BV', 'cloud provider', 'Netherlands', 'info@cloudscale.nl', '+31-20-999999'),
('AuthSecure GmbH', 'IAM provider', 'Germany', 'support@authsecure.de', '+49-30-888888'),
('MonitorPlus Inc.', 'monitoring provider', 'USA', 'support@monitorplus.com', '+1-555-444444');


INSERT INTO dependency (organization_id, third_party_id, service_id, dependency_type, description)
VALUES
(1, 7, 9, 'log storage', 'Storage esterno per log'),
(1, 8, 10, 'network transit', 'Transito rete per archivio'),
(1, 9, 15, 'email relay', 'Relay email esterno'),
(1, 10, 12, 'api scaling', 'Scaling API esterno'),
(1, 11, 14, 'IAM federato', 'Federazione IAM esterna'),
(1, 12, 13, 'monitoring', 'Monitoraggio DNS esterno'),
(1, 7, 10, 'archiviazione', 'Archivio remoto'),
(1, 8, 11, 'proxy routing', 'Routing proxy esterno'),
(1, 9, 15, 'antispam', 'Antispam esterno'),
(1, 12, 9, 'alerting', 'Alerting esterno');


INSERT INTO responsibility (organization_id, person_id, service_id, responsibility_type)
VALUES
(1, 11, 9, 'log manager'),
(1, 12, 10, 'archive owner'),
(1, 13, 11, 'proxy owner'),
(1, 14, 12, 'api owner'),
(1, 15, 13, 'dns owner'),
(1, 16, 14, 'iam replica owner'),
(1, 17, 15, 'mail relay owner'),
(1, 18, 9, 'incident responder'),
(1, 19, 10, 'iam specialist'),
(1, 20, 11, 'service desk operator');
