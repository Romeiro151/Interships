<?php
    /*Inicio da session*/
    session_start();

    /*Valores do input*/
    $util = $_POST["Nome_Util"];
    $pass = $_POST["Pass"];

    /* Nova ligação à base de dados */
    require("BDEstagios.php");
    $bd = new BDEstagios();
    $bd->ligarBD();
    $registos = $bd->executarSQL("SELECT login, password, tipo, utilizador_id FROM utilizador");
    for($i = 0; $i < $bd->numero_registos("utilizador"); $i++) {
        $registo = mysqli_fetch_row($registos);
        if($registo[0] == $util && $registo[1] == $pass){
            
            /*Guardar valor do id do utilizador na session*/
            $_SESSION["user_id"] = $registo[3];

            if($registo[2] == "aluno"){
                $bd->fecharBD();
                header("Location: estudante.php");
                exit;
            }
            elseif($registo[2] == "formador"){
                $bd->fecharBD();
                header("Location: formador.php");
                exit;
            }
            elseif($registo[2] == "administrativo"){
                $bd->fecharBD();
                header("Location: admin.php");
                exit;
            }
        }
    }
    $bd->fecharBD();
    session_destroy();
    header("Location: index.html");
    echo "Nome de utilizador ou palavra passe incorreta";
    exit;

    

    
    


