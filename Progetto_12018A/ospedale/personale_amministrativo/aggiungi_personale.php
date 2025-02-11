<?php

    include_once "../header.php";
    include_once "../database.php";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $cf = $_POST["cf"];
        $nome = $_POST["nome"];
        $cognome = $_POST["cognome"];
        if (isset($_POST['reparto'])) {
            list($nomereparto, $codospedale) = explode('-', $_POST['reparto']);      
        }

        $query = "INSERT INTO PersonaleAmministrativo (cf, nome, cognome, nomereparto, codospedale) VALUES ('$cf', '$nome', '$cognome', '$nomereparto', '$codospedale')";
        $result = pg_query($conn, $query);

        if ($result) {
            echo "Personale amministrativo aggiunto con successo";
        } else {
            echo "Errore nell'aggiunta del personale amministrativo";
        }
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aggiungi Personale Amministrativo</title>
</head>

<body>
    <form action="/ospedale/personale_amministrativo/personale_amministrativo.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>