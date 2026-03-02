<?php
include 'BDEstagios.php';
$BD = new BDEstagios();
$BD->ligarBD();

$edit_data = null;
if (isset($_GET['edit_id'])) {
    $id = $_GET['edit_id'];
    // Procura os dados do estágio para preencher o formulário
    $res = $BD->executarSQL("SELECT * FROM estagio WHERE aluno_id = {$id[0]} AND estabelecimento_id = {$id[1]} AND estabelecimento_empresa_id = {$id[2]}");
    $edit_data = mysqli_fetch_assoc($res);
}

// Sistema de mensagens
$msg_texto = "";

if(isset($_GET['msg'])) {
    // Sucessos
    if($_GET['msg'] == "estagio_ok") $msg_texto = "Sucesso: Estágio criado!";
    if($_GET['msg'] == "aluno_ok") $msg_texto = "Sucesso: Aluno criado!";
    if($_GET['msg'] == "apagado_ok") $msg_texto = "Sucesso: Estágio eliminado.";
    if($_GET['msg'] == "editado_ok") $msg_texto = "Sucesso: Estágio atualizado.";
    
    // Erros
    if($_GET['msg'] == "erro_existe") { $msg_texto = "Erro: Esse login de Aluno já existe."; }
    if($_GET['msg'] == "erro_terminado") { $msg_texto = "Erro: Não pode apagar estágios já terminados."; }
    if($_GET['msg'] == "erro_dados") { $msg_texto = "Erro: Faltam dados (Estabelecimento)."; }
    
    
    if($_GET['msg'] == "erro_duplicado") { 
        $msg_texto = "ERRO: Este Aluno já tem um estágio registado nessa Empresa! Não pode criar duplicados."; 
        $msg_cor = "red"; 
    }
    
    if($_GET['msg'] == "erro_sql_insert") { $msg_texto = "Erro técnico ao inserir na Base de Dados."; $msg_cor = "red"; }
}
?>

<!DOCTYPE html>
<html>
<head>
    <title>Portal Admin</title>
