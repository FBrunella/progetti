INSERT INTO Ospedale (codice, indirizzo, nome)
VALUES
    (1, 'Via Roma 1, 12345', 'Ospedale San Andrea'),
    (2, 'Via Garibaldi 10, 54321', 'Ospedale San Giovanni'),
    (3, 'Via Verdi 5, 67890', 'Ospedale San Raffaele'),
    (4, 'Via Dante 8, 13579', 'Ospedale San Matteo'),
    (5, 'Via Manzoni 15, 98765', 'Ospedale San Carlo'),
    (6, 'Via Carducci 20, 24680', 'Ospedale San Francesco'),
    (7, 'Via Leonardo 3, 97531', 'Ospedale San Paolo'),
    (8, 'Via Michelangelo 6, 86420', 'Ospedale San Pietro'),
    (9, 'Via Donizetti 12, 75319', 'Ospedale San Luca'),
    (10, 'Via Rossini 18, 31456', 'Ospedale San Marco');

-- Generazione Reparto
-- Esempio di inserimento di alcuni reparti ospedalieri

-- Assumiamo che gli ospedali siano stati creati e abbiano già dei codici associati

-- Inserimento di reparti per l'ospedale con codice 1
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Cardiologia', 1, '1234567890'),
    ('Reparto di Ortopedia', 1, '2345678901');

-- Inserimento di reparti per l'ospedale con codice 2
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Pediatria', 2, '3456789012'),
    ('Reparto di Neurologia', 2, '4567890123');

-- E così via, con altri reparti e ospedali
-- Inserimento di ulteriori reparti per gli ospedali esistenti

-- Inserimento di reparti per l'ospedale con codice 3
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Ginecologia', 3, '5678901234'),
    ('Reparto di Oculistica', 3, '6789012345');

-- Inserimento di reparti per l'ospedale con codice 4
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Dermatologia', 4, '7890123456'),
    ('Reparto di Radiologia', 4, '8901234567');

-- Inserimento di reparti per l'ospedale con codice 5
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Chirurgia', 5, '9012345678'),
    ('Reparto di Otorinolaringoiatria', 5, '0123456789');
-- Inserimento di reparti per l'ospedale con codice 6
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Neurologia', 6, '1234567890'),
    ('Reparto di Ortopedia', 6, '2345678901');

-- Inserimento di reparti per l'ospedale con codice 7
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Cardiologia', 7, '3456789012'),
    ('Reparto di Pediatria', 7, '4567890123');

-- Inserimento di reparti per l'ospedale con codice 8
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Urologia', 8, '5678901234'),
    ('Reparto di Endocrinologia', 8, '6789012345');

-- Inserimento di reparti per l'ospedale con codice 9
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Ematologia', 9, '6789012345'),
    ('Reparto di Anestesia', 9, '7890123456');

-- Inserimento di reparti per l'ospedale con codice 10
INSERT INTO Reparto (nome, codOspedale, telefono) VALUES
    ('Reparto di Oncologia', 10, '7890123456'),
    ('Reparto di Medicina Nucleare', 10, '8901234567');

-- generazione orari
-- Inserimento degli orari per il lunedì
INSERT INTO Orari (GiornodellaSett, fasciaoraria) VALUES
    ('Lunedì', '08:00 - 12:00'),
    ('Lunedì', '14:00 - 18:00');

-- Inserimento degli orari per il martedì
INSERT INTO Orari (GiornodellaSett, fasciaoraria) VALUES
    ('Martedì', '08:30 - 12:30'),
    ('Martedì', '15:00 - 19:00');

-- Inserimento degli orari per il mercoledì
INSERT INTO Orari (GiornodellaSett, fasciaoraria) VALUES
    ('Mercoledì', '09:00 - 13:00'),
    ('Mercoledì', '14:00 - 18:00');

-- Inserimento degli orari per il giovedì
INSERT INTO Orari (GiornodellaSett, fasciaoraria) VALUES
    ('Giovedì', '08:00 - 12:00'),
    ('Giovedì', '14:00 - 18:00');

-- Inserimento degli orari per il venerdì
INSERT INTO Orari (GiornodellaSett, fasciaoraria) VALUES
    ('Venerdì', '08:30 - 12:30'),
    ('Venerdì', '15:00 - 19:00');

-- Inserimento degli orari per il sabato
INSERT INTO Orari (GiornodellaSett, fasciaoraria) VALUES
    ('Sabato', '09:00 - 13:00'),
    ('Sabato', '14:00 - 18:00');

-- generazione pronto soccorso
-- Inserimento dei Pronto Soccorso per alcuni ospedali
INSERT INTO ProntoSoccorso (Codice, CodOspedale) VALUES
(1, 1), -- Pronto Soccorso per Ospedale 1
(2, 3), -- Pronto Soccorso per Ospedale 3
(3, 5); -- Pronto Soccorso per Ospedale 5

-- generazione infermieri
-- Inserimento di ulteriori dati nella tabella Infermiere
INSERT INTO Infermiere (CF, Nome, Cognome, nomeReparto, codOspedale) VALUES
    ('MRCFRN80A01H501V', 'Francesco', 'Marconi', 'Reparto di Cardiologia', 1),
    ('LNGSRA85B02H501U', 'Sara', 'Longhi', 'Reparto di Ortopedia', 1),
    ('BNCMRT90C03H501T', 'Marta', 'Bianchi', 'Reparto di Cardiologia', 1),
    ('RMNGVR75D04H501S', 'Giovanna', 'Romano', 'Reparto di Ortopedia', 1),
    ('PLZLUC80E05H501R', 'Luca', 'Palazzi', 'Reparto di Cardiologia', 1),
    ('VLCMRZ90F06H501Q', 'Marzia', 'Valcavi', 'Reparto di Ortopedia', 1),
    ('FRNCST85G07H501P', 'Cristina', 'Franchi', 'Reparto di Cardiologia', 1),
    ('GNTVLC80H08H501O', 'Valerio', 'Gentile', 'Reparto di Ortopedia', 1),
    ('MSTMLN75I09H501N', 'Milena', 'Mastroianni', 'Reparto di Cardiologia', 1),
    ('MNCFBN80J10H501M', 'Fabiano', 'Monaco', 'Reparto di Ortopedia', 1);

-- Inserimento dei dati nella tabella Infermiere
INSERT INTO Infermiere (CF, Nome, Cognome, nomeReparto, codOspedale) VALUES
    ('RSSMRA85M01H501Z', 'Mario', 'Rossi', 'Reparto di Cardiologia', 1),
    ('VRDLGI80A01H501Y', 'Luigi', 'Verdi', 'Reparto di Ortopedia', 1),
    ('BNCLRA75C01H501X', 'Laura', 'Bianchi', 'Reparto di Cardiologia', 1),
    ('FRTGLC70D01H501W', 'Giacomo', 'Ferri', 'Reparto di Ortopedia', 1);

