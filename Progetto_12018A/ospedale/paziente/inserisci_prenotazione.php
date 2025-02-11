<?php

    include_once "../header.php";
    include_once "../database.php";


    $query = "INSERT INTO Prenotazione (ntessanitariapaziente, datetimees, urgenza, codprescrizione, codlabint, codlabest) VALUES ($1, $2, $3, $4, $5, $6)";
    $result = pg_query_params($conn, $query, array($_POST['ntessanitaria'], $_POST['dataesame'], $_POST['urgenza'], $_POST['codprescrizione'], $_POST['codlabint'], $_POST['codlabest']));

    if (!$result) {
        echo "Errore nella query: " . pg_last_error($conn);
        exit;
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Inserimento completato</title>
</head>
<body>
    <h1>Inserimento completato</h1>
    <form action="/ospedale/paziente/paziente.php">
        <br>
        <button type="submit">Torna alla Home</button>
    </form>