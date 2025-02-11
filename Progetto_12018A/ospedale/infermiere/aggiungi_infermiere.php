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

        $query = "INSERT INTO Infermiere (cf, nome, cognome, nomereparto, codospedale) VALUES ('$cf', '$nome', '$cognome', '$nomereparto', '$codospedale')";
        $result = pg_query($conn, $query);

        if ($result) {
            echo "Infermiere aggiunto con successo";
        } else {
            echo "Errore nell'aggiunta dell'infermiere";
        }
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aggiungi Infermiere</title>
</head>

<body>
    <form action="/ospedale/infermiere/infermiere.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>