-- Inserimento di ulteriori dati nella tabella PersonaleAmministrativo con nuovi nomi e cognomi
INSERT INTO PersonaleAmministrativo (CF, Nome, Cognome, nomeReparto, codOspedale) VALUES
    ('BNCLRS85M01H501Z', 'Lorenzo', 'Bianchi', 'Reparto di Cardiologia', 1),
    ('GRTMRA85M01H501Z', 'Marco', 'Gritti', 'Reparto di Ortopedia', 1),
    ('CLSLGI85M01H501Z', 'Giorgia', 'Colombo', 'Reparto di Cardiologia', 1),
    ('MNLCLM85M01H501Z', 'Marta', 'Manzoni', 'Reparto di Ortopedia', 1),
    ('RSSAND85M01H501Z', 'Andrea', 'Rossi', 'Reparto di Cardiologia', 1),
    ('VRDGLR85M01H501Z', 'Luca', 'Verdi', 'Reparto di Ortopedia', 1),
    ('BNCLSC85M01H501Z', 'Simone', 'Bianchi', 'Reparto di Cardiologia', 1),
    ('FRNLGN85M01H501Z', 'Giulia', 'Ferrari', 'Reparto di Ortopedia', 1);

-- Inserimento di alcuni dati di esempio nella tabella Specializzazioni
INSERT INTO Specializzazioni (nome) VALUES
('Cardiologia'),
('Ortopedia'),
('Neurologia'),
('Pediatria'),
('Dermatologia');
-- Inserimento di ulteriori dati di esempio nella tabella Specializzazioni
INSERT INTO Specializzazioni (nome) VALUES
('Oncologia'),
('Gastroenterologia'),
('Oculistica'),
('Endocrinologia'),
('Chirurgia generale');

-- Inserimento di dati casuali nella tabella Patologie
INSERT INTO Patologie (nome) VALUES
('Ipertensione'),
('Diabete'),
('Asma'),
('Depressione'),
('Artrite'),
('Obesità'),
('Cancro'),
('Malattia di Alzheimer'),
('HIV/AIDS'),
('Malattia di Parkinson');

-- Inserimento Pazienti
INSERT INTO Paziente (nTesSanitaria, nome, cognome, dataNascita, indirizzo) VALUES
('1234567890', 'Mario', 'Rossi', '1980-05-15', 'Via Roma 10, 00100'),
('0987654321', 'Luigi', 'Bianchi', '1975-08-22', 'Via Milano 25, 20100'),
('2345678901', 'Anna', 'Verdi', '1990-03-10', 'Via Torino 50, 10100'),
('3456789012', 'Giulia', 'Neri', '1985-12-05', 'Via Napoli 75, 80100'),
('4567890123', 'Marco', 'Gialli', '2000-07-30', 'Via Venezia 100, 30100'),
('5678901234', 'Elena', 'Blu', '1995-11-18', 'Via Bologna 200, 40100'),
('6789012345', 'Stefano', 'Marrone', '1982-04-22', 'Via Firenze 300, 50100'),
('7890123456', 'Chiara', 'Azzurri', '1998-01-13', 'Via Genova 400, 60100'),
('8901234567', 'Francesco', 'Bianco', '1978-09-09', 'Via Bari 500, 70100'),
('9012345678', 'Laura', 'Rosa', '1987-06-19', 'Via Palermo 600, 90100');

INSERT INTO Paziente (nTesSanitaria, nome, cognome, dataNascita, indirizzo) VALUES
('0123456789', 'Roberto', 'Argento', '1973-11-25', 'Via Pisa 700, 56100'),
('1123456789', 'Valentina', 'Viola', '1986-02-17', 'Via Modena 800, 41100'),
('2123456789', 'Giorgio', 'Nero', '1969-08-11', 'Via Ravenna 900, 48100'),
('3123456789', 'Sara', 'Zafferano', '1991-12-30', 'Via Siena 1000, 53100'),
('4123456789', 'Davide', 'Ambra', '1984-04-21', 'Via Parma 1100, 43100'),
('5123456789', 'Martina', 'Oliva', '1993-07-15', 'Via Reggio 1200, 42100'),
('6123456789', 'Alessandro', 'Rubino', '1981-01-05', 'Via Perugia 1300, 06100'),
('7123456789', 'Federica', 'Menta', '1977-03-18', 'Via Matera 1400, 75100'),
('8123456789', 'Lorenzo', 'Corallo', '1996-09-25', 'Via Trento 1500, 38100'),
('9123456789', 'Paola', 'Limone', '1989-06-22', 'Via Trieste 1600, 34100');

-- inserimento MediciEsterni
INSERT INTO MedicoEsterno (CF, Nome, Cognome) VALUES
('RSSMRA80A01H501X', 'Mario', 'Rossi'),
('BNCLGU75M01F205Y', 'Luigi', 'Bianchi'),
('VRDNN90C41L378Z', 'Anna', 'Verdi'),
('NRAGL85T41A662S', 'Giulia', 'Neri'),
('GLLMRC00L30Z404W', 'Marco', 'Gialli'),
('BLULEN95S58D621U', 'Elena', 'Blu'),
('MRRRFN82D22H101V', 'Stefano', 'Marrone'),
('AZZCHR98A13G273T', 'Chiara', 'Azzurri'),
('BNCFRS78P09H205Q', 'Francesco', 'Bianco'),
('RSMLAU87H19G388R', 'Laura', 'Rosa'),
('ARGROB73S25L222P', 'Roberto', 'Argento'),
('VIOVAL86B17H501O', 'Valentina', 'Viola'),
('NRGGRG69M11L378A', 'Giorgio', 'Nero'),
('ZAFSAR91T30A662B', 'Sara', 'Zafferano'),
('AMBDVD84D21C662G', 'Davide', 'Ambra'),
('OLIMRT93L15E388L', 'Martina', 'Oliva'),
('RBNALS81A05H501M', 'Alessandro', 'Rubino'),
('MENTFR77C18H703N', 'Federica', 'Menta'),
('CORLNZ96P25L380K', 'Lorenzo', 'Corallo'),
('LIMPLA89H22D621J', 'Paola', 'Limone');

-- Inserimento Avvertenze
INSERT INTO Avvertenze (codice, descrizione) VALUES
(1, 'Non mangiare ne bere per almeno 8 ore prima dell esame'),
(2, 'Sospendere l assunzione di farmaci 24 ore prima dell esame'),
(3, 'Bere molta acqua il giorno prima dell esame'),
(4, 'Evitare il consumo di alcolici per 48 ore prima dell esame'),
(5, 'Indossare abiti comodi e senza parti metalliche'),
(6, 'Informare il medico di eventuali allergie'),
(7, 'Portare con se tutti i documenti medici precedenti'),
(8, 'Rimanere a riposo per almeno 30 minuti prima dell esame'),
(9, 'Non fumare per almeno 12 ore prima dell esame'),
(10, 'Assicurarsi di avere un accompagnatore se e prevista una sedazione'),
(11, 'Comunicare al personale medico se si e in gravidanza'),
(12, 'Evitare l assunzione di caffeina il giorno dell esame'),
(13, 'Rimuovere gioielli e accessori prima dell esame'),
(14, 'Segnalare al medico se si soffre di claustrofobia'),
(15, 'Evitare attivita fisica intensa nelle 24 ore precedenti all esame');

-- Inserimento stanze
INSERT INTO Stanza (numero, piano, codOspedale, nomeReparto, utilizzo) VALUES
    (101, 1, 1, 'Reparto di Cardiologia', 'laboratorio'),
    (102, 1, 1, 'Reparto di Cardiologia', 'stanza da letto'),
    (201, 2, 1, 'Reparto di Ortopedia', 'sala operatoria'),
    (202, 2, 1, 'Reparto di Ortopedia', 'altro');
