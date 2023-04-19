create database hito3_2023;
use hito3_2023;

set @usuario = 'GUEST';
set @locacion = 'El Alto';
select @usuario;
select @locacion;


create or replace function variable()
returns text
begin
    return @usuario;
end;

select variable();

set @Hito_3 = 'ADMIN';

create or replace function validaUsuario()
returns varchar(100)
begin
    declare respuesta varchar(100);
    if@Hito_3 = 'ADMIN' then
      set respuesta='Usuario Admin';
    else
        set respuesta= 'Usuario invitado';
    end if;
return respuesta;
end;
select validaUsuario();


create or replace function validaUsuario1()
returns varchar(100)
begin
    declare respuesta varchar(100);
   case @Hito_3
       when 'ADMIN' then set respuesta='Usuario Admin';
        else set respuesta='Usuario Invitado';
    end case;

return respuesta;
end;

select validaUsuario1();



create or replace function numerosNaturales(limite int)

returns text
begin
declare cont int default 1;
declare respuesta text default '';

    while cont <= limite do
        set respuesta = concat(respuesta,cont, ',');
        set cont = cont+1;
       end while;

return respuesta;
end;


select numerosNaturales(10);

create or replace function numerosNaturales1(limite int)

returns text
begin
declare cont int default 2;
declare respuesta text default '';

    while cont <= limite do
        set respuesta = concat(respuesta,cont, ',');
        set cont = cont+2;
       end while;

return respuesta;
end;

select numerosNaturales1(10);



create or replace function numeros1(limite int)

returns text
begin
declare cont int default 1;
declare respuesta text default '';
declare imp int default 1;
declare par int default 2;
    while cont <= limite do
        if (cont % 2 != 0) then
            set  respuesta= concat(respuesta,par,',');
            set  par = par+2;
            else
            set respuesta = concat(respuesta,imp,',');
            set imp=imp+2;
        end if;

        set cont = cont+1;
       end while;

return respuesta;
end;

select numeros1(8)