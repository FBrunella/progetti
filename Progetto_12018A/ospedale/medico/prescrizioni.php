<?php 

    include_once "../header.php";
    include_once "../database.php";

    if(isset($_POST['cf'])) {
        $cfmedico = $_POST['cf'];

        $query = "SELECT * FROM prescrizione p WHERE cfmedico = $1";
        $result = pg_query_params($conn, $query, array($cfmedico));

        if (!$result) {
            echo "Errore nella query: " . pg_last_error($conn);
            exit;
        }

    } else {
        echo "Errore: manca il codice fiscale del medico";
        exit;
    }
    
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Prescrizioni</title>
</head>
<body>
    <h1>Prescrizioni</h1>
    <h2>Lista prescrizioni</h2>
    <table>
        <tr>
            <th>Codice Fiscale Paziente</th>
            <th>Codice Fiscale Medico</th>
            <th>Data</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['cfmedico'] . "</td>";
                echo "<td>" . $row['ntessanitariapaziente'] . "</td>";
                echo "<td>" . $row['data'] . "</td>";
            }
        ?>
    </table>
</body>
</html>