<?php
    include "../header.php";
    include_once "../database.php";

    $query = "SELECT * FROM Infermiere";
    $result = pg_query($conn, $query);
    $resultReparti = pg_query($conn, "SELECT * FROM Reparto");
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
    <title>Infermieri</title>
    <script type="text/javascript">
        // Funzione per abilitare/disabilitare il pulsante di submit
        function checkForm() {
            var cf = document.getElementById("cf").value;
            var nome = document.getElementById("nome").value;
            var cognome = document.getElementById("cognome").value;
            var nomereparto = document.getElementById("nomereparto").value;           
            var submitButton = document.getElementById("submit_button");

            // Il pulsante sarà abilitato solo se tutti i campi sono valorizzati
            if (cf && nome && cognome && nomereparto) {
                submitButton.disabled = false;  // Abilita il pulsante
            } else {
                submitButton.disabled = true;   // Disabilita il pulsante
            }
        }
    </script>
</head>
<body>
    <h1>Infermieri</h1>
    <h2>Aggiungi infermieri</h2>
    <form action="aggiungi_infermiere.php" method="post" oninput="checkForm()">
        <label for="cf">Codice Fiscale</label>
        <input type="text" name="cf" id="cf" onchange="checkForm()">
        <br>
        <label for="nome">Nome</label>
        <input type="text" name="nome" id="nome" onchange="checkForm()">
        <?php echo "&nbsp"; ?>
        <label for="cognome">Cognome</label>
        <input type="text" name="cognome" id="cognome" onchange="checkForm()">
        <br>
        <label for="nomereparto">Reparto</label>
        <select name="reparto" id="nomereparto">
        <?php 
            while ($row = pg_fetch_array($resultReparti)) {
                echo "<option value='" . $row['nome'] . "-" . $row['codospedale'] . "'>". $row['nome'] . " - Ospedale: " . $row['codospedale'] . "</option>";
            }
        ?>
        </select>       
        <div id="datapromozionevice" style="display: none;">
            <label for="datapromozionevice">Data di promozione a Primario:</label>
            <input type="date" name="datapromozionevice" id="datapromozionevice">
        </div>
        <br>
        <!-- Il pulsante submit è inizialmente disabilitato -->
        <input type="submit" id="submit_button" value="Aggiungi" disabled>
    </form>

    <h3>Lista Infermieri</h3>
    <table>
        <tr>
            <th>Codice Fiscale</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Nome Reparto</th>
            <th>Codice Ospedale</th>
            <th>Azioni</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['cf'] . "</td>";
                echo "<td>" . $row['nome'] . "</td>";
                echo "<td>" . $row['cognome'] . "</td>";
                echo "<td>" . $row['nomereparto'] . "</td>";
                echo "<td>" . $row['codospedale'] . "</td>";

                echo "<td><form action='modifica_infermiere.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='cf' value='". $row['cf'] ."'>";
                echo "<button type='submit'>Modifica</button>";
                echo "</form>";
                echo "<form action='elimina_infermiere.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='cf' value='". $row['cf'] ."'>";
                echo "<input type='hidden' name='azione' value='elimina'". $row['cf'] ."'>";  // Gestione eliminazione
                echo "<button type='submit'>Elimina</button>";
                echo "</form></td>";
                echo "</tr>";
            }
        ?>
    </table>
</body>
</html>