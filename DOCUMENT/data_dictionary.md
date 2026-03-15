# DATA DICTIONARY – Modello NIS2 / ACN

---

## 1. Tabella: `organization`

### Descrizione
Contiene le informazioni anagrafiche dell’organizzazione soggetta a NIS2.

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `organization_id` | SERIAL | PK | Identificativo univoco dell’organizzazione |
| `name` | VARCHAR(255) | NOT NULL | Nome dell’organizzazione |
| `sector` | VARCHAR(255) | NOT NULL | Settore di appartenenza |
| `nis_category` | VARCHAR(50) | NOT NULL | Categoria NIS2 (essenziale / importante) |
| `country` | VARCHAR(100) | NOT NULL | Paese di registrazione |
| `valid_from` | TIMESTAMP | DEFAULT now() | Inizio validità versione |
| `valid_to` | TIMESTAMP | NULL | Fine validità versione |
| `is_current` | BOOLEAN | DEFAULT TRUE | Indica se la versione è attiva |

---

## 2. Tabella: `person`

### Descrizione
Anagrafica delle persone interne all’organizzazione, incluse figure NIS2 (CISO, referenti, service owner).

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `person_id` | SERIAL | PK | Identificativo persona |
| `organization_id` | INT | FK → organization | Organizzazione di appartenenza |
| `first_name` | VARCHAR(100) | NOT NULL | Nome |
| `last_name` | VARCHAR(100) | NOT NULL | Cognome |
| `email` | VARCHAR(255) | UNIQUE | Email aziendale |
| `phone` | VARCHAR(50) | NULL | Numero di telefono |
| `role_name` | VARCHAR(255) | NOT NULL | Ruolo aziendale |
| `is_nis_contact` | BOOLEAN | DEFAULT FALSE | Indica se è referente NIS2 |
| `valid_from` | TIMESTAMP | DEFAULT now() | Inizio validità |
| `valid_to` | TIMESTAMP | NULL | Fine validità |
| `is_current` | BOOLEAN | DEFAULT TRUE | Versione attiva |

---

## 3. Tabella: `asset`

### Descrizione
Rappresenta gli asset rilevanti ai fini NIS2: infrastrutture, applicazioni, dati, piattaforme.

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `asset_id` | SERIAL | PK | Identificativo asset |
| `organization_id` | INT | FK → organization | Organizzazione proprietaria |
| `name` | VARCHAR(255) | NOT NULL | Nome asset |
| `description` | TEXT | NULL | Descrizione |
| `category` | VARCHAR(100) | NOT NULL | Categoria (infrastruttura/applicazione/dato) |
| `criticality_level` | VARCHAR(50) | NOT NULL | Livello di criticità |
| `location` | VARCHAR(255) | NOT NULL | Collocazione fisica |
| `status` | VARCHAR(50) | NOT NULL | Stato operativo |
| `valid_from` | TIMESTAMP | DEFAULT now() | Inizio validità |
| `valid_to` | TIMESTAMP | NULL | Fine validità |
| `is_current` | BOOLEAN | DEFAULT TRUE | Versione attiva |

---

## 4. Tabella: `service`

### Descrizione
Contiene i servizi erogati dall’organizzazione, classificati secondo NIS2.

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `service_id` | SERIAL | PK | Identificativo servizio |
| `organization_id` | INT | FK → organization | Organizzazione |
| `name` | VARCHAR(255) | NOT NULL | Nome servizio |
| `description` | TEXT | NULL | Descrizione |
| `category` | VARCHAR(100) | NOT NULL | Categoria (IaaS/PaaS/SaaS/Network) |
| `criticality_level` | VARCHAR(50) | NOT NULL | Criticità |
| `status` | VARCHAR(50) | NOT NULL | Stato operativo |
| `valid_from` | TIMESTAMP | DEFAULT now() | Inizio validità |
| `valid_to` | TIMESTAMP | NULL | Fine validità |
| `is_current` | BOOLEAN | DEFAULT TRUE | Versione attiva |

---

## 5. Tabella: `service_asset`

### Descrizione
Tabella di relazione molti-a-molti tra servizi e asset.

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `service_id` | INT | FK → service | Servizio |
| `asset_id` | INT | FK → asset | Asset |
| `relation_type` | VARCHAR(255) | NOT NULL | Tipo di relazione (es. “ospitato su”, “protetto da”) |

**PK composta:** `(service_id, asset_id)`

---

## 6. Tabella: `third_party`

### Descrizione
Fornitori terzi rilevanti ai fini NIS2.

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `third_party_id` | SERIAL | PK | Identificativo fornitore |
| `name` | VARCHAR(255) | NOT NULL | Nome fornitore |
| `type` | VARCHAR(100) | NOT NULL | Categoria (cloud, telco, backup…) |
| `country` | VARCHAR(100) | NOT NULL | Paese |
| `contact_email` | VARCHAR(255) | NULL | Email |
| `contact_phone` | VARCHAR(50) | NULL | Telefono |
| `valid_from` | TIMESTAMP | DEFAULT now() | Inizio validità |
| `valid_to` | TIMESTAMP | NULL | Fine validità |
| `is_current` | BOOLEAN | DEFAULT TRUE | Versione attiva |

---

## 7. Tabella: `dependency`

### Descrizione
Rappresenta le dipendenze critiche dei servizi verso fornitori terzi o asset.

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `dependency_id` | SERIAL | PK | Identificativo dipendenza |
| `organization_id` | INT | FK → organization | Organizzazione |
| `third_party_id` | INT | FK → third_party | Fornitore |
| `service_id` | INT | FK → service | Servizio coinvolto |
| `asset_id` | INT | FK → asset | Asset coinvolto (opzionale) |
| `dependency_type` | VARCHAR(255) | NOT NULL | Tipo dipendenza |
| `description` | TEXT | NULL | Descrizione |
| `valid_from` | TIMESTAMP | DEFAULT now() | Inizio validità |
| `valid_to` | TIMESTAMP | NULL | Fine validità |
| `is_current` | BOOLEAN | DEFAULT TRUE | Versione attiva |

---

## 8. Tabella: `responsibility`

### Descrizione
Mappa le responsabilità interne per ciascun servizio o asset.

### Struttura

| Campo | Tipo | Vincoli | Descrizione |
|-------|-------|----------|-------------|
| `responsibility_id` | SERIAL | PK | Identificativo responsabilità |
| `organization_id` | INT | FK → organization | Organizzazione |
| `person_id` | INT | FK → person | Persona responsabile |
| `service_id` | INT | FK → service | Servizio |
| `asset_id` | INT | FK → asset | Asset (opzionale) |
| `responsibility_type` | VARCHAR(255) | NOT NULL | Tipo responsabilità |
| `valid_from` | TIMESTAMP | DEFAULT now() | Inizio validità |
| `valid_to` | TIMESTAMP | NULL | Fine validità |
| `is_current` | BOOLEAN | DEFAULT TRUE | Versione attiva |

---

## 9. Versioning – Logica comune

### Tabelle versionate
- `asset`
- `service`
- `dependency`
- `responsibility`

### Campi coinvolti
- `valid_from`
- `valid_to`
- `is_current`

### Comportamento
Ogni UPDATE produce:
1. Chiusura versione precedente  
2. Inserimento nuova versione  
3. Nessun UPDATE diretto sulla riga originale  

