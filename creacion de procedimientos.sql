use  terminal_automotriz;
-- ****************** ABM modelos ***************************--

DELIMITER |

CREATE PROCEDURE abm_modelo (IN _id_modelo int, IN _nombre varchar(50), IN _descripcion varchar(100),
 IN accion varchar(10),out _respuesta varchar(45))
BEGIN

    CASE 	accion
      WHEN 'alta' THEN 
        set @repetido =0 ;
	Select count(*) into @repetido from modelo where nombre= _nombre or id_modelo = _id_modelo;
        if @repetido =0 then
           insert into modelo values (_id_modelo,_nombre,_descripcion);
           set _respuesta ='Modelo creado con exito!';
         else
         set _respuesta='Modelo o id  repetido ';
         end if;
         
      WHEN 'baja' THEN 
        set @repetido =0 ;
	Select count(*) into @repetido from modelo where id_modelo= _id_modelo;
        if @repetido =1 then
           delete from modelo where id_modelo=_id_modelo;
           set _respuesta ='Modelo eliminado con exito!';
		else
           set _respuesta='No existe ese modelo';
         end if;
	
	WHEN 'mod' THEN
      set @repetido =0 ;
	Select count(*) into @repetido from modelo where id_modelo= _id_modelo;
    if @repetido =1 then
      update modelo set
		nombre=_nombre, descripcion=_descripcion where id_modelo=_id_modelo;
        set _respuesta ='Modelo actualizado con exito!';
	else
	    set _respuesta='No existe ese modelo';
	end if;
        
    END CASE;
    select * from modelo;
  END
  
  |
  
  -- ****************** ABM proveedor ***************************--

DELIMITER |
  
CREATE PROCEDURE abm_proveedor(IN _cuit int, IN _nombre varchar(50), IN _descripcion varchar(100), IN accion varchar(10)
,out _respuesta varchar (45))
BEGIN
	CASE accion
		WHEN "alta" THEN 
        set @repetido =0 ;
			Select count(*) into @repetido from proveedor where  cuit = _cuit;
        if @repetido =0 then
			insert into proveedor values (_cuit, _nombre, _descripcion);
            set _respuesta ='proveedor agregado con exito!';
         else
         set _respuesta='Proovedor  con ese cuit ya existe';
         end if;
		WHEN "baja" THEN
        set @repetido =0 ;
	Select count(*) into @repetido from proveedor where cuit= _cuit;
        if @repetido =1 then
			delete from proveedor WHERE cuit=_cuit;
            set _respuesta ='Proveedor eliminado con exito!';
		else
           set _respuesta='Proveedor con ese cuit no existe';
         end if;
		WHEN "mod" THEN 
        set @repetido =0 ;
	Select count(*) into @repetido from proveedor where cuit= _cuit;
    if @repetido =1 then
			update proveedor set
		nombre=_nombre, descripcion=_descripcion where cuit=_cuit;
        set _respuesta ='Proveedor actualizado con exito!';
	else
	    set _respuesta='Proveedor con ese cuit no existe';
	end if;
        
	END CASE;
	select * from proveedor;
END
|

-- ****************** ABM insumo ***************************--

DELIMITER |
  
 CREATE PROCEDURE abm_insumo(IN _id_insumo int, IN _nombre varchar(50), IN _descripcion varchar(150) , IN accion varchar(10),out _respuesta varchar(45))
BEGIN
	CASE accion
    WHEN "alta" THEN 
		set @repetido =0;
    Select count(*) into @repetido from insumo where  id_insumo = _id_insumo;
        if @repetido =0 then
			insert into insumo values (_id_insumo, _nombre, _descripcion);
            set _respuesta ='Insumo agregado con exito!';
		else
			set _respuesta='Insumo  con ese id ya existe';
         end if;
	WHEN "baja" THEN
          set @repetido =0 ;
	Select count(*) into @repetido from insumo where id_insumo= _id_insumo;
        if @repetido =1 then
			delete from insumo WHERE id_insumo=_id_insumo;
				set _respuesta ='Insumo eliminado con exito!';
		else
           set _respuesta='Insumo con ese id no existe';
		end if;   
	WHEN "mod" THEN 
        set @repetido =0 ;
	Select count(*) into @repetido from insumo where id_insumo= _id_insumo;
		if @repetido =1 then
			update insumo set
			nombre=_nombre, descripcion=_descripcion where id_insumo=_id_insumo;
				set _respuesta ='Insumo actualizado con exito!';
		else
			set _respuesta='Insumo con ese id no existe';
		end if;   
	END CASE;
	select * from insumo;
