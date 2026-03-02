drop table if exists EmpresaAtividade ;
drop table if exists EstabelecimentoProduto ;
drop table if exists ZonaTransportes ;
drop table if exists EstabelecimentoTransportes ;
drop table if exists Aluno ;
drop table if exists Administrativo ;
drop table if exists Formador ;
drop table if exists Estagio ;
drop table if exists Responsavel ;
drop table if exists Turma ;
drop table if exists Curso ;
drop table if exists Empresa ;
drop table if exists EmpresaDisponibilidade ;
drop table if exists Atividade ;
drop table if exists Estabelecimento ;
drop table if exists Produto ;
drop table if exists Utilizador ;
drop table if exists Zona ;
drop table if exists Transportes ;
drop table if exists MediaEstabelecimento ;
 
create table EmpresaAtividade
(
   Empresa_id_   Integer   not null,
   Atividade_CodigoCAE_   varchar(20)   not null,
 
   constraint PK_EmpresaAtividade primary key (Empresa_id_, Atividade_CodigoCAE_)
);
 
create table EstabelecimentoProduto
(
   Estabelecimento_Empresa_id_   Integer   not null,
   Estabelecimento_id_   Integer   not null,
   Produto_id_   Integer   not null,
 
   constraint PK_EstabelecimentoProduto primary key (Estabelecimento_Empresa_id_, Estabelecimento_id_, Produto_id_)
);
 
create table ZonaTransportes
(
   Zona_id_   Integer   not null,
   Transportes_id_   Integer   not null,
 
   constraint PK_ZonaTransportes primary key (Zona_id_, Transportes_id_)
);
 
create table EstabelecimentoTransportes
(
   Estabelecimento_Empresa_id_   Integer   not null,
   Estabelecimento_id_   Integer   not null,
   Transportes_id_   Integer   not null,
 
   constraint PK_EstabelecimentoTransportes primary key (Estabelecimento_Empresa_id_, Estabelecimento_id_, Transportes_id_)
);
 
create table Aluno
(
   Utilizador_id   Integer   not null,
   Numero   int(10)  unique null,
   Observacoes   text   null,
 
   constraint PK_Aluno primary key (Utilizador_id)
);
 
create table Administrativo
(
   Utilizador_id   Integer   not null,
 
   constraint PK_Administrativo primary key (Utilizador_id)
);
 
create table Formador
(
   Utilizador_id   Integer   not null,
   Numero   int(10)  unique null,
   Disciplina   varchar(20)   null,
 
   constraint PK_Formador primary key (Utilizador_id)
);
 
create table Estagio
(
   Aluno_Utilizador_id   Integer   not null,
   Formador_Utilizador_id   Integer   not null,
   Responsavel_id   Integer   not null,
   Estabelecimento_Empresa_id   Integer   not null,
   Estabelecimento_id   Integer   not null,
   id   Integer   not null,
   DataInicio   DATE   null,
   DataFim   DATE   null,
   NotaEmpresa   int(2)   null,
   NotaEscola   int(2)   null,
   NotaProcura   int(2)   null,
   NotaRelatorio   int(2)   null,
   NotaFimEstagio   int(2)   null,
   NotaAlunoEstabelecimento   int(1)   null,
 
   constraint PK_Estagio primary key (id)
);
 
create table Responsavel
(
   Estabelecimento_Empresa_id   Integer   not null,
   Estabelecimento_id   Integer   not null,
   id   Integer   not null,
   Nome   varchar(50)   null,
   Titulo   varchar(25)   null,
   Cargo   varchar(25)   null,
   Telefone   varchar(15)   null,
   Telemovel   varchar(15)  unique null,
   Email   varchar(40)  unique null,
   Observacoes   text   null,
 
   constraint PK_Responsavel primary key (id)
);
 
