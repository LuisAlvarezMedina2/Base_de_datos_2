create database HIto4_2023;
use HIto4_2023;

create table numeros(
  numero BIGINT primary key not null,
  cuadrado Bigint,
  cubo Bigint,
  raiz_cadrada REAL


);

insert into numeros(numero) values (2);
select * from numeros;

    create or replace trigger tr_completa_datos
        before insert #new
        on numeros
        for each row
        begin
            declare valor_cuadrado BIGINT;
            declare valor_cubo BIGINT;
            declare valor_raiz REAL;

            set valor_raiz = sqrt(new.numero);
            set valor_cuadrado = power(new.numero,2);
            set valor_cubo = power(new.numero,3);

            set NEW.cuadrado = valor_cuadrado;
            set NEW.cubo = valor_cubo;
            set NEW.raiz_cadrada = valor_raiz;
        end;
insert into numeros(numero) values (4);
insert into numeros(numero) values (10);
update numeros set numero = 8 where numero = 6;
select * from numeros;

show triggers ;


truncate table numeros;
alter table numeros add
    sumaTodo REAL;


    create or replace trigger tr_completa_datos
        before insert #new
        on numeros
        for each row
        begin
            declare valor_cuadrado BIGINT;
            declare valor_cubo BIGINT;
            declare valor_raiz REAL;
            declare valor_sumar REAL;

            set valor_raiz = sqrt(new.numero);
            set valor_cuadrado = power(new.numero,2);
            set valor_cubo = power(new.numero,3);
            set valor_sumar = valor_raiz + valor_cubo + valor_cuadrado + new.numero;

            set NEW.cuadrado = valor_cuadrado;
            set NEW.cubo = valor_cubo;
            set NEW.raiz_cadrada = valor_raiz;
            set NEW.sumaTodo = valor_sumar;

        end;


insert into numeros(numero) values (2);
insert into numeros(numero) values (3);
select *
from numeros;


create or replace table usuarios(
    id_usr bigint auto_increment primary key not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    edad int not null,
    corre varchar(100) not null,
    passsword varchar(100)




);


    create or replace trigger creaciondepassword
        before insert
        on usuarios
        for each row
        begin
            set NEW.passsword = lower (concat(substr(new.nombres,1,2),substr(new.apellidos,1,2),new.edad));
        end;

insert into usuarios(nombres, apellidos, edad, corre) values ('Luis','Alvarez',19,'luisAlvarez@gmail.com');
insert into usuarios(nombres, apellidos, edad, corre) values ('jhonny','Mamani',21,'jhonnymamani@gmail.com');
insert into usuarios(nombres, apellidos, edad, corre) values ('JUAN','APAZA',21,'jhonnymamani@gmail.com');

select * from usuarios;









