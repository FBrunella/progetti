<?php

    include_once "../header.php";
    include_once "../database.php";

    if(isset($_POST['nome'])){
        $nome = $_POST['nome'];

        $query = "DELETE FROM Reparto WHERE nome = $1";
        $result = pg_query_params($conn, $query, array($nome));

        if($result){
            echo "Reparto eliminato con successo!<br>";
        } else {
            echo "Errore nell'eliminazione del reparto: " . pg_last_error($conn);
        }

    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elimina reparto</title>
</head>
<body>
    <form action="/ospedale/reparto/reparto.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>
