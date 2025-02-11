<?php

include_once "../header.php";
include_once "../database.php";

$query = "SELECT * FROM Ospedale";
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
    <title>Ospedali</title>
    <script>
        // Funzione per abilitare/disabilitare il pulsante
        function toggleSubmitButton() {
            const codice = document.getElementById('codice').value.trim();
            const indirizzo = document.getElementById('indirizzo').value.trim();
            const nome = document.getElementById('nome').value.trim();
            const submitButton = document.getElementById('submitButton');

            // Abilita il pulsante solo se tutti i campi hanno un valore
            if (codice && indirizzo && nome) {
                submitButton.disabled = false;
            } else {
                submitButton.disabled = true;
            }
        }

        // Aggiungiamo l'event listener ai campi per verificare il loro stato
        document.addEventListener('DOMContentLoaded', () => {
            const inputs = document.querySelectorAll('#codice, #indirizzo, #nome');
            inputs.forEach(input => {
                input.addEventListener('input', toggleSubmitButton);
            });

            // Impostazione iniziale del pulsante come disabilitato
            toggleSubmitButton();
        });
    </script>
</head>
<body>
    <h1>Ospedali</h1>
    <h2>Aggiungi ospedale</h2>
    <form action="aggiungi_ospedale.php" method="post">
        <label for="codice">Codice</label>
        <input type="text" name="codice" id="codice">
        <br>
        <label for="indirizzo">Indirizzo</label>
        <input type="text" name="indirizzo" id="indirizzo">
        <br>
        <label for="nome">Nome</label>
        <input type="text" name="nome" id="nome">
        <br>
        <input type="submit" id="submitButton" value="Aggiungi" disabled>
    </form>
    <h3>Lista ospedali</h3>
    <table>
        <tr>
            <th>Codice</th>
            <th>Indirizzo</th>
            <th>Nome</th>
            <th>Azioni</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['codice'] . "</td>";
                echo "<td>" . $row['indirizzo'] . "</td>";
                echo "<td>" . $row['nome'] . "</td>";

                echo "<td><form action='modifica_ospedale.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='codice' value='". $row['codice'] ."'>";
                echo "<button type='submit'>Modifica</button>";
                echo "</form>";
                echo "<form action='elimina_ospedale.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='codice' value='". $row['codice'] ."'>";
                echo "<button type='submit'>Elimina</button>";
                echo "</form></td>";
                echo "</tr>";
            }
        ?>
    </table>
</body>
</html>