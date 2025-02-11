<?php
    
    include_once "../header.php";
    include_once "../database.php";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $codice = $_POST["codice"];
        $indirizzo = $_POST["indirizzo"];
        $nome = $_POST["nome"];

        $query = "INSERT INTO Ospedale (codice, indirizzo, nome) VALUES ('$codice', '$indirizzo', '$nome')";
        $result = pg_query($conn, $query);

        if ($result) {
            echo "Ospedale aggiunto con successo";
        } else {
            echo "Errore nell'aggiunta dell'ospedale";
        }
    }
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aggiungi ospedale</title>
</head>
<body>
    <form action="/ospedale/ospedale/ospedale.php">
        <button type="submit">Torna alla lista ospedali</button>
    </form>
</body>
</html>