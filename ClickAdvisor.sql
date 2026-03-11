-- SETUP SESSIONE
ALTER SESSION SET NLS_NUMERIC_CHARACTERS = '.,';
ALTER SESSION SET container = xepdb1;
ALTER SESSION SET current_schema = AMMINISTRATORE_DB;

-- CREAZIONE TABELLE
CREATE TABLE  "UTENTE" (	
    "ID_Utente" VARCHAR2(22) SUBSTR(RAWTOHEX(SYS_GUID()), 1, 22) NOT NULL ENABLE, 
	"Nome" VARCHAR2(50) NOT NULL ENABLE, 
    "Data_iscrizione" DATE NOT NULL ENABLE,
	"Num_recensioni" NUMBER(*,0) NOT NULL ENABLE, 
	"Num_cool" NUMBER(*,0) NOT NULL ENABLE, 
	"Num_funny" NUMBER(*,0) NOT NULL ENABLE, 
	"Num_useful" NUMBER(*,0) NOT NULL ENABLE, 
	"Media_recensioni" NUMBER NOT NULL ENABLE, 
	 CONSTRAINT "PK_UTENTE" PRIMARY KEY ("ID_Utente")
)

CREATE TABLE  "ATTIVITA" (
    "ID_Attivita" VARCHAR2(22) SUBSTR(RAWTOHEX(SYS_GUID()), 1, 22) NOT NULL ENABLE,
	"Nome" VARCHAR2(50) NOT NULL ENABLE, 
	"Indirizzo" VARCHAR2(50) DEFAULT 'N/D' NOT NULL ENABLE, 
	"Citta" VARCHAR2(50) NOT NULL ENABLE, 
	"Stato" VARCHAR2(50) NOT NULL ENABLE, 
	"CAP" VARCHAR2(10) NOT NULL ENABLE, 
	"Latitudine" FLOAT(126) NOT NULL ENABLE, 
	"Longitudine" FLOAT(126) NOT NULL ENABLE, 
    "Stelle" NUMBER(3,2) NOT NULL ENABLE, 
	"Num_recensioni" NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE, 
	"Stato_apertura" NUMBER(1,0) DEFAULT 0 NOT NULL ENABLE, 
        CONSTRAINT "BOOL_STATO_APERTURA" CHECK ("Stato_apertura" IN (0,1)) ENABLE, 
        CONSTRAINT "PK_ATTIVITA" PRIMARY KEY ("ID_Attivita"), 
        CONSTRAINT "CHECK_LIMITE_STELLE_ATTIVITA" CHECK ("Stelle" >= 1 AND "Stelle" <= 5) ENABLE,
        CONSTRAINT "CHECK_LAT" CHECK ("Latitudine" BETWEEN -90 AND 90) ENABLE,
        CONSTRAINT "CHECK_LON" CHECK ("Longitudine" BETWEEN -180 AND 180) ENABLE
)

CREATE TABLE  "RECENSIONE" (
    "ID_Recensione" VARCHAR2(22) SUBSTR(RAWTOHEX(SYS_GUID()), 1, 22) NOT NULL ENABLE, 
    "Stelle" NUMBER(*,0) NOT NULL ENABLE, 
    "Data" DATE NOT NULL ENABLE,
    "Testo" VARCHAR2(3000), 
	"Num_cool" NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE, 
	"Num_funny" NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE, 
	"Num_useful" NUMBER(*,0) DEFAULT 0 NOT NULL ENABLE, 
    "ID_Utente" VARCHAR2(22) NOT NULL ENABLE, 
    "ID_Attivita" VARCHAR2(22) NOT NULL ENABLE,
        CONSTRAINT "PK_RECENSIONE" PRIMARY KEY ("ID_Recensione"),
        CONSTRAINT "CHECK_LIMITE_STELLE_RECENSIONE" CHECK ("Stelle" >= 1 AND "Stelle" <= 5) ENABLE
)

CREATE TABLE  "AMICI" (
    "ID_Utente" VARCHAR2(22), 
	"ID_Amico" VARCHAR2(22), 
	    CONSTRAINT "PK_AMICI" PRIMARY KEY ("ID_Utente", "ID_Amico")
)

