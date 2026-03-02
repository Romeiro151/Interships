<?php
    session_start();
    require 'BDEstagios.php';
    $BD = new BDEstagios();
    $BD->ligarBD();

    if (isset($_POST['btn_lancar_notas'])) {
        
        // Receber os dados do formulário
        $id_estagio = $_POST['aluno_id'];
        $n_empresa  = $_POST['n_emp'];
        $n_escola   = $_POST['n_esc'];
        $n_procura  = $_POST['n_pro'];
        $n_relatorio = $_POST['n_rel'];

        // Calcular a Média automaticamente
        $media = ($n_empresa + $n_escola + $n_procura + $n_relatorio) / 4;
        
        // Arredondar para 1 casa decimal (ex: 14.5)
        $nota_final = number_format($media, 1, '.', '');

        // Atualizar a Base de Dados
        $sql_update = "UPDATE estagio SET 
                        nota_empresa = '$n_empresa',
                        nota_escola = '$n_escola',
                        nota_procura = '$n_procura',
                        nota_relatorio = '$n_relatorio',
                        nota_final = '$nota_final'
                    WHERE aluno_id = $id_estagio";

        $resultado = $BD->executarSQL($sql_update);

        if ($resultado) {
            $BD->fecharBD();
            header("Location: formador.php?msg=sucesso");
        } else {
            $BD->fecharBD();
            header("Location: formador.php?msg=erro_sql");
        }

    } else {
        // Se tentarem abrir o ficheiro diretamente sem clicar no botão
        $BD->fecharBD();
        header("Location: formador.php");
    }
?>