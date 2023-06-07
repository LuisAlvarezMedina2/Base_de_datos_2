create database defensa_hito4_2023;
use defensa_hito4_2023;

create  table departamento (
    id_dep int  primary key,
    nombre varchar(50)
);

create table provincia(
    id_prov int  primary key,
    nombre varchar(50),
    id_dep int,
    foreign key (id_dep) references departamento(id_dep)
);


create table persona(
    id_per int  primary key,
    nombre varchar(20),
    apellidos varchar(50),
    fecah_nac date,
    edad int,
    email varchar(50),
    id_dep int,
    id_prov int,
    sexo char(1),
    foreign key (id_dep) references departamento(id_dep),
    foreign key (id_prov) references provincia(id_prov)
);
drop table detalle_proyecto;
drop table proyecto;
create table proyecto (
    id_proy int  primary key,
    nombreProy varchar(100),
    tipoProy varchar(30)
);

create table detalle_proyecto(
    id_dp int  primary key,
    id_per int,
    id_proy int,
    foreign key (id_per) references persona(id_per),
    foreign key (id_proy) references proyecto(id_proy)

);

insert into departamento(id_dep, nombre) values (1,'La Paz'),
                                                (2,'Cochabamba');

insert into provincia(id_prov, nombre, id_dep) values (1,'Domingo Murillo',1),
                                                      (2,'Quillacollo',2);

insert into persona(id_per,nombre, apellidos, fecah_nac, edad, email, id_dep, id_prov, sexo)
values (1,'Luis','Alvarez Medina','2004-01-26',19,'LuisAlvarez@gmail.com',2,2,'M'),
       (2,'Carolina','Alanoca Paucara','2000-10-10',23,'CarolinaPucara@gmail.com',1,1,'F');
insert into proyecto(id_proy,nombreProy, tipoProy)
values (1,'Conce y Aprende','Educacion'),
       (2,'Conexion Cultural','Cultura');
insert into detalle_proyecto (id_dp,id_per, id_proy)
values (1,1,1),
       (2,2,2);


create table audit_proyectos(
    id_audit int auto_increment primary key,
    nombre_proy_aterir varchar(30) default 'no existe valor previo',
    nombre_proy_posterior varchar(30) default 'no existe valor previo',
    tipo_proy_anterior varchar(30) default 'no existe valor previo',
    tipo_proy_posterior varchar(30) default 'no existe valor previo',
    operation varchar(30) default 'no existe valor previo',
    userld varchar(30) default 'no existe valor previo',
    hostname varchar(30) default 'no existe valor previo',
    fecha varchar(30) default 'no existe valor previo'

);

   create or replace trigger tr_completa_datos
        after insert #new
        on proyecto
        for each row
        begin

            insert into audit_proyectos ( nombre_proy_aterir, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userld, hostname, fecha)
                select 'no existe valor previo',new.nombreProy,'No existe valor previo',new.tipoProy,'insert',user(),@@hostname,now();
        end;
    create or replace trigger tr_completa_datos_update
        after update #new
        on proyecto
        for each row
        begin

            insert into audit_proyectos ( nombre_proy_aterir, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userld, hostname, fecha)
                select old.nombreProy,new.nombreProy,old.tipoProy,new.tipoProy,'update',user(),@@hostname,now();
        end;
        create or replace trigger tr_completa_datos_delete
        after delete #new
        on proyecto
        for each row
        begin

            insert into audit_proyectos ( nombre_proy_aterir, nombre_proy_posterior, tipo_proy_anterior, tipo_proy_posterior, operation, userld, hostname, fecha)
                select old.nombreProy,'no existe valor posterior',old.tipoProy,'n existe valor posterior','delete',user(),@@hostname,now();
        end;


insert into proyecto(id_proy,nombreProy, tipoProy)
values (3,'Conce y Aprende','Educacion');

update proyecto set nombreProy = 'COCA'where id_proy=3;

delete from proyecto where id_proy=3;

select * from audit_proyectos;




create or replace view reporte_proyecto as
    select concat(pe.nombre,' ',pe.apellidos) as fullname, concat(p.nombreProy,' ',p.tipoProy) as desc_proyecto, d.nombre as departamento,
        (
        case
            when d.nombre = 'La Paz' then 'LPZ'
            when d.nombre = 'Cochabamba' then 'CBB'
            when d.nombre = 'El Alto' then 'EAT'
        else 'no hya departamento'
            end
        ) as codigo_dep from persona pe
join departamento d on d.id_dep = pe.id_dep
join detalle_proyecto dp on pe.id_per = dp.id_per
join proyecto p on dp.id_proy = p.id_proy;

select * from reporte_proyecto;



create or replace trigger noadmite
before insert
    on proyecto
    for each row
    begin
        declare dia text default dayname(current_date);
        declare mes text default monthname(current_date);

       if(new.tipoProy = 'FORESTACION' and dia = 'Wednesday' and mes = 'June'  )then
                signal  sqlstate '45000'
                set MESSAGE_TEXT = 'no se admite inserciones del tipo FORESTACION';
                end if;
    end;

insert into proyecto (id_proy, nombreProy, tipoProy)
values (7,'construccion carretera','FORESTACION')

insert into proyecto (id_proy, nombreProy, tipoProy)
values (7,'construccion carretera','CARRETERAS')


create or replace function diccionarioDias (dia text)
returns text
begin
    declare resp text default '';
    case
            when dia = 'Monday' then set resp='Lunes';
            when dia = 'Tuesday' then set resp='Martes';
            when dia = 'Wednesday' then set resp='Miercoles';
            when dia = 'Thursday' then set resp='Jueves';
            when dia = 'Friday' then set resp='Viernes';
            when dia = 'Saturday' then set resp='Sabado';
            when dia = 'Sunday' then set resp='Domingo';
    else
    set resp = 'Dia no encontrado';
    end case;
    return resp;
end;

select diccionarioDias('Monday');
select diccionarioDias('Tuesday');
select diccionarioDias('Wednesday');