END
|

-- ****************** ABM concesionaria ***************************--
  
  DELIMITER |
  
CREATE  PROCEDURE abm_concesionaria(IN _id_concesionaria int, IN _nombre varchar(50), IN accion varchar(10)
,out _respuesta varchar(45))
BEGIN
	CASE accion
		WHEN "alta" THEN 
        set @repetido =0 ;
			Select count(*) into @repetido from concesionaria where nombre= _nombre or id_concesionaria = _id_concesionaria;
        if @repetido =0 then
			insert into concesionaria values (_id_concesionaria, _nombre);
            set _respuesta ='Concecionaria creado con exito!';
         else
         set _respuesta='Concesionaria  con ese nombre o id ya existe';
         end if;
		WHEN "baja" THEN
          set @repetido =0 ;
	Select count(*) into @repetido from concesionaria where id_modelo= _id_modelo;
        if @repetido =1 then
			delete from concesionaria WHERE id_concesionaria=_id_concesionaria;
            set _respuesta ='Concecionaria eliminado con exito!';
		else
           set _respuesta='No existe esa Concecionaria';
         end if;
		WHEN "mod" THEN 
        set @repetido =0 ;
	Select count(*) into @repetido from concesionaria where id_modelo= _id_modelo;
    if @repetido =1 then
			update concesionaria set
		nombre=_nombre where id_concesionaria=_id_concesionaria;
	 set _respuesta ='Concesinaria actualizado con exito!';
	else
	    set _respuesta='No existe esa Concesionaria';
	end if;
	END CASE;
	select * from concesionaria;
END
|

-- ****************** ABM pedido ***************************--
  

 DELIMITER |
  
CREATE PROCEDURE abm_pedido(IN _id_pedido int, IN _concesionaria_id_concesionaria int, IN _fecha_pedido date,
IN _fecha_entrega date, IN accion varchar(10),out _respuesta varchar (65))
BEGIN
	CASE accion
	WHEN "alta" THEN -- valida que no exista un pedido con el mismo id, y valida que exista la concesionaria
        set @repetido =0 ;
        set @existe_concesionaria=0;
			Select count(*) into @repetido from pedido where id_pedido=_id_pedido;
			Select count(*) into @existe_concesionaria from concesionaria where id_concesionaria= _concesionaria_id_concesionaria;
        if @repetido =0 and @existe_concesionaria=1 then
			insert into pedido (id_pedido,concesionaria_id_concesionaria, fecha_pedido, fecha_entrega) values (_id_pedido, _concesionaria_id_concesionaria, _fecha_pedido, _fecha_entrega);
				set _respuesta ='Pedido creado con exito!';
		else
				set _respuesta='Pedido  con ese id ya existe o concecionaria no existe';
		end if;  
	WHEN "baja" THEN
		set @repetido =0 ;
	Select count(*) into @repetido from pedido where id_pedido= _id_pedido;
        if @repetido =1 then
			delete from pedido WHERE id_pedido=_id_pedido;
				set _respuesta ='Pedido eliminado con exito!';
		else
           set _respuesta='Pedido no existe con ese id';
         end if;
            
		WHEN "mod" THEN -- En este caso solo se pueden modificar las columnas que no son clave (fecha_pedido y fecha_entrega), cualquier otro intento dara error
			set @repetido =0 ;
	Select count(*) into @repetido from pedido where id_pedido= _id_pedido;
        if @repetido =1 then
            update pedido set
			fecha_pedido=_fecha_pedido, fecha_entrega=_fecha_entrega where id_pedido=_id_pedido ;
        set _respuesta ='Pedido actualizado con exito!';
	else
	    set _respuesta='Pedido no existe con ese id';
	end if;    
	END CASE;
	select * from pedido;
