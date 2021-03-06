        ��  ��                  e  0   T X T   D O M A I N         0         create domain dSimNao as char(1) default 'N' check (value in ('S', 'N'));
create domain dVarchar2 as varchar(2);
create domain dVarchar3 as varchar(3);
create domain dVarchar10 as varchar(10);
create domain dVarchar20 as varchar(20);
create domain dVarchar50 as varchar(50);
create domain dVarchar80 as varchar(80);
create domain dVarchar100 as varchar(100);
create domain dCodigo as integer;
create domain dData as Date default current_date;
create domain dDataHora as timestamp default current_timestamp;
create domain dEmpresa as char(1) default '0' check (value in ('0', '1', '2'));

Commit work;   -   4   T X T   S E Q U E N C E         0         Create sequence Seq_Parceiro;
Commit work;
   �  0   T X T   E M P R E S A       0         Create table Empresa(
id_Empresa dcodigo primary key,
nomefantasia dVarchar100 not null,
rsocial dVarchar100 not null,
cgc dvarchar20,
ie dvarchar20,
criada ddata,
email dvarchar50,
telefone1 dvarchar20,
telefone2 dvarchar20,
Endereco dvarchar50,
cidade dvarchar50,
complemento dvarchar50,
bairro dvarchar20,
uf dvarchar2,
cep dvarchar20,
Ativo dsimnao,
TipoEmpresa dEmpresa);

Commit work;
 �  4   T X T   P A R C E I R O         0         Create table Parceiro(
id_Parceiro dcodigo primary key,
nome dvarchar50 not null,
cgc dvarchar20,
rg dvarchar10,
nascimento ddata,
email dvarchar50,
telefone1 dvarchar20,
telefone2 dvarchar20,
NomeConjuge dvarchar50,
cpfConjuge dvarchar20,
Ativo dsimnao,
Endereco dvarchar50,
complemento dvarchar20,
bairro dvarchar20,
cidade dvarchar50,
uf dvarchar2,
cep dvarchar20 );

Commit work;