create table Turma
(
   Curso_Codigo   int(10)   not null,
   Sigla   char(2)   not null,
   Ano   int(10)   not null,
 
   constraint PK_Turma primary key (Curso_Codigo, Sigla, Ano)
);
 
create table Curso
(
   Codigo   int(10)   unique not null,
   Designacao   char(20)   null,
 
   constraint PK_Curso primary key (Codigo)
);
 
create table Empresa
(
   id   Integer   not null,
   Firma   varchar(20)   null,
   NIF   varchar(9)  unique null,
   Morada   varchar(50)   null,
   Localidade   varchar(30)   null,
   CodigoPostal   varchar(8)   null,
   Telefone   varchar(15)   null,
   Email   varchar(40)  unique null,
   Website   varchar(60)  unique null,
   Observacoes   text   null,
 
   constraint PK_Empresa primary key (id)
);
 
create table EmpresaDisponibilidade
(
   Empresa_id   Integer   not null,
   Ano   varchar(9)   not null,
   Disponibilidade   Boolean   null,
   Capacidade   int(10)   null,
 
   constraint PK_EmpresaDisponibilidade primary key (Ano)
);
 
create table Atividade
(
   CodigoCAE   varchar(20)   unique not null,
   Descricao   text   null,
 
   constraint PK_Atividade primary key (CodigoCAE)
);
 
create table Estabelecimento
(
   Empresa_id   Integer   not null,
   Zona_id   Integer   not null,
   id   Integer   not null,
   NomeComercial   varchar(20)  unique null,
   Morada   varchar(50)   null,
   Localidade   varchar(30)   null,
   CodigoPostal   varchar(8)   null,
   Telefone   varchar(15)   null,
   Email   varchar(40)   null,
   HorarioFuncionamento   varchar(11)   null,
   DataFundacao   DATE   null,
   AceitouEstagiarios   Boolean   null,
   Observacoes   text   null,
   Foto   varchar(255)   null,
 
   constraint PK_Estabelecimento primary key (Empresa_id, id)
);
 
create table Produto
(
   id   Integer   not null,
   Nome   varchar(40)   null,
   Marca   varchar(30)   null,
 
   constraint PK_Produto primary key (id)
);
 
create table Utilizador
(
   id   Integer   not null,
   TipoUtilizador   varchar(20)   null,
   Nome   varchar(40)   null,
   login   varchar(20)  unique null,
   password   varchar(30)   null,
 
   constraint PK_Utilizador primary key (id)
);
 
create table Zona
(
   id   Integer   not null,
   Designacao   varchar(20)   null,
   Localidade   varchar(25)   null,
   Mapa   varchar(255)   null,
 
   constraint PK_Zona primary key (id)
);
 
create table Transportes
(
   id   Integer   not null,
   MeioDeTransporte   varchar(20)   null,
   Linha   varchar(20)   null,
   Observacoes   text   null,
 
   constraint PK_Transportes primary key (id)
);
 
create table MediaEstabelecimento
(
   Estabelecimento_Empresa_id   Integer   not null,
   Estabelecimento_id   Integer   not null,
   AnoLetivo   varchar(9)   not null,
   Media   varchar(2)   null,
 
   constraint PK_MediaEstabelecimento primary key (AnoLetivo)
);
 
alter table EmpresaAtividade
   add constraint FK_Empresa_EmpresaAtividade_Atividade_ foreign key (Empresa_id_)
   references Empresa(id)
   on delete cascade
   on update cascade
; 
alter table EmpresaAtividade
   add constraint FK_Atividade_EmpresaAtividade_Empresa_ foreign key (Atividade_CodigoCAE_)
   references Atividade(CodigoCAE)
   on delete cascade
   on update cascade
;
 
alter table EstabelecimentoProduto
   add constraint FK_Estabelecimento_EstabelecimentoProduto_Produto_ foreign key (Estabelecimento_Empresa_id_, Estabelecimento_id_)
   references Estabelecimento(Empresa_id, id)
   on delete cascade
   on update cascade
