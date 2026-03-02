<?php
    session_start();
?>
<html>
    <head>
        <title>Consulta de Estágios</title>
    </head>
    <body>
        <br/><h1><center>Consulta Estágios</center></h1>
        <br/><br/>
        <?php
            require("BDEstagios.php");
            $firma = $_POST["firma"];
            $Est = new Estagios();
            
            /*Loop sobre os estabelecimantos*/
            for($i = 0; $i < $Est->totalEstabelecimentos($firma); $i++){
                /*Loops sobre as 4 tabelas com dados de: Estabelecimento, Responsável, Empresa, Transporte*/
                
                /*Verificação se existe estágios*/
                if($i == 0){
                    $rows = mysqli_num_rows($Est->listarEstabelecimento($firma, $i+1));
                    if($rows == 0){
                        echo "<p><font size ='4'><center>De momento não há estágios disponíveis nesta Empresa</center></font></p>";
                        break;
                    }
                }

                /*Tabela Estabelecimento*/
                echo "<h2>Estágio " . ($i + 1) . ":</h2><br/>
                        <table align='left' border='1' cellpadding='6' cellspacing='0'>
                        <caption><b><font size='4'>Estabelecimento:</font></b></caption>
                        <th bgcolor='#218FC1'>Nome</th><th bgcolor='#218FC1'>Morada</th><th bgcolor='#218FC1'>Localidade</th>";
                for($j = 0; $j < mysqli_num_rows($Est->listarEstabelecimento($firma, $i+1)); $j++){
                    $registo = mysqli_fetch_row($Est->listarEstabelecimento($firma, $i+1));
                    echo "<tr>";
                    for($a = 0; $a < count($registo); $a++){
                        echo "<td>" . $registo[$a] . "</td>";
                    }     
                    echo "</tr>";
                }
                echo "</table>";


                /*Tabela para espaçar as outras*/
                echo "<table align='left' border='0'>
                        <tr><td width='20'></td></tr>
                    </table>";


                /*Tabela Responsável*/
                echo "<table align='left' border='1' cellpadding='6' cellspacing='0'>
                        <caption><b><font size='4'>Responsável:</font></b></caption>
                        <th bgcolor='#218FC1'>Nome</th><th bgcolor='#218FC1'>Cargo</th><th bgcolor='#218FC1'>Telemóvel</th><th bgcolor='#218FC1'>Email</th>";
                for($k = 0; $k < mysqli_num_rows($Est->listarResponsavel($firma, $i + 1)); $k++){
                    $registo = mysqli_fetch_row($Est->listarResponsavel($firma, $i + 1));
                    echo "<tr>";
                    for($a = 0; $a < count($registo); $a++){
                        echo "<td>" . $registo[$a] . "</td>";
                    }     
                    echo "</tr>";
                }
                echo "</table>";


                /*Tabela para espaçar as outras*/
                echo "<table align='left' border='0'>
                        <tr><td width='20'></td></tr>
                    </table>";


                /*Tabela Empresa*/
                echo "<table align='left' border='1' cellpadding='6' cellspacing='0'>
                        <caption><b><font size='4'>Empresa:</font></b></caption>
                        <th bgcolor='#218FC1'>Nome</th><th bgcolor='#218FC1'>Ramo Atividade</th>
                        <th bgcolor='#218FC1'>Morada Sede</th><th bgcolor='#218FC1'>Localidade</th>
                        <th bgcolor='#218FC1'>Telefone</th>";
                for($l = 0; $l < mysqli_num_rows($Est->listarEmpresa($firma)); $l++){
                    $registo = mysqli_fetch_row($Est->listarEmpresa($firma));
                    echo "<tr>";
                    for($a = 0; $a < count($registo); $a++){
                        echo "<td>" . $registo[$a] . "</td>";
                    }     
                    echo "</tr>";
                }
                echo "</table>";


                /*Tabela para espaçar as outras*/
                echo "<table align='left' border='0'>
                        <tr><td width='20'></td></tr>
                    </table>";


                /*Tabela Transporte*/
                echo "<table align='left' border='1' cellpadding='6' cellspacing='0'>
                        <caption><b><font size='4'>Transportes:</font></b></caption>
                        <th bgcolor='#218FC1'>Meio de Transporte</th><th bgcolor='#218FC1'>Linha</th>";
                for($m = 0; $m < mysqli_num_rows($Est->listarTransporte($firma, $i + 1)); $m++){
                    $registo = mysqli_fetch_row($Est->listarTransporte($firma, $i + 1));
                    echo "<tr>";
                    for($a = 0; $a < count($registo); $a++){
                        echo "<td>" . $registo[$a] . "</td>";
                    }     
                    echo "</tr>";
                }
                echo "</table><br/><br/>";
            } 
        ?>
    </body>
</html>
