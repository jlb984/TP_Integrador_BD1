DELIMITER |

 CREATE PROCEDURE abm_estacion_vehiculosa(IN chasis int,
out nResultado int, out chasis_ocupando int, cMensaje
varchar(50) )
 BEGIN
 declare estacion int;
 declare estacion_siguiente int;
 declare cantidad_estaciones int;
 declare linea int;
 declare modelo int;
 declare estado int;


 select count(*) into estacion from estacion_vehiculo ev where
ev.vehiculo_id_chasis = chasis;
 select modelo_id_modelo into modelo from vehiculo where
id_chasis = chasis;
 select id_linea into linea from linea_montaje where
modelo_id_modelo=modelo;
 if linea = 2 then
 set estacion = estacion + 5;
 end if;
 set estacion_siguiente = estacion+1;

 if estacion = 0 or estacion = 5 then
 select count(*) into estado from estacion_vehiculo ev where
ev.estacion_trabajo_id_estacion = estacion_siguiente and
ev.egreso is null;
 else
 set nResultado = -1;
 set cMensaje = 'El automovil ya se inicializo';
 set estado = -1;
 end if;

 if estado = 0 then
 insert into estacion_vehiculo values (chasis, estacion_siguiente,
curdate(), null);
 elseif estado = 1 then
 set nResultado = -1;
 set cMensaje = 'Estacion ocupada';
 select vehiculo_id_chasis into chasis_ocupando from
estacion_vehiculo ev where ev.estacion_trabajo_id_estacion =
estacion_siguiente and
ev.egreso is null;
 end if;

END
|
 PUNTO 10
DELIMITER |

 CREATE PROCEDURE abm_estacion_vehiculosaa(IN
chasis int, out nResultado int, out chasis_ocupando int,
cMensaje varchar(50) )
 BEGIN
 declare estacion_actual int;
 declare estacion_siguiente int;
 declare cantidad_estaciones int;
 declare linea int;
 declare modelo int;
 declare estado int;


 select count(*) into estacion_actual from
estacion_vehiculo ev where ev.vehiculo_id_chasis =
chasis;
 select modelo_id_modelo into modelo from vehiculo
where id_chasis = chasis;
 select id_linea into linea from linea_montaje where
modelo_id_modelo=modelo;
 if linea = 2 then
 set estacion_actual = estacion_actual + 5;
 end if;
 set estacion_siguiente = estacion_actual+1;
 if estacion_actual != 5 and estacion_actual != 10 then
 select count(*) into estado from estacion_vehiculo ev
where ev.estacion_trabajo_id_estacion =
estacion_siguiente and
ev.egreso is null;
 else
 set estado = -1;
 set cMensaje = 'El automovil todabia no se inicializo';
 set nResultado = -1;
 end if;

 select count(*) into cantidad_estaciones from
estacion_trabajo where linea_id_linea = linea;

 if estado = 0 and estacion_actual < cantidad_estaciones
then
 update estacion_vehiculo set egreso = curdate() where
vehiculo_id_chasis = chasis and
estacion_trabajo_id_estacion = estacion_actual;
 insert into estacion_vehiculo values (chasis,
estacion_siguiente, curdate(), null);
 set nResultado = 0;
 elseif estado = 0 and estacion_actual <
(cantidad_estaciones+5) and estacion_actual !=5 then
 update estacion_vehiculo set egreso = curdate() where
vehiculo_id_chasis = chasis and
estacion_trabajo_id_estacion = estacion_actual;
 insert into estacion_vehiculo values (chasis,
estacion_siguiente, curdate(), null);
 set nResultado = 0;
 elseif estado = 1 then
 select vehiculo_id_chasis into chasis_ocupando from
estacion_vehiculo ev where
ev.estacion_trabajo_id_estacion = 9 and
ev.egreso is null;
set nResultado = -1;
set cMensaje = 'Estacion ocupada';
end if;
if linea = 1 and estacion_actual = 5 then
update estacion_vehiculo set egreso = curdate() where
vehiculo_id_chasis = chasis and
estacion_trabajo_id_estacion = estacion_actual;
set cMensaje = 'Vehiculo terminado';
set nResultado = 0;
elseif linea = 2 and estacion_actual = 10 then
update estacion_vehiculo set egreso = curdate() where
vehiculo_id_chasis = chasis and
estacion_trabajo_id_estacion = estacion_actual;
set cMensaje = 'Vehiculo terminado';
set nResultado = 0;
end if;

END
|

select id_chasis, modelo_id_modelo, pedido_id_pedido, ingreso, egreso from vehiculo v
left join estacion_vehiculo ev on ev.vehiculo_id_chasis=v.id_chasis
where id_chasis=22;
call abm_estacion_vehiculosa(22, @nResultado, @chasis_ocupando, @cMensaje)


select * from vehiculo
where id_chasis=21;