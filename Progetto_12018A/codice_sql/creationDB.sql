CREATE TABLE Ospedale (
    codice INT PRIMARY KEY,
    indirizzo VARCHAR(255) NOT NULL CHECK (indirizzo ~ '^Via [a-zA-Z0-9\s]+ \d+, \d{5}$'),
    nome VARCHAR(100) NOT NULL
);

CREATE TABLE Reparto (
    nome VARCHAR(100) NOT NULL,
    codOspedale INT NOT NULL,
    telefono VARCHAR(10) NOT NULL CHECK (telefono ~ '^[0-9]{1,10}$'),
    PRIMARY KEY (nome, codOspedale),
    FOREIGN KEY (codOspedale) REFERENCES Ospedale(codice) ON UPDATE CASCADE
);

CREATE TABLE Orari (
    GiornodellaSett VARCHAR(9) NOT NULL,
    fasciaoraria VARCHAR(25) NOT NULL CHECK (fasciaoraria ~ '^\d{2}:\d{2} \- \d{2}:\d{2}$'),
    PRIMARY KEY (GiornodellaSett, fasciaoraria)
);

CREATE TABLE Infermiere (
    CF VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    nomeReparto VARCHAR(100) NOT NULL,
    codOspedale INT NOT NULL,
    FOREIGN KEY (nomeReparto, codOspedale) REFERENCES Reparto(nome, codOspedale) ON UPDATE CASCADE
);

CREATE TABLE PersonaleAmministrativo (
    CF VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Cognome VARCHAR(100) NOT NULL,
    nomeReparto VARCHAR(100) NOT NULL,
    codOspedale INT NOT NULL,
    FOREIGN KEY (nomeReparto, codOspedale) REFERENCES Reparto(nome, codOspedale) ON UPDATE CASCADE
);

CREATE TABLE ProntoSoccorso (
    Codice INT PRIMARY KEY,
    CodOspedale INT NOT NULL,
    FOREIGN KEY (CodOspedale) REFERENCES Ospedale(codice) ON UPDATE CASCADE
);

