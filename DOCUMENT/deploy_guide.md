# NIS2 Database – Deployment Guide  
Guida ufficiale per il deploy dello schema, dei vincoli, del versioning e dei dataset di test

---

## Struttura degli script

Gli script SQL sono organizzati come segue:

```
01_create_tables.sql
02_constraints_indexes.sql
03_versioning_functions.sql
04_versioning_triggers.sql
05_insert_sample_data.sql
06_views.sql
07_query_example.sql
08_dataset.sql
09_versioning.sql
```

Ogni file ha uno scopo preciso e deve essere eseguito nell’ordine indicato

---

# 1. Prerequisiti

- PostgreSQL 14 o superiore  
- Linguaggio PL/pgSQL abilitato  
- Permessi di creazione schema, tabelle, funzioni e trigger  
- Database dedicato (es. `nis2db`)  
- Schema `nis2` creato o da creare nel primo script  

---

# 2. Ordine di deploy degli script

##  **01_create_tables.sql**
Crea tutte le tabelle del modello:

- `organization`  
- `person`  
- `asset`  
- `service`  
- `third_party`  
- `service_asset`  
- `dependency`  
- `responsibility`  
- `security_measure`  
- `maturity_level`  
- `current_maturity`  
- `target_maturity`  
- `improvement_action`  

Questo script **deve essere eseguito per primo**

---

## **02_constraints_indexes.sql**
Contiene:

- tutte le **foreign key**
- vincoli **UNIQUE**, **NOT NULL**
- indici per ottimizzare le query

Dipende dal file 01

---

## **03_versioning_functions.sql**
Crea le funzioni PL/pgSQL per il versioning:

- `asset_versioning()`  
- `service_versioning()`  
- `dependency_versioning()`  
- `responsibility_versioning()`  
- `current_maturity_versioning()`  
- `target_maturity_versioning()`  
- `improvement_action_updated_at()`  

Queste funzioni devono esistere **prima** dei trigger

---

## **04_versioning_triggers.sql**
Installa i trigger AFTER UPDATE:

- `trg_asset_versioning`  
- `trg_service_versioning`  
- `trg_dependency_versioning`  
- `trg_responsibility_versioning`  
- `trg_current_maturity_versioning`  
- `trg_target_maturity_versioning`  
- `trg_improvement_action_updated_at`  

Ogni trigger richiama la rispettiva funzione

Dipende dal file 03

---

## **05_insert_sample_data.sql**
Inserisce un **dataset minimo** per verificare:

- corretto funzionamento delle FK  
- corretto popolamento delle tabelle  
- funzionamento delle viste  

Dipende dai file 01 e 02

---

## **06_views.sql**
Contiene le viste richieste per un potenziale **export CSV**, con i campi minimi necessari:

Esempi:
- `acn_profile_export` : vista che produce un export completo dei dati NIS2/ACN, unificando servizi, asset, terze parti e responsabilità in un unico dataset pronto per la generazione del documento CSV richiesto da ACN.
- `vw_gap_analysis`  vista che confronta il livello di maturità attuale e target per ogni misura ACN, calcolando automaticamente il gap e mostrando scadenze e note rilevanti.
- `profile_target_export` vista che esporta il Profilo Target ACN completo, includendo misure, livelli target, azioni di miglioramento e relativi collegamenti a servizi, asset e terze parti.

Dipende dai file 01, 02 e 05

---

## **07_query_example.sql**
Contiene esempi di query utili per estrarre, per ogni azienda:

- elenco asset critici  
- servizi erogati  
- dipendenze da terze parti  
- punti di contatto (responsabilità)  

Serve come documentazione e test funzionale

Dipende dai file 01, 02, 05 e 06

---

## **08_dataset.sql**
Contiene un **dataset esteso**, utile per:

- testare il versioning su larga scala  
- simulare un ambiente reale  
- popolare il database con dati coerenti  

Dipende dai file 01–06

---

## **09_versioning.sql**
Contiene UPDATE controllati per testare il versioning:

- verifica che i trigger creino nuove versioni  
- verifica che `valid_to` e `is_current` siano aggiornati correttamente  
- verifica che lo storico sia completo  

Dipende dai file 03, 04, 05 o 08

---

# 3. Dipendenze tra gli script

| Script | Dipende da |
|--------|------------|
| 01_create_tables.sql | nessuno |
| 02_constraints_indexes.sql | 01 |
| 03_versioning_functions.sql | 01 |
| 04_versioning_triggers.sql | 03 |
| 05_insert_sample_data.sql | 01, 02 |
| 06_views.sql | 01, 02, 05 |
| 07_query_example.sql | 01, 02, 05, 06 |
| 08_dataset.sql | 01, 02, 03, 04, 06 |
| 09_versioning.sql | 03, 04, 05 o 08 |

---

# 4. Procedura di deploy consigliata

Eseguire gli script in questo ordine:

```
01_create_tables.sql
02_constraints_indexes.sql
03_versioning_functions.sql
04_versioning_triggers.sql
05_insert_sample_data.sql
06_views.sql
07_query_example.sql
08_dataset.sql
09_versioning.sql
```

---

# 5. Verifica del deploy

## Verifica trigger installati

```sql
SELECT tgname, tgrelid::regclass
FROM pg_trigger
WHERE NOT tgisinternal
ORDER BY tgrelid;
```

## Verifica versioning

```sql
UPDATE nis2.asset
SET status = 'manutenzione'
WHERE asset_id = 1 AND is_current = TRUE;

SELECT *
FROM nis2.asset
WHERE asset_id = 1
ORDER BY valid_from DESC;
```

Dovresti vedere:

- una versione chiusa (`is_current = FALSE`)  
- una nuova versione (`is_current = TRUE`)  

---

# 6. Note operative

- Non modificare manualmente `valid_from`, `valid_to`, `is_current`  
- Usare sempre `WHERE is_current = TRUE` negli UPDATE  
- Per eliminare una riga, usare soft-delete (es. `status = 'disattivo'`)  
- Per ricostruire lo storico, usare `ORDER BY valid_from`  

---

# Deploy completato

Il database è ora pronto per:

- gestione versionata degli asset  
- mappatura dei servizi  
- gestione delle dipendenze  
- responsabilità interne  
- compliance NIS2/ACN  