INSERT INTO Stanza (numero, piano, codOspedale, nomeReparto, utilizzo) VALUES
    (103, 1, 1, 'Reparto di Cardiologia', 'laboratorio'),
    (104, 1, 1, 'Reparto di Cardiologia', 'stanza da letto'),
    (105, 1, 1, 'Reparto di Cardiologia', 'sala operatoria'),
    (106, 1, 1, 'Reparto di Cardiologia', 'altro'),
    (107, 1, 1, 'Reparto di Cardiologia', 'laboratorio'),
    (108, 1, 1, 'Reparto di Cardiologia', 'stanza da letto'),
    (109, 1, 1, 'Reparto di Cardiologia', 'sala operatoria'),
    (110, 1, 1, 'Reparto di Cardiologia', 'altro'),
    (111, 1, 1, 'Reparto di Cardiologia', 'laboratorio'),
    (112, 1, 1, 'Reparto di Cardiologia', 'stanza da letto'),
    (113, 1, 1, 'Reparto di Cardiologia', 'sala operatoria'),
    (114, 1, 1, 'Reparto di Cardiologia', 'altro'),
    (115, 1, 1, 'Reparto di Cardiologia', 'laboratorio'),
    (116, 1, 1, 'Reparto di Cardiologia', 'stanza da letto'),
    (117, 1, 1, 'Reparto di Cardiologia', 'sala operatoria'),
    (118, 1, 1, 'Reparto di Cardiologia', 'altro'),
    (119, 1, 1, 'Reparto di Cardiologia', 'laboratorio'),
    (120, 1, 1, 'Reparto di Cardiologia', 'stanza da letto'),
    (121, 1, 1, 'Reparto di Cardiologia', 'sala operatoria'),
    (122, 1, 1, 'Reparto di Cardiologia', 'altro'),
    (203, 2, 1, 'Reparto di Ortopedia', 'laboratorio'),
    (204, 2, 1, 'Reparto di Ortopedia', 'stanza da letto'),
    (205, 2, 1, 'Reparto di Ortopedia', 'sala operatoria'),
    (206, 2, 1, 'Reparto di Ortopedia', 'altro'),
    (207, 2, 1, 'Reparto di Ortopedia', 'laboratorio'),
    (208, 2, 1, 'Reparto di Ortopedia', 'stanza da letto'),
    (209, 2, 1, 'Reparto di Ortopedia', 'sala operatoria'),
    (210, 2, 1, 'Reparto di Ortopedia', 'altro'),
    (211, 2, 1, 'Reparto di Ortopedia', 'laboratorio'),
    (212, 2, 1, 'Reparto di Ortopedia', 'stanza da letto'),
    (213, 2, 1, 'Reparto di Ortopedia', 'sala operatoria'),
    (214, 2, 1, 'Reparto di Ortopedia', 'altro'),
    (215, 2, 1, 'Reparto di Ortopedia', 'laboratorio'),
    (216, 2, 1, 'Reparto di Ortopedia', 'stanza da letto'),
    (217, 2, 1, 'Reparto di Ortopedia', 'sala operatoria'),
    (218, 2, 1, 'Reparto di Ortopedia', 'altro'),
    (219, 2, 1, 'Reparto di Ortopedia', 'laboratorio'),
    (220, 2, 1, 'Reparto di Ortopedia', 'stanza da letto'),
    (221, 2, 1, 'Reparto di Ortopedia', 'sala operatoria'),
    (222, 2, 1, 'Reparto di Ortopedia', 'altro');

-- Inserimento Laboratori esterni
INSERT INTO LaboratorioEsterno (codice, indirizzo, telefono) VALUES
(1, 'Via Roma, 123, 00100', '1234567890'),
(2, 'Via Milano, 456, 20100', '0987654321'),
(3, 'Via Napoli, 789, 80100', '1122334455'),
(4, 'Via Firenze, 101, 50100', '5566778899'),
(5, 'Via Torino, 202, 10100', '6677889900');

-- Inserimento dei dati nella tabella Letto utilizzando solo le stanze con utilizzo = 'stanza da letto'
INSERT INTO Letto (codLetto, numeroStanza, pianoStanza, nomeReparto, codOspedale) VALUES
(1, 102, 1, 'Reparto di Cardiologia', 1),
(2, 104, 1, 'Reparto di Cardiologia', 1),
(3, 108, 1, 'Reparto di Cardiologia', 1),
(4, 112, 1, 'Reparto di Cardiologia', 1),
(5, 116, 1, 'Reparto di Cardiologia', 1),
(6, 120, 1, 'Reparto di Cardiologia', 1),
(7, 204, 2, 'Reparto di Ortopedia', 1),
(8, 208, 2, 'Reparto di Ortopedia', 1),
(9, 212, 2, 'Reparto di Ortopedia', 1),
(10, 216, 2, 'Reparto di Ortopedia', 1),
(11, 220, 2, 'Reparto di Ortopedia', 1);

-- Inserimento di ulteriori dati nella tabella Letto
INSERT INTO Letto (codLetto, numeroStanza, pianoStanza, nomeReparto, codOspedale) VALUES
(12, 102, 1, 'Reparto di Cardiologia', 1),
(13, 104, 1, 'Reparto di Cardiologia', 1),
(14, 108, 1, 'Reparto di Cardiologia', 1),
(15, 112, 1, 'Reparto di Cardiologia', 1),
(16, 116, 1, 'Reparto di Cardiologia', 1),
(17, 120, 1, 'Reparto di Cardiologia', 1),
(18, 204, 2, 'Reparto di Ortopedia', 1),
(19, 208, 2, 'Reparto di Ortopedia', 1),
(20, 212, 2, 'Reparto di Ortopedia', 1),
(21, 216, 2, 'Reparto di Ortopedia', 1),
(22, 220, 2, 'Reparto di Ortopedia', 1),
(23, 102, 1, 'Reparto di Cardiologia', 1),
(24, 104, 1, 'Reparto di Cardiologia', 1),
(25, 108, 1, 'Reparto di Cardiologia', 1),
(26, 112, 1, 'Reparto di Cardiologia', 1),
(27, 116, 1, 'Reparto di Cardiologia', 1),
(28, 120, 1, 'Reparto di Cardiologia', 1),
(29, 204, 2, 'Reparto di Ortopedia', 1),
(30, 208, 2, 'Reparto di Ortopedia', 1),
(31, 212, 2, 'Reparto di Ortopedia', 1),
(32, 216, 2, 'Reparto di Ortopedia', 1),
(33, 220, 2, 'Reparto di Ortopedia', 1);

-- Inserimento dei dati nella tabella LaboratorioInterno utilizzando solo le stanze con utilizzo = 'laboratorio' e codici a partire da 6
INSERT INTO LaboratorioInterno (codice, numeroStanza, pianoStanza, nomeReparto, codOspedale) VALUES
(6, 101, 1, 'Reparto di Cardiologia', 1),
(7, 103, 1, 'Reparto di Cardiologia', 1),
(8, 107, 1, 'Reparto di Cardiologia', 1),
(9, 111, 1, 'Reparto di Cardiologia', 1),
(10, 115, 1, 'Reparto di Cardiologia', 1),
(11, 119, 1, 'Reparto di Cardiologia', 1),
(12, 203, 2, 'Reparto di Ortopedia', 1),
(13, 207, 2, 'Reparto di Ortopedia', 1),
(14, 211, 2, 'Reparto di Ortopedia', 1),
(15, 215, 2, 'Reparto di Ortopedia', 1);

