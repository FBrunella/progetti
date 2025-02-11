<?php
include "../header.php";
include_once "../database.php";

if ($_SERVER["REQUEST_METHOD"] === "POST" && isset($_POST["cf"])) {
    $cf = $_POST["cf"];

    $query = "SELECT * FROM Medico WHERE cf = $1";
    $result = pg_query_params($conn, $query, array($cf));

    if (!$result) {
        echo "Errore nella query: " . pg_last_error($conn);
        exit;
    }

    $medico = pg_fetch_assoc($result);
    if (!$medico) {
        echo "Medico non trovato.";
        exit;
    }

    if (isset($_POST["update"])) {
        $datadiassunzione = $_POST["datadiassunzione"];
        $primario = isset($_POST["primario"]) ? 'true' : 'false';
        $vice = isset($_POST["vice"]) ? 'true' : 'false';
        if (isset($_POST['reparto'])) {
            list($nomereparto, $codospedale) = explode('-', $_POST['reparto']);      
        }
        
        $datapromozionevice = isset($_POST["datapromozionevice"]) && $_POST["datapromozionevice"] !== '' ? $_POST["datapromozionevice"] : null;

        $updateQuery = "UPDATE Medico 
                        SET datadiassunzione = $1, 
                            primario = $2, 
                            vice = $3, 
                            nomereparto = $4, 
                            codospedale = $5, 
                            datapromozionevice = $6 
                        WHERE cf = $7";
        $params = array(
            $datadiassunzione,
            $primario,
            $vice,
            $nomereparto,
            $codospedale,
            $datapromozionevice,
            $cf
        );
        $updateResult = pg_query_params($conn, $updateQuery, $params);

        if ($updateResult) {
            echo "Medico aggiornato con successo.";
            header("Location: medico.php"); 
            exit;
        } else {
            echo "Errore nell'aggiornamento del medico: " . pg_last_error($conn);
        }
    }
    $resultReparti = pg_query($conn, "SELECT * FROM Reparto");
} else {
    echo "Nessun CF specificato.";
    exit;
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Modifica Medico</title>
    <script>
        function togglePromotionDate() {
            const primario = document.getElementById("primario").checked;
            const promotionDateField = document.getElementById("datapromozionevice");
            promotionDateField.style.display = primario ? "block" : "none";
        }

        function toggleCheckboxes() {
            const primario = document.getElementById("primario");
            const vice = document.getElementById("vice");

            // Selezionare "Primario" disabilita "Vice Primario" e viceversa
            primario.disabled = vice.checked;
            vice.disabled = primario.checked;
        }

        // Aggiungere gli event listener per aggiornare i checkbox al cambio stato
        document.addEventListener('DOMContentLoaded', () => {
            document.getElementById("primario").addEventListener("change", toggleCheckboxes);
            document.getElementById("vice").addEventListener("change", toggleCheckboxes);
            toggleCheckboxes(); 
        });
    </script>
</head>
<body>
    <h1>Modifica Medico - <?php echo $cf;?> </h1>
    <form action="modifica_medico.php" method="post">
        <input type="hidden" name="cf" value="<?php echo htmlspecialchars($medico['cf']); ?>">

        <label for="datadiassunzione">Data Assunzione:</label>
        <input type="date" name="datadiassunzione" id="datadiassunzione" value="<?php echo htmlspecialchars($medico['datadiassunzione']); ?>">
        <br>

        <label for="primario">Primario:</label>
        <input type="checkbox" name="primario" id="primario" onclick="togglePromotionDate()" <?php echo $medico['primario'] === 't' ? 'checked' : ''; ?>>
        <br>

        <label for="vice">Vice Primario:</label>
        <input type="checkbox" name="vice" id="vice">
        <br>

        <div id="datapromozionevice" style="display: <?php echo $medico['primario'] === 't' ? 'block' : 'none'; ?>;">
            <label for="datapromozionevice">Data di Promozione:</label>
            <input type="date" name="datapromozionevice" id="datapromozionevice" value="<?php echo htmlspecialchars($medico['datapromozionevice']); ?>">
        </div>
        <br>        

        <label for="nomereparto">Reparto</label>
        <select name="reparto" id="nomereparto">
        <?php 
        while ($row = pg_fetch_array($resultReparti)) {
            if($row['nome'] === $medico['nomereparto'] && $row['codospedale'] === $medico['codospedale']) {
                echo "<option value='" . $row['nome'] . "-" . $row['codospedale'] . "' selected>". $row['nome'] . " - Ospedale: " . $row['codospedale'] . "</option>";    
            } else {
                echo "<option value='" . $row['nome'] . "-" . $row['codospedale'] . "'>". $row['nome'] . " - Ospedale: " . $row['codospedale'] . "</option>";
            }
        }
        ?>
        </select>
        <br>
        <input type="submit" name="update" value="Aggiorna">
    </form>
    <form action="medico.php">
        <button type="submit">Torna alla Home</button>
    </form>
</body>
</html>
