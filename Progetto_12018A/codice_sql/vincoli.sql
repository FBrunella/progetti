-- vincolo 1
CREATE OR REPLACE FUNCTION check_medici_vice_primario()
RETURNS TRIGGER AS $$
BEGIN
    -- Verifica se uno dei medici ha il flag "vice" alzato
    IF (SELECT vice FROM Medico WHERE CF = NEW.CFMedico1) <> TRUE THEN
        RAISE EXCEPTION 'Il medico 1 deve avere il flag "vice" alzato';
    END IF;

    -- Verifica se l'altro medico ha il flag "primario" alzato
    IF (SELECT primario FROM Medico WHERE CF = NEW.CFMedico2) <> TRUE THEN
        RAISE EXCEPTION 'Il medico 2 deve avere il flag "primario" alzato';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_sostituzione
BEFORE INSERT OR UPDATE ON Sostituzione
FOR EACH ROW
EXECUTE FUNCTION check_medici_vice_primario();

-- vincolo 2
CREATE OR REPLACE FUNCTION check_medici_reparto_ospedale()
RETURNS TRIGGER AS $$
DECLARE
    reparto_ospedale_medico1 RECORD;
    reparto_ospedale_medico2 RECORD;
BEGIN
    -- Ottieni il reparto e il codice dell'ospedale associato al medico 1
    SELECT nomeReparto, codOspedale
    INTO reparto_ospedale_medico1
    FROM Medico
    WHERE CF = NEW.CFMedico1;

    -- Ottieni il reparto e il codice dell'ospedale associato al medico 2
    SELECT nomeReparto, codOspedale
    INTO reparto_ospedale_medico2
    FROM Medico
    WHERE CF = NEW.CFMedico2;

    -- Controlla se i reparti e i codici ospedalieri sono gli stessi
    IF reparto_ospedale_medico1 <> reparto_ospedale_medico2 THEN
        RAISE EXCEPTION 'Il medico 1 e il medico 2 devono essere nello stesso reparto dello stesso ospedale';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_sostituzione2
BEFORE INSERT OR UPDATE ON Sostituzione
FOR EACH ROW
EXECUTE FUNCTION check_medici_reparto_ospedale();

-- vincolo 3
CREATE OR REPLACE FUNCTION check_letto_non_occupato()
RETURNS TRIGGER AS $$
DECLARE
    letto_occupato BOOLEAN;
BEGIN
    -- Controlla se il letto è già occupato da un altro ricovero attivo con una data di ricovero diversa
    SELECT EXISTS (
        SELECT 1 
        FROM Ricovero R 
        WHERE R.codLetto = NEW.codLetto 
        AND R.DataDimissione IS NULL
        AND R.DataRicovero != NEW.DataRicovero
    )
    INTO letto_occupato;

    -- Se il letto è già occupato, genera un'eccezione
    IF letto_occupato THEN
        RAISE EXCEPTION 'Il letto è già occupato da un altro ricovero attivo con una data di ricovero diversa';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_ricovero
BEFORE INSERT OR UPDATE ON Ricovero
FOR EACH ROW
EXECUTE FUNCTION check_letto_non_occupato();


--vincolo 4
CREATE OR REPLACE FUNCTION check_solo_un_ricovero_attivo_per_paziente()
RETURNS TRIGGER AS $$
DECLARE
    numero_ricoveri_attivi INTEGER;
BEGIN
    -- Conta il numero di ricoveri attivi per il paziente
    SELECT COUNT(*)
    INTO numero_ricoveri_attivi
    FROM Ricovero
    WHERE nTesSanitariaPaziente = NEW.nTesSanitariaPaziente
    AND DataDimissione IS NULL;

    -- Se il numero di ricoveri attivi è maggiore di 1, genera un'eccezione
    IF numero_ricoveri_attivi > 1 THEN
        RAISE EXCEPTION 'Il paziente ha già un ricovero attivo';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_ricovero2
BEFORE INSERT OR UPDATE ON Ricovero
FOR EACH ROW
EXECUTE FUNCTION check_solo_un_ricovero_attivo_per_paziente();