CREATE TABLE  "CHECKIN" (
    "ID_Attivita" VARCHAR2(22), 
	"ID_Utente" VARCHAR2(22), 
	"Timestamp" DATE, 
	    CONSTRAINT "PK_CHECKIN" PRIMARY KEY ("ID_Attivita", "ID_Utente", "Timestamp")
)

CREATE TABLE  "FOTO" (
    "ID_Foto" VARCHAR2(22), 
	"Didascialia" VARCHAR2(3000), 
	"Etichetta" VARCHAR2(200), 
    "ID_Utente" VARCHAR2(22) NOT NULL ENABLE, 
    "ID_Attivita" VARCHAR2(22) NOT NULL ENABLE,
	    CONSTRAINT "PK_FOTO" PRIMARY KEY ("ID_Foto")
)

CREATE TABLE  "SUGGERIMENTO" (
    "Testo" VARCHAR2(3000), 
	"Data_caricamento" DATE, 
	"Num_complimenti" NUMBER(*,0) DEFAULT 0, 
    "ID_Utente" VARCHAR2(22) NOT NULL ENABLE, 
    "ID_Attivita" VARCHAR2(22) NOT NULL ENABLE,
        CONSTRAINT "PK_SUGGERIMENTO" PRIMARY KEY ("ID_Utente", "ID_Attivita", "Data_caricamento")
)

CREATE TABLE  "CATEGORIA" (	
    "ID_Categoria" VARCHAR2(22) DEFAULT SUBSTR(RAWTOHEX(SYS_GUID()), 1, 22) NOT NULL ENABLE, 
	"Nome" VARCHAR2(50) NOT NULL ENABLE, 
	    CONSTRAINT "PK_CATEGORIA" PRIMARY KEY ("ID_Categoria")
)

CREATE TABLE  "APPARTIENE_A" (	
    "ID_Attivita" VARCHAR2(22),
	"ID_Categoria" VARCHAR2(22),
	    CONSTRAINT "PK_APPARTIENE" PRIMARY KEY ("ID_Attivita", "ID_Categoria")
)

CREATE TABLE  "ORARIO" (
    "ID_Orario" VARCHAR2(22) DEFAULT SUBSTR(RAWTOHEX(SYS_GUID()), 1, 22) NOT NULL ENABLE, 
	"Giorno" VARCHAR2(10) NOT NULL ENABLE, 
	"Ora_apertura" TIMESTAMP NOT NULL ENABLE, 
	"Ora_chiusura" TIMESTAMP NOT NULL ENABLE,
    "ID_Attivita" VARCHAR2(22),
	    CONSTRAINT "PK_ORARIO" PRIMARY KEY ("ID_Orario")
)

CREATE TABLE  "ATTRIBUTO" (	
    "ID_Attributo" VARCHAR2(22) DEFAULT SUBSTR(RAWTOHEX(SYS_GUID()), 1, 22) NOT NULL ENABLE,
	"Nome" VARCHAR2(50) NOT NULL ENABLE, 
	    CONSTRAINT "PK_ATTRIBUTO" PRIMARY KEY ("ID_Attributo")
)

CREATE TABLE  "POSSIEDE" (
    "ID_Attivita" VARCHAR2(22), 
	"ID_Attributo" VARCHAR2(22), 
	    CONSTRAINT "PK_OFFRE" PRIMARY KEY ("ID_Attivita", "ID_Attributo")
)

-- Collegamenti Tabella RECENSIONE
ALTER TABLE "RECENSIONE" ADD CONSTRAINT "FK_RECENSIONE_UTENTE" FOREIGN KEY ("ID_Utente")
      REFERENCES "UTENTE" ("ID_Utente") ENABLE;

ALTER TABLE "RECENSIONE" ADD CONSTRAINT "FK_RECENSIONE_ATTIVITA" FOREIGN KEY ("ID_Attivita")
      REFERENCES "ATTIVITA" ("ID_Attivita") ENABLE;

