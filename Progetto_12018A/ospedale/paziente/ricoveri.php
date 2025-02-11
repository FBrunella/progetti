<?php

    include_once "../database.php";
    include_once "../header.php";

    if(isset($_POST['ntessanitaria'])) {
        $ntessanitaria = $_POST['ntessanitaria'];
        $query = "SELECT DISTINCT r.dataricovero , r.datadimissione , r2.nome AS reparto, s.numero AS stanza , s.piano, l.codletto FROM ricovero r
	    INNER JOIN letto l ON r.codletto = l.codletto
	    INNER JOIN reparto r2 ON r2.nome = l.nomereparto
	    INNER JOIN stanza s ON s.numero = l.numerostanza
        WHERE ntessanitariapaziente = $1";

        $result = pg_query_params($conn, $query, array($ntessanitaria));

        if (!$result) {
            echo "Errore nella query: " . pg_last_error($conn);
            exit;
        }
    }else{
        echo "Errore: manca il numero di tessera sanitaria";
        exit;
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Ricoveri</title>
</head>
<body>
    <h2>Ricoveri del paziente <?php echo $ntessanitaria ?></h2>
    <table>
        <tr>
            <th>Data di Ricovero</th>
            <th>Data di Dimissione</th>
            <th>Reparto</th>
            <th>Camera</th>
            <th>Piano</th>
            <th>Codice Letto</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['dataricovero'] . "</td>";
                echo "<td>" . $row['datadimissione'] . "</td>";
                echo "<td>" . $row['reparto'] . "</td>";
                echo "<td>" . $row['stanza'] . "</td>";
                echo "<td>" . $row['piano'] . "</td>";
                echo "<td>" . $row['codletto'] . "</td>";
                echo "</tr>";
            }
        ?>
    </table>
    <form action="/ospedale/paziente/paziente.php">
        <br>
        <button type="submit">Torna alla Home</button>
    </form>

