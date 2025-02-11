<?php

    include "../header.php";
    include_once "../database.php";

    if(isset($_POST['codice'])){
        $codice = $_POST['codice'];

        $query = "DELETE FROM Ospedale WHERE codice = $1";
        $result = pg_query_params($conn, $query, array($codice));

        if($result){
            echo "Ospedale eliminato con successo!<br>";
        } else {
            echo "Errore nell'eliminazione dell'ospedale: " . pg_last_error($conn);
        }

    }
    
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elimina ospedale</title>
</head>
<body>
    <form action="/ospedale/ospedale/ospedale.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>