-- Collegamenti Tabella AMICI
ALTER TABLE "AMICI" ADD CONSTRAINT "FK_AMICI_UTENTE" FOREIGN KEY ("ID_Utente")
      REFERENCES "UTENTE" ("ID_Utente") ENABLE;

ALTER TABLE "AMICI" ADD CONSTRAINT "FK_AMICI_AMICO" FOREIGN KEY ("ID_Amico")
      REFERENCES "UTENTE" ("ID_Utente") ENABLE;

-- Collegamenti Tabella CHECKIN
ALTER TABLE "CHECKIN" ADD CONSTRAINT "FK_CHECKIN_ATTIVITA" FOREIGN KEY ("ID_Attivita")
      REFERENCES "ATTIVITA" ("ID_Attivita") ENABLE;

ALTER TABLE "CHECKIN" ADD CONSTRAINT "FK_CHECKIN_UTENTE" FOREIGN KEY ("ID_Utente")
      REFERENCES "UTENTE" ("ID_Utente") ENABLE;

-- Collegamenti Tabella FOTO
ALTER TABLE "FOTO" ADD CONSTRAINT "FK_FOTO_UTENTE" FOREIGN KEY ("ID_Utente")
      REFERENCES "UTENTE" ("ID_Utente") ENABLE;

ALTER TABLE "FOTO" ADD CONSTRAINT "FK_FOTO_ATTIVITA" FOREIGN KEY ("ID_Attivita")
      REFERENCES "ATTIVITA" ("ID_Attivita") ENABLE;

-- Collegamenti Tabella SUGGERIMENTO
ALTER TABLE "SUGGERIMENTO" ADD CONSTRAINT "FK_SUGGERIMENTO_UTENTE" FOREIGN KEY ("ID_Utente")
      REFERENCES "UTENTE" ("ID_Utente") ENABLE;

ALTER TABLE "SUGGERIMENTO" ADD CONSTRAINT "FK_SUGGERIMENTO_ATTIVITA" FOREIGN KEY ("ID_Attivita")
      REFERENCES "ATTIVITA" ("ID_Attivita") ENABLE;

-- Collegamenti Tabella APPARTIENE_A
ALTER TABLE "APPARTIENE_A" ADD CONSTRAINT "FK_APPARTIENE_ATTIVITA" FOREIGN KEY ("ID_Attivita")
      REFERENCES "ATTIVITA" ("ID_Attivita") ENABLE;

ALTER TABLE "APPARTIENE_A" ADD CONSTRAINT "FK_APPARTIENE_CATEGORIA" FOREIGN KEY ("ID_Categoria")
      REFERENCES "CATEGORIA" ("ID_Categoria") ENABLE;

-- Collegamenti Tabella ORARIO
ALTER TABLE "ORARIO" ADD CONSTRAINT "FK_ORARIO_ATTIVITA" FOREIGN KEY ("ID_Attivita")
      REFERENCES "ATTIVITA" ("ID_Attivita") ENABLE;

-- Collegamenti Tabella POSSIEDE (Previa correzione dei tipi di dato in VARCHAR2)
ALTER TABLE "POSSIEDE" ADD CONSTRAINT "FK_POSSIEDE_ATTIVITA" FOREIGN KEY ("ID_Attivita")
      REFERENCES "ATTIVITA" ("ID_Attivita") ENABLE;

ALTER TABLE "POSSIEDE" ADD CONSTRAINT "FK_POSSIEDE_ATTRIBUTO" FOREIGN KEY ("ID_Attributo")
      REFERENCES "ATTRIBUTO" ("ID_Attributo") ENABLE;


