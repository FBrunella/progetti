<?php

    include_once "../header.php";
    include_once "../database.php";

    if(isset($_POST['ntessanitaria'])) {
        $ntessanitaria = $_POST['ntessanitaria'];

        $query = "SELECT p.codprescrizione , p.dataprenotazione,p.datetimees AS dataesame , e.descrizione AS esame, urgenza , (COALESCE(CAST (p.codlabint AS varchar), concat('laboratorio: ', CAST(le.codice AS varchar),' indirizzo: ', le.indirizzo))) AS laboratorio  
        FROM prenotazione p 
        INNER JOIN esame e ON p.codiceesame = e.codes
        LEFT JOIN laboratorioesterno le ON p.codlabest = le.codice 
        LEFT JOIN laboratoriointerno li ON p.codlabint = li.codice
        WHERE ntessanitariapaziente = $1";

        $result = pg_query_params($conn, $query, array($ntessanitaria));

        $queryPrescrizioni = "SELECT * FROM prescrizione p WHERE ntessanitariapaziente = $1";
        $resultPrescrizioni = pg_query_params($conn, $queryPrescrizioni, array($ntessanitaria));

        $queryEsame = "SELECT * FROM esame";
        $resultEsame = pg_query($conn, $queryEsame);

        $queryLaboratorio = "SELECT * FROM laboratorioesterno";
        $resultLaboratorio = pg_query($conn, $queryLaboratorio);

        $queryLaboratorioInterno = "SELECT * FROM laboratoriointerno";
        $resultLaboratorioInterno = pg_query($conn, $queryLaboratorioInterno);


        if (!$result) {
            echo "Errore nella query: " . pg_last_error($conn);
            exit;
        }

    } else {
        echo "Errore: manca il numero tessera sanitaria del paziente";
        exit;
    }

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Prenotazioni</title>
    <script type="text/javascript">
        // Funzione per gestire l'abilitazione dei laboratori
        function toggleLabs() {
            var laboratorioEsterno = document.getElementById("laboratorio_esterno");
            var laboratorioInterno = document.getElementById("laboratorio_interno");
            var codlabint = document.getElementById("codlabint");
            var codlabest = document.getElementById("codlabest");

            // Se il laboratorio esterno è selezionato, abilitiamo la selezione del laboratorio esterno e disabilitiamo l'interno
            if (laboratorioEsterno.checked) {
                codlabest.disabled = false;
                codlabint.disabled = true;
                codlabint.selectedIndex = -1; // Deseleziona l'elemento nel laboratorio interno
            } else {
                codlabest.disabled = true;
            }

            // Se il laboratorio interno è selezionato, abilitiamo la selezione del laboratorio interno e disabilitiamo l'esterno
            if (laboratorioInterno.checked) {
                codlabint.disabled = false;
                codlabest.disabled = true;
                codlabest.selectedIndex = -1; // Deseleziona l'elemento nel laboratorio esterno
            } else {
                codlabint.disabled = true;
            }

            checkForm(); // Ricalcola se il pulsante di invio deve essere abilitato
        }

        // Funzione per controllare se il form è valido (tutti i campi sono valorizzati)
        function checkForm() {
            var codprescrizione = document.getElementById("codprescrizione").value;
            var codiceesame = document.getElementById("codiceesame").value;
            var dataesame = document.getElementById("dataesame").value;
            var urgenza = document.getElementById("urgenza").value;
            var codlabint = document.getElementById("codlabint").value;
            var codlabest = document.getElementById("codlabest").value;
            var submitButton = document.getElementById("submit_button");

            // Il pulsante sarà abilitato solo se tutti i campi sono valorizzati
            if (codprescrizione && codiceesame && dataesame && urgenza && (codlabint || codlabest)) {
                submitButton.disabled = false;  // Abilita il pulsante
            } else {
                submitButton.disabled = true;   // Disabilita il pulsante
            }
        }

        // Funzione per inizializzare lo stato dei laboratori
        function initializeLabSelection() {
            var codlabint = document.getElementById("codlabint").value;
            var codlabest = document.getElementById("codlabest").value;

            // Se uno dei laboratori è già selezionato, disabilitare l'altro
           
            document.getElementById("laboratorio_interno").checked = false;
            document.getElementById("codlabest").disabled = true;           
            document.getElementById("laboratorio_esterno").checked = false;
            document.getElementById("codlabint").disabled = true;
            codlabint.selectedIndex = -1;
            codlabest.selectedIndex = -1; 
        }
    </script>