--vincolo 5
CREATE OR REPLACE FUNCTION check_nTesSanitaria_prenotazione()
RETURNS TRIGGER AS $$
BEGIN
    -- Controlla se il valore di nTesSanitariaPaziente nella prenotazione è lo stesso della prescrizione
    IF NEW.nTesSanitariaPaziente IS NOT NULL THEN
        IF NEW.nTesSanitariaPaziente != (SELECT nTesSanitariaPaziente FROM Prescrizione WHERE codice = NEW.codPrescrizione) THEN
            RAISE EXCEPTION 'Il valore di nTesSanitariaPaziente nella prenotazione deve essere lo stesso della prescrizione (se non è null)';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_prenotazione
BEFORE INSERT OR UPDATE ON Prenotazione
FOR EACH ROW
EXECUTE FUNCTION check_nTesSanitaria_prenotazione();


-- vincolo 6
CREATE OR REPLACE FUNCTION check_medici_esterni()
RETURNS TRIGGER AS $$
BEGIN
    -- Controlla se solo uno dei campi CFMedico o CFMedEst è non nullo
    IF (NEW.CFMedico IS NULL AND NEW.CFMedEst IS NULL) OR
       (NEW.CFMedico IS NOT NULL AND NEW.CFMedEst IS NOT NULL) THEN
        RAISE EXCEPTION 'Devi specificare solo uno tra CFMedico e CFMedEst';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_prescrizione
BEFORE INSERT OR UPDATE ON Prescrizione
FOR EACH ROW
EXECUTE FUNCTION check_medici_esterni();


-- vincolo 11 infermieri
CREATE OR REPLACE FUNCTION check_infermiere_ospedale_pronto_soccorso()
RETURNS TRIGGER AS $$
DECLARE
    ospedale_infermiere INTEGER;
    ospedale_pronto_soccorso INTEGER;
BEGIN
    -- Ottieni il codice dell'ospedale associato all'infermiere
    SELECT codOspedale
    INTO ospedale_infermiere
    FROM Infermiere
    WHERE CF = NEW.CFInfermiere;

    -- Ottieni il codice dell'ospedale associato al pronto soccorso
    SELECT codOspedale
    INTO ospedale_pronto_soccorso
    FROM ProntoSoccorso
    WHERE Codice = NEW.codProntoSoccorso;

    -- Controlla se i codici degli ospedali sono diversi
    IF ospedale_infermiere <> ospedale_pronto_soccorso THEN
        RAISE EXCEPTION 'Il codice dell''ospedale associato all''infermiere non corrisponde al codice dell''ospedale associato al pronto soccorso';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_turni_infermieri
BEFORE INSERT OR UPDATE ON TurniInfermieri
FOR EACH ROW
EXECUTE FUNCTION check_infermiere_ospedale_pronto_soccorso();

--vincolo 11 medici
CREATE OR REPLACE FUNCTION check_medico_ospedale_pronto_soccorso()
RETURNS TRIGGER AS $$
DECLARE
    ospedale_medico INTEGER;
    ospedale_pronto_soccorso INTEGER;
BEGIN
    -- Ottieni il codice dell'ospedale associato al medico
    SELECT codOspedale
    INTO ospedale_medico
    FROM Medico
    WHERE CF = NEW.CFMedico;

    -- Ottieni il codice dell'ospedale associato al pronto soccorso
    SELECT codOspedale
    INTO ospedale_pronto_soccorso
    FROM ProntoSoccorso
    WHERE Codice = NEW.codProntoSoccorso;

    -- Controlla se i codici degli ospedali sono diversi
    IF ospedale_medico <> ospedale_pronto_soccorso THEN
        RAISE EXCEPTION 'Il codice dell''ospedale associato al medico non corrisponde al codice dell''ospedale associato al pronto soccorso';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_turni_medici
BEFORE INSERT OR UPDATE ON TurniMedici
FOR EACH ROW
EXECUTE FUNCTION check_medico_ospedale_pronto_soccorso();


-- vincolo 14
CREATE OR REPLACE FUNCTION check_unico_primario_per_reparto()
RETURNS TRIGGER AS $$
DECLARE
    count_primario INTEGER;
BEGIN
    SELECT COUNT(*)
    INTO count_primario
    FROM Medico AS M2
    WHERE M2.primario = TRUE AND M2.nomeReparto = NEW.nomeReparto;

    IF count_primario > 1 THEN
        RAISE EXCEPTION 'Ci può essere al massimo un medico primario per reparto';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_medico