; 
alter table EstabelecimentoProduto
   add constraint FK_Produto_EstabelecimentoProduto_Estabelecimento_ foreign key (Produto_id_)
   references Produto(id)
   on delete cascade
   on update cascade
;
 
alter table ZonaTransportes
   add constraint FK_Zona_ZonaTransportes_Transportes_ foreign key (Zona_id_)
   references Zona(id)
   on delete cascade
   on update cascade
; 
alter table ZonaTransportes
   add constraint FK_Transportes_ZonaTransportes_Zona_ foreign key (Transportes_id_)
   references Transportes(id)
   on delete cascade
   on update cascade
;
 
alter table EstabelecimentoTransportes
   add constraint FK_Estabelecimento_EstabelecimentoTransportes_Transportes_ foreign key (Estabelecimento_Empresa_id_, Estabelecimento_id_)
   references Estabelecimento(Empresa_id, id)
   on delete cascade
   on update cascade
; 
alter table EstabelecimentoTransportes
   add constraint FK_Transportes_EstabelecimentoTransportes_Estabelecimento_ foreign key (Transportes_id_)
   references Transportes(id)
   on delete cascade
   on update cascade
;
 
alter table Aluno
   add constraint FK_Aluno_Utilizador foreign key (Utilizador_id)
   references Utilizador(id)
   on delete cascade
   on update cascade
;
 
alter table Administrativo
   add constraint FK_Administrativo_Utilizador foreign key (Utilizador_id)
   references Utilizador(id)
   on delete cascade
   on update cascade
;
 
alter table Formador
   add constraint FK_Formador_Utilizador foreign key (Utilizador_id)
   references Utilizador(id)
   on delete cascade
   on update cascade
;
 
alter table Estagio
   add constraint FK_Estagio_noname_Aluno foreign key (Aluno_Utilizador_id)
   references Aluno(Utilizador_id)
   on delete restrict
   on update cascade
; 
alter table Estagio
   add constraint FK_Estagio_noname_Formador foreign key (Formador_Utilizador_id)
   references Formador(Utilizador_id)
   on delete restrict
   on update cascade
; 
alter table Estagio
   add constraint FK_Estagio_noname_Responsavel foreign key (Responsavel_id)
   references Responsavel(id)
   on delete restrict
   on update cascade
; 
alter table Estagio
   add constraint FK_Estagio_noname_Estabelecimento foreign key (Estabelecimento_Empresa_id, Estabelecimento_id)
   references Estabelecimento(Empresa_id, id)
   on delete restrict
   on update cascade
;
 
alter table Responsavel
   add constraint FK_Responsavel_noname_Estabelecimento foreign key (Estabelecimento_Empresa_id, Estabelecimento_id)
   references Estabelecimento(Empresa_id, id)
   on delete restrict
   on update cascade
;
 
alter table Turma
   add constraint FK_Turma_noname_Curso foreign key (Curso_Codigo)
   references Curso(Codigo)
   on delete cascade
   on update cascade
;
 
 
 
alter table EmpresaDisponibilidade
   add constraint FK_EmpresaDisponibilidade_noname_Empresa foreign key (Empresa_id)
   references Empresa(id)
   on delete restrict
   on update cascade
;
 
 
alter table Estabelecimento
   add constraint FK_Estabelecimento_noname_Empresa foreign key (Empresa_id)
   references Empresa(id)
   on delete cascade
   on update cascade
; 
alter table Estabelecimento
   add constraint FK_Estabelecimento_noname_Zona foreign key (Zona_id)
   references Zona(id)
   on delete restrict
   on update cascade
;
 
 
 
 
 
alter table MediaEstabelecimento
   add constraint FK_MediaEstabelecimento_noname_Estabelecimento foreign key (Estabelecimento_Empresa_id, Estabelecimento_id)
   references Estabelecimento(Empresa_id, id)
   on delete restrict
   on update cascade
;
 
