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

show triggers;


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



    create or replace trigger creaciondepasswordafter
        after insert
        on usuarios
        for each row
        begin

            update usuarios set passsword =
                concat(substr(new.nombres,1,2),substr(new.apellidos,1,2),new.edad)
                            where last_insert_id(id_usr);
        end;
#last_insert_id();  nso permite obtener el ultimo id ingresado
select *from usuarios;
insert into usuarios(nombres, apellidos, edad, corre) values ('JUAN','APAZA',21,'jhonnymamani@gmail.com');




create or replace table usuarios(
    id_usr bigint auto_increment primary key not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    fecha_Nac date not null,
    corre varchar(100) not null,
    passsword varchar(100),
    edad int

);


insert into usuarios(nombres, apellidos, fecha_Nac, corre) VALUES ('JUAN','APAZA','2004/01/20','jhonnymamani@gmail.com');

  create or replace trigger creaciondepasswordedad
        before insert
        on usuarios
        for each row
        begin
            set NEW.passsword = lower (concat(substr(new.nombres,1,2),substr(new.apellidos,1,2)));
            set new.edad= timestampdiff(year, new.fecha_Nac,curdate());

        end;

drop trigger creaciondepasswordedad


select * from usuarios;


  create or replace trigger nuevopassword
        before insert
        on usuarios
        for each row
        begin
            declare cnt varchar(100) default new.passsword;
            set new.edad= timestampdiff(year, new.fecha_Nac,curdate());

           if(char_length(new.passsword)<=10) then
            set new.passsword = lower(concat(substr(cnt,-2,2),substr(new.nombres,-2,2),substr(new.apellidos,-2,2),new.edad)) ;
           end if;

        end;

insert into usuarios(nombres, apellidos, fecha_Nac, corre,passsword) VALUES ('JUAN','APAZA','2004/01/20','jhonnymamani@gmail.com','12345678');

select * from usuarios;

select dayname(current_date);

insert into usuarios(nombres, apellidos, fecha_Nac, corre) VALUES ('JUAN','APAZA','2004/01/20','jhonnymamani@gmail.com');




create or replace table usuarios(
    id_usr bigint auto_increment primary key not null,
    nombres varchar(100) not null,
    apellidos varchar(100) not null,
    fecha_Nac date not null,
    corre varchar(100) not null,
    passsword varchar(100),
    edad int

);

alter table usuarios add column naionalidad varchar(100);

select * from usuarios;


create or replace trigger nopermitechilenos
    before insert
    on usuarios
    for each row
    begin
        declare vernacionalidad text default new.naionalidad;
            declare cnt varchar(100) default new.passsword;
            set new.edad= timestampdiff(year, new.fecha_Nac,curdate());

           if(char_length(new.passsword)<=10) then
            set new.passsword = lower(concat(substr(cnt,-2,2),substr(new.nombres,-2,2),substr(new.apellidos,-2,2),new.edad)) ;
           end if;

            if(vernacionalidad != 'Paraway' or vernacionalidad !='Bolivia' or vernacionalidad !='Argentina')then
                signal  sqlstate '45000'
                set MESSAGE_TEXT = 'BASE DE DATOS EBN MANTENIMIENTO';
                end if;
    end;


insert into usuarios(nombres, apellidos, fecha_Nac, corre,naionalidad,passsword) VALUES ('JUAN','APAZA','2004/01/20','jhonnymamani@gmail.com','chile','12345678');
select * from usuarios;


create table audit_usuarios_rhh
(
    fecha_mod text not null ,
    usuario_log text not null ,
    hostname text not null,
    accion text not null,
    ci text not null ,
    fullname text not null ,
    passsword text not null


);

create table audit_usuarios_rrhh
  (
      fecha_mod text not null ,
      usuario_log text not null ,
      hostname text not null ,
      acccion text not null ,

      id_usr text not null ,
      nombre_completo text not null ,
      password text not null
  );

create table usuarios_rrhh(
    id_usr integer primary key not null ,
    nombre_completo varchar(50) not null ,
    fecha_nac date not null ,
    correo varchar(100)not null ,
    pasword varchar(100)
);