</head>
<body onload="initializeLabSelection()">
    <h1>Prenotazioni</h1>
    <h2>Prenotazioni del paziente <?php echo $ntessanitaria ?></h2>
    <h3>Inserisci prenotazione</h3>
    <form action="inserisci_prenotazione.php" method="post">
        <label for="codprescrizione">Codice Prescrizione</label>
        <select name="codprescrizione" id="codprescrizione" onchange="checkForm()" oninput="checkForm()">
        <?php 
        while ($row = pg_fetch_array($resultPrescrizioni)) {
            echo "<option value='" . $row['codice'] . "'>" . "codice: " . $row['codice'] . " data: " . $row['data'] . "</option>";
        }
        ?>
        </select>
        <br>
        
        <label for="codiceesame">Esame</label>
        <select name="codiceesame" id="codiceesame" onchange="checkForm()" oninput="checkForm()">
        <?php 
        while ($row = pg_fetch_array($resultEsame)) {
            echo "<option value='" . $row['codes'] . "'>" . $row['descrizione'] . "</option>";
        }
        ?>
        </select>   
        <br>
        
        <label for="dataesame">Data Esame</label>
        <input type="date" name="dataesame" id="dataesame" onchange="checkForm()" oninput="checkForm()">
        <br>
        
        <label for="urgenza">Urgenza:</label>
        <select id="urgenza" name="urgenza" onchange="checkForm()" oninput="checkForm()">
            <option value="bianco">Bianco</option>
            <option value="verde">Verde</option>
            <option value="giallo">Giallo</option>
            <option value="rosso">Rosso</option>
            <option value="nero">Nero</option>
        </select>
        <br>

        <!-- Radio buttons per selezionare il laboratorio -->
        <label for="laboratorio_esterno">Laboratorio Esterno</label>
        <input type="radio" id="laboratorio_esterno" name="laboratorio" onclick="toggleLabs()">
        
        <label for="laboratorio_interno">Laboratorio Interno</label>
        <input type="radio" id="laboratorio_interno" name="laboratorio" onclick="toggleLabs()">
        
        <br>
        
        <label for="codlabint">Codice Laboratorio Interno</label>
        <select name="codlabint" id="codlabint" onchange="checkForm()" oninput="checkForm()">
        <?php 
        while ($row = pg_fetch_array($resultLaboratorioInterno)) {
            echo "<option value='" . $row['codice'] . "'>" . "Numero Stanza: " . $row['numerostanza'] . " Nome reparto: " . $row['nomereparto'] . "</option>";
        }
        ?>
        </select>   
        <br>
        
        <label for="codlabest">Codice Laboratorio Esterno</label>
        <select name="codlabest" id="codlabest" onchange="checkForm()" oninput="checkForm()">
        <?php 
        while ($row = pg_fetch_array($resultLaboratorio)) {
            echo "<option value='" . $row['codice'] . "'>" . $row['indirizzo'] . "</option>";
        }
        ?>
        </select>   
        <br>

        <input type="hidden" name="ntessanitaria" value="<?php echo $ntessanitaria ?>">

        <!-- Il pulsante submit è inizialmente disabilitato -->
        <input type="submit" id="submit_button" value="Inserisci" disabled>
    </form>

    <h2>Lista prenotazioni</h2>
    <table>
        <tr>
            <th>Data Prenotazione</th>
            <th>Codice Prescrizione</th>
            <th>Esame</th>
            <th>Data Esame</th>
            <th>Urgenza</th>
            <th>Laboratorio</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['dataprenotazione'] . "</td>";
                echo "<td>" . $row['codprescrizione'] . "</td>";
                echo "<td>" . $row['esame'] . "</td>";
                echo "<td>" . $row['dataesame'] . "</td>";
                echo "<td>" . $row['urgenza'] . "</td>";
                echo "<td>" . $row['laboratorio'] . "</td>";
                echo "</tr>";
            }
        ?>
    </table>
</body>
</html>
