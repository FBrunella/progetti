<?php
    include_once 'settings.php';
    global $host, $db, $port, $user, $pass;
    $conn = pg_connect("host=$host dbname=$db port=$port user=$user password=$pass");
    if (!$conn) {
        echo "Errore di connessione al database";
        exit;
    }
?>