BEFORE INSERT OR UPDATE ON Medico
FOR EACH ROW
EXECUTE FUNCTION check_unico_primario_per_reparto();

-- vincolo 15
CREATE OR REPLACE FUNCTION check_codice_esame_prenotazione()
RETURNS TRIGGER AS $$
BEGIN
    -- Controlla se il codice dell'esame in prenotazione è lo stesso di quello in prescrizione (se codPrescrizione non è null)
    IF NEW.codPrescrizione IS NOT NULL THEN
        IF NEW.codiceEsame != (SELECT codEs FROM Prescrizione WHERE codice = NEW.codPrescrizione) THEN
            RAISE EXCEPTION 'Il codice dell''esame in prenotazione deve essere lo stesso di quello in prescrizione (se codPrescrizione non è null)';
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_prenotazione2
BEFORE INSERT OR UPDATE ON Prenotazione
FOR EACH ROW
EXECUTE FUNCTION check_codice_esame_prenotazione();


-- vincolo 18
CREATE OR REPLACE FUNCTION check_duplicate_lab_code()
RETURNS TRIGGER AS $$
DECLARE
    lab_code_exists INTEGER;
BEGIN
    -- Controlla se il codice del laboratorio esiste già in LaboratorioInterno
    SELECT COUNT(*)
    INTO lab_code_exists
    FROM LaboratorioInterno
    WHERE codice = NEW.codice;

    IF lab_code_exists > 0 THEN
        RAISE EXCEPTION 'Il codice del laboratorio esiste già in LaboratorioInterno';
    END IF;

    -- Controlla se il codice del laboratorio esiste già in LaboratorioEsterno
    SELECT COUNT(*)
    INTO lab_code_exists
    FROM LaboratorioEsterno
    WHERE codice = NEW.codice;

    IF lab_code_exists > 0 THEN
        RAISE EXCEPTION 'Il codice del laboratorio esiste già in LaboratorioEsterno';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- vincolo 19
CREATE TRIGGER before_insert_lab_est
BEFORE INSERT ON LaboratorioEsterno
FOR EACH ROW
EXECUTE FUNCTION check_duplicate_lab_code();

CREATE TRIGGER before_insert_lab_int
BEFORE INSERT ON LaboratorioInterno
FOR EACH ROW
EXECUTE FUNCTION check_duplicate_lab_code();

CREATE OR REPLACE FUNCTION check_specializzazione_medico()
RETURNS TRIGGER AS $$
DECLARE
    esame_specializzazione VARCHAR(255);
BEGIN
    -- Recupera il nome della specializzazione dell'esame associato alla prescrizione
    SELECT nomeSpecializzazione
    INTO esame_specializzazione
    FROM Esame
    WHERE codEs = NEW.codEs;

    -- Verifica se almeno uno dei campi CFMedico o CFMedEst ha la specializzazione richiesta
    IF (NEW.CFMedico IS NOT NULL AND EXISTS (
            SELECT 1 
            FROM MedicoSpecializzazioni MS
            WHERE MS.CF = NEW.CFMedico AND MS.NomeSpecializzazione = esame_specializzazione
        )) OR 
       (NEW.CFMedEst IS NOT NULL AND EXISTS (
            SELECT 1 
            FROM MedicoSpecializzazioni MS
            WHERE MS.CF = NEW.CFMedEst AND MS.NomeSpecializzazione = esame_specializzazione
        )) THEN
        RETURN NEW;
    ELSE
        RAISE EXCEPTION 'Il medico in questione non può prescrivere questo esame';
    END IF;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_update_prescrizione2
BEFORE INSERT OR UPDATE ON Prescrizione
FOR EACH ROW
EXECUTE FUNCTION check_specializzazione_medico();

-- quando viene inserito un letto l'utilizzo di stanza cambia in stanza da letto
CREATE OR REPLACE FUNCTION update_utilizzo_stanza()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Stanza
    SET utilizzo = 'stanza da letto'
    WHERE numero = NEW.numeroStanza
        AND piano = NEW.pianoStanza
        AND nomeReparto = NEW.nomeReparto
        AND codOspedale = NEW.codOspedale;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_utilizzo_stanza