-- Popolamento della tabella Ricovero
INSERT INTO Ricovero (codLetto, DataRicovero, nTesSanitariaPaziente, DataDimissione) VALUES
(1, '2024-01-01', '1234567890', '2024-01-10'),
(1, '2024-01-12', '0987654321', '2024-01-22'),
(1, '2024-01-25', '2345678901', '2024-02-04'),
(2, '2024-01-03', '3456789012', '2024-01-13'),
(2, '2024-01-15', '4567890123', '2024-01-25'),
(2, '2024-01-28', '5678901234', '2024-02-07'),
(3, '2024-01-05', '6789012345', '2024-01-15'),
(3, '2024-01-18', '7890123456', '2024-01-28'),
(3, '2024-01-30', '8901234567', '2024-02-09'),
(4, '2024-01-08', '9012345678', '2024-01-18'),
(4, '2024-01-20', '0123456789', '2024-01-30'),
(4, '2024-02-01', '1123456789', '2024-02-11'),
(5, '2024-01-10', '2123456789', '2024-01-20'),
(5, '2024-01-22', '3123456789', '2024-02-01'),
(5, '2024-02-03', '4123456789', '2024-02-13'),
(6, '2024-01-12', '5123456789', '2024-01-22'),
(6, '2024-01-24', '6123456789', '2024-02-03'),
(6, '2024-02-05', '7123456789', '2024-02-15'),
(7, '2024-01-14', '8123456789', '2024-01-24'),
(7, '2024-01-26', '9123456789', '2024-02-05');

-- Ricoveri attivi
INSERT INTO Ricovero (codLetto, DataRicovero, nTesSanitariaPaziente, DataDimissione) VALUES
(8, '2024-02-07', '1234567890', NULL),
(9, '2024-02-09', '0987654321', NULL);

-- Inserimento dei dati nella tabella Medico
INSERT INTO Medico (CF, DataDiAssunzione, vice, primario, nomeReparto, codOspedale, DataPromozioneVice) VALUES
('MRCVRD82A01H501Y', '2010-01-01', FALSE, TRUE, 'Reparto di Cardiologia', 1, NULL), -- Primario di Cardiologia
('LNGFRN75B02L379Z', '2012-05-10', TRUE, FALSE, 'Reparto di Cardiologia', 1, '2015-06-15'), -- Vice Primario Cardiologia
('PTRGLL88C03A662S', '2014-09-20', TRUE, FALSE, 'Reparto di Cardiologia', 1, '2017-08-10'), -- Vice Primario Cardiologia
('SNDRCC90D04G321P', '2011-11-05', FALSE, FALSE, 'Reparto di Cardiologia', 1, NULL), -- Medico Cardiologia
('FNHVLD85A02E523X','2011-02-16', true, false,'Reparto di Cardiologia',1,'2012-07-16'),
('GRIHDZ36L19G311N','2011-02-16', true, false,'Reparto di Cardiologia',1,'2012-07-16'),
('PDYVTY56E02L406B','2011-02-16', true, false,'Reparto di Cardiologia',1,'2012-07-16'),
('SFTRDZ83B16D527X','2011-02-16', true, false,'Reparto di Cardiologia',1,'2012-07-16'),
('MNTDLC78E01B379L', '2008-03-14', FALSE, TRUE, 'Reparto di Ortopedia', 1, NULL), -- Primario di Ortopedia
('RDFCHR83F02C378M', '2013-07-18', TRUE, FALSE, 'Reparto di Ortopedia', 1, '2016-09-22'), -- Vice Primario Ortopedia
('SLVPMR92G03D379N', '2015-10-22', TRUE, FALSE, 'Reparto di Ortopedia', 1, '2018-11-25'), -- Vice Primario Ortopedia
('GRGFLT84H04E380Q', '2010-12-30', FALSE, FALSE, 'Reparto di Ortopedia', 1, NULL); -- Medico Ortopedia

-- Inserimento di ulteriori medici base (né vice né primari) nella tabella Medico
INSERT INTO Medico (CF, DataDiAssunzione, vice, primario, nomeReparto, codOspedale, DataPromozioneVice) VALUES
('PLRMRC85M05L123T', '2011-02-15', FALSE, FALSE, 'Reparto di Cardiologia', 1, NULL),
('BNCMRC90L10R234U', '2013-03-20', FALSE, FALSE, 'Reparto di Cardiologia', 1, NULL),
('RSVRNC82P22K345V', '2015-04-25', FALSE, FALSE, 'Reparto di Cardiologia', 1, NULL),
('VDLBLL87N11N456W', '2016-05-30', FALSE, FALSE, 'Reparto di Cardiologia', 1, NULL),
('CRSFRC79D19S567X', '2018-06-05', FALSE, FALSE, 'Reparto di Cardiologia', 1, NULL),

('GRGLLL81J12T678Y', '2011-07-10', FALSE, FALSE, 'Reparto di Ortopedia', 1, NULL),
('TRSBLL86K23U789Z', '2013-08-15', FALSE, FALSE, 'Reparto di Ortopedia', 1, NULL),
('VRCFRC88L14V890A', '2015-09-20', FALSE, FALSE, 'Reparto di Ortopedia', 1, NULL),
('MDCRCC89M15W901B', '2016-10-25', FALSE, FALSE, 'Reparto di Ortopedia', 1, NULL),
('MNTFRC91N16X012C', '2018-11-30', FALSE, FALSE, 'Reparto di Ortopedia', 1, NULL);

-- Inserimenti sostituzioni
INSERT INTO Sostituzione (CFMedico1, CFMedico2, DataInizio, DataFine) VALUES
-- Vice Primario sostituisce Primario dal 2015-06-16 al 2015-06-22 (una settimana)
('LNGFRN75B02L379Z', 'MRCVRD82A01H501Y', '2015-06-16', '2015-06-22'),
-- Altro Vice Primario sostituisce Primario dal 2017-08-10 al 2017-08-16 (una settimana)
('PTRGLL88C03A662S', 'MRCVRD82A01H501Y', '2017-08-10', '2017-08-16');

INSERT INTO Sostituzione (CFMedico1, CFMedico2, DataInizio, DataFine) VALUES
-- Vice Primario sostituisce Primario dal 2016-09-23 al 2016-09-29
('RDFCHR83F02C378M', 'MNTDLC78E01B379L', '2016-09-23', '2016-09-29'),
-- Altro Vice Primario sostituisce Primario dal 2018-11-25 al 2018-12-01
('SLVPMR92G03D379N', 'MNTDLC78E01B379L', '2018-11-25', '2018-12-01');
-- Cardiologia
INSERT INTO Sostituzione (CFMedico1, CFMedico2, DataInizio, DataFine) VALUES
('LNGFRN75B02L379Z', 'MRCVRD82A01H501Y', '2015-07-01', '2015-07-07'),
('PTRGLL88C03A662S', 'MRCVRD82A01H501Y', '2016-01-10', '2016-01-16'),
('LNGFRN75B02L379Z', 'MRCVRD82A01H501Y', '2016-05-15', '2016-05-21'),
('PTRGLL88C03A662S', 'MRCVRD82A01H501Y', '2017-09-01', '2017-09-07'),
('LNGFRN75B02L379Z', 'MRCVRD82A01H501Y', '2018-03-01', '2018-03-07'),
('PTRGLL88C03A662S', 'MRCVRD82A01H501Y', '2018-04-10', '2018-04-16');
-- Ortopedia
INSERT INTO Sostituzione (CFMedico1, CFMedico2, DataInizio, DataFine) VALUES
('RDFCHR83F02C378M', 'MNTDLC78E01B379L', '2017-01-15', '2017-01-21'),
('SLVPMR92G03D379N', 'MNTDLC78E01B379L', '2019-02-05', '2019-02-11'),
('RDFCHR83F02C378M', 'MNTDLC78E01B379L', '2018-01-25', '2018-01-31'),
('SLVPMR92G03D379N', 'MNTDLC78E01B379L', '2018-03-15', '2018-03-21'),
('RDFCHR83F02C378M', 'MNTDLC78E01B379L', '2019-04-10', '2019-04-16'),
('SLVPMR92G03D379N', 'MNTDLC78E01B379L', '2019-05-01', '2019-05-07');

