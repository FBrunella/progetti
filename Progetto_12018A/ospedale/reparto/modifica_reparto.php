<?php

    include_once "../header.php";
    include_once "../database.php";

    if (isset($_POST['azione']) && $_POST['azione'] == 'aggiorna') {
        $nome = $_POST['nome'];
        $codospedale = $_POST['codospedale'];
        $telefono = $_POST['telefono'];

        $query = "UPDATE Reparto SET codospedale = $1, telefono = $2 WHERE nome = $3";
        $result = pg_query_params($conn, $query, array($codospedale, $telefono, $nome));

        if($result){
            $reparto['nome'] = $nome;
            $reparto['telefono'] = $telefono;
            $reparto['codospedale'] = $codospedale;
            echo "Reparto aggiornato con successo!<br>";
        } else {
            echo "Errore nell'aggiornamento del reparto: " . pg_last_error($conn);
        }

    }else if(isset($_POST['nome']) ){
        $nome = isset($_POST['nome'])?$_POST['nome']:'';
        $codospedale = isset($_POST['codospedale'])?$_POST['codospedale']:'';
        $telefono = isset($_POST['telefono'])?$_POST['telefono']:'';

        $query2 = "SELECT * FROM Reparto WHERE nome = $1";
        $result2 = pg_query_params($conn, $query2, array($nome));
        $reparto = pg_fetch_assoc($result2);
        
    }

?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica reparto</title>
</head>
<body>
    <h2>Aggiorna Reparto</h2>
    <form action="modifica_reparto.php" method="POST">
        <label for="nome">Nome:</label>
        <input type="text" name="nome" value="<?php echo htmlspecialchars($reparto["nome"]) ?>">
        <label for="codospedale">Codice Ospedale:</label>
        <input type="text" name="codospedale" id="codospedale" value="<?php echo htmlspecialchars($reparto["codospedale"]) ?>">
        <label for="telefono">Telefono:</label>
        <input type="text" name="telefono" id="telefono" value="<?php echo htmlspecialchars($reparto["telefono"]) ?>">
        <input type="hidden" name="azione" value="aggiorna">
        <button type="submit">Aggiorna reparto</button>
    </form>
    <from action="/ospedale/reparto/reparto.php">
        <br>
        <button type="submit">Torna alla Home</button>
    </from>
</body>