--INDICI PER MIGLIORARE LA PERFORMANCE
-- Indici per la tabella RECENSIONE (Join frequenti tra Utenti e Attivita')
CREATE INDEX IDX_FK_REC_UTENTE ON RECENSIONE ("ID_Utente");
CREATE INDEX IDX_FK_REC_ATTIVITA ON RECENSIONE ("ID_Attivita");

-- Indici per la tabella AMICI (Velocizza la ricerca di chi e' amico di un dato utente)
CREATE INDEX IDX_FK_AMICI_AMICO ON AMICI ("ID_Amico");

-- Indici per i contenuti multimediali (FOTO)
CREATE INDEX IDX_FK_FOTO_UTENTE ON FOTO ("ID_Utente");
CREATE INDEX IDX_FK_FOTO_ATTIVITA ON FOTO ("ID_Attivita");

-- Indice per gli orari delle attivita'
CREATE INDEX IDX_FK_ORARIO_ATTIVITA ON ORARIO ("ID_Attivita");

-- Indici per le tabelle di associazione (N:M)
CREATE INDEX IDX_FK_APPARTIENE_CAT ON APPARTIENE_A ("ID_Categoria");
CREATE INDEX IDX_FK_POSSIEDE_ATTR ON POSSIEDE ("ID_Attributo");

-- Ricerca rapida di un'attivita' per nome
CREATE INDEX IDX_ATTIVITA_NOME ON ATTIVITA ("Nome");

-- Ricerca rapida di un utente per nome
CREATE INDEX IDX_UTENTE_NOME ON UTENTE ("Nome");

-- Per visualizzare le ultime recensioni pubblicate
CREATE INDEX IDX_RECENSIONE_DATA_DESC ON RECENSIONE ("Data" DESC);

-- Per visualizzare gli ultimi suggerimenti caricati
CREATE INDEX IDX_SUGGERIMENTO_DATA_DESC ON SUGGERIMENTO ("Data_caricamento" DESC);

--QUERY STATISTICHE
--Attivita' con la valutazione media piu' alta in una citta'
SELECT "Nome", "Indirizzo", "Stelle", "Num_recensioni"
FROM ATTIVITA
WHERE "Citta" = 'Tampa'
ORDER BY "Stelle" DESC, "Num_recensioni" DESC
FETCH FIRST 10 ROWS ONLY;

--Numero medio di recensioni per categoria
SELECT c."Nome" AS "Categoria", ROUND(AVG(a."Num_recensioni"), 2) AS "Media_Recensioni"
FROM "CATEGORIA" c
JOIN "APPARTIENE_A" aa ON c."ID_Categoria" = aa."ID_Categoria"
JOIN "ATTIVITA" a ON aa."ID_Attivita" = a."ID_Attivita"
GROUP BY c."Nome"
ORDER BY "Media_Recensioni" DESC;

--Utenti piu' attivi o con il maggior numero di complimenti
SELECT "Nome", 
       "Num_recensioni", 
       ("Num_cool" + "Num_funny" + "Num_useful") AS "Totale_Complimenti"
FROM "UTENTE"
ORDER BY "Num_recensioni" DESC, "Totale_Complimenti" DESC
FETCH FIRST 10 ROWS ONLY;

--Distribuzione temporale dei check-in
SELECT TO_CHAR("Timestamp", 'HH24') AS "Fascia_Oraria", 
       COUNT(*) AS "Numero_Checkin"
FROM "CHECKIN"
GROUP BY TO_CHAR("Timestamp", 'HH24')
ORDER BY "Fascia_Oraria";

--Categorie di attivita' con maggiore densita' di fotografie
SELECT c."Nome" AS "Categoria", 
       COUNT(f."ID_Foto") AS "Totale_Foto"
FROM "CATEGORIA" c
JOIN "APPARTIENE_A" aa ON c."ID_Categoria" = aa."ID_Categoria"
LEFT JOIN "FOTO" f ON aa."ID_Attivita" = f."ID_Attivita"
GROUP BY c."Nome"
ORDER BY "Totale_Foto" DESC;

--Attivita della categoria 'Italian' con piu' recensioni e foto
SELECT 
    a."Nome", 
    a."Num_recensioni", 
    COUNT(f."ID_Foto") AS "Totale_Foto",
    (a."Num_recensioni" + COUNT(f."ID_Foto")) AS "Totale_Combinato"
FROM "ATTIVITA" a
JOIN "APPARTIENE_A" aa ON a."ID_Attivita" = aa."ID_Attivita"
JOIN "CATEGORIA" c ON aa."ID_Categoria" = c."ID_Categoria"
LEFT JOIN "FOTO" f ON a."ID_Attivita" = f."ID_Attivita"
WHERE c."Nome" = 'Italian'
GROUP BY a."ID_Attivita", a."Nome", a."Num_recensioni"
ORDER BY "Totale_Combinato" DESC
FETCH FIRST 10 ROWS ONLY;

--Distribuzione percentuale delle recensioni delle attivita con attributo 'GoodForKids'
SELECT 
    r."Stelle", 
    COUNT(*) AS "Conteggio_Recensioni",
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS "Percentuale"
FROM "RECENSIONE" r
JOIN "POSSIEDE" p ON r."ID_Attivita" = p."ID_Attivita"
JOIN "ATTRIBUTO" attr ON p."ID_Attributo" = attr."ID_Attributo"
WHERE attr."Nome" = 'GoodForKids'
GROUP BY r."Stelle"
ORDER BY r."Stelle" DESC;

--STORED PROCEDURE
--SP per eliminare ogni traccia di un utente dal DB
CREATE OR REPLACE PROCEDURE "Elimina_Utente_Completo" (
    p_ID_Utente IN VARCHAR2
) AS
BEGIN
    -- 1. Eliminazione dalle relazioni di amicizia (sia come utente che come amico)
    DELETE FROM "AMICI" 
    WHERE "ID_Utente" = p_ID_Utente OR "ID_Amico" = p_ID_Utente;

    -- 2. Eliminazione dei check-in registrati dall'utente
    DELETE FROM "CHECKIN" 
    WHERE "ID_Utente" = p_ID_Utente;

    -- 3. Eliminazione delle fotografie caricate dall'utente
    DELETE FROM "FOTO" 
    WHERE "ID_Utente" = p_ID_Utente;

    -- 4. Eliminazione dei suggerimenti rapidi pubblicati dall'utente
    DELETE FROM "SUGGERIMENTO" 
    WHERE "ID_Utente" = p_ID_Utente;

    -- 5. Eliminazione delle recensioni scritte dall'utente
    DELETE FROM "RECENSIONE" 
    WHERE "ID_Utente" = p_ID_Utente;

    -- 6. Infine, eliminazione del profilo utente principale
    DELETE FROM "UTENTE" 
    WHERE "ID_Utente" = p_ID_Utente;

    COMMIT;
END;

--SP per correggere stelle e testo di una recensione
CREATE OR REPLACE PROCEDURE "Correggi_Recensione" (
    p_ID_Recensione IN VARCHAR2,
    p_Nuove_Stelle IN NUMBER,
    p_Nuovo_Testo IN VARCHAR2
) AS
    v_ID_Attivita VARCHAR2(22);
BEGIN
    -- 1. Recupero l'ID dell'attivita' associata alla recensione per aggiornare la media in seguito
    SELECT "ID_Attivita" INTO v_ID_Attivita
    FROM "RECENSIONE"
    WHERE "ID_Recensione" = p_ID_Recensione;

    -- 2. Aggiornamento del testo e delle stelle nella tabella RECENSIONE
    -- Il database verifichera' automaticamente il vincolo CHECK_LIMITE_STELLE_RECENSIONE
    UPDATE "RECENSIONE"
    SET "Stelle" = p_Nuove_Stelle,
        "Testo" = p_Nuovo_Testo,
        "Data" = SYSDATE -- Opzionale: aggiorna la data all'ultimo intervento
    WHERE "ID_Recensione" = p_ID_Recensione;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Errore: ID Recensione non trovato.');
    WHEN OTHERS THEN
        ROLLBACK;
        RAISE;
END;

--SP per modificare la didascalia di una foto
CREATE OR REPLACE PROCEDURE "Cambia_Didascalia_Foto" (
    p_ID_Foto IN VARCHAR2,
    p_Nuova_Didascalia IN VARCHAR2
) AS
BEGIN
    -- Aggiornamento della didascalia per la foto identificata dall'ID univoco
    UPDATE "FOTO"
    SET "Didascialia" = p_Nuova_Didascalia
    WHERE "ID_Foto" = p_ID_Foto;

    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        -- In caso di errore imprevisto, annulla l'operazione
        ROLLBACK;
        RAISE;
END;

--TRIGGER
--Modifica Num_recensioni e Media_recensioni in Utente ad ogni aggiunta/modifica/eliminazione di una recensione
CREATE OR REPLACE TRIGGER "TRG_AGGIORNA_STATISTICHE_RECENSIONE"
AFTER INSERT OR UPDATE OR DELETE ON "RECENSIONE"
FOR EACH ROW
DECLARE
    v_id_attivita VARCHAR2(22);
    v_id_utente   VARCHAR2(22);
BEGIN
    -- Gestione degli ID per le operazioni di INSERT/UPDATE (NEW) e DELETE (OLD)
    IF DELETING THEN
        v_id_attivita := :OLD."ID_Attivita";
        v_id_utente   := :OLD."ID_Utente";
    ELSE
        v_id_attivita := :NEW."ID_Attivita";
        v_id_utente   := :NEW."ID_Utente";
    END IF;

    -- 1. Aggiornamento statistiche dell'ATTIVITA (Stelle e Num_recensioni) [1]
    UPDATE "ATTIVITA"
    SET "Stelle" = (SELECT AVG("Stelle") FROM "RECENSIONE" WHERE "ID_Attivita" = v_id_attivita),
        "Num_recensioni" = (SELECT COUNT(*) FROM "RECENSIONE" WHERE "ID_Attivita" = v_id_attivita)
    WHERE "ID_Attivita" = v_id_attivita;

    -- 2. Aggiornamento statistiche dell'UTENTE (Media_recensioni e Num_recensioni) [1]
    UPDATE "UTENTE"
    SET "Media_recensioni" = (SELECT NVL(AVG("Stelle"), 0) FROM "RECENSIONE" WHERE "ID_Utente" = v_id_utente),
        "Num_recensioni" = (SELECT COUNT(*) FROM "RECENSIONE" WHERE "ID_Utente" = v_id_utente)
    WHERE "ID_Utente" = v_id_utente;
END;

--Modifica Num_recensioni e Stelle in Attivita' ad ogni aggiunta/modifica/eliminazione di una recensione
CREATE OR REPLACE TRIGGER "TRG_AGGIORNA_VALUTAZIONE_ATTIVITA"
AFTER INSERT OR UPDATE OR DELETE ON "RECENSIONE"
FOR EACH ROW
BEGIN
    -- Aggiorna la media delle stelle e il numero totale di recensioni per l'attivita' interessata
    UPDATE "ATTIVITA"
    SET "Stelle" = (
        SELECT AVG("Stelle") 
        FROM "RECENSIONE" 
        WHERE "ID_Attivita" = :NEW."ID_Attivita"
    ),
    "Num_recensioni" = (
        SELECT COUNT(*) 
        FROM "RECENSIONE" 
        WHERE "ID_Attivita" = :NEW."ID_Attivita"
    )
    WHERE "ID_Attivita" = :NEW."ID_Attivita";
END;

--Rimozione relazione speculare alla rimozione di una amicizia
CREATE OR REPLACE TRIGGER "TRG_RIMUOVI_AMICIZIA_SIMMETRICA"
AFTER DELETE ON "AMICI"
FOR EACH ROW
BEGIN
    -- Elimina la relazione speculare (Amico -> Utente) 
    -- per garantire che l'amicizia rimanga sempre reciproca.
    DELETE FROM "AMICI"
    WHERE "ID_Utente" = :OLD."ID_Amico"
      AND "ID_Amico" = :OLD."ID_Utente";
END;

--VISTE
--Vista delle recensioni senza didascalia
CREATE VIEW "V_FOTO_SENZA_ETICHETTA" AS
SELECT "ID_Foto", "Etichetta", "ID_Utente", "ID_Attivita"
FROM "FOTO"
WHERE "Didascialia" IS NULL;

--Vista recensioni caricate nell'ultimo mese
CREATE VIEW "V_RECENSIONI_ULTIMO_MESE" AS
SELECT *
FROM "RECENSIONE"
WHERE "Data" >= SYSDATE - 30;

--Orari delle attivita' aperte il lunedi'
CREATE VIEW "V_ORARI_LUNEDI" AS
SELECT a."Nome", o."Ora_apertura", o."Ora_chiusura", a."Citta"
FROM "ORARIO" o
JOIN "ATTIVITA" a ON o."ID_Attivita" = a."ID_Attivita"
WHERE o."Giorno" = 'Monday';

--UTENTI E GRANT
-- Creazione Amministratore
CREATE USER "AMMINISTRATORE_DB" IDENTIFIED BY "passamministratore";
-- Assegnazione Privilegi Completi
GRANT ALL PRIVILEGES TO "AMMINISTRATORE_DB";

-- Creazione Moderatore
CREATE USER "MODERATORE_DB" IDENTIFIED BY "passmoderatore";
-- Privilegi di gestione sui contenuti generati dagli utenti
GRANT SELECT, UPDATE, DELETE ON "RECENSIONE" TO "MODERATORE_DB";
GRANT SELECT, UPDATE, DELETE ON "SUGGERIMENTO" TO "MODERATORE_DB";
GRANT SELECT, UPDATE, DELETE ON "FOTO" TO "MODERATORE_DB";
GRANT SELECT, DELETE ON "CHECKIN" TO "MODERATORE_DB";
-- Privilegi di sola lettura per consultazione profili e attivita'
GRANT SELECT ON "UTENTE" TO "MODERATORE_DB";
GRANT SELECT ON "ATTIVITA" TO "MODERATORE_DB";

-- Creazione Utente
CREATE USER "UTENTE_DB" IDENTIFIED BY "passutente";
-- Privilegi di consultazione generale
GRANT SELECT ON "ATTIVITA" TO "UTENTE_DB";
GRANT SELECT ON "CATEGORIA" TO "UTENTE_DB";
GRANT SELECT ON "ORARIO" TO "UTENTE_DB";
GRANT SELECT ON "ATTRIBUTO" TO "UTENTE_DB";
-- Privilegi di inserimento e modifica (solo sui contenuti con il loro ID)
GRANT INSERT, UPDATE, DELETE ON "RECENSIONE" TO "UTENTE_DB";
GRANT INSERT, UPDATE, DELETE ON "SUGGERIMENTO" TO "UTENTE_DB";
GRANT INSERT, UPDATE, DELETE ON "FOTO" TO "UTENTE_DB";
GRANT INSERT ON "CHECKIN" TO "UTENTE_DB";
-- Privilegi per interazioni sociali
GRANT INSERT, DELETE ON "AMICI" TO "UTENTE_DB";

--Prompt in linguaggio naturale
--Diamo i diritti di utilizzo di Select AI all'amministratore
GRANT EXECUTE ON DBMS_CLOUD_AI TO AMMINISTRATORE_DB;

--Diamo i permessi di amministratore a Select AI
BEGIN
    DBMS_CLOUD_ADMIN.ENABLE_PRINCIPAL_AUTH(provider => 'OCI',username =>'AMMINISTRATORE_DB');
END;

--Creiamo un profilo per configurare Select AI sul nostro DB
BEGIN
    DBMS_CLOUD_AI.CREATE_PROFILE(
    'OCI_GENAI',
    '{
        "provider": "oci",
        "credential_name": "OCI$RESOURCE_PRINCIPAL",
        "object_list": [
            {
                "owner": "AMMINISTRATORE_DB"
            }
        ],
        "model": "cohere.command-light",
        "oci_runtimetype": "COHERE",
        "temperature":"0.4"
      }');
END;
EXEC DBMS_CLOUD_AI.set_profile('OCI_GENAI');

--Esempio di prompt
SELECT DBMS_CLOUD_AI.GENERATE(
    prompt       => 'Mostra tutte le attivita aperte il lunedi alle 10',
    profile_name => 'OCI_GENAI'
)
FROM dual;