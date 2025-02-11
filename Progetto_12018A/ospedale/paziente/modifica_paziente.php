<?php
include_once "../header.php";
include_once "../database.php";

$paziente = null; // Inizializziamo la variabile $paziente

// Se il form è stato inviato per l'aggiornamento
if (isset($_POST['azione']) && $_POST['azione'] == 'aggiorna') {
    $ntessanitaria = $_POST['ntessanitaria'];
    $nome = $_POST['nome'];
    $cognome = $_POST['cognome'];
    $datanascita = $_POST['datanascita'];
    $indirizzo = $_POST['indirizzo'];   

    // Esegui l'aggiornamento
    $query = "UPDATE Paziente SET nome = $1, cognome = $2, datanascita = $3, indirizzo = $4 WHERE ntessanitaria = $5";
    $result = pg_query_params($conn, $query, array($nome, $cognome, $datanascita, $indirizzo, $ntessanitaria));

    if ($result) {
        echo "Paziente aggiornato con successo!<br>";

        // Ricarica i dati del paziente aggiornato per visualizzarli nel modulo
        $query2 = "SELECT * FROM Paziente WHERE ntessanitaria = $1";
        $result2 = pg_query_params($conn, $query2, array($ntessanitaria));
        $paziente = pg_fetch_assoc($result2);
    } else {
        echo "Errore nell'aggiornamento del paziente: " . pg_last_error($conn);
    }
}
// Se il paziente non è ancora stato caricato, caricalo per la visualizzazione
else if (isset($_POST['ntessanitaria'])) {
    $ntessanitaria = $_POST['ntessanitaria'];

    $query2 = "SELECT * FROM Paziente WHERE ntessanitaria = $1";
    $result2 = pg_query_params($conn, $query2, array($ntessanitaria));
    $paziente = pg_fetch_assoc($result2);
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica paziente</title>
</head>

<body>
    <h2>Aggiorna Paziente</h2>
    <form action="modifica_paziente.php" method="POST">
        <label for="ntessanitaria">Numero Tessera Sanitaria:</label>
        <input type="text" name="ntessanitaria" value="<?php echo htmlspecialchars($paziente['ntessanitaria'] ?? ''); ?>" readonly>
        <br>
        
        <label for="nome">Nome:</label>
        <input type="text" name="nome" id="nome" value="<?php echo htmlspecialchars($paziente['nome'] ?? ''); ?>">
        <br>
        
        <label for="cognome">Cognome:</label>
        <input type="text" name="cognome" id="cognome" value="<?php echo htmlspecialchars($paziente['cognome'] ?? ''); ?>">
        <br>
        
        <label for="datanascita">Data Nascita:</label>
        <input type="date" name="datanascita" id="datanascita" value="<?php echo htmlspecialchars($paziente['datanascita'] ?? ''); ?>">
        <br>
        
        <label for="indirizzo">Indirizzo:</label>
        <input type="text" name="indirizzo" id="indirizzo" value="<?php echo htmlspecialchars($paziente['indirizzo'] ?? ''); ?>">
        <br>

        <input type="hidden" name="azione" value="aggiorna">
        <button type="submit">Aggiorna paziente</button>
    </form>

    <form action="/ospedale/paziente/paziente.php">
        <br>
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>
