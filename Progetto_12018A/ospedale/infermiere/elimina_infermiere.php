<?php

    include_once "../header.php";
    include_once "../database.php";

    if(isset($_POST['azione']) && $_POST['azione'] == 'elimina'){
        $cf = $_POST['cf'];

        $query = "DELETE FROM Infermiere WHERE cf = $1";
        $result = pg_query_params($conn, $query, array($cf));

        if($result){
            echo "Infermiere eliminato con successo!<br>";
        } else {
            echo "Errore nell'eliminazione dell'infermiere: " . pg_last_error($conn);
        }
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elimina infermiere</title>
</head>

<body>
    <form action="/ospedale/infermiere/infermiere.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>