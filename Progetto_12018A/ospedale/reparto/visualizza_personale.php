<?php
    include_once "../header.php";
    include_once "../database.php";

    if(isset($_POST['nome'])) {
        $nome = $_POST['nome'];
        $query = "SELECT CF,'Infermiere' AS TipoPersonale FROM Infermiere WHERE nomeReparto = $1
        UNION ALL SELECT CF,'Personale Amministrativo' AS TipoPersonale FROM PersonaleAmministrativo WHERE nomeReparto = $1
        UNION ALL SELECT CF, 'Medico' AS TipoPersonale FROM Medico WHERE nomeReparto = $1";

        $result = pg_query_params($conn, $query, array($nome));
        
        if (!$result) {
            echo "Errore nella query: " . pg_last_error($conn);
            exit;
        }
    } else {
        echo "Errore: manca il nome del reparto";
        exit;
    }

?>


<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Visualizza Personale</title>
</head>
<body>
    <h2>Personale del reparto <?php echo $nome ?></h2>
    <table>
        <tr>
            <th>CF</th>
            <th>Tipo Personale</th>
        </tr>
        <?php
            while ($row = pg_fetch_array($result)) {
                echo "<tr>";
                echo "<td>" . $row['cf'] . "</td>";
                echo "<td>" . $row['tipopersonale'] . "</td>";
                echo "</tr>";
            }
        ?>
    </table>
    <form action="/ospedale/reparto/reparto.php">
        <br>
        <button type="submit">Torna alla Home</button>
    </form>


