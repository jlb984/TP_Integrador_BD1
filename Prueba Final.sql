-- MODO DE USO DEL SIGUIENTE ARCHIVO
-- crear BD con archivo "creacion de base de datos terminal automotriz.sql"
-- cargar datos con archivo "carga de datos.sql" SOLO hasta la linea 241 de dicho script
-- cargar procedimientos del archivo "creacion de procedimientos.sql"
-- ejecutar este script paso a paso para comprobar los resultados
-- ADVERTENCIA: los id's de chasis se crean aleatoriamente, por lo tanto luego de ejecutar el procedimiento "cargar_pedido", se deberan modificar
-- 				los parametros de entrada de los siguientes procedimientos colocando los id's generados en su consulta

-- creacion de un pedido
CALL `terminal_automotriz`.`abm_pedido`(10, 834, curdate(), null, "alta", @_respuesta);
select @_respuesta;

-- carga de datos en pedido

insert into pedido_del_modelo values (10,1,37);
insert into pedido_del_modelo values (10,2,37);

select * from pedido
inner join pedido_del_modelo on id_pedido=pedido_id_pedido
where id_pedido=10;

-- creacion de id's de vehiculos segun pedido
CALL `terminal_automotriz`.`cargar_pedido`(10, @_mensaje);
select @_mensaje;

select * from vehiculo where pedido_id_pedido=10;  -- muestro detalle del pedido con todos los id de chasis incluidos
select count(*) from vehiculo where id_chasis>0 and id_chasis<100 ;  -- muestro detalle del pedido con todos los id de chasis incluidos
select * from vehiculo ;
-- inicio un vehiculo en linea 1 (modelo id 1)

CALL `terminal_automotriz`.`inicio_vehiculo`(27, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=27;



-- inicio vehiculo en linea 2 (Modelo id 2)

CALL `terminal_automotriz`.`inicio_vehiculo`(39, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=39;

-- avanzo linea 1

CALL `terminal_automotriz`.`avanzo_vehiculo`(27, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=27;


-- avanzo linea 2

CALL `terminal_automotriz`.`avanzo_vehiculo`(39, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=39;

-- inicio un vehiculo en linea 1 (modelo id 1) //ya se encuentra vacia la primer estacion

CALL `terminal_automotriz`.`inicio_vehiculo`(94, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=94;


-- intento avanzar a siguiente estacion //esta ocupada

CALL `terminal_automotriz`.`avanzo_vehiculo`(94, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=94;

-- avanzo primer vehiculo hasta final de linea y lo finalizo// repetir 4 veces el procedimiento

CALL `terminal_automotriz`.`avanzo_vehiculo`(27, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=27;

-- estando finalizado intento hacerlo avanzar // repito el procedimiento por 5° vez




-- inicio vehiculo en linea 2 (Modelo id 2)  //ya se encuentra vacia la primer estacion

CALL `terminal_automotriz`.`inicio_vehiculo`(25, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=25;

-- Intento iniciar otro vehiculo en linea 2  //primer estacion todavia esta ocupada

CALL `terminal_automotriz`.`inicio_vehiculo`(41, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=41;

-- avanzo primer vehiculo hasta final de linea 2 sin finalizarlo// repetir 3 veces el procedimiento

CALL `terminal_automotriz`.`avanzo_vehiculo`(39, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=39;

-- avanzo segundo vehiculo hasta estacion 8  de linea 2// repetir 2 veces el procedimiento
CALL `terminal_automotriz`.`avanzo_vehiculo`(25, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=25;

-- inicio ultimo vehiculo de linea 2

CALL `terminal_automotriz`.`inicio_vehiculo`(41, @cMensaje, @nResultado);
select @cMensaje, @nResultado;
select * from vehiculo
inner join estacion_vehiculo on vehiculo_id_chasis=id_chasis
where id_chasis=41;


-- reporte de estado pedido 10

CALL `terminal_automotriz`.`reporte_vehiculos`(10);


-- TODO LO DE ABAJO ES PARA PROBAR, BORRAR CUANDO TERMINE !!!!!!!
select * from estacion_vehiculo;

delete from estacion_vehiculo where vehiculo_id_chasis=86026 or  vehiculo_id_chasis=58905 or vehiculo_id_chasis=53416;