-- Turno 1
INSERT INTO TurniInfermieri (codProntoSoccorso, dateTimeInit, dateTimeFine, CFInfermiere) VALUES
(1, '2024-06-01 08:00:00', '2024-06-01 16:00:00', 'RSSMRA85M01H501Z'),
(1, '2024-06-01 08:00:00', '2024-06-01 16:00:00', 'BNCLRA75C01H501X');

-- Turno 2
INSERT INTO TurniInfermieri (codProntoSoccorso, dateTimeInit, dateTimeFine, CFInfermiere) VALUES
(1, '2024-06-01 16:00:00', '2024-06-02 00:00:00', 'RSSMRA85M01H501Z'),
(1, '2024-06-01 16:00:00', '2024-06-02 00:00:00', 'VRDLGI80A01H501Y');

-- Turno 3
INSERT INTO TurniInfermieri (codProntoSoccorso, dateTimeInit, dateTimeFine, CFInfermiere) VALUES
(1, '2024-06-02 00:00:00', '2024-06-02 08:00:00', 'FRTGLC70D01H501W'),
(1, '2024-06-02 00:00:00', '2024-06-02 08:00:00', 'BNCLRA75C01H501X');

-- Reparto di Cardiologia
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-01 08:00:00', '2024-06-01 16:00:00', 'PLRMRC85M05L123T'),
(1, '2024-06-01 16:00:00', '2024-06-01 24:00:00', 'BNCMRC90L10R234U'),
(1, '2024-06-02 00:00:00', '2024-06-02 08:00:00', 'RSVRNC82P22K345V'),
(1, '2024-06-02 08:00:00', '2024-06-02 16:00:00', 'VDLBLL87N11N456W'),
(1, '2024-06-02 16:00:00', '2024-06-02 24:00:00', 'CRSFRC79D19S567X');

-- Reparto di Ortopedia
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-01 08:00:00', '2024-06-01 16:00:00', 'GRGLLL81J12T678Y'),
(1, '2024-06-01 16:00:00', '2024-06-01 24:00:00', 'TRSBLL86K23U789Z'),
(1, '2024-06-02 00:00:00', '2024-06-02 08:00:00', 'VRCFRC88L14V890A'),
(1, '2024-06-02 08:00:00', '2024-06-02 16:00:00', 'MDCRCC89M15W901B'),
(1, '2024-06-02 16:00:00', '2024-06-02 24:00:00', 'MNTFRC91N16X012C');

-- Reparto di Cardiologia (continuazione)
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-03 00:00:00', '2024-06-03 08:00:00', 'PLRMRC85M05L123T'),
(1, '2024-06-03 08:00:00', '2024-06-03 16:00:00', 'BNCMRC90L10R234U'),
(1, '2024-06-03 16:00:00', '2024-06-03 24:00:00', 'RSVRNC82P22K345V'),
(1, '2024-06-04 00:00:00', '2024-06-04 08:00:00', 'VDLBLL87N11N456W'),
(1, '2024-06-04 08:00:00', '2024-06-04 16:00:00', 'CRSFRC79D19S567X');

-- Reparto di Ortopedia (continuazione)
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-03 00:00:00', '2024-06-03 08:00:00', 'GRGLLL81J12T678Y'),
(1, '2024-06-03 08:00:00', '2024-06-03 16:00:00', 'TRSBLL86K23U789Z'),
(1, '2024-06-03 16:00:00', '2024-06-03 24:00:00', 'VRCFRC88L14V890A'),
(1, '2024-06-04 00:00:00', '2024-06-04 08:00:00', 'MDCRCC89M15W901B'),
(1, '2024-06-04 08:00:00', '2024-06-04 16:00:00', 'MNTFRC91N16X012C');

-- Reparto di Cardiologia (continuazione)
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-04 16:00:00', '2024-06-05 00:00:00', 'PLRMRC85M05L123T'),
(1, '2024-06-05 00:00:00', '2024-06-05 08:00:00', 'BNCMRC90L10R234U'),
(1, '2024-06-05 08:00:00', '2024-06-05 16:00:00', 'RSVRNC82P22K345V'),
(1, '2024-06-05 16:00:00', '2024-06-06 00:00:00', 'VDLBLL87N11N456W'),
(1, '2024-06-06 00:00:00', '2024-06-06 08:00:00', 'CRSFRC79D19S567X');

-- Reparto di Ortopedia (continuazione)
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-04 16:00:00', '2024-06-05 00:00:00', 'GRGLLL81J12T678Y'),
(1, '2024-06-05 00:00:00', '2024-06-05 08:00:00', 'TRSBLL86K23U789Z'),
(1, '2024-06-05 08:00:00', '2024-06-05 16:00:00', 'VRCFRC88L14V890A'),
(1, '2024-06-05 16:00:00', '2024-06-06 00:00:00', 'MDCRCC89M15W901B'),
(1, '2024-06-06 00:00:00', '2024-06-06 08:00:00', 'MNTFRC91N16X012C');

-- Reparto di Cardiologia (continuazione)
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-06 08:00:00', '2024-06-06 16:00:00', 'PLRMRC85M05L123T'),
(1, '2024-06-06 16:00:00', '2024-06-07 00:00:00', 'BNCMRC90L10R234U'),
(1, '2024-06-07 00:00:00', '2024-06-07 08:00:00', 'RSVRNC82P22K345V'),
(1, '2024-06-07 08:00:00', '2024-06-07 16:00:00', 'VDLBLL87N11N456W'),
(1, '2024-06-07 16:00:00', '2024-06-08 00:00:00', 'CRSFRC79D19S567X');

-- Reparto di Ortopedia (continuazione)
INSERT INTO TurniMedici (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico)
VALUES
(1, '2024-06-06 08:00:00', '2024-06-06 16:00:00', 'GRGLLL81J12T678Y'),
(1, '2024-06-06 16:00:00', '2024-06-07 00:00:00', 'TRSBLL86K23U789Z'),
(1, '2024-06-07 00:00:00', '2024-06-07 08:00:00', 'VRCFRC88L14V890A'),
(1, '2024-06-07 08:00:00', '2024-06-07 16:00:00', 'MDCRCC89M15W901B'),
(1, '2024-06-07 16:00:00', '2024-06-08 00:00:00', 'MNTFRC91N16X012C');

INSERT INTO AssociazioneOspedaleLaboratorioEsterno (codOspedale, codLabLaboratorioEsterno)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5);

