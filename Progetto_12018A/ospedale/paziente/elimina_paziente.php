<?php

    include_once "../header.php";
    include_once "../database.php";

    if(isset($_POST['ntessanitaria'])){
        $ntessanitaria = $_POST['ntessanitaria'];

        $query = "DELETE FROM Paziente WHERE ntessanitaria = $1";
        $result = pg_query_params($conn, $query, array($ntessanitaria));

        if($result){
            echo "Paziente eliminato con successo!<br>";
        } else {
            echo "Errore nell'eliminazione del paziente: " . pg_last_error($conn);
        }

    }

?>  

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Elimina paziente</title>
</head>

<body>
    <form action="/ospedale/paziente/paziente.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>