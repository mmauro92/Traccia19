-- =========================================================
-- Schema per registro asset/servizi NIS2 - esempio : fornitore cloud
-- RDBMS: PostgreSQL
-- =========================================================

-- -------------------------
-- ORGANIZATION
-- -------------------------
CREATE TABLE organization (
    organization_id      SERIAL PRIMARY KEY,
    name                 VARCHAR(255) NOT NULL,
    sector               VARCHAR(100),
    nis_category         VARCHAR(50), -- essenziale / importante
    country              VARCHAR(100) DEFAULT 'Italy',
    created_at           TIMESTAMP NOT NULL DEFAULT NOW()
);

-- -------------------------
-- ASSET
-- -------------------------
CREATE TABLE asset (
    asset_id             SERIAL PRIMARY KEY,
    organization_id      INT NOT NULL,
    name                 VARCHAR(255) NOT NULL,
    description          TEXT,
    category             VARCHAR(100), -- applicazione, infrastruttura, dato, processo
    criticality_level    VARCHAR(50),  -- alto/medio/basso
    location             VARCHAR(255), -- es. "DC Milano", "AWS eu-central-1"
    status               VARCHAR(50),  -- attivo, dismesso
    valid_from           TIMESTAMP NOT NULL DEFAULT NOW(),
    valid_to             TIMESTAMP,
    is_current           BOOLEAN NOT NULL DEFAULT TRUE
);

-- -------------------------
-- SERVICE
-- -------------------------
CREATE TABLE service (
    service_id           SERIAL PRIMARY KEY,
    organization_id      INT NOT NULL,
    name                 VARCHAR(255) NOT NULL,
    description          TEXT,
    category             VARCHAR(100), -- es. IaaS, PaaS, SaaS
    criticality_level    VARCHAR(50),
    status               VARCHAR(50),
    valid_from           TIMESTAMP NOT NULL DEFAULT NOW(),
    valid_to             TIMESTAMP,
    is_current           BOOLEAN NOT NULL DEFAULT TRUE
);

-- -------------------------
-- SERVICE_ASSET (M:N)
-- -------------------------
CREATE TABLE service_asset (
    service_id           INT NOT NULL,
    asset_id             INT NOT NULL,
    relation_type        VARCHAR(100), -- utilizza, ospitato su, dipende da
    PRIMARY KEY (service_id, asset_id)
);

-- -------------------------
-- THIRD_PARTY (fornitori terzi)
-- -------------------------
CREATE TABLE third_party (
    third_party_id       SERIAL PRIMARY KEY,
    name                 VARCHAR(255) NOT NULL,
    type                 VARCHAR(100), -- cloud provider, telco, outsourcer...
    country              VARCHAR(100),
    contact_email        VARCHAR(255),
    contact_phone        VARCHAR(50)
);

-- -------------------------
-- DEPENDENCY (dipendenze da terze parti)
-- -------------------------
CREATE TABLE dependency (
    dependency_id        SERIAL PRIMARY KEY,
    organization_id      INT NOT NULL,
    third_party_id       INT NOT NULL,
    service_id           INT,
    asset_id             INT,
    dependency_type      VARCHAR(100), -- hosting, connettività, SaaS, supporto
    description          TEXT,
    valid_from           TIMESTAMP NOT NULL DEFAULT NOW(),
    valid_to             TIMESTAMP,
    is_current           BOOLEAN NOT NULL DEFAULT TRUE,
    CHECK (
        (service_id IS NOT NULL AND asset_id IS NULL)
        OR (service_id IS NULL AND asset_id IS NOT NULL)
    )
);

-- -------------------------
-- PERSON (persone/ruoli)
-- -------------------------
CREATE TABLE person (
    person_id            SERIAL PRIMARY KEY,
    organization_id      INT NOT NULL,
    first_name           VARCHAR(100) NOT NULL,
    last_name            VARCHAR(100) NOT NULL,
    email                VARCHAR(255),
    phone                VARCHAR(50),
    role_name            VARCHAR(100), -- CISO, Service Owner, ecc.
    is_nis_contact       BOOLEAN NOT NULL DEFAULT FALSE
);

-- -------------------------
-- RESPONSIBILITY
-- -------------------------
CREATE TABLE responsibility (
    responsibility_id    SERIAL PRIMARY KEY,
    organization_id      INT NOT NULL,
    person_id            INT NOT NULL,
    service_id           INT,
    asset_id             INT,
    responsibility_type  VARCHAR(100), -- owner, custodian, risk owner
    valid_from           TIMESTAMP NOT NULL DEFAULT NOW(),
    valid_to             TIMESTAMP,
    is_current           BOOLEAN NOT NULL DEFAULT TRUE,
    CHECK (
        (service_id IS NOT NULL AND asset_id IS NULL)
        OR (service_id IS NULL AND asset_id IS NOT NULL)
    )
);