CREATE TABLE Specializzazioni (
    nome VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Patologie (
    nome VARCHAR(100) PRIMARY KEY
);

CREATE TABLE Paziente (
    nTesSanitaria VARCHAR(20) PRIMARY KEY CHECK (nTesSanitaria ~ '^[0-9]+$'),
    nome VARCHAR(100) NOT NULL,
    cognome VARCHAR(100) NOT NULL,
    dataNascita DATE NOT NULL,
    indirizzo VARCHAR(255) NOT NULL CHECK (indirizzo ~ '^Via [a-zA-Z0-9\s]+ \d+, \d{5}$')
);

CREATE TABLE Avvertenze (
    codice INT PRIMARY KEY,
    descrizione VARCHAR(255) NOT NULL
);

CREATE TABLE Medico (
    CF VARCHAR(16) PRIMARY KEY,
    DataDiAssunzione DATE NOT NULL,
    vice BOOLEAN,
    primario BOOLEAN,
    nomeReparto VARCHAR(100) NOT NULL,
    codOspedale INT NOT NULL,
    DataPromozioneVice DATE,
    FOREIGN KEY (nomeReparto, codOspedale) REFERENCES Reparto(nome, codOspedale) ON UPDATE CASCADE,
    FOREIGN KEY (codOspedale) REFERENCES Ospedale(codice) ON UPDATE CASCADE,
    CHECK ((vice = FALSE AND primario = FALSE) OR (vice = TRUE AND primario = FALSE) OR (vice = FALSE AND primario = TRUE)), -- vincolo 16
    CHECK (DataPromozioneVice IS NULL OR (vice != primario)), -- vincolo 13
    CHECK (DataPromozioneVice IS NULL OR DataPromozioneVice > DataDiAssunzione) -- vincolo 17
);

CREATE TABLE MedicoEsterno (
    CF VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(255) NOT NULL,
    Cognome VARCHAR(255) NOT NULL
);

CREATE TABLE LaboratorioEsterno (
    codice INT PRIMARY KEY,
    indirizzo VARCHAR(255) NOT NULL CHECK (indirizzo ~ '^Via [a-zA-Z0-9\s]+, \d{1,5}, \d{5}$'),
    telefono VARCHAR(10) NOT NULL CHECK (telefono ~ '^[0-9]{1,10}$')
);

CREATE TABLE AssociazioneOspedaleLaboratorioEsterno (
    codOspedale INT,
    codLabLaboratorioEsterno INT,
    PRIMARY KEY (codOspedale, codLabLaboratorioEsterno),
    FOREIGN KEY (codOspedale) REFERENCES Ospedale(codice) ON UPDATE CASCADE,
    FOREIGN KEY (codLabLaboratorioEsterno) REFERENCES LaboratorioEsterno(codice) ON UPDATE CASCADE
);

CREATE TABLE TurniInfermieri (
    codProntoSoccorso INT,
    dateTimeInit TIMESTAMP,
    dateTimeFine TIMESTAMP,
    CFInfermiere VARCHAR(16),
    PRIMARY KEY (codProntoSoccorso, dateTimeInit, dateTimeFine, CFInfermiere),
    FOREIGN KEY (codProntoSoccorso) REFERENCES ProntoSoccorso(Codice) ON UPDATE CASCADE,
    FOREIGN KEY (CFInfermiere) REFERENCES Infermiere(CF) ON UPDATE CASCADE
);

CREATE TABLE TurniMedici (
    codProntoSoccorso INT,
    dateTimeInit TIMESTAMP,
    dateTimeFine TIMESTAMP,
    CFMedico VARCHAR(16),
    PRIMARY KEY (codProntoSoccorso, dateTimeInit, dateTimeFine, CFMedico),
    FOREIGN KEY (codProntoSoccorso) REFERENCES ProntoSoccorso(Codice) ON UPDATE CASCADE,
    FOREIGN KEY (CFMedico) REFERENCES Medico(CF) ON UPDATE CASCADE
);

CREATE TABLE Sostituzione (
    CFMedico1 VARCHAR(16),
    CFMedico2 VARCHAR(16),
    DataInizio DATE NOT NULL,
    DataFine DATE,
    PRIMARY KEY (CFMedico1, CFMedico2, DataInizio),
    FOREIGN KEY (CFMedico1) REFERENCES Medico(CF) ON UPDATE CASCADE,
    FOREIGN KEY (CFMedico2) REFERENCES Medico(CF) ON UPDATE CASCADE,
    CHECK (DataFine IS NULL OR DataFine >= DataInizio) -- vincolo 7
);

CREATE TABLE Stanza (
    numero INT,
    piano INT,
    codOspedale INT,
    nomeReparto VARCHAR(255),
    utilizzo VARCHAR(255) NOT NULL,
    PRIMARY KEY (numero, piano, codOspedale, nomeReparto),
    FOREIGN KEY (nomeReparto, codOspedale) REFERENCES Reparto(nome, codOspedale) ON UPDATE CASCADE,
    CHECK (
        utilizzo IN ('laboratorio', 'stanza da letto', 'sala operatoria', 'altro')
    )
);

CREATE TABLE SalaOperatoria (
    codice INT PRIMARY KEY,
    numeroStanza INT NOT NULL,
    pianoStanza INT NOT NULL,
    nomeReparto VARCHAR(255),
    codOspedale INT NOT NULL,
    FOREIGN KEY (numeroStanza,pianoStanza, nomeReparto, codOspedale) REFERENCES Stanza(numero,piano,nomeReparto,codOspedale) ON UPDATE CASCADE
);

CREATE TABLE LaboratorioInterno (
    codice INT PRIMARY KEY,
    numeroStanza INT NOT NULL,
    pianoStanza INT NOT NULL,
    nomeReparto VARCHAR(255),
    codOspedale INT NOT NULL,
    FOREIGN KEY (numeroStanza,pianoStanza, nomeReparto, codOspedale) REFERENCES Stanza(numero,piano,nomeReparto,codOspedale) ON UPDATE CASCADE
);

CREATE TABLE Letto (
    codLetto INT PRIMARY KEY,
    numeroStanza INT NOT NULL,
    pianoStanza INT NOT NULL,
    nomeReparto VARCHAR(255) NOT NULL,
    codOspedale INT NOT NULL,
    FOREIGN KEY (numeroStanza, pianoStanza, nomeReparto, codOspedale) REFERENCES Stanza(numero, piano, nomeReparto, codOspedale) ON UPDATE CASCADE
);

CREATE TABLE Ricovero (
    codLetto INT NOT NULL,
    DataRicovero DATE NOT NULL,
    nTesSanitariaPaziente VARCHAR(20) NOT NULL,
    DataDimissione DATE,
    PRIMARY KEY (codLetto, DataRicovero, nTesSanitariaPaziente),
    FOREIGN KEY (codLetto) REFERENCES Letto(codLetto) ON UPDATE CASCADE,
    FOREIGN KEY (nTesSanitariaPaziente) REFERENCES Paziente(nTesSanitaria) ON UPDATE CASCADE,
    CHECK (DataDimissione IS NULL OR DataDimissione >= DataRicovero) -- vincolo 8
);

CREATE TABLE Esame (
    codEs INT PRIMARY KEY,
    nomeSpecializzazione VARCHAR(100),
    descrizione VARCHAR(255) NOT NULL,
    costoPub DECIMAL(10, 2) NOT NULL,
    costoPriv DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (nomeSpecializzazione) REFERENCES Specializzazioni(nome) ON UPDATE CASCADE
);

CREATE TABLE MedicoSpecializzazioni (
    CF VARCHAR(16),
    NomeSpecializzazione VARCHAR(255),
    FOREIGN KEY (CF) REFERENCES Medico(CF),
    FOREIGN KEY (NomeSpecializzazione) REFERENCES Specializzazioni(nome) ON UPDATE CASCADE,
    PRIMARY KEY (CF, NomeSpecializzazione)
);

CREATE TABLE MedicoEsternoSpecializzazioni (
    CF VARCHAR(16),
    nomeSpecializzazione VARCHAR(255),
    PRIMARY KEY (CF, nomeSpecializzazione),
    FOREIGN KEY (CF) REFERENCES MedicoEsterno(CF),
    FOREIGN KEY (nomeSpecializzazione) REFERENCES Specializzazioni(nome) ON UPDATE CASCADE
);


CREATE TABLE Prescrizione (
    codice INT PRIMARY KEY,
    data DATE NOT NULL,
    nTesSanitariaPaziente VARCHAR(20) NOT NULL,
    codEs INT NOT NULL,
    CFMedico VARCHAR(16),
    CFMedEst VARCHAR(16),
    FOREIGN KEY (nTesSanitariaPaziente) REFERENCES Paziente(nTesSanitaria) ON UPDATE CASCADE,
    FOREIGN KEY (codEs) REFERENCES Esame(codEs) ON UPDATE CASCADE,
    FOREIGN KEY (CFMedico) REFERENCES Medico(CF) ON UPDATE CASCADE,
    FOREIGN KEY (CFMedEst) REFERENCES MedicoEsterno(CF) ON UPDATE CASCADE
);

CREATE TABLE Prenotazione (
    dateTimeEs TIMESTAMP,
    codiceEsame INT,
    nTesSanitariaPaziente VARCHAR(16),
    urgenza VARCHAR(10),
    dataPrenotazione DATE NOT NULL,
    codLabInt INT,
    codLabEst INT,
    codPrescrizione INT,
    regime BOOLEAN,
    PRIMARY KEY (dateTimeEs, codiceEsame, nTesSanitariaPaziente),
    FOREIGN KEY (codiceEsame) REFERENCES Esame(codEs) ON UPDATE CASCADE,
    FOREIGN KEY (nTesSanitariaPaziente) REFERENCES Paziente(nTesSanitaria) ON UPDATE CASCADE, -- Vincolo di integrità referenziale con il paziente
    FOREIGN KEY (codLabInt) REFERENCES LaboratorioInterno(codice) ON UPDATE CASCADE,
    FOREIGN KEY (codLabEst) REFERENCES LaboratorioEsterno(codice) ON UPDATE CASCADE,
    FOREIGN KEY (codPrescrizione) REFERENCES Prescrizione(codice) ON UPDATE CASCADE,
    CHECK (
        (codLabInt IS NOT NULL AND codLabEst IS NULL) OR
        (codLabInt IS NULL AND codLabEst IS NOT NULL)
    ),
    CHECK (
        regime IN (CASE WHEN codPrescrizione IS NOT NULL THEN TRUE ELSE FALSE END) -- Vincolo per il flag regime
    )
);

CREATE TABLE MotivazioneRicovero (
    codLetto INT,
    DataRicovero DATE,
    nTesSanitariaPaziente VARCHAR(20),
    nomePatologia VARCHAR(255),
    PRIMARY KEY (codLetto, DataRicovero, nTesSanitariaPaziente, nomePatologia),
    FOREIGN KEY (codLetto, DataRicovero, nTesSanitariaPaziente) REFERENCES Ricovero(codLetto, DataRicovero, nTesSanitariaPaziente) ON UPDATE CASCADE,
    FOREIGN KEY (nomePatologia) REFERENCES Patologie(nome) ON UPDATE CASCADE
);

CREATE TABLE AvvertenzeEsame (
    codEs INT,
    codAvv INT,
    PRIMARY KEY (codEs, codAvv),
    FOREIGN KEY (codEs) REFERENCES Esame(codEs) ON UPDATE CASCADE,
    FOREIGN KEY (codAvv) REFERENCES Avvertenze(codice) ON UPDATE CASCADE
);

CREATE TABLE OrariDivisitaReparto (
    giornoSett VARCHAR(20),
    fasciaoraria VARCHAR(25) NOT NULL CHECK (fasciaoraria ~ '^\d{2}:\d{2} \- \d{2}:\d{2}$'),
    NomeReparto VARCHAR(255),
    codOspedale INT,
    PRIMARY KEY (giornoSett, fasciaOraria, NomeReparto, codOspedale),
    FOREIGN KEY (giornoSett, fasciaOraria) REFERENCES Orari(GiornoDellaSett, FasciaOraria) ON UPDATE CASCADE,
    FOREIGN KEY (NomeReparto, codOspedale) REFERENCES Reparto(Nome, codOspedale) ON UPDATE CASCADE
);

CREATE TABLE OrariDiAperturaLabInt (
    giornoSett VARCHAR(20),
    fasciaoraria VARCHAR(25) NOT NULL CHECK (fasciaoraria ~ '^\d{2}:\d{2} \- \d{2}:\d{2}$'),
    codice INT,
    PRIMARY KEY (giornoSett, fasciaOraria, codice),
    FOREIGN KEY (giornoSett, fasciaOraria) REFERENCES Orari(GiornoDellaSett, FasciaOraria) ON UPDATE CASCADE,
    FOREIGN KEY (codice) REFERENCES LaboratorioInterno(codice) ON UPDATE CASCADE
);

CREATE TABLE OrariDiAperturaLabEst (
    giornoSett VARCHAR(20),
    fasciaoraria VARCHAR(25) NOT NULL CHECK (fasciaoraria ~ '^\d{2}:\d{2} \- \d{2}:\d{2}$'),
    codice INT,
    PRIMARY KEY (giornoSett, fasciaOraria, codice),
    FOREIGN KEY (giornoSett, fasciaOraria) REFERENCES Orari(GiornoDellaSett, FasciaOraria) ON UPDATE CASCADE,
    FOREIGN KEY (codice) REFERENCES LaboratorioEsterno(codice) ON UPDATE CASCADE
);

CREATE TABLE utenti(
    username VARCHAR(255) PRIMARY KEY,
    pass VARCHAR(255) NOT NULL,
    tipoUtente VARCHAR(255) NOT NULL CHECK(tipoUtente='Amministratore' OR tipoUtente='Medico' OR tipoUtente='Paziente' OR tipoUtente='DBA' OR tipoUtente='Infermiere'),
    tesserasanitaria VARCHAR(20),
    cf VARCHAR(16)
);