-- Per i medici in Cardiologia
INSERT INTO MedicoSpecializzazioni (CF, NomeSpecializzazione)
VALUES
('PLRMRC85M05L123T', 'Cardiologia'),
('BNCMRC90L10R234U', 'Cardiologia'),
('RSVRNC82P22K345V', 'Cardiologia'),
('VDLBLL87N11N456W', 'Cardiologia'),
('CRSFRC79D19S567X', 'Cardiologia');

-- Per i medici in Ortopedia
INSERT INTO MedicoSpecializzazioni (CF, NomeSpecializzazione)
VALUES
('GRGLLL81J12T678Y', 'Ortopedia'),
('TRSBLL86K23U789Z', 'Ortopedia'),
('VRCFRC88L14V890A', 'Ortopedia'),
('MDCRCC89M15W901B', 'Ortopedia'),
('MNTFRC91N16X012C', 'Ortopedia');

-- Aggiornamento per i medici in Cardiologia
INSERT INTO MedicoSpecializzazioni (CF, NomeSpecializzazione)
VALUES
('PLRMRC85M05L123T', 'Oculistica'),
('BNCMRC90L10R234U', 'Endocrinologia'),
('RSVRNC82P22K345V', 'Pediatria'),
('VDLBLL87N11N456W', 'Dermatologia'),
('CRSFRC79D19S567X', 'Neurologia');

-- Aggiornamento per i medici in Ortopedia
INSERT INTO MedicoSpecializzazioni (CF, NomeSpecializzazione)
VALUES
('GRGLLL81J12T678Y', 'Gastroenterologia'),
('TRSBLL86K23U789Z', 'Oncologia'),
('VRCFRC88L14V890A', 'Cardiologia'),
('MDCRCC89M15W901B', 'Chirurgia generale'),
('MNTFRC91N16X012C', 'Oculistica');

INSERT INTO MedicoEsternoSpecializzazioni (CF, nomeSpecializzazione)
VALUES
('RSSMRA80A01H501X', 'Dermatologia'),
('BNCLGU75M01F205Y', 'Oculistica'),
('VRDNN90C41L378Z', 'Neurologia'),
('NRAGL85T41A662S', 'Pediatria'),
('GLLMRC00L30Z404W', 'Endocrinologia'),
('BLULEN95S58D621U', 'Oncologia'),
('MRRRFN82D22H101V', 'Gastroenterologia'),
('AZZCHR98A13G273T', 'Ortopedia'),
('BNCFRS78P09H205Q', 'Cardiologia'),
('RSMLAU87H19G388R', 'Neurologia'),
('ARGROB73S25L222P', 'Oncologia'),
('VIOVAL86B17H501O', 'Cardiologia'),
('NRGGRG69M11L378A', 'Dermatologia'),
('ZAFSAR91T30A662B', 'Endocrinologia'),
('AMBDVD84D21C662G', 'Oculistica'),
('OLIMRT93L15E388L', 'Cardiologia'),
('RBNALS81A05H501M', 'Ortopedia'),
('MENTFR77C18H703N', 'Gastroenterologia'),
('CORLNZ96P25L380K', 'Neurologia'),
('LIMPLA89H22D621J', 'Pediatria');

-- Inserimento dei dati di esempio nella tabella Esame
INSERT INTO Esame (codEs, nomeSpecializzazione, descrizione, costoPub, costoPriv)
VALUES
(1, 'Cardiologia', 'Elettrocardiogramma', 50.00, 100.00),
(2, 'Ortopedia', 'Radiografia articolare', 70.00, 120.00),
(3, 'Neurologia', 'Tomografia computerizzata (TC) del cervello', 150.00, 250.00),
(4, 'Pediatria', 'Visita pediatrica di controllo', 40.00, 80.00),
(5, 'Dermatologia', 'Biopsia cutanea', 80.00, 150.00),
(6, 'Oncologia', 'Esame del sangue per marker tumorali', 90.00, 180.00),
(7, 'Gastroenterologia', 'Endoscopia digestiva', 200.00, 300.00),
(8, 'Oculistica', 'Visita oculistica completa', 60.00, 100.00),
(9, 'Endocrinologia', 'Dosaggio degli ormoni tiroidei', 45.00, 90.00),
(10, 'Chirurgia generale', 'Consulto chirurgico generale', 100.00, 200.00);
-- Inserimento di esami con specializzazione NULL
INSERT INTO Esame (codEs, nomeSpecializzazione, descrizione, costoPub, costoPriv)
VALUES
(11, NULL, 'Analisi del sangue', 30.00, 60.00),
(12, NULL, 'Ecografia addominale', 80.00, 140.00),
(13, NULL, 'Risonanza magnetica (RM) al ginocchio', 120.00, 200.00),
(14, NULL, 'Visita medica generica', 40.00, 80.00),
(15, NULL, 'Radiografia toracica', 50.00, 90.00);

-- Inserimento delle tuple nella tabella AvvertenzeEsame
INSERT INTO AvvertenzeEsame (codEs, codAvv)
VALUES
-- Elettrocardiogramma
(1, 1), -- Non mangiare ne bere per almeno 8 ore prima dell esame
(1, 2), -- Sospendere l assunzione di farmaci 24 ore prima dell esame
(1, 5), -- Indossare abiti comodi e senza parti metalliche
(1, 6), -- Informare il medico di eventuali allergie
-- Radiografia articolare
(2, 5), -- Indossare abiti comodi e senza parti metalliche
(2, 7), -- Portare con se tutti i documenti medici precedenti
(2, 15), -- Evitare attività fisica intensa nelle 24 ore precedenti all esame
-- Tomografia computerizzata (TC) del cervello
(3, 1), -- Non mangiare ne bere per almeno 8 ore prima dell esame
(3, 2), -- Sospendere l assunzione di farmaci 24 ore prima dell esame
(3, 5), -- Indossare abiti comodi e senza parti metalliche
(3, 7), -- Portare con se tutti i documenti medici precedenti
-- Visita pediatrica di controllo
(4, 5), -- Indossare abiti comodi e senza parti metalliche
(4, 7), -- Portare con se tutti i documenti medici precedenti
(4, 8), -- Rimanere a riposo per almeno 30 minuti prima dell esame
-- Biopsia cutanea
(5, 5), -- Indossare abiti comodi e senza parti metalliche
(5, 6), -- Informare il medico di eventuali allergie
(5, 13), -- Rimuovere gioielli e accessori prima dell esame
-- Esame del sangue per marker tumorali
(6, 1), -- Non mangiare ne bere per almeno 8 ore prima dell esame
(6, 2), -- Sospendere l assunzione di farmaci 24 ore prima dell esame
(6, 5), -- Indossare abiti comodi e senza parti metalliche
(6, 6), -- Informare il medico di eventuali allergie
-- Endoscopia digestiva
(7, 1), -- Non mangiare ne bere per almeno 8 ore prima dell esame
(7, 2), -- Sospendere l assunzione di farmaci 24 ore prima dell esame
(7, 3), -- Bere molta acqua il giorno prima dell esame
(7, 5), -- Indossare abiti comodi e senza parti metalliche
(7, 6), -- Informare il medico di eventuali allergie
(7, 7), -- Portare con se tutti i documenti medici precedenti
-- Visita oculistica completa
(8, 5), -- Indossare abiti comodi e senza parti metalliche
(8, 7), -- Portare con se tutti i documenti medici precedenti
-- Dosaggio degli ormoni tiroidei
(9, 1), -- Non mangiare ne bere per almeno 8 ore prima dell esame
(9, 2), -- Sospendere l assunzione di farmaci 24 ore prima dell esame
(9, 5), -- Indossare abiti comodi e senza parti metalliche
-- Consulto chirurgico generale
(10, 5), -- Indossare abiti comodi e senza parti metalliche
(10, 7), -- Portare con se tutti i documenti medici precedenti
(10, 8); -- Rimanere a riposo per almeno 30 minuti prima dell esame

