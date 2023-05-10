create database defensa_hito3_2023;
use defensa_hito3_2023;

create or replace function elimina_consonantes_y_numerosv1(cadena varchar(100))
returns text
begin
    declare resp text default '';
    declare puntero char;
    declare cont int default 1;
    WHILE (cont <= char_length(cadena)) do
        set puntero = substr(cadena,cont,1);
        if(puntero = 'a' OR puntero = 'e' oR puntero = 'i' OR puntero = 'o' OR puntero = 'u')then
            set  resp = concat(resp,puntero);
            end if;
          IF(puntero = ' ') THEN
                SET resp = CONCAT(RESP,' ');
            end if;
        set cont = cont+1;
        end while;
return resp;
end;
select elimina_consonantes_y_numerosv1('base de datos ii 2023');
select elimina_consonantes_y_numerosv1('bbbbbbbbbbbbbbb');
select elimina_consonantes_y_numerosv1('65654512023');
select elimina_consonantes_y_numerosv1('ae io u');


create table CLientes(
    id_clientes integer auto_increment primary key,
    fullname varchar(20),
    last_name varchar(20),
    age int,
    genero char(1) # m o f

);

insert into CLientes (fullname, last_name, age, genero)values
                                                           ('Luis','Alvarez',19,'m'),
                                                           ('Yamiley','Lipe',20,'f'),
                                                           ('Eddy','Mamani',21,'m');


create or replace function edadMaximaClientes()
returns int
begin
    declare resp int default 0;
    select MAX(age) into resp from CLientes;

    return resp;
end;

select edadMaximaClientes();

create or replace function ParesImpares()
    returns text
    begin
        declare resp text default '';
        declare par int default 0;
        declare impar int default edadMaximaClientes();
        if edadMaximaClientes() % 2 = 0 then
                pares: loop
                if par > edadMaximaClientes() then
                    leave pares;
                end if;
                if par % 2 = 0 then
                    set resp = concat(resp,par,',');
                end if;
                set par = par+1;
                iterate pares;
            end loop;
            else
                impares: LOOP
                    if impar<0 then
                        leave impares;/* andate*/
                        end if;
                    if impar % 2 != 0 then
                        set resp= concat(resp,impar,',');
                        end if;
                    set impar=impar-1; /*seguinomas*/
                    iterate impares;
                    end loop;
            end if;
        return resp;
  end;


select ParesImpares();


create or replace function ParesImpares()
    returns text
    begin
        declare resp text default '';
        declare par int default 0;
        declare impar int default 20;
        if 20 % 2 = 0 then
            pares: loop
                if par > 20 then
                    leave pares;
                end if;
                if par % 2 = 0 then
                    set resp = concat(resp,par,',');
                end if;
                set par = par+1;
                iterate pares;
            end loop;
            else
                impares: LOOP
                    if impar<0 then
                        leave impares;/* andate*/
                        end if;
                    if impar % 2 != 0 then
                        set resp= concat(resp,impar,',');
                        end if;
                    set impar=impar-1; /*seguinomas*/
                    iterate impares;
                    end loop;
            end if;
        return resp;
  end;

select ParesImpares();



create or replace function serieFivonacci(numero int)
returns TEXT
begin
    declare respuesta TEXT default '';
    declare cont int default 1;
    declare numR int default 0;
    declare num1 int default 0;
    declare num2 int default 1;

    while(numero >= cont) do
    set respuesta = concat(respuesta,num1,',');
    set numR = num1+num2;
    set num1 = num2 ;
    set num2 = numR ;
    set cont = cont+1;

    end while;
    return respuesta;
end;

select serieFivonacci(0);


create or replace function remplazaCadenas(cadenaPrincipal varchar(100),valorRempl varchar(100),newValor varchar(100))
returns text
begin
    declare resp text default '';
    declare salir int default locate(valorRempl,cadenaPrincipal);
    declare cortar1 text default '';
    declare cortar2 text default '';
     set cortar1 = substr(cadenaPrincipal,-salir);
    set cortar2 = substr(cadenaPrincipal,1,salir-1);
    set resp = concat(resp,cortar2,newValor,', ',newValor,cortar1);
    return resp;
end;
select remplazaCadenas('Bienvenidos a UNIFRANz, UNIFRANZ tiene 10 carrs','UNIFRANZ','UNIVALLE');




create or replace function alreves(cadena1 varchar(100))
returns text
begin
    declare resp varchar default'';
    declare puntero char;
    declare cont int default char_length(cadena1);
    declare cont2 int default 1;
    repeat
        set puntero = substr(cadena1,-cont,cont2);
        set resp = concat(resp,puntero,',');
        set cont = cont-1;
    until cont = 0  end repeat;
    return resp;
end;









create or replace function darlavuelta(cadena1 varchar(100))
returns TEXT
begin
    return reverse(cadena1);
end;


create or replace function darlavuelta(cadena1 varchar(100))
returns TEXT
begin
    declare resp text default '';
    declare puntero varchar(100);
    declare cont int default char_length(cadena1);
    repeat
        set puntero = substr(cadena1,-cont,1);
        set resp = concat(puntero,resp);
        set cont = cont-1;
    until cont = 0  end repeat;
    return resp;
end;
select darlavuelta('HOLA');
select darlavuelta('2033');

