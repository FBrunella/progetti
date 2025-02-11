<?php
    include_once "../header.php";
    include_once "../database.php";

    $resultReparti = pg_query($conn, "SELECT * FROM Reparto");
    
    // Se l'azione è "aggiorna", esegui l'aggiornamento del personale
    if(isset($_POST['azione']) && $_POST['azione'] == 'aggiorna'){
        $cf = $_POST['cf'];
        $nome = $_POST['nome'];
        $cognome = $_POST['cognome'];
        if (isset($_POST['reparto'])) {
            list($nomereparto, $codospedale) = explode('-', $_POST['reparto']);      
        }
        $query = "UPDATE PersonaleAmministrativo SET nome = $1, cognome = $2, nomereparto = $3, codospedale = $4 WHERE cf = $5";
        $result = pg_query_params($conn, $query, array($nome, $cognome, $nomereparto, $codospedale, $cf));

        if ($result) {
            echo "Infermiere aggiornato con successo!<br>";
    
            $personale_amministrativo['cf'] = $cf;
            $personale_amministrativo['nome'] = $nome;
            $personale_amministrativo['cognome'] = $cognome;
            $personale_amministrativo['nomereparto'] = $nomereparto;
            $personale_amministrativo['codospedale'] = $codospedale;
        } else {
            echo "Errore nell'aggiornamento del Personale amministrativo: ";
        }
    }
    
    // Recupera i dettagli del personale amministrativo per la modifica
    else if (isset($_POST['cf'])){
        $cf = $_POST['cf'];
        
        // Recupera i dati del personale amministrativo
        $query2 = "SELECT * FROM PersonaleAmministrativo WHERE cf = $1";
        $result2 = pg_query_params($conn, $query2, array($cf));
        $personale_amministrativo = pg_fetch_assoc($result2);
        
        // Se non si trova il personale, visualizza un errore
        if (!$personale_amministrativo) {
            echo "Personale amministrativo non trovato!";
            exit;
        }
    } else {
        // Se il cf non è stato passato tramite POST, mostra un errore
        echo "Codice fiscale mancante.";
        exit;
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Personale Amministrativo</title>
</head>
<body>
<h2>Aggiorna personale amministrativo</h2>
    <form action="modifica_personale.php" method="POST">
        <label for="cf">Codice Fiscale:</label>
        <input type="text" name="cf" value="<?php echo htmlspecialchars($personale_amministrativo['cf']); ?>">
        <br>
        <label for="nome">Nome:</label>
        <input type="text" name="nome" id="nome" value="<?php echo htmlspecialchars($personale_amministrativo['nome']); ?>">
        <br>
        <label for="cognome">Cognome:</label>
        <input type="text" name="cognome" id="cognome" value="<?php echo htmlspecialchars($personale_amministrativo['cognome']); ?>">
        <br>
        <label for="nomereparto">Reparto:</label>
        <select name="reparto" id="nomereparto">
        <?php 
        while ($row = pg_fetch_array($resultReparti)) {
            // Verifica se il reparto è lo stesso che stiamo cercando di aggiornare
            if($row['nome'] === $personale_amministrativo['nomereparto'] && $row['codospedale'] === $personale_amministrativo['codospedale']) {
                echo "<option value='" . $row['nome'] . "-" . $row['codospedale'] . "' selected>" . $row['nome'] . " - Ospedale: " . $row['codospedale'] . "</option>";    
            } else {
                echo "<option value='" . $row['nome'] . "-" . $row['codospedale'] . "'>" . $row['nome'] . " - Ospedale: " . $row['codospedale'] . "</option>";
            }
        }
        ?>
        </select>
        <br>
        <input type="hidden" name="azione" value="aggiorna">
        <button type="submit">Aggiorna personale amministrativo</button>
    </form>
    
    <form action="/ospedale/personale_amministrativo/personale_amministrativo.php">
        <button type="submit">Torna alla home</button>
    </form>
</body>
</html>
