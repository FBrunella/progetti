<?php

    include_once "../header.php";
    include_once "../database.php";

    $query = "SELECT * FROM Reparto";
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
    <title>Reparti</title>
    <script>
        function enableSubmit() {
            // Ottieni i valori dei campi
            var nome = document.getElementById('nome').value;
            var codospedale = document.getElementById('codospedale').value;
            var telefono = document.getElementById('telefono').value;

            // Se tutti i campi sono valorizzati, abilita il pulsante di submit
            if (nome && codospedale && telefono) {
                document.getElementById('submitBtn').disabled = false;
            } else {
                document.getElementById('submitBtn').disabled = true;
            }
        }
    </script>
</head>
<body>
    <h1>Reparti</h1>
    <h2>Aggiungi reparto</h2>
    <form action="aggiungi_reparto.php" method="post">
        <label for="nome">Nome</label>
        <input type="text" name="nome" id="nome" oninput="enableSubmit()">
        <br>
        <label for="codospedale">Codice Ospedale</label>
        <input type="text" name="codospedale" id="codospedale" oninput="enableSubmit()">
        <br>
        <label for="telefono">Numero di Telefono</label>
        <input type="text" name="telefono" id="telefono" oninput="enableSubmit()">
        <br>
        <input type="submit" id="submitBtn" value="Aggiungi" disabled>
    </form>
    <h3>Lista reparti</h3>
    <table>
        <tr>
            <th>Nome</th>
            <th>Codice Ospedale</th>
            <th>Telefono</th>
            <th>Azioni</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['nome'] . "</td>";
                echo "<td>" . $row['codospedale'] . "</td>";
                echo "<td>" . $row['telefono'] . "</td>";

                echo "<td><form action='modifica_reparto.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='nome' value='". $row['nome'] ."'>";
                echo "<button type='submit'>Modifica</button>";
                echo "</form>";
                echo "<form action='elimina_reparto.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='nome' value='". $row['nome'] ."'>";
                echo "<button type='submit'>Elimina</button>";
                echo "</form>";
                echo "&nbsp";
                echo "<form action='visualizza_personale.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='nome' value='". $row['nome'] ."'>";
                echo "<button type='submit'>Visualizza Personale</button>";
                echo "</form></td>";
                echo "</tr>";
                
            }
        ?>
    </table>
</body>