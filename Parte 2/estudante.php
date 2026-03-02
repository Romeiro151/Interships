<?php
    session_start();
?>
<html>
    <head>
        <title>Portal Estudante</title>
    </head>
    <body>
        <br/>
        <h1><b><center>Portal Estudante</center></b></h1>
        <br/>
        <br/>
        <h2>Empresas Disponiveis</h2><br/>
        <table border="1" cellpadding="7" cellspacing="0" align="left">
        <?php
            require("BDEstagios.php");
            $ramo_ativ = null;
            $localidade = null;
            if (isset($_GET["ramo_ativ"])) {
                $ramo_ativ = $_GET["ramo_ativ"];
            }
            if (isset($_GET["localidade"])) {
                $localidade = $_GET["localidade"];
            }
            $Emp = new Empresas();
            $tabela = $Emp->listarEmpresas($ramo_ativ, $localidade);
            echo "<tr bgcolor='#218FC1'><th>Empresa</th><th>Tipo de Organização</th><th>Localidade</th><th>Telefone</th><th>Website</th></tr>";
            for($i = 0; $i < mysqli_num_rows($tabela); $i++) {
                $registo = mysqli_fetch_row($tabela);
                echo "<tr>";
                echo "<td>{$registo[0]}</td>";
                echo "<td>{$registo[1]}</td>";
                echo "<td>{$registo[2]}</td>";
                echo "<td>{$registo[3]}</td>";
                echo "<td>{$registo[4]}</td>";
                echo "</tr>";
            }
            echo "<table align='left' border='0'>
                        <tr><td width='10'></td></tr>
                    </table>";
            echo "<form action='consulta_estagios.php' method='post'>
                    <table border='0' cellpadding='7' cellspacing='0' align='left'>
                    <tr>
                        <th>&nbsp;</th>
                    </tr>";
            mysqli_data_seek($tabela, 0);
            for($i = 0; $i < mysqli_num_rows($tabela); $i++) {
                $registo = mysqli_fetch_row($tabela);
                echo "<tr>
                        <td>
                            <button type='submit' name='firma' value='{$registo[0]}'>Consultar Estágios</button>
                        </td>
                    </tr>";
            }
            echo "</table>
                </form>";
        ?>
        </table>
        <table align='left' border='0'>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
            <tr><td width='40'>&nbsp;</td></tr>
        </table>
        <b><font size="4">Filtro:</font></b><br/>
        <form action="" method="get" name="empresas">
            <p><b>Ramo de Atividade</b></p>
            <input type="checkbox" name="ramo_ativ[]" value="Programação informática"> Programação informática
            <input type="checkbox" name="ramo_ativ[]" value="Comércio"> Comércio
            <input type="checkbox" name="ramo_ativ[]" value="Contabilidade"> Contabilidade <br/>
            <input type="checkbox" name="ramo_ativ[]" value="Clínicas"> Clínicas
            <input type="checkbox" name="ramo_ativ[]" value="Construção Civil"> Construção Civil
            <input type="checkbox" name="ramo_ativ[]" value="Direito"> Direito
            <input type="checkbox" name="ramo_ativ[]" value="Publicidade"> Publicidade<br/><br/>
            <p><b>Localidade</b></p>
            <input type="checkbox" name="localidade[]" value="Lisboa"> Lisboa
            <input type="checkbox" name="localidade[]" value="Porto"> Porto
            <input type="checkbox" name="localidade[]" value="Coimbra"> Coimbra
            <input type="checkbox" name="localidade[]" value="Faro"> Faro
            <input type="checkbox" name="localidade[]" value="Braga"> Braga
            <input type="checkbox" name="localidade[]" value="Évora"> Évora
            <input type="checkbox" name="localidade[]" value="Aveiro"> Aveiro<br/><br/>
            <input type="submit" value="Filtrar">
        </form>
    </body>
</html>