AFTER INSERT ON Letto
FOR EACH ROW
EXECUTE FUNCTION update_utilizzo_stanza();

-- quando un laboratorio viene associato ad una stanza cambia l'utilizzo di stanza
CREATE OR REPLACE FUNCTION update_utilizzo_stanza_laboratorio()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE Stanza
    SET utilizzo = 'laboratorio'
    WHERE numero = NEW.numeroStanza
        AND piano = NEW.pianoStanza
        AND codOspedale = NEW.codOspedale;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_utilizzo_stanza_laboratorio
AFTER INSERT ON LaboratorioInterno
FOR EACH ROW
EXECUTE FUNCTION update_utilizzo_stanza_laboratorio();

CREATE OR REPLACE FUNCTION check_lab_availability() RETURNS trigger AS $$
DECLARE
    giorno VARCHAR(20);
    giorno_italiano VARCHAR(20);
    prenotazione_inizio TIME;
    prenotazione_fine TIME;
    count_lab INT;
BEGIN
    -- Determina il giorno della settimana dalla data e ora della prenotazione
    giorno := to_char(NEW.dateTimeEs, 'Day');
    -- Rimuovi spazi bianchi dalla stringa giorno
    giorno := trim(giorno);

    -- Traduci il giorno della settimana in italiano
    CASE 
        WHEN giorno = 'Monday' THEN giorno_italiano := 'Lunedì';
        WHEN giorno = 'Tuesday' THEN giorno_italiano := 'Martedì';
        WHEN giorno = 'Wednesday' THEN giorno_italiano := 'Mercoledì';
        WHEN giorno = 'Thursday' THEN giorno_italiano := 'Giovedì';
        WHEN giorno = 'Friday' THEN giorno_italiano := 'Venerdì';
        WHEN giorno = 'Saturday' THEN giorno_italiano := 'Sabato';
        WHEN giorno = 'Sunday' THEN giorno_italiano := 'Domenica';
        ELSE giorno_italiano := giorno; -- In caso di errore, lascia il giorno in inglese
    END CASE;
    
    -- Determina l'orario di inizio e fine della prenotazione
    prenotazione_inizio := NEW.dateTimeEs::time;
    prenotazione_fine := (NEW.dateTimeEs + interval '1 hour')::time;

    -- Controlla se il laboratorio interno è aperto in quel giorno e fascia oraria
    IF NEW.codLabInt IS NOT NULL THEN
        SELECT COUNT(*) INTO count_lab
        FROM OrariDiAperturaLabInt
        WHERE giornoSett = giorno_italiano
        AND (substring(fasciaoraria from 1 for 5)::time <= prenotazione_inizio)
        AND (substring(fasciaoraria from 8 for 5)::time >= prenotazione_fine)
        AND codice = NEW.codLabInt;
        
        -- Se non ci sono corrispondenze, genera un errore
        IF count_lab = 0 THEN
            RAISE EXCEPTION 'Il laboratorio interno % non è aperto % dalle % alle %', NEW.codLabInt, giorno_italiano, prenotazione_inizio, prenotazione_fine;
        END IF;
    END IF;
    
    -- Controlla se il laboratorio esterno è aperto in quel giorno e fascia oraria
    IF NEW.codLabEst IS NOT NULL THEN
        SELECT COUNT(*) INTO count_lab
        FROM OrariDiAperturaLabEst
        WHERE giornoSett = giorno_italiano
        AND (substring(fasciaoraria from 1 for 5)::time <= prenotazione_inizio)
        AND (substring(fasciaoraria from 8 for 5)::time >= prenotazione_fine)
        AND codice = NEW.codLabEst;
        
        -- Se non ci sono corrispondenze, genera un errore
        IF count_lab = 0 THEN
            RAISE EXCEPTION 'Il laboratorio esterno % non è aperto % dalle % alle %', NEW.codLabEst, giorno_italiano, prenotazione_inizio, prenotazione_fine;
        END IF;
    END IF;
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Crea il trigger sulla tabella Prenotazione
CREATE TRIGGER trigger_check_lab_availability
BEFORE INSERT OR UPDATE ON Prenotazione
FOR EACH ROW
EXECUTE FUNCTION check_lab_availability();