-- Inserimento dei dati nella tabella MotivazioneRicovero
INSERT INTO MotivazioneRicovero (codLetto, DataRicovero, nTesSanitariaPaziente, nomePatologia)
VALUES
-- Ricoveri con data di dimissione
(1, '2024-01-01', '1234567890', 'Ipertensione'),
(1, '2024-01-12', '0987654321', 'Diabete'),
(1, '2024-01-25', '2345678901', 'Asma'),
(2, '2024-01-03', '3456789012', 'Depressione'),
(2, '2024-01-15', '4567890123', 'Artrite'),
(2, '2024-01-28', '5678901234', 'Obesità'),
(3, '2024-01-05', '6789012345', 'Cancro'),
(3, '2024-01-18', '7890123456', 'Malattia di Alzheimer'),
(3, '2024-01-30', '8901234567', 'HIV/AIDS'),
(4, '2024-01-08', '9012345678', 'Malattia di Parkinson'),
(4, '2024-01-20', '0123456789', 'Ipertensione'),
(4, '2024-02-01', '1123456789', 'Diabete'),
(5, '2024-01-10', '2123456789', 'Asma'),
(5, '2024-01-22', '3123456789', 'Depressione'),
(5, '2024-02-03', '4123456789', 'Artrite'),
(6, '2024-01-12', '5123456789', 'Obesità'),
(6, '2024-01-24', '6123456789', 'Cancro'),
(6, '2024-02-05', '7123456789', 'Malattia di Alzheimer'),
(7, '2024-01-14', '8123456789', 'HIV/AIDS'),
(7, '2024-01-26', '9123456789', 'Malattia di Parkinson'),
-- Ricoveri attivi
(8, '2024-02-07', '1234567890', 'Diabete'),
(9, '2024-02-09', '0987654321', 'Cancro');

-- Inserimento degli orari di visita per i reparti
INSERT INTO OrariDivisitaReparto (giornoSett, fasciaOraria, NomeReparto, codOspedale)
VALUES
    ('Lunedì', '08:00 - 12:00', 'Reparto di Cardiologia', 1),
    ('Lunedì', '14:00 - 18:00', 'Reparto di Cardiologia', 1),
    ('Martedì', '08:30 - 12:30', 'Reparto di Cardiologia', 1),
    ('Martedì', '15:00 - 19:00', 'Reparto di Cardiologia', 1),
    ('Mercoledì', '09:00 - 13:00', 'Reparto di Cardiologia', 1),
    ('Mercoledì', '14:00 - 18:00', 'Reparto di Cardiologia', 1),
    ('Giovedì', '08:00 - 12:00', 'Reparto di Cardiologia', 1),
    ('Giovedì', '14:00 - 18:00', 'Reparto di Cardiologia', 1),
    ('Venerdì', '08:30 - 12:30', 'Reparto di Cardiologia', 1),
    ('Venerdì', '15:00 - 19:00', 'Reparto di Cardiologia', 1),
    ('Sabato', '09:00 - 13:00', 'Reparto di Cardiologia', 1),
    ('Sabato', '14:00 - 18:00', 'Reparto di Cardiologia', 1),
    ('Lunedì', '08:00 - 12:00', 'Reparto di Ortopedia', 1),
    ('Lunedì', '14:00 - 18:00', 'Reparto di Ortopedia', 1),
    ('Martedì', '08:30 - 12:30', 'Reparto di Ortopedia', 1),
    ('Martedì', '15:00 - 19:00', 'Reparto di Ortopedia', 1),
    ('Mercoledì', '09:00 - 13:00', 'Reparto di Ortopedia', 1),
    ('Mercoledì', '14:00 - 18:00', 'Reparto di Ortopedia', 1),
    ('Giovedì', '08:00 - 12:00', 'Reparto di Ortopedia', 1),
    ('Giovedì', '14:00 - 18:00', 'Reparto di Ortopedia', 1),
    ('Venerdì', '08:30 - 12:30', 'Reparto di Ortopedia', 1),
    ('Venerdì', '15:00 - 19:00', 'Reparto di Ortopedia', 1),
    ('Sabato', '09:00 - 13:00', 'Reparto di Ortopedia', 1),
    ('Sabato', '14:00 - 18:00', 'Reparto di Ortopedia', 1);

-- Inserimento degli orari per il lunedì
INSERT INTO OrariDiAperturaLabInt (giornoSett, fasciaOraria, codice)
VALUES
    ('Lunedì', '08:00 - 12:00', 6),
    ('Lunedì', '14:00 - 18:00', 7);

-- Inserimento degli orari per il martedì
INSERT INTO OrariDiAperturaLabInt (giornoSett, fasciaOraria, codice)
VALUES
    ('Martedì', '08:30 - 12:30', 8),
    ('Martedì', '15:00 - 19:00', 9);

-- Inserimento degli orari per il mercoledì
INSERT INTO OrariDiAperturaLabInt (giornoSett, fasciaOraria, codice)
VALUES
    ('Mercoledì', '09:00 - 13:00', 10),
    ('Mercoledì', '14:00 - 18:00', 11);

-- Inserimento degli orari per il giovedì
INSERT INTO OrariDiAperturaLabInt (giornoSett, fasciaOraria, codice)
VALUES
    ('Giovedì', '08:00 - 12:00', 12),
    ('Giovedì', '14:00 - 18:00', 13);

-- Inserimento degli orari per il venerdì
INSERT INTO OrariDiAperturaLabInt (giornoSett, fasciaOraria, codice)
VALUES
    ('Venerdì', '08:30 - 12:30', 14),
    ('Venerdì', '15:00 - 19:00', 15);

-- Inserimento degli orari per il sabato
INSERT INTO OrariDiAperturaLabInt (giornoSett, fasciaOraria, codice)
VALUES
    ('Sabato', '09:00 - 13:00', 6),
    ('Sabato', '14:00 - 18:00', 7);

-- Inserimento degli orari per il laboratorio esterno con ID 1
INSERT INTO OrariDiAperturaLabEst (giornoSett, fasciaOraria, codice)
VALUES
    ('Lunedì', '08:00 - 12:00', 1),
    ('Lunedì', '14:00 - 18:00', 1),
    ('Martedì', '08:30 - 12:30', 1),
    ('Martedì', '15:00 - 19:00', 1),
    ('Mercoledì', '09:00 - 13:00', 1),
    ('Mercoledì', '14:00 - 18:00', 1),
    ('Giovedì', '08:00 - 12:00', 1),
    ('Giovedì', '14:00 - 18:00', 1),
    ('Venerdì', '08:30 - 12:30', 1),
    ('Venerdì', '15:00 - 19:00', 1),
    ('Sabato', '09:00 - 13:00', 1),
    ('Sabato', '14:00 - 18:00', 1);

