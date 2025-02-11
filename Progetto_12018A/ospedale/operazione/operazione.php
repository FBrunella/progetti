<?php

    include "../header.php";
    include_once "../database.php";

    $query = "SELECT DISTINCT 
                    m.cf AS codice_fiscale_medico,
                    r.nome AS nome_reparto,
                    r.codospedale
                FROM tirocinante t
                JOIN medico m ON t.cf = m.cf
                JOIN reparto r ON t.codospedale = r.codospedale AND t.nome_reparto = r.nome
                WHERE t.data_fine IS NOT NULL
                AND r.nome = 'Reparto di Cardiologia'";
    
    $result = pg_query($conn, $query);
   
    if (!$result) {
        echo "Errore nella query: " . pg_last_error($conn);
        exit;
    }

        
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ospedale</title>
</head>
<body>
    <h1>Tirocinanti del Reparto di Cardiologia assunti come Medici</h1>
    <table>
        <tr>
            <th>Codice Fiscale</th>
            <th>Nome Reparto</th>
            <th>Codice Ospedale</th>
        </tr>
        <?php
            while($row = pg_fetch_array($result)){
                echo "<tr>";
                echo "<td>" . $row['codice_fiscale_medico'] . "</td>";
                echo "<td>" . $row['nome_reparto'] . "</td>";    
                echo "<td>" . $row['codospedale'] . "</td>";
                echo "</tr>";
            }
        ?>
    </table>
</body>
</html>