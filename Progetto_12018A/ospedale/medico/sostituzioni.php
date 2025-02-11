<?php

    include_once "../database.php";
    include_once "../header.php";

    $query1 = "SELECT cfmedico1 FROM sostituzione group by(cfmedico1) HAVING COUNT (*) = 1";
    $query2 = "SELECT cfmedico1 FROM sostituzione group by(cfmedico1) HAVING COUNT (*) >= 2";
    $query3 = "SELECT cf FROM medico where vice = 't' and cf not in (SELECT cfmedico1 FROM sostituzione)";
    $result = pg_query($conn, $query1);
    $result2 = pg_query($conn, $query2);
    $result3 = pg_query($conn, $query3);
    
    if (!$result) {
        echo "Errore nella query: " . pg_last_error($conn);
        exit;
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Sostituzioni</title>
</head>
<body>
    <h2>Viceprimari che hanno sostituito UNA volta il primario</h2>
    <table>
        <tr>
            <th>Codice Fiscale</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['cfmedico1'] . "</td>";
                echo "</tr>";
            }
        ?>
    </table>
    <h2>Viceprimari che hanno sostituito PIU' di una volta il primario</h2>
    <table>
        <tr>
            <th>Codice Fiscale</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result2)) {
                echo "<tr>";
                echo "<td>" . $row['cfmedico1'] . "</td>";
                echo "</tr>";
            }
        ?>
    </table>
    <h2>Viceprimari che non hanno mai sostituito il primario</h2>
    <table>
        <tr>
            <th>Codice Fiscale</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result3)) {
                echo "<tr>";
                echo "<td>" . $row['cf'] . "</td>";
                echo "</tr>";
            }
        ?>
    </table>
    <form action="/ospedale/medico/medico.php">
        <br>
        <button type="submit">Torna alla Home</button>
    </form>