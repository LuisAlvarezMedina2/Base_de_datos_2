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

select numeros1(8);



create or replace function dowhile (x int)
    returns text
    begin

    declare  str text default '';

    REPEAT
    set str= concat(str,x,',');
    set x = x-1;
    until x <= 0 end REPEAT ;
    return str;


    end;

select dowhile(10);

create or replace function dowhileletra (x int)
    returns text
    begin
declare  str text default '';
 declare a text default 'A';
 declare b text default 'B';
    REPEAT

    if(x%2=0) then
        set str= concat(str,x,'-',a,a,'-',',');
        set x = x-1;
    else
        set str= concat(str,x,'-',b,b,'-',',');
        set x = x-1;
        end if;
    until x <= 0 end REPEAT ;
    return str;


    end;

select dowhileletra(10);






create or replace function manejoDeLoop_label (x int)
    returns text
    begin
    declare str text default '';
    dbail: LOOP
    if x>0 then
    leave dbail;/* andate*/
    end if;
    set str= concat(str,x,',');
    set x=x+1;
    iterate dbail; /*seguinomas*/
    end loop;
    return str;
    end;
select manejoDeLoop_label(-10);


create or replace function manejoDeLoop_labelletra (x int)
    returns text
    begin
    declare str text default '';
    dbail: LOOP
    if x>0 then
    leave dbail;/* andate*/
    end if;
    if(x%2=0) then
        set str= concat(str,x,'-AA-',',');

    else
        set str = concat(str,x,'-BB-',',');

     end if;
    set x=x+1;
    iterate dbail; /*seguinomas*/
    end loop;
    return str;
    end;

    select manejoDeLoop_labelletra(-10);

create or replace function estatusdelcliente (credit_namber integer)
    returns text
    begin
    declare str text default '';
    if  credit_namber >50000 then set  str = 'PLATINUM';
    end if;
    if(credit_namber>=10000 and credit_namber<=50000) then set str = 'GOLD';
    end if;
    if(credit_namber<10000) then set str='SILVER';
    end if;
    return str;
    end;


select estatusdelcliente(-5);
select estatusdelcliente(20000);
select estatusdelcliente(50001);


    #uso de charlength
    #cuanos caracteres tiene una palabra hola = 4

select char_length('BDAII') ; # -> 5 palabras
select char_length('BDAII 2023'); # -> 10 palabras
select char_length(' BDAII 2023 '); # -> 12 palabras



create or replace function validaLegth_7(password text)
returns text
begin
    declare res text default '';
    if char_length(password)>7 then
        set res = 'PASSED';
    else
        set res = 'FAILD';
    end if ;
    return res;
end;


select validaLegth_7('123456');



# comparacion de cadenas
# si dos cadenas son iguales
# DBAII = DBAII ? true
# DBAII = DBAI ? false



select strcmp('DBAII', 'DBA2023');# retorna 1 o -1 porque es falso (no son iguales)
select strcmp('DBAII', 'DBAII'); # retorna 0 porque es verdadero
select strcmp('dbaii', 'DBAII'); # no existe destincion entre mayusculas y minusculas

create or replace function determinaigualdad(cadena1 text,cadena2 text)
returns text
begin
    declare res text default '';
    if strcmp(cadena1,cadena2)=0 then
        set res = 'son iguales';
    else
        set res = 'no son iguales';
    end if ;
    return res;
end;

select determinaigualdad('BDAII','BDA2023');
select determinaigualdad('BDAII','BDAII');



# en base a las dosfunciones anteriores
# recibir dos cadenas en la fncion si las dos cadenas son ifuales y ademas el length es mayor a 10
# retornar el mensaje VALIDO caso contraio retornar no valido



create or replace function determinaigualdadv1(cadena1 text,cadena2 text)
returns text
begin
    declare res text default '';
    if strcmp(cadena1,cadena2)=0 and char_length(concat(cadena1,cadena2))>15  then
        set res = 'es valido';
    else
        set res = 'no es valido';
    end if ;
    return res;
end;

select determinaigualdadv1('DBAII-2023','DBAII-2023');




select substr('DBAII 2023 Unifranz',7); # le cortamos de donde queramos siepre uno despues
select substr('Hola',3);

select substr('DBAII 2023 Unifranz',7,4);# la priemra coma desde donde inicia el texto que no se cortara la segunda coma es cuantos espacios tiene la letra que no cortaremos

select substr('DBAII 2023 Unifranz'from 7 for 4);
select substr('DBAII 2023 Unifranz',-9 );
select substr('DBAII 2023 Unifranz', -13 , 4); # contar desde la derecha a izquierda

select locate('2023','Base de Datos II, gestion 2023 Unifranz 2023',28);# cuenta de donde incia la cade que bsucamos donde solo encuentra el primer datos


create or replace function localizador(cadena1 text,cadena2 text)
    returns text
begin
    declare res text default '';
    DECLARE LOCALIZADOR INTEGER DEFAULT locate(cadena2,cadena1);
    if(LOCALIZADOR>0) then
        set res = concat( 'Si exste: ',LOCALIZADOR);
    else
        set res = 'no existe';
    end if;
        return res;
end;

select localizador('13644437LP','Lp');


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

select numeros1(8);





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

create or replace function cadenanumero(cadena1 text , numero integer)

returns text
begin
    declare resp text default '';
    declare cont integer default 0;
    while (cont < numero) do
        set resp = concat(resp,cadena1,',');
        set cont = cont+1;
        end while;
    return resp;
end;

select cadenanumero('DBAII',3);










