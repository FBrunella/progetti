<?php
include_once "../header.php";
include_once "../database.php";

$infermiere = [
    'cf' => '',
    'nome' => '',
    'cognome' => '',
    'nomereparto' => '',
    'codospedale' => ''
];
$resultReparti = pg_query($conn, "SELECT * FROM Reparto");
if (isset($_POST['cf']) && !isset($_POST['azione'])) {
    $cf = $_POST['cf'];

    $query2 = "SELECT * FROM Infermiere WHERE cf = $1";
    $result2 = pg_query_params($conn, $query2, array($cf));

    if ($result2 && pg_num_rows($result2) > 0) {
        $infermiere = pg_fetch_assoc($result2);
    } else {
        echo "Infermiere non trovato!<br>";
    }
}

if (isset($_POST['azione']) && $_POST['azione'] == 'aggiorna') {
    $cf = $_POST['cf'];
    $nome = $_POST['nome'];
    $cognome = $_POST['cognome'];
    if (isset($_POST['reparto'])) {
        list($nomereparto, $codospedale) = explode('-', $_POST['reparto']);      
    }

    $query = "UPDATE Infermiere SET nome = $1, cognome = $2, nomereparto = $3, codospedale = $4 WHERE cf = $5";
    $result = pg_query_params($conn, $query, array($nome, $cognome, $nomereparto, $codospedale, $cf));

    if ($result) {
        echo "Infermiere aggiornato con successo!<br>";

        $infermiere['cf'] = $cf;
        $infermiere['nome'] = $nome;
        $infermiere['cognome'] = $cognome;
        $infermiere['nomereparto'] = $nomereparto;
        $infermiere['codospedale'] = $codospedale;
    } else {
        echo "Errore nell'aggiornamento dell'infermiere: " . pg_last_error($conn);
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica infermieri</title>
</head>

<body>
    <h2>Aggiorna infermiere</h2>
    <form action="modifica_infermiere.php" method="POST">
    <label for="cf">Codice Fiscale:</label>
    <input type="text" name="cf" value="<?php echo htmlspecialchars($infermiere['cf']); ?>" required>
    <br>
    <label for="nome">Nome:</label>
    <input type="text" name="nome" id="nome" value="<?php echo htmlspecialchars($infermiere['nome']); ?>" required>
    <label for="cognome">Cognome:</label>
    <input type="text" name="cognome" id="cognome" value="<?php echo htmlspecialchars($infermiere['cognome']); ?>" required>
    <br>
    <label for="nomereparto">Reparto</label>
    <select name="reparto" id="nomereparto">
    <?php 
    while ($row = pg_fetch_array($resultReparti)) {
        if($row['nome'] === $infermiere['nomereparto'] && $row['codospedale'] === $infermiere['codospedale']) {
            echo "<option value='" . $row['nome'] . "-" . $row['codospedale'] . "' selected>". $row['nome'] . " - Ospedale: " . $row['codospedale'] . "</option>";    
        } else {
            echo "<option value='" . $row['nome'] . "-" . $row['codospedale'] . "'>". $row['nome'] . " - Ospedale: " . $row['codospedale'] . "</option>";
        }
    }
    ?>
    </select>
    <br>
    <input type="hidden" name="azione" value="aggiorna">
    <br>
    <button type="submit">Aggiorna infermiere</button>
</form>

</body>
</html>