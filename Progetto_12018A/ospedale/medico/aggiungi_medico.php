<?php

include_once "../header.php";
include_once "../database.php";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $cf = $_POST["cf"];
    $datadiassunzione = $_POST["datadiassunzione"];
    $primario = isset($_POST["primario"]) ? 'true' : 'false';
    $vice = isset($_POST["vice"]) ? 'true' : 'false';
    if (isset($_POST['reparto'])) {
        list($nomereparto, $codospedale) = explode('-', $_POST['reparto']);      
    }
    
    $datapromozionevice = isset($_POST["datapromozionevice"]) && $_POST["datapromozionevice"] !== '' ? $_POST["datapromozionevice"] : null;

    $query = "INSERT INTO Medico (cf, datadiassunzione, primario, vice, nomereparto, codospedale, datapromozionevice) VALUES ($1, $2, $3, $4, $5, $6, $7)";
    $params = array(
        $cf,
        $datadiassunzione,
        $primario,
        $vice,
        $nomereparto,
        $codospedale,
        $datapromozionevice
    );

    $result = pg_query_params($conn, $query, $params);

    if ($result) {
        echo "Medico aggiunto con successo";
    } else {
        echo "Errore nell'aggiunta del medico: " . pg_last_error($conn);
    }
}

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aggiungi Medico</title>
</head>

<body>
    <form action="/ospedale/medico/medico.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>
