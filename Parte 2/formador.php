<?php
    session_start();
    require 'BDEstagios.php';
    $BD = new BDEstagios();
    $BD->ligarBD();

    $id_formador_logado = $_SESSION['user_id']; 

    /*Processar mensagens de sucesso/erro*/
    $msg = "";
    if (isset($_GET['msg'])) {
        if ($_GET['msg'] == 'sucesso') $msg = "<center><font color='green'>Notas lançadas e média calculada com sucesso!</font></center>";
        if ($_GET['msg'] == 'erro_sql') $msg = "<center><font color='red'>Erro ao gravar na base de dados.</font></center>";
    }
?>
<!DOCTYPE html>
<html lang="pt">
<head>
    <meta charset="UTF-8">
    <title>Portal do Formador</title>
</head>
<body>

    <br/><h1><center>Portal do Formador</center></h1>
    <?php echo $msg; ?>

    <br/><h3><center>Os Meus Alunos de Estágio</center></h3>

    <table border="1" cellpadding="6" cellspacing="0" align="center">
        <thead>
            <tr bgcolor="#218FC1">
                <th>ID</th>
                <th>Aluno</th>
                <th>Estabelecimento</th>
                <th>Data Fim</th>
                <th>Lançamento de Notas (0-20)</th>
            </tr>
        </thead>
        <tbody>
            <?php
            
            /*Procurar apenas os estagios deste formador*/
            $sql = "
                SELECT e.*, u.nome AS nome_aluno, est.nome_comercial 
                FROM estagio e
                JOIN aluno a ON e.aluno_id = a.utilizador_id
                JOIN utilizador u ON a.utilizador_id = u.utilizador_id
                JOIN estabelecimento est ON e.estabelecimento_id = est.estabelecimento_id AND e.estabelecimento_empresa_id = est.empresa_id
                WHERE e.formador_id = '" . $id_formador_logado . "'
                ORDER BY e.aluno_id
            ";
            
            $res = $BD->executarSQL($sql);
            $hoje = date('Y-m-d');

            if ($res && mysqli_num_rows($res) > 0) {
                while ($row = mysqli_fetch_assoc($res)) {
                    $id = $row['aluno_id'];
                    $terminou = ($row['data_fim'] && $row['data_fim'] < $hoje);
                    
                    echo "<tr>";
                    echo "<td>#$id</td>";
                    echo "<td><strong>{$row['nome_aluno']}</strong></td>";
                    echo "<td>{$row['nome_comercial']}</td>";
                    
                    /*Coluna da Data*/
                    if ($terminou) {
                        echo "<td>Terminado em: <br>{$row['data_fim']}</td>"; /*<td class='badge-fim'>*/
                    } else {
                        echo "<td>Em curso<br><small>(Fim: {$row['data_fim']})</small></td>";
                    }

                    /*Coluna das Notas*/
                    echo "<td>";
                    if ($terminou) {
                        
                        /*Se já tiver notas, mostra os valores, senão mostra vazio*/
                        $n_emp = $row['nota_empresa'];
                        $n_esc = $row['nota_escola'];
                        $n_pro = $row['nota_procura'];
                        $n_rel = $row['nota_relatorio'];
                        $n_final = $row['nota_final'];

                        if ($n_final) {
                            echo "<strong>Nota Final: $n_final</strong>"; //<small>({$row['classificacao']})</small>";
                        } 
                        
                        /*Formulário para lançar ou atualizar*/
                        echo "<form action='acoes_formacoes.php' method='post'>
                                <input type='hidden' name='aluno_id' value='$id'>

                                <table border='0' cellpadding='5' cellspacing='0'>
                                    <tr>
                                        <td><label><small>Empresa:</small></label></td>
                                        <td><input type='number' name='n_emp' step='0.1' min='0' max='20' value='$n_emp' required placeholder='Emp'></td>
                                    </tr>
                                    <tr>
                                        <td><label><small>Escola:</small></label></td>
                                        <td><input type='number' name='n_esc' step='0.1' min='0' max='20' value='$n_esc' required placeholder='Esc'></td>
                                    </tr>
                                    <tr>
                                        <td><label><small>Procura:</small></label></td>
                                        <td><input type='number' name='n_pro' step='0.1' min='0' max='20' value='$n_pro' required placeholder='Proc'></td>
                                    </tr>
                                    <tr>
                                        <td><label><small>Relatório:</small></label></td>
                                        <td><input type='number' name='n_rel' step='0.1' min='0' max='20' value='$n_rel' required placeholder='Rel'></td>
                                    </tr>
                                    <tr>
                                        <td colspan='2' align='center'>
                                            <button type='submit' name='btn_lancar_notas'>Registar</button>
                                        </td>
                                    </tr>
                                </table>
                            </form>
                            ";
                    } else {
                        echo "<p><font size ='4'><center>Aguarde a finalização do estágio.</center></font></p>";
                    }
                    echo "</td>";
                    echo "</tr>";
                }
                $BD->fecharBD();
            } else {
                echo "<tr><td colspan='5' style='text-align:center'>Não tem alunos atribuídos ou erro na consulta.</td></tr>";
                $BD->fecharBD();
            }
            ?>
        </tbody>
    </table>

</body>
</html>