END
|


-- prociedimiento para listar pedido solicitado

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `mostrar_pedido`(IN _id_pedido int)
BEGIN
    select id_pedido, fecha_pedido, concesionaria_id_concesionaria, modelo_id_modelo, cantidad  from pedido p
    inner join pedido_del_modelo pm on id_pedido=pedido_id_pedido
    where id_pedido=_id_pedido;
  END$$
DELIMITER ;

-- EJERCICIO 8 ------ 
-- procedimiento extra validaChasis
DELIMITER $$
USE `terminal_automotriz`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `validaChasis`(IN _id_chasis int,out _existe int)
BEGIN

-- variables cursor chasis
DECLARE n_chasis int;
DECLARE finished INT DEFAULT 0; 
-- Cursor para recorrer la tabla de vehiculos completa
DECLARE curChasis CURSOR FOR SELECT id_chasis FROM vehiculo;
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1; -- inicializado en true
SET _existe = 0;
OPEN curChasis;
					getChasis: LOOP
						FETCH curChasis INTO n_chasis;
						IF finished = 1 THEN
							LEAVE getChasis;
						END IF;
                        IF n_chasis=_id_chasis THEN
							SET _existe = 1;
                            LEAVE getChasis;
						END IF;
					END LOOP getChasis;
CLOSE curChasis;
                    
END$$

DELIMITER ;

-- Crea los vehiculos indicados en el pedido seleccionado, crea los id's correspondientes para cada chasis

