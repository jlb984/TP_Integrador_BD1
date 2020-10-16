-- EJERCICIO 9 SEGUNDA ETAPA

DELIMITER |

 CREATE PROCEDURE inicio_vehiculo(IN chasis int, OUT cMensaje varchar(50), OUT nResultado int )
 proc: BEGIN
 declare estacion int default 0;
 declare estacion_ocupada int default 0;
 declare linea int;
 declare modelo int;
 declare estado int default 0;

-- compruebo si chasis tiene registros en estacion_vehiculo
 select count(*) into estado from estacion_vehiculo ev where
ev.vehiculo_id_chasis = chasis;
-- si estado es mayor a 0, mensaje --> vehiculo ya iniciado
-- salir del procedimiento
if estado>0 then
	set nResultado = -1;
	set cMensaje = 'El automovil ya se iniciado';
    leave proc;
end if;
    
 -- leo modelo del vehiculo para identificar linea de montaje   
select modelo_id_modelo into modelo from vehiculo where
id_chasis = chasis;
select id_linea into linea from linea_montaje where
modelo_id_modelo=modelo;

-- comprobar si 1° estacion de la linea esta ocupada (linea 1 -->estacion 1 , linea 2 --> estacion 6)
-- si esta ocupada sale del procedimiento
 if linea = 1 then
	set estacion = 1;
else 
	set estacion = 6;
 end if;
 
 select count(*) into estacion_ocupada from estacion_vehiculo ev where
ev.estacion_trabajo_id_estacion = estacion and
ev.egreso is null and ingreso is not null;
if estacion_ocupada>0 then
 set nResultado = -1;
 set cMensaje = 'Estacion Inicial Ocupada, vuelva a intentar';
 leave proc;
 end if;

 insert into estacion_vehiculo values (chasis, 1,
now(), null);
 set nResultado = 0;
 set cMensaje = 'Vehiculo Iniciado con exito';
 
 select id_chasis as Num_Chasis, modelo_id_modelo as Modelo, pedido_id_pedido as pedido,  estacion_trabajo_id_estacion as estacion , ingreso, egreso from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
where estacion_trabajo_id_estacion = estacion;

END
|


-- me fijo si estacion 1 esta vacia
select * from estacion_vehiculo ev where
ev.estacion_trabajo_id_estacion = 1 and
ev.egreso is null and ingreso is not null;

-- veo todos los registros de estacion 1
select * from estacion_vehiculo where estacion_trabajo_id_estacion = 1;

-- veo vehiculo chasis N°16
select * from vehiculo where id_chasis=16;

-- compruebo registros de ingreso y egreso de chasis N°16
select id_chasis, modelo_id_modelo, pedido_id_pedido, ingreso, egreso from vehiculo v
left join estacion_vehiculo ev on ev.vehiculo_id_chasis=v.id_chasis
where id_chasis=16;

-- llamo a procedimiento y veo mensajes
call inicio_vehiculo(16, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
-- vuelvo a comprobar registros
