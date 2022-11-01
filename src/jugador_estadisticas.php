<?php

$srv = "sqlserver";
$opc = array("Database" => "wordle_db", "UID" => "sa", "PWD" => "12345Ab##");
$con = sqlsrv_connect($srv, $opc) or die(print_r(sqlsrv_errors(), true));

$sql = "select nick, numPartidas, mediaIntentos, aciertos from jugadores";
$res = sqlsrv_query($con, $sql);

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <title>Estadisticas</title>
    <link rel="stylesheet" href="style.css">

</head>

<body>

    <a href='index.php'>
        <h3>Volver</h3>
    </a>

    <div class="listado">

        <table>

            <tr>
                <th>NICK</th>
                <th>TOTAL PARTIDAS</th>
                <th>MEDIA INTENTOS</th>
                <th>TOTAL ACIERTOS</th>
            </tr>

            <?php
            if (!$res) { ?>
                <tr>
                    <td colspan="6">No hay datos para mostrar</td>
                </tr>
                <?php
            } else {
                while ($row = sqlsrv_fetch_array($res)) { ?>
                    <tr>
                        <td><?php echo $row['nick']; ?></td>
                        <td><?php echo $row['numPartidas']; ?></td>
                        <td><?php echo $row['mediaIntentos']; ?></td>
                        <td><?php echo $row['aciertos']; ?></td>
                    </tr>
            <?php
                }
            }
            sqlsrv_close($con);
            ?>

        </table>

    </div>

</body>

</html>