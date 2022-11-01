<?php

$a = session_id();
if (empty($a)) session_start();
$a = session_id();

?>

<?php

$srv = "sqlserver";
$opc = array("Database" => "wordle_db", "UID" => "sa", "PWD" => "12345Ab##");
$con = sqlsrv_connect($srv, $opc) or die(print_r(sqlsrv_errors(), true));

$sql = "select
substring(palabraIntento,1,1) as pal1,
substring(palabraIntento,2,1) as pal2,
substring(palabraIntento,3,1) as pal3,
substring(palabraIntento,4,1) as pal4,
substring(palabraIntento,5,1) as pal5,
substring(resultado,1,1) as res1,
substring(resultado,2,1) as res2,
substring(resultado,3,1) as res3,
substring(resultado,4,1) as res4,
substring(resultado,5,1) as res5,dbo.palabraDelDia() as palabradehoy from intentos i
inner join jugadores j on j.idjugador=i.idjugador
inner join palabras p on i.fecha=p.fecha
where j.nick = '" . $a . "' and i.fecha = cast(getdate() as date)";

$res = sqlsrv_query($con, $sql);

?>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Wordle</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.0-beta1/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="style.css">

</head>

<body>

    <a href='listadopalabras.php'>(Admin) Lista de palabras</a>
    <br>
    <a href='jugador_Estadisticas.php'>(Admin) Estadisticas de jugadores</a>

    <div class="wordle ">
        <h1>Wordle</h1>
        <?php

        $contador = 1;
        $palabradehoy = "";
        while ($row = sqlsrv_fetch_array($res)) {
            $palabradehoy = $row['palabradehoy'];
        ?>
            <div class="linea">
                <div class="cuadrado <?php echo $row['res1']; ?>"> <?php echo $row['pal1']; ?></div>
                <div class="cuadrado <?php echo $row['res2']; ?>"> <?php echo $row['pal2']; ?></div>
                <div class="cuadrado <?php echo $row['res3']; ?>"> <?php echo $row['pal3']; ?></div>
                <div class="cuadrado <?php echo $row['res4']; ?>"> <?php echo $row['pal4']; ?></div>
                <div class="cuadrado <?php echo $row['res5']; ?>"> <?php echo $row['pal5']; ?></div>
            </div>
        <?php
            $contador++;
        }
        sqlsrv_close($con);
        $palabrasIntentos = $contador;
        while ($contador <= 6) {
        ?>
            <div class="linea">
                <div class="cuadrado"></div>
                <div class="cuadrado"></div>
                <div class="cuadrado"></div>
                <div class="cuadrado"></div>
                <div class="cuadrado"></div>
            </div>
        <?php
            $contador++;
        }
        ?>

        <?php
        if ($palabrasIntentos > 6)
            echo "La palabra de hoy era '", $palabradehoy, "'";
        ?>
        <form method="post" action="./guardarintento.php">
            <div class="form-group">
                <input type="text" name="palabra" id="palabra" class="form-control" maxlength="5" autofocus <?php
                                                                                                            if ($palabrasIntentos > 6)
                                                                                                                echo "disabled"
                                                                                                            ?>>
            </div>
            <button type="submit" class="btn btn-primary" style="display:none;">enviar</button>
        </form>

    </div>

</body>

</html>