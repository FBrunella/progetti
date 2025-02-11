<?php

    include_once "../header.php";
    include_once "../database.php";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $ntessanitaria = $_POST["ntessanitaria"];
        $nome = $_POST["nome"];
        $cognome = $_POST["cognome"];
        $datanascita = $_POST["datanascita"];
        $indirizzo = $_POST["indirizzo"];

        $query = "INSERT INTO Paziente (ntessanitaria, nome, cognome, datanascita, indirizzo) VALUES ('$ntessanitaria', '$nome', '$cognome', '$datanascita', '$indirizzo')";
        $result = pg_query($conn, $query);

        if ($result) {
            echo "Paziente aggiunto con successo";
        } else {
            echo "Errore nell'aggiunta del paziente";
        }
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aggiungi paziente</title>
</head>

<body>
    <form action="/ospedale/paziente/paziente.php">
        <button type="submit">Torna alla lista pazienti</button>
    </form>
</body>
</html>