        ��  ��                    0   T X T   D O M A I N         0         create domain dSimNao as char(1) default 'N' check (value in ('S', 'N'));
create domain dVarchar2 as varchar(2);
create domain dVarchar3 as varchar(3);
create domain dVarchar10 as varchar(10);
create domain dVarchar20 as varchar(20);
create domain dVarchar50 as varchar(50);
create domain dVarchar80 as varchar(80);
create domain dVarchar100 as varchar(100);
create domain dCodigo as integer;
create domain dData as Date default current_date;
create domain dDataHora as timestamp default current_timestamp;   4   T X T   S E Q U E N C E         0         Create sequence Seq_Parceiro;
 i  4   T X T   P A R C E I R O         0         Create table Parceiro(
id_Parceiro dcodigo primary key,
nome dvarchar50 not null,
cpfCnpj dvarchar20,
nascimento ddata,
email dvarchar50,
telefone1 dvarchar20,
telefone2 dvarchar20,
NomeConjuge dvarchar50,
cpfConjuge dvarchar20,
Ativo dsimnao,
Logradouro dvarchar50,
complemento dvarchar20,
bairro dvarchar20,
cidade dvarchar50,
uf dvarchar2 );
   