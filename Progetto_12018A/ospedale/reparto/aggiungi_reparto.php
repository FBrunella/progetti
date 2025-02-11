<?php

    include_once "../header.php";
    include_once "../database.php";

    if ($_SERVER["REQUEST_METHOD"] == "POST") {
        $nome = $_POST["nome"];
        $codospedale = $_POST["codospedale"];
        $telefono = $_POST["telefono"];

        $query = "INSERT INTO Reparto (nome, codospedale, telefono) VALUES ('$nome', '$codospedale', '$telefono')";
        $result = pg_query($conn, $query);

        if ($result) {
            echo "Reparto aggiunto con successo";
        } else {
            echo "Errore nell'aggiunta del reparto";
        }
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Aggiungi reparto</title>
</head>
<body>
    <form action="/ospedale/reparto/reparto.php">
        <button type="submit">Torna alla lista reparti</button>
    </form>
</body>
</html>