insert into usuarios_rrhh(id_usr, nombre_completo, fecha_nac, correo, pasword)
values (9210838,'Nilber Mayta Cuno','2003/09/18','nilberrmayta@gmail.com','9210838');

select * from usuarios_rrhh;


create trigger tr_audit_usuarios_rrhh
    after delete
    on usuarios_rrhh
    for each row
    begin
        declare id_usuario text;
        declare nombres text;
        declare user_password text;

        set id_usuario = OLD.id_usr;
        set nombres = OLD.nombre_completo;
        set user_password = OLD.pasword;

        insert into audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, acccion, id_usr, nombre_completo, password) select
        now(),user(),@@hostname,'DELETE',id_usuario,nombres,user_password;
    end;

insert into usuarios_rrhh(id_usr, nombre_completo, fecha_nac, correo, pasword)
values (92108788,'Pepe Mayta Cuno','2003/09/18','nilberrmayta@gmail.com','9210838');

select * from usuarios_rrhh;

delete from usuarios_rrhh
where id_usr =  92108788;

select * from audit_usuarios_rrhh;
-- triguers de auditoria


select current_date; -- permite obtener la fecha actual

select now(); --  esto obtiene la fecha actual y la hora


-- permite obtener el usuario logueado

select user();

-- me permite obtener el host name

select @@hostname;

-- este comando me permite ver todas las variables de la base de datos
show variables;

-- la auditoria es erar una tabla de auditoria para ver un registro de modificaciones lo que nos permite monitorear el registro de actividad



create trigger tr_audit_usuarios_rrhh_registrar
    after insert
    on usuarios_rrhh
    for each row
    begin

        insert into audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, acccion, id_usr, nombre_completo, password) select
        now(),user(),@@hostname,'ingreso',new.id_usr,new.nombre_completo,new.pasword;
    end;


insert into usuarios_rrhh(id_usr, nombre_completo, fecha_nac, correo, pasword)
values (9210835,'Nilber Mayta Cuno','2003/09/18','nilberrmayta@gmail.com','9210838');

select * from audit_usuarios_rrhh;

create table audit_usuarios_rrhh
  (
      fecha_mod text not null ,
      usuario_log text not null ,
      hostname text not null ,
      acccion text not null ,

      antes_del_cambio text not null ,
      despues_del_cambio text not null
  );

create table usuarios_rrhh(
    id_usr integer primary key not null ,
    nombre_completo varchar(50) not null ,
    fecha_nac date not null ,
    correo varchar(100)not null ,
    pasword varchar(100)
);


create or replace trigger tr_audit_usuarios_rrhh_registrar_si
    after update
    on usuarios_rrhh
    for each row
    begin
        declare antes text default concat(old.id_usr,old.nombre_completo,OLD.fecha_nac);
          declare despues text default concat(new.id_usr,new.nombre_completo,new.fecha_nac);
    insert into audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, acccion, antes_del_cambio, despues_del_cambio) select
        now(),user(),@@hostname,'update',antes,despues;


    end;
select * from usuarios_rrhh;
update usuarios_rrhh set nombre_completo = 'luis Alvarez' where id_usr = 9210838;
select *
from audit_usuarios_rrhh;


create or replace procedure inserta_datos(fecha text,usuario text,hostname text,accion text,antes text,despues text
)
begin

     insert into audit_usuarios_rrhh(fecha_mod, usuario_log, hostname, acccion, antes_del_cambio, despues_del_cambio)
     values (fecha,usuario,hostname,accion,antes,despues);



end;


create or replace trigger tr_audit_usuarios_rrhh_registrar_si
    after update
    on usuarios_rrhh
    for each row
    begin
        declare antes text default concat(old.id_usr,old.nombre_completo,OLD.fecha_nac);
          declare despues text default concat(new.id_usr,new.nombre_completo,new.fecha_nac);
    call inserta_datos( now(),user(),@@hostname,'update',antes,despues); # call es para llamar a los procedimientos almacenados
    end;

update usuarios_rrhh set nombre_completo = 'relleno de postre' where id_usr = 9210838;
select *
from audit_usuarios_rrhh;
