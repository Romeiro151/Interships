<?php
    class BDEstagios {
    
        var $conn;
    
        function ligarBD() {
            $this->conn = mysqli_connect("localhost", "root", "");
            if(!$this->conn) {
                die("Erro Inesperado. Base de Dados não operacional.");;
            }
            if (!mysqli_select_db($this->conn, "SIEstagios")) {
                die("Erro: Base de Dados SIEstagios não encontrada.");
            }
        }
        
        function executarSQL($sql_command) {
            $resultado = mysqli_query($this->conn, $sql_command);
            return $resultado;
        }

        function numero_registos($tabela) {
            $resultado = $this->executarSQL("SELECT * FROM $tabela");
            $nr = mysqli_num_rows($resultado);
            return $nr;
        }

        function fecharBD() {
            mysqli_close($this->conn);
        }
    }

    class Empresas extends BDEstagios {

        function __construct() {
            $this->ligarBD();
        }

        function listarEmpresas($ramo_ativ, $localidade) {
            $sql = "SELECT firma, tipo_organizacao, localidade, telefone, website 
                    FROM empresa e, trabalha t, ramo_atividade r, disponibilidade d 
                    WHERE e.empresa_id = t.ramo_atividade_id AND t.ramo_atividade_id = r.ramo_atividade_id";
            $str = "";
            if($ramo_ativ != null) {
                for($i = 0; $i < count($ramo_ativ); $i++){
                    if(count($ramo_ativ) == 1){
                        $str = " AND r.descricao = '" . $ramo_ativ[0] . "'" ;
                    }
                    elseif($i == 0){
                        $str = " AND r.descricao IN ('" . $ramo_ativ[0] . "', ";

                    }
                    elseif($i == count($ramo_ativ) - 1){
                        $str = $str . "'" . $ramo_ativ[$i] . "')";
                    }
                    else{
                        $str = $str . "'" . $ramo_ativ[$i] . "', ";
                    }
                }
                $sql .= $str;
            }
            if($localidade != null) {
                for($i = 0; $i < count($localidade); $i++){
                    if(count($localidade) == 1){
                        $str = " AND e.localidade = '" . $localidade[0] . "'" ;
                    }
                    elseif($i == 0){
                        $str = " AND e.localidade IN ('" . $localidade[0] . "', ";

                    }
                    elseif($i == count($localidade) - 1){
                        $str = $str . "'" . $localidade[$i] . "')";
                    }
                    else{
                        $str = $str . "'" . $localidade[$i] . "', ";
                    }
                }
                $sql .= $str;
            }  
            $sql .= " AND d.empresa_id = e.empresa_id AND d.ano = YEAR(CURRENT_DATE)
                        AND (SELECT COUNT(*)
                            FROM estagio est
                            WHERE YEAR(est.data_inicio) = YEAR(CURRENT_DATE) 
                            AND est.estabelecimento_empresa_id = e.empresa_id) <= d.num_estagios";
            
            $resultado = $this->executarSQL($sql);
            return $resultado;
        }
    }

    class Estagios extends BDEstagios {
        
        function __construct() {
            $this->ligarBD();
        }

        function listarEstabelecimento($firma, $nr_estabelecimento) {
            $sql = "SELECT est.nome_comercial, est.morada, est.localidade
                    FROM estabelecimento est, empresa e
                    WHERE est.empresa_id = e.empresa_id AND e.firma = '" . $firma . "' AND est.estabelecimento_id = '" . $nr_estabelecimento ."'";
            $resultado = $this->executarSQL($sql);
            return $resultado;
        }

        function totalEstabelecimentos($firma) {
            $sql = "SELECT COUNT(*)
                    FROM estabelecimento est, empresa e
                    WHERE est.empresa_id = e.empresa_id AND e.firma = '" . $firma . "'";
            $resultado = $this->executarSQL($sql);
            $total = mysqli_num_rows($resultado);
            return $total;
        }

        function listarResponsavel($firma, $nr_estabelecimento) {
            $sql = "SELECT nome, cargo, telemovel, r.email
                    FROM responsavel r, estabelecimento est, empresa e
                    WHERE est.estabelecimento_id = '" . $nr_estabelecimento . "' AND r.responsavel_id = est.responsavel_id
                    AND est.empresa_id = e.empresa_id AND e.firma = '" . $firma . "'";
            $resultado = $this->executarSQL($sql);
            return $resultado;
        }

        function listarEmpresa($firma){
            $sql = "SELECT firma, descricao, morada_sede, localidade, telefone
                    FROM empresa e, trabalha t, ramo_atividade r
                    WHERE e.empresa_id = t.empresa_id AND t.ramo_atividade_id = r.ramo_atividade_id
                    AND e.firma = '" . $firma . "'";
            $resultado = $this->executarSQL($sql);
            return $resultado;
        }

        function listarTransporte($firma, $nr_estabelecimento) {
            $sql = "SELECT meio_transporte, linha
                    FROM transporte t, servido s, estabelecimento est, empresa e
                    WHERE t.transporte_id = s.transporte_id AND s.estabelecimento_id = est.estabelecimento_id
                    AND s.estabelecimento_empresa_id = e.empresa_id AND est.empresa_id = e.empresa_id 
                    AND e.firma = '" . $firma . "' AND est.estabelecimento_id = '" . $nr_estabelecimento . "'";
            $resultado = $this->executarSQL($sql);
            return $resultado;
        }
    }