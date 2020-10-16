-- EJERCICIO 10 SEGUNDA ETAPA

DELIMITER |
 CREATE PROCEDURE avanzo_vehiculo(IN chasis int, OUT cMensaje varchar(100), OUT nResultado int )
 proc: BEGIN
 declare estacion_actual int default 0;
 declare estacion_siguiente int default 0;
 declare estacion_ocupada int default 0;
 declare orden int;
 declare linea int;
 declare modelo int;
 declare estado int default 0;
 
 -- guardo estacion actual
 select estacion_trabajo_id_estacion into estacion_actual from estacion_vehiculo
 where vehiculo_id_chasis=chasis and egreso is null;

-- leo modelo del vehiculo para identificar linea de montaje  y orden de estacion 
select modelo_id_modelo into modelo from vehiculo where
id_chasis = chasis;
select id_linea into linea from linea_montaje where
modelo_id_modelo=modelo;
select tarea_id_tarea into orden from estacion_trabajo
where id_estacion=estacion_actual;


-- compruebo estacion siguiente o si es fin de linea
if orden<5 then
	if linea=1 then
		set estacion_siguiente=orden+1; -- linea 1, estaciones de 1 a 5
	else
		set estacion_siguiente=orden+1+5; -- linea 2, estaciones de 6 a 10
	end if;
else  -- si orden(tarea) no es menor a 5 significa que se esta en  la ultima tarea de la linea
	update estacion_vehiculo set egreso = now() 
    where vehiculo_id_chasis=chasis and estacion_trabajo_id_estacion=estacion_actual;
    set nResultado = 0;
	set cMensaje = 'Vehiculo A Llegado al fin de la linea y ha sido completado';
	leave proc;
end if;

-- compruebo si estacion_siguiente esta vacia, caso contrario declaro mensaje y salgo
 select count(*) into estado from estacion_vehiculo  where
 estacion_trabajo_id_estacion=estacion_siguiente and egreso is null;
-- si estado es mayor a 0, mensaje --> estacion ocupada
-- salir del procedimiento
if estado>0 then
	set nResultado = -1;
	set cMensaje = 'La estacion siguiente se encuentra ocupada, espere y vuelva a intentarlo';
    leave proc;
end if;

    
 -- si estacion_siguiente esta libre ...
	-- cerramos estacion actual
if estado=0 then
    update estacion_vehiculo set egreso = now() 
    where vehiculo_id_chasis=chasis and estacion_trabajo_id_estacion=estacion_actual
    limit 1;
    
    -- iniciamos vehiculo en estacion siguiente
	insert into estacion_vehiculo values (chasis, estacion_siguiente,curdate(), null);
-- finalizamos con exito
 set nResultado = 0;
 set cMensaje = 'Vehiculo Avanzado con exito';
 end if;

END
|

-- vacio estacion 2
update estacion_vehiculo set egreso = now()
where vehiculo_id_chasis=9 and estacion_trabajo_id_estacion=3;

-- me fijo si estacion 2 esta vacia
select * from estacion_vehiculo ev where
ev.estacion_trabajo_id_estacion = 9 and
ev.egreso is null and ingreso is not null;


-- veo todos los registros de estacion 2
select * from estacion_vehiculo where estacion_trabajo_id_estacion = 9;

-- veo vehiculo chasis N°16
select * from vehiculo where id_chasis=16;

-- compruebo registros de ingreso y egreso de chasis N°16
select id_chasis, modelo_id_modelo, pedido_id_pedido, estacion_trabajo_id_estacion as estacion, ingreso, egreso from vehiculo v
left join estacion_vehiculo ev on ev.vehiculo_id_chasis=v.id_chasis
where id_chasis=15;

-- llamo a procedimiento y veo mensajes
call avanzo_vehiculo(15, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
-- vuelvo a comprobar registros

select * from estacion_trabajo;
select count(*) from estacion_vehiculo  where
 estacion_trabajo_id_estacion=3 and egreso is null;
 
 select * from estacion_vehiculo;
 
select * from estacion_vehiculo 
    where vehiculo_id_chasis=15 and estacion_trabajo_id_estacion=8;
