create domain dSimNao as char(1) default 'N' check (value in ('S', 'N'));
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

Commit work;