<?php
include 'BDEstagios.php';
$BD = new BDEstagios();
$BD->ligarBD();

$id_edit = null;
$aluno_id = null;
$estab_id = null;
$empresa_id = null;
if (isset($_GET['edit_id']) && is_array($_GET['edit_id']) && count($_GET['edit_id']) === 3) {
    $id_edit = $_GET['edit_id'];
    $aluno_id   = (int) $id_edit[0];
    $estab_id   = (int) $id_edit[1];
    $empresa_id = (int) $id_edit[2];
}


// Adicionar Aluno
if (isset($_POST['btn_add_aluno'])) {
    $novo_nome = $_POST['novo_nome'];
    $novo_user = $_POST['novo_user'];
    $novo_pass = $_POST['novo_pass'];
    $novo_turma_id = $_POST['novo_turma_id'];
    
    // Verifica duplicados no Login
    $check = $BD->executarSQL("SELECT * FROM utilizador WHERE login = '$novo_user'");
    if (mysqli_num_rows($check) > 0) {
        header("Location: admin.php?msg=erro_existe");
        exit();
    }

    $res = $BD->executarSQL("SELECT MAX(utilizador_id) AS max_id FROM utilizador");
    $row = mysqli_fetch_assoc($res);
    $novo_id = $row['max_id'] + 1;

    // Insere no utilizador
    $sql_user = "INSERT INTO utilizador (utilizador_id, login, password, nome, tipo) VALUES ('$novo_id', '$novo_user', '$novo_pass', '$novo_nome', 'aluno')";
    
    if ($BD->executarSQL($sql_user)) {
        
        $sql_aluno = "INSERT INTO aluno (turma_id, utilizador_id) VALUES ('$novo_turma_id', '$novo_id')";
        
        if($BD->executarSQL($sql_aluno)){
            header("Location: admin.php?msg=aluno_ok");
        } else {
            echo "Erro ao inserir na tabela ALUNO: " . mysqli_error($BD->conn);
            exit(); 
        }

    } else {
        header("Location: admin.php?msg=erro_sql_insert");
    }
    exit();
}

// Regista novo estagio
if (isset($_POST['btn_add_estagio'])) {
    
    // Validar se o Select veio preenchido
    if(isset($_POST['combo_ids']) && !empty($_POST['combo_ids'])) {
        $partes = explode('|', $_POST['combo_ids']);
        $estab_id = $partes[0];
        $empresa_id = $partes[1];
    } else {
        header("Location: admin.php?msg=erro_dados");
        exit();
    }

    $inicio = $_POST['data_inicio'];
    $aluno_id = $_POST['aluno'];
    $formador_id = $_POST['formador'];

    // Verifica se este aluno já está registado nesta empresa especifica
    $sql_check = "SELECT * FROM estagio 
                  WHERE estabelecimento_id = '$estab_id' 
                  AND estabelecimento_empresa_id = '$empresa_id' 
                  AND aluno_id = '$aluno_id'";
                  
    $result_check = $BD->executarSQL($sql_check);

    if (mysqli_num_rows($result_check) > 0) {
        // Se já existe, manda de volta com erro
        header("Location: admin.php?msg=erro_duplicado");
        exit();
    }

    // Se não existe, prossegue
    $sql = "INSERT INTO estagio (estabelecimento_id, estabelecimento_empresa_id, data_inicio, aluno_id, formador_id) 
            VALUES ('$estab_id', '$empresa_id', '$inicio', '$aluno_id', '$formador_id')";
    
    // Tenta inserir
    if($BD->executarSQL($sql)){
        header("Location: admin.php?msg=estagio_ok");
    } else {
        // Se der erro, avisa
        header("Location: admin.php?msg=erro_sql_insert");
    }
    exit();
}

// Apagar estagio
if (isset($_GET['delete_id'])) {
    $id = $_GET['delete_id'];
    if (!$id || !is_array($id) || count($id) !== 3) {
        header("Location: admin.php?msg=erro_dados");
        exit();
    }

    $aluno_id   = (int) $id[0];
    $estab_id   = (int) $id[1];
    $empresa_id = (int) $id[2];
    
    // Verifica se o estagio já terminou antes de apagar
    $check = $BD->executarSQL("SELECT data_fim FROM estagio WHERE aluno_id = {$aluno_id} AND estabelecimento_id = {$estab_id}
    AND estabelecimento_empresa_id = {$empresa_id}");
    
    if($check && mysqli_num_rows($check) > 0) {
        $row = mysqli_fetch_assoc($check);
        $hoje = date("Y-m-d");

        //Se tiver data de fim e for no passado, impede
        if ($row['data_fim'] != NULL && $row['data_fim'] < $hoje && $row['data_fim'] != '0000-00-00') {
            header("Location: admin.php?msg=erro_terminado");
        } else {
            $BD->executarSQL("DELETE FROM estagio WHERE aluno_id = {$aluno_id} AND estabelecimento_id = {$estab_id}
                                AND estabelecimento_empresa_id = {$empresa_id}");
            header("Location: admin.php?msg=apagado_ok");
        }
    } else {
        header("Location: admin.php?msg=erro_id");
    }
    exit();
}

// Atualizar estagio
if (isset($_POST['btn_update_estagio'])) {
    $id_edit = $_POST['edit_id'] ?? null; 

    // Validaçao
    if (!$id_edit || !is_array($id_edit) || count($id_edit) !== 3) {
        header("Location: admin.php?msg=erro_dados");
        exit();
    }

    $aluno_id_old   = (int) $id_edit[0];
    $estab_id_old   = (int) $id_edit[1];
    $empresa_id_old = (int) $id_edit[2];
    
    // Separa o ID do Estabelecimento e da Empresa
    if(isset($_POST['combo_ids']) && !empty($_POST['combo_ids'])) {
        $partes = explode('|', $_POST['combo_ids']);
        $estab_id = $partes[0];
        $empresa_id = $partes[1];
    } else {
        header("Location: admin.php?msg=erro_dados");
        exit();
    }

    $inicio = $_POST['data_inicio'];
    $aluno_id = $_POST['aluno'];
    $formador_id = $_POST['formador'];
    $fim = $_POST['data_fim'];

    if(empty($fim)) {
        $sql_update = "UPDATE estagio SET 
            estabelecimento_id='$estab_id', 
            estabelecimento_empresa_id='$empresa_id', 
            data_inicio='$inicio', 
            aluno_id='$aluno_id', 
            formador_id='$formador_id', 
            data_fim=NULL 
            WHERE aluno_id = {$aluno_id_old} AND estabelecimento_id = {$estab_id_old}
            AND estabelecimento_empresa_id = {$empresa_id_old}";
    } else {
        $sql_update = "UPDATE estagio SET 
            estabelecimento_id='$estab_id', 
            estabelecimento_empresa_id='$empresa_id', 
            data_inicio='$inicio', 
            aluno_id='$aluno_id', 
            formador_id='$formador_id', 
            data_fim='$fim' 
            WHERE aluno_id = {$aluno_id_old} AND estabelecimento_id = {$estab_id_old}
            AND estabelecimento_empresa_id = {$empresa_id_old}";
    }
    
    if($BD->executarSQL($sql_update)){
        header("Location: admin.php?msg=editado_ok");
    } else {
        echo "Erro ao atualizar: " . mysqli_error($BD->conn);
    }
    exit();
}