</head>
<body>

    <br/><h1><center>Portal do Administrativo</center></h1>
    
    <?php 
        if($msg_texto){
            echo "<center>'" . $msg_texto . "'</center>";
        } 
    ?>

    <table border="0" cellpadding="10" cellspacing="10" align="center">
    <tr>
        <td valign="top">
            <table border="0" cellpadding="5" cellspacing="0">
                <tr>
                    <td><h2>Criar Novo Aluno</h2></td>
                </tr>
                <tr>
                    <td>
                        <form method="post" action="acoes_admin.php">
                            <?php
                                if ($edit_data) {
                                    $id = $_GET['edit_id'];
                                    echo '<input type="hidden" name="edit_id[]" value="' . $id[0] . '">';
                                    echo '<input type="hidden" name="edit_id[]" value="' . $id[1] . '">';
                                    echo '<input type="hidden" name="edit_id[]" value="' . $id[2] . '">';
                                }
                            ?>
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td><label>Nome Completo:</label></td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="novo_nome" required placeholder="Ex: João Silva"></td>
                                </tr>
                                <tr>
                                    <td><label>Login (Email/User):</label></td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="novo_user" required placeholder="Ex: joao.silva"></td>
                                </tr>
                                <tr>
                                    <td><label>Password:</label></td>
                                </tr>
                                <tr>
                                    <td><input type="text" name="novo_pass" required placeholder="******"></td>
                                </tr>
                                <tr>
                                    <td><label>Turma:</label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <select name="novo_turma_id" required>
                                            <option value="" disabled selected>Escolha a turma...</option>
                                            <option value="1">INF-A (Informática A)</option>
                                            <option value="2">INF-B (Informática B)</option>
                                            <option value="3">GEST-A (Gestão)</option>
                                            <option value="4">CONT-A (Contabilidade)</option>
                                            <option value="5">MKT-A (Marketing)</option>
                                            <option value="6">DIR-A (Direito)</option>
                                            <option value="7">SAU-A (Saúde)</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><input type="submit" name="btn_add_aluno" value="Criar Aluno"></td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
            </table>
        </td>

        <td valign="middle">
            <h2>Lista de Estágios</h2>
            <table border="1" cellpadding="6" cellspacing="0" align="center">
                <tr bgcolor='#218FC1'>
                    <th>Emp | Estab</th>
                    <th>Aluno</th>
                    <th>Formador</th>
                    <th>Início</th>
                    <th>Fim</th>
                    <th>Ações</th>
                </tr>
                <?php
                    $res = $BD->executarSQL("SELECT es.*, e.firma, est.nome_comercial, ua.nome AS 'a_nome', uf.nome AS 'f_nome' 
                    FROM estagio es, estabelecimento est, empresa e, utilizador ua, utilizador uf
                    WHERE e.empresa_id = es.estabelecimento_empresa_id AND ua.utilizador_id = es.aluno_id AND uf.utilizador_id = es.formador_id
                    AND est.empresa_id = e.empresa_id AND es.estabelecimento_id = est.estabelecimento_id ORDER BY aluno_id");
                    $hoje = date("Y-m-d");

                    if($res){
                        while ($row = mysqli_fetch_assoc($res)) {
                            $id = array($row['aluno_id'], $row['estabelecimento_id'], $row['estabelecimento_empresa_id']);
                            $fim = $row['data_fim'];
                            $terminado = ($fim != NULL && $fim != '0000-00-00' && $fim < $hoje);

                            echo "<tr>";
                            echo "<td>{$row['firma']} | {$row['nome_comercial']}</td>";
                            echo "<td>{$row['a_nome']}</td>";
                            echo "<td>{$row['f_nome']}</td>";
                            echo "<td>{$row['data_inicio']}</td>";

                            if($fim) {
                                echo "<td>$fim</td>";
                            } else {
                                echo "<td><span style='color:green; font-weight:bold;'>Em curso</span></td>";
                            }

                            echo "<td>";
                            if (!$terminado) {
                                echo '<a href="admin.php?' . http_build_query(['edit_id' => $id]) . '">Editar</a> | ';
                                echo "<a href='acoes_admin.php?" . http_build_query(['delete_id' => $id]) . "' onclick=\"return confirm('Tem a certeza que deseja apagar?');\" style='color:red;'>Apagar</a>";
                            } else {
                                echo "<span style='color:gray;'>Fechado</span>";
                            }
                            echo "</td></tr>";
                        }
                    }
                ?>
            </table>
        </td>
    </tr>

    <tr>
        <td valign="top">
            <table border="0" cellpadding="5" cellspacing="0">
                <tr>
                    <td><h2><?php echo $edit_data ? "Editar Estágio #".$edit_data['aluno_id'] : "Registar Novo Estágio"; ?></h2></td>
                </tr>
                <tr>
                    <td>
                        <form method="post" action="acoes_admin.php">
                            <?php
                                if ($edit_data) {
                                    $id = $_GET['edit_id'];
                                    echo '<input type="hidden" name="edit_id[]" value="' . $id[0] . '">';
                                    echo '<input type="hidden" name="edit_id[]" value="' . $id[1] . '">';
                                    echo '<input type="hidden" name="edit_id[]" value="' . $id[2] . '">';
                                }
                            ?>
                            <table border="0" cellpadding="2" cellspacing="0">
                                <tr>
                                    <td><label>Estabelecimento / Empresa:</label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <select name="combo_ids" required>
                                            <option value="">-- Selecione --</option>
                                            <?php
                                                $sql_estab = "SELECT est.estabelecimento_id, e.empresa_id, firma, nome_comercial FROM estabelecimento est, empresa e WHERE est.empresa_id = e.empresa_id"; 
                                                $res_estab = $BD->executarSQL($sql_estab);
                                                if($res_estab){
                                                    while($lin = mysqli_fetch_assoc($res_estab)){
                                                        $id1 = $lin['estabelecimento_id'];
                                                        $id2 = $lin['empresa_id'];
                                                        $val = "$id1|$id2";
                                                        $sel = ($edit_data && $edit_data['estabelecimento_id']==$id1 && $edit_data['estabelecimento_empresa_id']==$id2) ? "selected" : "";
                                                        echo "<option value='$val' $sel>Emp: {$lin['firma']} | Estab: {$lin['nome_comercial']}</option>";
                                                    }
                                                }
                                            ?>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Aluno:</label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <select name="aluno" required>
                                            <option value="">-- Selecione o Aluno --</option>
                                            <?php
                                                $sql_aluno = "SELECT a.utilizador_id, u.nome FROM aluno a, utilizador u WHERE u.utilizador_id = a.utilizador_id"; 
                                                $res_aluno = $BD->executarSQL($sql_aluno);

                                                if($res_aluno){
                                                    while($al = mysqli_fetch_assoc($res_aluno)){
                                                        $id_aluno = $al['utilizador_id']; 
                                                        $sel = ($edit_data && $edit_data['aluno_id'] == $id_aluno) ? "selected" : "";
                                                        echo "<option value='$id_aluno' $sel>Aluno: {$al['nome']}</option>";
                                                    }
                                                }
                                            ?>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Formador:</label></td>
                                </tr>
                                <tr>
                                    <td>
                                        <select name="formador" required>
                                            <option value="">-- Selecione o Formador --</option>
                                            <?php
                                                $sql_form = "SELECT f.utilizador_id, u.nome FROM formador f, utilizador u WHERE f.utilizador_id = u.utilizador_id"; 
                                                $res_form = $BD->executarSQL($sql_form);

                                                if($res_form){
                                                    while($fr = mysqli_fetch_assoc($res_form)){
                                                        $id_form = $fr['utilizador_id']; 
                                                        $sel = ($edit_data && $edit_data['formador_id'] == $id_form) ? "selected" : "";
                                                        echo "<option value='$id_form' $sel>Formador: {$fr['nome']}</option>";
                                                    }
                                                }
                                            ?>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <td><label>Data Início:</label></td>
                                </tr>
                                <tr>
                                    <td><input type="date" name="data_inicio" value="<?php echo $edit_data['data_inicio'] ?? ''; ?>" required></td>
                                </tr>
                                <?php
                                    if ($edit_data) {
                                        echo '<tr><td><label>Data Fim (Opcional):</label></td></tr>';
                                        echo '<tr><td><input type="date" name="data_fim" value="' . ($edit_data['data_fim'] ?? '') . '"></td></tr>';
                                    }
                                ?>
                                <tr>
                                    <td>
                                        <?php
                                            if ($edit_data) {
                                                echo '<input type="submit" name="btn_update_estagio" value="Guardar Alterações">';
                                                echo '<a href="admin.php" class="btn-cancel">Cancelar Edição</a>';
                                            } else {
                                                echo '<input type="submit" name="btn_add_estagio" value="Registar Estágio">';
                                            }
                                        ?>
                                    </td>
                                </tr>
                            </table>
                        </form>
                    </td>
                </tr>
            </table>
        </td>
        <td></td>
    </tr>
</table>


</body>
</html>
<?php $BD->fecharBD(); ?>