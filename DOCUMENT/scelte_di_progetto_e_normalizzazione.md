# Descrizione delle scelte di normalizzazione e dei trade‑off

## 1. Scelte di normalizzazione

### 1.1 Prima Forma Normale (1NF)
- Tutti gli attributi sono atomici.
- Nessun campo multivalore.
- Nessun gruppo ripetuto.
- Le relazioni molti‑a‑molti sono gestite tramite tabelle dedicate (es. `service_asset`).

### 1.2 Seconda Forma Normale (2NF)
- Nessuna dipendenza parziale da chiavi composte.
- Le tabelle principali utilizzano chiavi surrogate (`*_id`).
- Le tabelle associative hanno PK composte senza attributi dipendenti da una sola parte della chiave.

### 1.3 Terza Forma Normale (3NF)
- Nessuna dipendenza transitiva.
- Le informazioni sono collocate nelle rispettive entità (es. fornitori in `third_party`, persone in `person`).
- Nessuna ridondanza non necessaria.

---

## 2. Scelte architetturali aggiuntive

### 2.1 Uso di chiavi surrogate
- Facilita le relazioni.
- Evita PK composite nelle tabelle principali.
- Supporta il versioning.

### 2.2 Versioning (SCD2)
Campi utilizzati:
- `valid_from`
- `valid_to`
- `is_current`

Vantaggi:
- storico completo
- auditabilità
- ricostruzione dello stato passato

Svantaggi:
- maggiore spazio
- maggiore complessità
- necessità di trigger

### 2.3 Tabelle di relazione
- `service_asset` per relazioni molti‑a‑molti.
- `dependency` per modellare dipendenze complesse.

Trade‑off:
- più join
- maggiore flessibilità e coerenza

### 2.4 Separazione tra entità statiche e dinamiche
- Anche entità come `person`, `third_party`, `organization` sono versionate.
- Necessario per compliance NIS2/ACN.

---

## 3. Trade‑off principali

### 3.1 Complessità vs. tracciabilità
- Modello più complesso.
- Massima auditabilità e conformità normativa.

### 3.2 Performance vs. integrità
- Molte FK e trigger rallentano gli UPDATE.
- Integrità referenziale garantita.

### 3.3 Spazio vs. storico
- Il versioning aumenta lo spazio occupato.
- Storico completo richiesto da NIS2/ACN.