-- Inserimento degli orari per il laboratorio esterno con ID 2
INSERT INTO OrariDiAperturaLabEst (giornoSett, fasciaOraria, codice)
VALUES
    ('Lunedì', '08:00 - 12:00', 2),
    ('Lunedì', '14:00 - 18:00', 2),
    ('Martedì', '08:30 - 12:30', 2),
    ('Martedì', '15:00 - 19:00', 2),
    ('Mercoledì', '09:00 - 13:00', 2),
    ('Mercoledì', '14:00 - 18:00', 2),
    ('Giovedì', '08:00 - 12:00', 2),
    ('Giovedì', '14:00 - 18:00', 2),
    ('Venerdì', '08:30 - 12:30', 2),
    ('Venerdì', '15:00 - 19:00', 2),
    ('Sabato', '09:00 - 13:00', 2),
    ('Sabato', '14:00 - 18:00', 2);

-- Inserimento degli orari per il laboratorio esterno con ID 3
INSERT INTO OrariDiAperturaLabEst (giornoSett, fasciaOraria, codice)
VALUES
    ('Lunedì', '08:00 - 12:00', 3),
    ('Lunedì', '14:00 - 18:00', 3),
    ('Martedì', '08:30 - 12:30', 3),
    ('Martedì', '15:00 - 19:00', 3),
    ('Mercoledì', '09:00 - 13:00', 3),
    ('Mercoledì', '14:00 - 18:00', 3),
    ('Giovedì', '08:00 - 12:00', 3),
    ('Giovedì', '14:00 - 18:00', 3),
    ('Venerdì', '08:30 - 12:30', 3),
    ('Venerdì', '15:00 - 19:00', 3),
    ('Sabato', '09:00 - 13:00', 3),
    ('Sabato', '14:00 - 18:00', 3);

-- Inserimento degli orari per il laboratorio esterno con ID 4
INSERT INTO OrariDiAperturaLabEst (giornoSett, fasciaOraria, codice)
VALUES
    ('Lunedì', '08:00 - 12:00', 4),
    ('Lunedì', '14:00 - 18:00', 4),
    ('Martedì', '08:30 - 12:30', 4),
    ('Martedì', '15:00 - 19:00', 4),
    ('Mercoledì', '09:00 - 13:00', 4),
    ('Mercoledì', '14:00 - 18:00', 4),
    ('Giovedì', '08:00 - 12:00', 4),
    ('Giovedì', '14:00 - 18:00', 4),
    ('Venerdì', '08:30 - 12:30', 4),
    ('Venerdì', '15:00 - 19:00', 4),
    ('Sabato', '09:00 - 13:00', 4),
    ('Sabato', '14:00 - 18:00', 4);

-- Inserimento degli orari per il laboratorio esterno con ID 5
INSERT INTO OrariDiAperturaLabEst (giornoSett, fasciaOraria, codice)
VALUES
    ('Lunedì', '08:00 - 12:00', 5),
    ('Lunedì', '14:00 - 18:00', 5),
    ('Martedì', '08:30 - 12:30', 5),
    ('Martedì', '15:00 - 19:00', 5),
    ('Mercoledì', '09:00 - 13:00', 5),
    ('Mercoledì', '14:00 - 18:00', 5),
    ('Giovedì', '08:00 - 12:00', 5),
    ('Giovedì', '14:00 - 18:00', 5),
    ('Venerdì', '08:30 - 12:30', 5),
    ('Venerdì', '15:00 - 19:00', 5),
    ('Sabato', '09:00 - 13:00', 5),
    ('Sabato', '14:00 - 18:00', 5);

INSERT INTO Prescrizione (codice, data, nTesSanitariaPaziente, codEs, CFMedico, CFMedEst)
VALUES
(6, '2024-10-10', '1234567890', 1, 'PLRMRC85M05L123T', NULL),
(2, '2024-01-12', '0987654321', 1, 'BNCMRC90L10R234U', NULL),
(3, '2024-01-15', '2345678901', 1, 'RSVRNC82P22K345V', NULL),
(4, '2024-01-18', '1234567890', 1, 'VDLBLL87N11N456W', NULL),
(5, '2024-01-20', '0987654321', 1, 'CRSFRC79D19S567X', NULL),
(1, '2024-01-10', '1234567890', 1, 'PLRMRC85M05L123T', null),
(7, '2024-01-10', '5678901234', 1, 'PLRMRC85M05L123T', null);


INSERT INTO Prenotazione (dateTimeEs, codiceEsame, nTesSanitariaPaziente, urgenza, dataPrenotazione, codLabInt, codLabEst, codPrescrizione, regime)
VALUES
('2024-06-15 10:00:00', 1, '1234567890', 'Verde', '2024-06-10',6, NULL, 1, TRUE);

INSERT INTO Prenotazione (dateTimeEs, codiceEsame, nTesSanitariaPaziente, urgenza, dataPrenotazione, codLabInt, codLabEst, codPrescrizione, regime)
VALUES
('2024-06-17 10:30:00', 2, '0987654321', 'Rosso', '2024-06-15', NULL, 1, NULL, FALSE);

INSERT INTO Prenotazione (dateTimeEs, codiceEsame, nTesSanitariaPaziente, urgenza, dataPrenotazione, codLabInt, codLabEst, codPrescrizione, regime)
VALUES
('2024-06-15 10:00:00', 1, '5678901234', 'Verde', '2024-06-10',6, NULL, 7, TRUE);

insert into sostituzione(cfmedico1,cfmedico2,datainizio,datafine) VALUES
('FNHVLD85A02E523X','MRCVRD82A01H501Y','2022-05-03','2022-05-04'),
('GRIHDZ36L19G311N','MRCVRD82A01H501Y','2021-05-01','2021-05-02'),
('GRIHDZ36L19G311N','MRCVRD82A01H501Y','2022-05-01','2022-05-02');

-- Inserimento dei dati nella tabella SalaOperatoria utilizzando solo le stanze con utilizzo = 'sala operatoria'
insert into SalaOperatoria(codice, numeroStanza, pianoStanza, codOspedale, nomeReparto) VALUES
(1, 201,	2,	1,	'Reparto di Ortopedia'),
(2, 105,	1,	1,	'Reparto di Cardiologia'),
(3, 109,	1,	1,	'Reparto di Cardiologia'),
(4, 113,	1,	1,	'Reparto di Cardiologia'),
(5, 117,	1,	1,	'Reparto di Cardiologia'),
(6, 121,	1,	1,	'Reparto di Cardiologia'),
(7, 205,	2,	1,	'Reparto di Ortopedia'),
(8, 209,	2,	1,	'Reparto di Ortopedia');

insert into utenti (username, pass, TipoUtente, tesserasanitaria, cf ) VALUES
('Amministratore1', 'ciao123', 'Amministratore', null,'VRDGLR85M01H501Z'),
('Dottore1','dottore1', 'Medico',null,'BNCMRC90L10R234U'),
('Paziente1', 'paziente1','Paziente', 5678901234, null),
('Amministratore2', 'ciao456','Amministratore',null,'FRNLGN85M01H501Z'),
('Dottore2','dottore2','Medico', null,'GRGFLT84H04E380Q'),
('Paziente2', 'paziente2','Paziente', 3456789012, null),
('DBA', 'admin','DBA', null,null);

insert into utenti (username, pass, TipoUtente, tesserasanitaria, cf ) VALUES
('Infermiere1', 'infermiere1', 'Infermiere', null,'PLZLUC80E05H501R'),
('Infermiere2', 'infermiere2', 'Infermiere', null,'RSSMRA85M01H501Z');