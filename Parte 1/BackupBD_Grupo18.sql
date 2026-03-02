-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Oct 27, 2025 at 09:28 PM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `SIEstagios`
--

-- --------------------------------------------------------

--
-- Table structure for table `Administrativo`
--

CREATE TABLE `Administrativo` (
  `Utilizador_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Administrativo`
--

INSERT INTO `Administrativo` (`Utilizador_id`) VALUES
(4);

-- --------------------------------------------------------

--
-- Table structure for table `Aluno`
--

CREATE TABLE `Aluno` (
  `Utilizador_id` int(11) NOT NULL,
  `Numero` int(10) DEFAULT NULL,
  `Observacoes` text DEFAULT NULL,
  `Turma_Curso_Codigo` int(10) DEFAULT NULL,
  `Turma_Sigla` varchar(3) DEFAULT NULL,
  `Turma_Ano` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Aluno`
--

INSERT INTO `Aluno` (`Utilizador_id`, `Numero`, `Observacoes`, `Turma_Curso_Codigo`, `Turma_Sigla`, `Turma_Ano`) VALUES
(1, 124790, 'Luis Pacheco - Estudante ISCTE-LEI', 1010, 'LEI', 2),
(2, 247901, 'José Romeiro - Estudante ISCTE-LEM', 1020, 'LEM', 1),
(3, 150950, 'Ruben Fonseca - Estudante ISCTE-LGE', 1030, 'LGE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Atividade`
--

CREATE TABLE `Atividade` (
  `CodigoCAE` varchar(20) NOT NULL,
  `Descricao` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Atividade`
--

INSERT INTO `Atividade` (`CodigoCAE`, `Descricao`) VALUES
('11050', 'Fabricação de cerveja'),
('62010', 'Programação e Informática');

-- --------------------------------------------------------

--
-- Table structure for table `Curso`
--

CREATE TABLE `Curso` (
  `Codigo` int(10) NOT NULL,
  `Designacao` char(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Curso`
--

INSERT INTO `Curso` (`Codigo`, `Designacao`) VALUES
(1010, 'Engenharia Infor.'),
(1020, 'Engenharia Mecânica'),
(1030, 'Gestão Empresas');

-- --------------------------------------------------------

--
-- Table structure for table `Empresa`
--

CREATE TABLE `Empresa` (
  `id` int(11) NOT NULL,
  `Firma` varchar(20) DEFAULT NULL,
  `NIF` varchar(9) DEFAULT NULL,
  `Morada` varchar(50) DEFAULT NULL,
  `Localidade` varchar(30) DEFAULT NULL,
  `CodigoPostal` varchar(8) DEFAULT NULL,
  `Telefone` varchar(15) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL,
  `Website` varchar(60) DEFAULT NULL,
  `Observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Empresa`
--

INSERT INTO `Empresa` (`id`, `Firma`, `NIF`, `Morada`, `Localidade`, `CodigoPostal`, `Telefone`, `Email`, `Website`, `Observacoes`) VALUES
(1, 'Google', '890238', 'Estrada da Google, nº12', 'Corroios', '2403-210', '910034988', 'google.emprego@gmail.com', 'google.com', 'Empresa Google'),
(2, 'Super Bock', '420980146', 'Estrada da Cerveja, nº21', 'Lisboa', '1960-230', '912456376', 'superbock@gmail.com', 'superbock.com', 'Fábrica de Cerveja Super Bock');

-- --------------------------------------------------------

--
-- Table structure for table `EmpresaAtividade`
--

CREATE TABLE `EmpresaAtividade` (
  `Empresa_id_` int(11) NOT NULL,
  `Atividade_CodigoCAE_` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `EmpresaAtividade`
--

INSERT INTO `EmpresaAtividade` (`Empresa_id_`, `Atividade_CodigoCAE_`) VALUES
(1, '62010'),
(2, '11050');

-- --------------------------------------------------------

--
-- Table structure for table `EmpresaDisponibilidade`
--

CREATE TABLE `EmpresaDisponibilidade` (
  `Empresa_id` int(11) NOT NULL,
  `Ano` varchar(9) NOT NULL,
  `Disponibilidade` tinyint(1) DEFAULT NULL,
  `Capacidade` int(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `EmpresaDisponibilidade`
--

INSERT INTO `EmpresaDisponibilidade` (`Empresa_id`, `Ano`, `Disponibilidade`, `Capacidade`) VALUES
(1, '2025', 1, 10),
(2, '2025', 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Estabelecimento`
--

CREATE TABLE `Estabelecimento` (
  `Empresa_id` int(11) NOT NULL,
  `Zona_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `NomeComercial` varchar(20) DEFAULT NULL,
  `Morada` varchar(50) DEFAULT NULL,
  `Localidade` varchar(30) DEFAULT NULL,
  `CodigoPostal` varchar(8) DEFAULT NULL,
  `Telefone` varchar(15) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL,
  `HorarioFuncionamento` varchar(11) DEFAULT NULL,
  `DataFundacao` date DEFAULT NULL,
  `AceitouEstagiarios` tinyint(1) DEFAULT NULL,
  `Observacoes` text DEFAULT NULL,
  `Foto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Estabelecimento`
--

INSERT INTO `Estabelecimento` (`Empresa_id`, `Zona_id`, `id`, `NomeComercial`, `Morada`, `Localidade`, `CodigoPostal`, `Telefone`, `Email`, `HorarioFuncionamento`, `DataFundacao`, `AceitouEstagiarios`, `Observacoes`, `Foto`) VALUES
(1, 2, 2, 'Google Sintra', 'Estrada da Google nº12', 'Sintra', '2725-123', '925678412', 'google.sintra@gmail.com', '08:00-20:00', '1990-08-20', 1, NULL, NULL),
(1, 1, 3, 'Google Lisboa', 'Avenida da Google Lisboa, nº1', 'Lisboa', '1234-238', '213678495', 'google.lisboa@gmail.com', '09:00-21:00', '2015-10-15', 1, NULL, NULL),
(2, 1, 1, 'Super Bock', 'Estrada da Cerveja nº21', 'Lisboa', '2760-230', '912478123', 'superbock.fabrica@gmail.com', '08:00-18:00', '1927-03-03', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `EstabelecimentoProduto`
--

CREATE TABLE `EstabelecimentoProduto` (
  `Estabelecimento_Empresa_id_` int(11) NOT NULL,
  `Estabelecimento_id_` int(11) NOT NULL,
  `Produto_id_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `EstabelecimentoProduto`
--

INSERT INTO `EstabelecimentoProduto` (`Estabelecimento_Empresa_id_`, `Estabelecimento_id_`, `Produto_id_`) VALUES
(1, 2, 1),
(2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `EstabelecimentoTransportes`
--

CREATE TABLE `EstabelecimentoTransportes` (
  `Estabelecimento_Empresa_id_` int(11) NOT NULL,
  `Estabelecimento_id_` int(11) NOT NULL,
  `Transportes_id_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `EstabelecimentoTransportes`
--

INSERT INTO `EstabelecimentoTransportes` (`Estabelecimento_Empresa_id_`, `Estabelecimento_id_`, `Transportes_id_`) VALUES
(1, 2, 1),
(2, 1, 1),
(2, 1, 2);

-- --------------------------------------------------------

--
-- Table structure for table `Estagio`
--

CREATE TABLE `Estagio` (
  `Aluno_Utilizador_id` int(11) NOT NULL,
  `Formador_Utilizador_id` int(11) NOT NULL,
  `Responsavel_id` int(11) NOT NULL,
  `Estabelecimento_Empresa_id` int(11) NOT NULL,
  `Estabelecimento_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `DataInicio` date DEFAULT NULL,
  `DataFim` date DEFAULT NULL,
  `NotaEmpresa` int(2) DEFAULT NULL,
  `NotaEscola` int(2) DEFAULT NULL,
  `NotaProcura` int(2) DEFAULT NULL,
  `NotaRelatorio` int(2) DEFAULT NULL,
  `NotaFimEstagio` int(2) DEFAULT NULL,
  `NotaAlunoEstabelecimento` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Estagio`
--

INSERT INTO `Estagio` (`Aluno_Utilizador_id`, `Formador_Utilizador_id`, `Responsavel_id`, `Estabelecimento_Empresa_id`, `Estabelecimento_id`, `id`, `DataInicio`, `DataFim`, `NotaEmpresa`, `NotaEscola`, `NotaProcura`, `NotaRelatorio`, `NotaFimEstagio`, `NotaAlunoEstabelecimento`) VALUES
(1, 5, 1, 1, 2, 1, '2025-10-14', '2026-10-16', 20, 18, 17, 18, 19, 4),
(2, 6, 2, 2, 1, 2, '2025-12-18', '2025-12-24', 17, 19, 15, 16, 18, 3);

-- --------------------------------------------------------

--
-- Table structure for table `Formador`
--

CREATE TABLE `Formador` (
  `Utilizador_id` int(11) NOT NULL,
  `Numero` int(10) DEFAULT NULL,
  `Disciplina` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Formador`
--

INSERT INTO `Formador` (`Utilizador_id`, `Numero`, `Disciplina`) VALUES
(5, 122780, 'Base de Dados'),
(6, 259876, 'Mecanica Fluidos');

-- --------------------------------------------------------

--
-- Table structure for table `MediaEstabelecimento`
--

CREATE TABLE `MediaEstabelecimento` (
  `Estabelecimento_Empresa_id` int(11) NOT NULL,
  `Estabelecimento_id` int(11) NOT NULL,
  `AnoLetivo` varchar(9) NOT NULL,
  `Media` varchar(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `MediaEstabelecimento`
--

INSERT INTO `MediaEstabelecimento` (`Estabelecimento_Empresa_id`, `Estabelecimento_id`, `AnoLetivo`, `Media`) VALUES
(1, 3, '2024', '4'),
(1, 2, '2025', '4'),
(2, 1, '2025', '3');

-- --------------------------------------------------------

--
-- Table structure for table `Produto`
--

CREATE TABLE `Produto` (
  `id` int(11) NOT NULL,
  `Nome` varchar(40) DEFAULT NULL,
  `Marca` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Produto`
--

INSERT INTO `Produto` (`id`, `Nome`, `Marca`) VALUES
(1, 'Websites', 'Google'),
(2, 'Cerveja', 'SuperBock');

-- --------------------------------------------------------

--
-- Table structure for table `Responsavel`
--

CREATE TABLE `Responsavel` (
  `Estabelecimento_Empresa_id` int(11) NOT NULL,
  `Estabelecimento_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `Nome` varchar(50) DEFAULT NULL,
  `Titulo` varchar(25) DEFAULT NULL,
  `Cargo` varchar(25) DEFAULT NULL,
  `Telefone` varchar(15) DEFAULT NULL,
  `Telemovel` varchar(15) DEFAULT NULL,
  `Email` varchar(40) DEFAULT NULL,
  `Observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Responsavel`
--

INSERT INTO `Responsavel` (`Estabelecimento_Empresa_id`, `Estabelecimento_id`, `id`, `Nome`, `Titulo`, `Cargo`, `Telefone`, `Telemovel`, `Email`, `Observacoes`) VALUES
(1, 2, 1, 'Larry Page', 'Eng.', 'CEO', '214589276', '913098578', 'larry.page@gmail.com', NULL),
(2, 1, 2, 'Alberto Fonseca', 'Eng.', 'CEO', '213567098', '933888790', 'alberto.fonseca@hotmail.com', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `Transportes`
--

CREATE TABLE `Transportes` (
  `id` int(11) NOT NULL,
  `MeioDeTransporte` varchar(20) DEFAULT NULL,
  `Linha` varchar(20) DEFAULT NULL,
  `Observacoes` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Transportes`
--

INSERT INTO `Transportes` (`id`, `MeioDeTransporte`, `Linha`, `Observacoes`) VALUES
(1, 'Comboio', 'Sintra', 'Comboio da Linha de Sintra'),
(2, 'Metro', 'Vermelha', 'Metro linha vermelha, paragens:\r\nAeroporto, Moscavide, Oriente'),
(3, 'Autocarro', '727', 'Roma-Areeiro - Restelo');

-- --------------------------------------------------------

--
-- Table structure for table `Turma`
--

CREATE TABLE `Turma` (
  `Curso_Codigo` int(10) NOT NULL,
  `Sigla` varchar(3) NOT NULL,
  `Ano` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Turma`
--

INSERT INTO `Turma` (`Curso_Codigo`, `Sigla`, `Ano`) VALUES
(1010, 'LEI', 1),
(1010, 'LEI', 2),
(1020, 'LEM', 1),
(1030, 'LGE', 1);

-- --------------------------------------------------------

--
-- Table structure for table `Utilizador`
--

CREATE TABLE `Utilizador` (
  `id` int(11) NOT NULL,
  `TipoUtilizador` enum('Aluno','Administrativo','Formador') DEFAULT NULL,
  `Nome` varchar(40) DEFAULT NULL,
  `login` varchar(20) DEFAULT NULL,
  `password` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Utilizador`
--

INSERT INTO `Utilizador` (`id`, `TipoUtilizador`, `Nome`, `login`, `password`) VALUES
(1, 'Aluno', 'Luis Pacheco', 'luiberna', 'luiberna123'),
(2, 'Aluno', 'Jose Romeiro', 'jromeiro', 'jromeiro123'),
(3, 'Aluno', 'Ruben Fonseca', 'rfonseca', 'rfonseca123'),
(4, 'Administrativo', 'Filipe Santos', 'proffsantos', 'fsantos123'),
(5, 'Formador', 'José Coelho', 'profJoseCoelho', 'josecoelho123'),
(6, 'Formador', 'Marco Aurelio', 'maraurelio', 'maraurelio123');

-- --------------------------------------------------------

--
-- Table structure for table `Zona`
--

CREATE TABLE `Zona` (
  `id` int(11) NOT NULL,
  `Designacao` varchar(20) DEFAULT NULL,
  `Localidade` varchar(25) DEFAULT NULL,
  `Mapa` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `Zona`
--

INSERT INTO `Zona` (`id`, `Designacao`, `Localidade`, `Mapa`) VALUES
(1, 'LIS', 'Lisboa', NULL),
(2, 'SIN', 'Sintra', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `ZonaTransportes`
--

CREATE TABLE `ZonaTransportes` (
  `Zona_id_` int(11) NOT NULL,
  `Transportes_id_` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ZonaTransportes`
--

INSERT INTO `ZonaTransportes` (`Zona_id_`, `Transportes_id_`) VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Administrativo`
--
ALTER TABLE `Administrativo`
  ADD PRIMARY KEY (`Utilizador_id`);

--
-- Indexes for table `Aluno`
--
ALTER TABLE `Aluno`
  ADD PRIMARY KEY (`Utilizador_id`),
  ADD UNIQUE KEY `Numero` (`Numero`),
  ADD KEY `FK_Aluno_Turma` (`Turma_Curso_Codigo`,`Turma_Sigla`,`Turma_Ano`);

--
-- Indexes for table `Atividade`
--
ALTER TABLE `Atividade`
  ADD PRIMARY KEY (`CodigoCAE`),
  ADD UNIQUE KEY `CodigoCAE` (`CodigoCAE`);

--
-- Indexes for table `Curso`
--
ALTER TABLE `Curso`
  ADD PRIMARY KEY (`Codigo`),
  ADD UNIQUE KEY `Codigo` (`Codigo`);

--
-- Indexes for table `Empresa`
--
ALTER TABLE `Empresa`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `NIF` (`NIF`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD UNIQUE KEY `Website` (`Website`);

--
-- Indexes for table `EmpresaAtividade`
--
ALTER TABLE `EmpresaAtividade`
  ADD PRIMARY KEY (`Empresa_id_`,`Atividade_CodigoCAE_`),
  ADD KEY `FK_Atividade_EmpresaAtividade_Empresa_` (`Atividade_CodigoCAE_`);

--
-- Indexes for table `EmpresaDisponibilidade`
--
ALTER TABLE `EmpresaDisponibilidade`
  ADD PRIMARY KEY (`Empresa_id`,`Ano`) USING BTREE;

--
-- Indexes for table `Estabelecimento`
--
ALTER TABLE `Estabelecimento`
  ADD PRIMARY KEY (`Empresa_id`,`id`),
  ADD UNIQUE KEY `NomeComercial` (`NomeComercial`),
  ADD KEY `FK_Estabelecimento_noname_Zona` (`Zona_id`);

--
-- Indexes for table `EstabelecimentoProduto`
--
ALTER TABLE `EstabelecimentoProduto`
  ADD PRIMARY KEY (`Estabelecimento_Empresa_id_`,`Estabelecimento_id_`,`Produto_id_`) USING BTREE,
  ADD KEY `FK_Produto_EstabelecimentoProduto_Estabelecimento_` (`Produto_id_`);

--
-- Indexes for table `EstabelecimentoTransportes`
--
ALTER TABLE `EstabelecimentoTransportes`
  ADD PRIMARY KEY (`Estabelecimento_Empresa_id_`,`Estabelecimento_id_`,`Transportes_id_`),
  ADD KEY `FK_Transportes_EstabelecimentoTransportes_Estabelecimento_` (`Transportes_id_`);

--
-- Indexes for table `Estagio`
--
ALTER TABLE `Estagio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `FK_Estagio_noname_Aluno` (`Aluno_Utilizador_id`),
  ADD KEY `FK_Estagio_noname_Formador` (`Formador_Utilizador_id`),
  ADD KEY `FK_Estagio_noname_Responsavel` (`Responsavel_id`),
  ADD KEY `FK_Estagio_noname_Estabelecimento` (`Estabelecimento_Empresa_id`,`Estabelecimento_id`);

--
-- Indexes for table `Formador`
--
ALTER TABLE `Formador`
  ADD PRIMARY KEY (`Utilizador_id`),
  ADD UNIQUE KEY `Numero` (`Numero`);

--
-- Indexes for table `MediaEstabelecimento`
--
ALTER TABLE `MediaEstabelecimento`
  ADD PRIMARY KEY (`AnoLetivo`,`Estabelecimento_Empresa_id`,`Estabelecimento_id`) USING BTREE,
  ADD KEY `FK_MediaEstabelecimento_noname_Estabelecimento` (`Estabelecimento_Empresa_id`,`Estabelecimento_id`);

--
-- Indexes for table `Produto`
--
ALTER TABLE `Produto`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Responsavel`
--
ALTER TABLE `Responsavel`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `Telemovel` (`Telemovel`),
  ADD UNIQUE KEY `Email` (`Email`),
  ADD KEY `FK_Responsavel_noname_Estabelecimento` (`Estabelecimento_Empresa_id`,`Estabelecimento_id`);

--
-- Indexes for table `Transportes`
--
ALTER TABLE `Transportes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Turma`
--
ALTER TABLE `Turma`
  ADD PRIMARY KEY (`Curso_Codigo`,`Sigla`,`Ano`);

--
-- Indexes for table `Utilizador`
--
ALTER TABLE `Utilizador`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- Indexes for table `Zona`
--
ALTER TABLE `Zona`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ZonaTransportes`
--
ALTER TABLE `ZonaTransportes`
  ADD PRIMARY KEY (`Zona_id_`,`Transportes_id_`),
  ADD KEY `FK_Transportes_ZonaTransportes_Zona_` (`Transportes_id_`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Empresa`
--
ALTER TABLE `Empresa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Estagio`
--
ALTER TABLE `Estagio`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Produto`
--
ALTER TABLE `Produto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Responsavel`
--
ALTER TABLE `Responsavel`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `Transportes`
--
ALTER TABLE `Transportes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `Utilizador`
--
ALTER TABLE `Utilizador`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `Zona`
--
ALTER TABLE `Zona`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Administrativo`
--
ALTER TABLE `Administrativo`
  ADD CONSTRAINT `FK_Administrativo_Utilizador` FOREIGN KEY (`Utilizador_id`) REFERENCES `Utilizador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Aluno`
--
ALTER TABLE `Aluno`
  ADD CONSTRAINT `FK_Aluno_Turma` FOREIGN KEY (`Turma_Curso_Codigo`,`Turma_Sigla`,`Turma_Ano`) REFERENCES `Turma` (`Curso_Codigo`, `Sigla`, `Ano`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Aluno_Utilizador` FOREIGN KEY (`Utilizador_id`) REFERENCES `Utilizador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EmpresaAtividade`
--
ALTER TABLE `EmpresaAtividade`
  ADD CONSTRAINT `FK_Atividade_EmpresaAtividade_Empresa_` FOREIGN KEY (`Atividade_CodigoCAE_`) REFERENCES `Atividade` (`CodigoCAE`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Empresa_EmpresaAtividade_Atividade_` FOREIGN KEY (`Empresa_id_`) REFERENCES `Empresa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EmpresaDisponibilidade`
--
ALTER TABLE `EmpresaDisponibilidade`
  ADD CONSTRAINT `FK_EmpresaDisponibilidade_noname_Empresa` FOREIGN KEY (`Empresa_id`) REFERENCES `Empresa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Estabelecimento`
--
ALTER TABLE `Estabelecimento`
  ADD CONSTRAINT `FK_Estabelecimento_noname_Empresa` FOREIGN KEY (`Empresa_id`) REFERENCES `Empresa` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Estabelecimento_noname_Zona` FOREIGN KEY (`Zona_id`) REFERENCES `Zona` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `EstabelecimentoProduto`
--
ALTER TABLE `EstabelecimentoProduto`
  ADD CONSTRAINT `FK_Estabelecimento_EstabelecimentoProduto_Produto_` FOREIGN KEY (`Estabelecimento_Empresa_id_`,`Estabelecimento_id_`) REFERENCES `Estabelecimento` (`Empresa_id`, `id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Produto_EstabelecimentoProduto_Estabelecimento_` FOREIGN KEY (`Produto_id_`) REFERENCES `Produto` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `EstabelecimentoTransportes`
--
ALTER TABLE `EstabelecimentoTransportes`
  ADD CONSTRAINT `FK_Estabelecimento_EstabelecimentoTransportes_Transportes_` FOREIGN KEY (`Estabelecimento_Empresa_id_`,`Estabelecimento_id_`) REFERENCES `Estabelecimento` (`Empresa_id`, `id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Transportes_EstabelecimentoTransportes_Estabelecimento_` FOREIGN KEY (`Transportes_id_`) REFERENCES `Transportes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `Estagio`
--
ALTER TABLE `Estagio`
  ADD CONSTRAINT `FK_Estagio_noname_Aluno` FOREIGN KEY (`Aluno_Utilizador_id`) REFERENCES `Aluno` (`Utilizador_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Estagio_noname_Estabelecimento` FOREIGN KEY (`Estabelecimento_Empresa_id`,`Estabelecimento_id`) REFERENCES `Estabelecimento` (`Empresa_id`, `id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Estagio_noname_Formador` FOREIGN KEY (`Formador_Utilizador_id`) REFERENCES `Formador` (`Utilizador_id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Estagio_noname_Responsavel` FOREIGN KEY (`Responsavel_id`) REFERENCES `Responsavel` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `Formador`
--
ALTER TABLE `Formador`
  ADD CONSTRAINT `FK_Formador_Utilizador` FOREIGN KEY (`Utilizador_id`) REFERENCES `Utilizador` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `MediaEstabelecimento`
--
ALTER TABLE `MediaEstabelecimento`
  ADD CONSTRAINT `FK_MediaEstabelecimento_noname_Estabelecimento` FOREIGN KEY (`Estabelecimento_Empresa_id`,`Estabelecimento_id`) REFERENCES `Estabelecimento` (`Empresa_id`, `id`) ON UPDATE CASCADE;

--
-- Constraints for table `Responsavel`
--
ALTER TABLE `Responsavel`
  ADD CONSTRAINT `FK_Responsavel_noname_Estabelecimento` FOREIGN KEY (`Estabelecimento_Empresa_id`,`Estabelecimento_id`) REFERENCES `Estabelecimento` (`Empresa_id`, `id`) ON UPDATE CASCADE;

--
-- Constraints for table `Turma`
--
ALTER TABLE `Turma`
  ADD CONSTRAINT `FK_Turma_noname_Curso` FOREIGN KEY (`Curso_Codigo`) REFERENCES `Curso` (`Codigo`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `ZonaTransportes`
--
ALTER TABLE `ZonaTransportes`
  ADD CONSTRAINT `FK_Transportes_ZonaTransportes_Zona_` FOREIGN KEY (`Transportes_id_`) REFERENCES `Transportes` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `FK_Zona_ZonaTransportes_Transportes_` FOREIGN KEY (`Zona_id_`) REFERENCES `Zona` (`id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
