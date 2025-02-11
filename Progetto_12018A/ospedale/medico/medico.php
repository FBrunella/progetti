<?php
    include "../header.php";
    include_once "../database.php";
    
    $query = "SELECT * FROM Medico";
    $result = pg_query($conn, $query);
    
    if (!$result) {
        echo "Errore nella query: " . pg_last_error($conn);
        exit;
    }

    $resultReparti = pg_query($conn, "SELECT * FROM Reparto");
    
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Medici</title>
    <script>
    // Funzione per mostrare/nascondere il campo "Data di Promozione"
    function togglePromotionDate() {
        const primario = document.getElementById("primario");
        const vice = document.getElementById("vice");
        document.getElementById("datapromozionevice").style.display = "none"; 
        if (primario.checked) {
            vice.disabled = true; // Disabilita "Vice Primario" se "Primario" è selezionato
            document.getElementById("datapromozionevice").style.display = "block"; 
            vice.checked = false;
        } else {
            vice.disabled = false;
        }

        if (vice.checked) {
            primario.disabled = true; // Disabilita "Primario" se "Vice Primario" è selezionato
        } else {
            primario.disabled = false;
        }
    }

    // Funzione per abilitare/disabilitare il pulsante di invio
    function toggleSubmitButton() {
        const codiceFisc = document.getElementById('cf').value.trim();
        const datadiassunzione = document.getElementById('datadiassunzione').value.trim();
        const reparto = document.getElementById('nomereparto').value.trim();
        const submitButton = document.getElementById('submitButton');

        // Abilita il pulsante solo se i campi obbligatori hanno un valore
        if (codiceFisc && datadiassunzione && reparto) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }

    // Aggiungere gli event listener ai campi per verificare il loro stato
    document.addEventListener('DOMContentLoaded', () => {
        const inputs = document.querySelectorAll('#cf, #datadiassunzione, #nomereparto');
        inputs.forEach(input => {
            input.addEventListener('input', toggleSubmitButton);
        });

        const checkboxes = document.querySelectorAll('#vice, #primario');
        checkboxes.forEach(checkbox => {
            checkbox.addEventListener('change', toggleSubmitButton);
        });

        // Impostazione iniziale del pulsante come disabilitato
        toggleSubmitButton();
    });
</script>

</head>
<body>
    <h1>Medici</h1>
    <h2>Aggiungi Medico</h2>
    <form action="aggiungi_medico.php" method="post">
        <label for="cf">Codice Fiscale</label>
        <input type="text" name="cf" id="cf">
        <br>
        <label for="datadiassunzione">Data Assunzione</label>
        <input type="date" name="datadiassunzione" id="datadiassunzione">
        <br>
        <label for="primario">Primario</label>
        <input type="checkbox" name="primario" id="primario" onclick="togglePromotionDate()">
        <?php
        echo "&nbsp";
        ?>
        <label for="vice">Vice Primario</label>
        <input type="checkbox" name="vice" id="vice">
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
        <input type="submit" id="submitButton" value="Aggiungi">
    </form>
    <br>
    <form action='sostituzioni.php' method='POST' style='display:inline-block;'>
        <button type='submit'>Visualizza Sostituzioni</button>
    </form>
    <h3>Lista Medici</h3>
    <table>
        <tr>
            <th>Codice Fiscale</th>
            <th>Data Assunzione</th>
            <th>Primario</th>
            <th>Vice Primario</th>
            <th>Nome Reparto</th>
            <th>Codice Ospedale</th>
            <th>Azioni</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['cf'] . "</td>";
                echo "<td>" . $row['datadiassunzione'] . "</td>";
                echo "<td>" . ($row['primario'] === 't' ? "Sì" : "No") . "</td>";
                echo "<td>" . ($row['vice'] === 't' ? "Sì" : "No") . "</td>";
                echo "<td>" . $row['nomereparto'] . "</td>";
                echo "<td>" . $row['codospedale'] . "</td>";

                echo "<td><form action='modifica_medico.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='cf' value='". $row['cf'] ."'>";
                echo "<button type='submit'>Modifica</button>";
                echo "</form>";
                echo "<form action='elimina_medico.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='cf' value='". $row['cf'] ."'>";
                echo "<input type='hidden' name='azione' value='elimina'". $row['cf'] ."'>";
                echo "<button type='submit'>Elimina</button>";
                echo "</form>";
                echo "&nbsp";
                echo "<form action='prescrizioni.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='cf' value='". $row['cf'] ."'>";
                echo "<button type='submit'>Prescrizioni</button>";
                echo "</form>";
                echo "</tr>";
            }
            
        ?>
    </table>
</body>
</html>
