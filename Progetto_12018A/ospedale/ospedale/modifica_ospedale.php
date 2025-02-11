<?php

include_once "../header.php";
include_once "../database.php";

if (isset($_POST['azione']) && $_POST['azione'] == 'aggiorna') {
    // Aggiornamento dell'ospedale
    $codice = $_POST["codice"];
    $indirizzo = $_POST["indirizzo"];
    $nome = $_POST["nome"];

    // Query per aggiornare l'ospedale
    $query = "UPDATE Ospedale SET indirizzo = $1, nome = $2 WHERE codice = $3";
    $result = pg_query_params($conn, $query, array($indirizzo, $nome, $codice));

    if ($result) {
        echo "Ospedale aggiornato con successo.";
        $query2 = "SELECT * FROM Ospedale WHERE codice = $1";
        $result2 = pg_query_params($conn, $query2, array($codice));

        if ($result2 && pg_num_rows($result2) > 0) {
            $ospedale = pg_fetch_assoc($result2);
        } else {
            echo "Errore: nessun ospedale trovato con il codice specificato.";
            exit;
        }
    } else {
        echo "Errore nell'aggiornamento dell'ospedale: " . pg_last_error($conn);
    }
} elseif (isset($_POST['codice'])) {
    // Recupero informazioni dell'ospedale per la modifica
    $codice = $_POST['codice'];

    // Query per ottenere i dati dell'ospedale
    $query2 = "SELECT * FROM Ospedale WHERE codice = $1";
    $result2 = pg_query_params($conn, $query2, array($codice));

    if ($result2 && pg_num_rows($result2) > 0) {
        $ospedale = pg_fetch_assoc($result2);
    } else {
        echo "Errore: nessun ospedale trovato con il codice specificato.";
        exit;
    }
} else {
    echo "Errore: nessun codice ospedale fornito.";
    exit;
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica ospedale</title>
</head>
<body> 
    <h2>Aggiorna Ospedale</h2>
    <form action="modifica_ospedale.php" method="POST">
        <label for="codice">Codice:</label>
        <input type="text" name="codice" value="<?php echo isset($ospedale["codice"]) ? htmlspecialchars($ospedale["codice"]) : ''; ?>" readonly>
        <label for="indirizzo">Indirizzo:</label>
        <input type="text" name="indirizzo" id="indirizzo" value="<?php echo isset($ospedale["indirizzo"]) ? htmlspecialchars($ospedale["indirizzo"]) : ''; ?>">
        <label for="nome">Nome:</label>
        <input type="text" name="nome" id="nome" value="<?php echo isset($ospedale["nome"]) ? htmlspecialchars($ospedale["nome"]) : ''; ?>">
        <input type="hidden" name="azione" value="aggiorna">
        <button type="submit">Aggiorna ospedale</button>
    </form>
    <form action="/ospedale/ospedale/ospedale.php">
        <button type="submit">Torna alla lista ospedali</button>
    </form>
</body>
</html>