DELIMITER $$
USE `terminal_automotriz`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_pedido`(IN _id_pedido int,out _mensaje varchar(60))
BEGIN

DECLARE idPedidoParametro INTEGER DEFAULT 0;
DECLARE idChasis INTEGER DEFAULT 0;
DECLARE dFechaIngreso DATETIME;
DECLARE finished INT DEFAULT 0; 

-- variables cursor pedido
DECLARE _modelo_id_modelo INTEGER;
DECLARE nCantidadDetalle INT;
DECLARE conteo INT DEFAULT 0;
DECLARE existe INT DEFAULT 0;




-- Cursor para recorrer los detalles pero solo del pedido indicado en el parametro
DECLARE curDetallePedido CURSOR FOR
SELECT modelo_id_modelo, cantidad FROM pedido_del_modelo WHERE pedido_id_pedido = _id_pedido;


-- Manejador de ambos cursores
DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1; -- inicializado en true

-- INICIO chequeo si pedido esta cargado --
set @auto_repetido =0; 
select count(*) into @auto_repetido from vehiculo where pedido_id_pedido = _id_pedido;
 if @auto_repetido > 0 then
	SET _mensaje= 'El auto ya está pedido';
else
    SET _mensaje= 'El auto se proceso con exito';
end if;

-- FIN chequeo si pedido esta cargado --

   -- Aca comienzo el loop recorriendo el cursor de pedido.
OPEN curDetallePedido;
getDetalle: LOOP
	FETCH curDetallePedido INTO _modelo_id_modelo, nCantidadDetalle;
	IF finished = 1 THEN
		LEAVE getDetalle;
	END IF;
	SET conteo = 0;		-- control de cantidad de vehiculos cargados por linea
	
	WHILE 	conteo < nCantidadDetalle and @auto_repetido =0 DO -- Aca loopeo para hacer N inserts.
		validaChasis: LOOP
			SET idChasis= FLOOR(RAND() * 100); -- genera id aleatorio entre 0 y 100.000
			--  genero un loop nuevo con un cursor y recorro todo el listado de chasis existentes para asegurar que no exista el que acabo de generar
			CALL validaChasis(idChasis, @_existe);
            IF (SELECT @_existe = 1) THEN
				ITERATE validaChasis;
			END IF;
            IF (SELECT @_existe = 0) THEN
				LEAVE validaChasis;
			END IF;
		END LOOP validaChasis;
		
	insert into vehiculo values (idChasis,_modelo_id_modelo, _id_pedido);
	

	SET conteo = conteo  +1;

	END WHILE;

    END LOOP getDetalle;
-- 
-- Elimino el cursor de memoria

    CLOSE curDetallePedido;

END$$

DELIMITER ;


-- EJERCICIO 9 SEGUNDA ETAPA
-- procedimiento que inicia chasis en primer estacion de la linea correspondiente  a ese modelo
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
modelo_id_modelo=modelo limit 1;

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

 insert into estacion_vehiculo values (chasis, estacion,
now(), null);
 set nResultado = 0;
 set cMensaje = 'Vehiculo Iniciado con exito';
 
 -- MUESTRO TODOS LOS REGISTROS DE ESA ESTACION AL SALIR
 select id_chasis as Num_Chasis, modelo_id_modelo as Modelo, pedido_id_pedido as pedido,  estacion_trabajo_id_estacion as estacion , ingreso, egreso from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
where estacion_trabajo_id_estacion = estacion;

END
|


-- EJERCICIO 10 SEGUNDA ETAPA
-- procedimiento que avanza chasis a la siguiente estacion si se encuentra vacia, y finaliza vehiculo si esta en la ultima

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
	insert into estacion_vehiculo values (chasis, estacion_siguiente,now(), null);
-- finalizamos con exito
 set nResultado = 0;
 set cMensaje = 'Vehiculo Avanzado con exito';
 end if;
 
   -- MUESTRO TODOS LOS REGISTROS DE NUEVA ESTACION AL SALIR
 select id_chasis as Num_Chasis, modelo_id_modelo as Modelo, pedido_id_pedido as pedido,  estacion_trabajo_id_estacion as estacion , ingreso, egreso from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
where estacion_trabajo_id_estacion = estacion_siguiente;

END
|


-- EJERCICIO 11
-- reporte de un pedido determinado


DELIMITER |
CREATE DEFINER=`root`@`localhost` PROCEDURE `reporte_vehiculos`(IN _id_pedido int)
BEGIN

DECLARE _id_chasis INT;
DECLARE _id_modelo INT;
DECLARE cantidad INT;
DECLARE _fecha_ingreso DATE;
DECLARE _fecha_egreso DATE;
DECLARE finished INT DEFAULT 0; 

DECLARE estacion INT DEFAULT 1;
DECLARE nombre_est varchar(200);
DECLARE estado varchar(200);


    
DECLARE curReporte
        CURSOR FOR
            SELECT ve.id_chasis, ve.modelo_id_modelo, count(id_chasis), es.ingreso, es.egreso 
            FROM vehiculo ve JOIN estacion_vehiculo es 
            ON es.vehiculo_id_chasis = ve.id_chasis 
            where ve.pedido_id_pedido=_id_pedido group by id_chasis;

DECLARE CONTINUE HANDLER
	FOR NOT FOUND SET finished = 1;
    
drop table if exists temp;
    create temporary table if not exists temp (
		ID_CHASIS int,
		ESTADO varchar(200),
		ULTIMA_ESTACION varchar(200)
    );
    
OPEN curReporte;
	getReporte: LOOP
		FETCH curReporte INTO _id_chasis, _id_modelo, cantidad, _fecha_ingreso, _fecha_egreso;
    
		IF finished = 1 THEN
            LEAVE getReporte;
        END IF;
        
        IF _id_modelo = 2 THEN
		SET estacion = cantidad + 5;
		
        ELSE 
        SET estacion = cantidad;
        END IF;
        
        SELECT nombre_estacion INTO nombre_est from estacion_trabajo where id_estacion=estacion;
        
        IF cantidad = 5 AND _fecha_egreso is not null THEN
        SET estado = 'FINALIZADO';
        ELSEIF _fecha_ingreso is null THEN
        SET estado = 'AUN SIN INICIAR';
        ELSE 
        SET estado = 'EN CURSO';
        END IF;
        
        INSERT into temp VALUES(_id_chasis, estado, nombre_est);
        
    END LOOP getReporte;
CLOSE curReporte;

select * from temp;
truncate temp;
END

|