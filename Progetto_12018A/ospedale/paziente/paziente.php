<?php
    include "../header.php";
    include_once "../database.php";

    $query = "SELECT * FROM Paziente";
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
    <title>Pazienti</title>
    <script>
    // Funzione per abilitare/disabilitare il pulsante di submit
    function toggleSubmitButton() {
        const ntessanitaria = document.getElementById('ntessanitaria').value.trim();
        const nome = document.getElementById('nome').value.trim();
        const cognome = document.getElementById('cognome').value.trim();
        const datanascita = document.getElementById('datanascita').value.trim();
        const indirizzo = document.getElementById('indirizzo').value.trim();
        const submitButton = document.getElementById('submitButton');

        // Abilita il pulsante solo se tutti i campi sono valorizzati
        if (ntessanitaria && nome && cognome && datanascita && indirizzo) {
            submitButton.disabled = false;
        } else {
            submitButton.disabled = true;
        }
    }

    // Aggiungi gli event listener ai campi del modulo
    document.addEventListener('DOMContentLoaded', () => {
        const inputs = document.querySelectorAll('#ntessanitaria, #nome, #cognome, #datanascita, #indirizzo');
        inputs.forEach(input => {
            input.addEventListener('input', toggleSubmitButton);
        });

        // Inizializza lo stato del pulsante al caricamento della pagina
        toggleSubmitButton();
    });
</script>
</head>
<body>
    <h1>Pazienti</h1>
    <h2>Aggiungi pazienti</h2>
    <form action="aggiungi_paziente.php" method="post">
        <label for="ntessanitaria">Numero Tessera Sanitaria</label>
        <input type="text" name="ntessanitaria" id="ntessanitaria">
        <br>
        <label for="nome">Nome</label>
        <input type="text" name="nome" id="nome">
        <?php
        echo "&nbsp";
        ?>
        <label for="cognome">Cognome</label>
        <input type="text" name="cognome" id="cognome">
        <br>
        <label for="datanascita">Data di nascita</label>
        <input type="date" name="datanascita" id="datanascita">
        <br>
        <label for="indirizzo">Indirizzo</label>
        <input type="text" name="indirizzo" id="indirizzo">
        
        <input type="submit" id="submitButton" value="Aggiungi" disabled>
    </form>
    <h3>Lista pazienti</h3>
    <table>
        <tr>
            <th>Numero Tessera Sanitaria</th>
            <th>Nome</th>
            <th>Cognome</th>
            <th>Data di nascita</th>
            <th>Indirizzo</th>
            <th>Azioni</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['ntessanitaria'] . "</td>";
                echo "<td>" . $row['nome'] . "</td>";
                echo "<td>" . $row['cognome'] . "</td>";
                echo "<td>" . $row['datanascita'] . "</td>";
                echo "<td>" . $row['indirizzo'] . "</td>";

                echo "<td><form action='modifica_paziente.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='ntessanitaria' value='". $row['ntessanitaria'] ."'>";
                echo "<button type='submit'>Modifica</button>";
                echo "</form>";
                echo "<form action='elimina_paziente.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='ntessanitaria' value='". $row['ntessanitaria'] ."'>";
                echo "<button type='submit'>Elimina</button>";
                echo "</form>";
                echo "&nbsp";   
                echo "&nbsp";
                echo "<form action='ricoveri.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='ntessanitaria' value='". $row['ntessanitaria'] ."'>";
                echo "<button type='submit'>Ricoveri</button>";
                echo "</form>";
                echo "&nbsp";   
                echo "&nbsp";
                echo "<form action='prenotazioni.php' method='POST' style='display:inline-block;'> ";
                echo "<input type='hidden' name='ntessanitaria' value='". $row['ntessanitaria'] ."'>";
                echo "<button type='submit'>Prenotazioni</button>";
                echo "</form>";
                echo "</tr>";
                
            }
            
        ?>
    </table>

    
</body>
</html>