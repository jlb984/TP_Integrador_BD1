-- ****************** ABM modelos ***************************--
DELIMITER |

CREATE PROCEDURE abm_modelo (IN _id_modelo int, IN _nombre varchar(50), IN _descripcion varchar(100), IN accion varchar(10))
-- ingresar id = 0, si se quiere utilizar el auto_incremento
  BEGIN

    CASE 	accion
      WHEN 'alta' THEN
      insert into modelo values (_id_modelo,_nombre,_descripcion);
      IF _id_modelo = 0 THEN
		insert into modelo( nombre, descripcion) values (_nombre,_descripcion);
      ELSE
		insert into modelo values (_id_modelo,_nombre,_descripcion);
	  END IF;
      WHEN 'baja' THEN 
      delete from modelo where id_modelo=_id_modelo;
      WHEN 'mod' THEN
      update modelo set
		nombre=_nombre, descripcion=_descripcion where id_modelo=_id_modelo;
    END CASE;
    select * from modelo;
  END;
  |
  
  call abm_modelo(5,"Emma","Infantil","alta");
  call abm_modelo(0, "Uso de IF ", "Utiliza el Auto incremento", "alta");
  call abm_modelo(5,"Emma2","Version 2","mod");
  call abm_modelo(10,"","","baja");
  
  
  -- ****************** ABM linea_montaje ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_linea_montaje(IN _id_linea int, IN _modelo_id_modelo int, IN _produccion_mes int, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  -- ingresar id = 0, si se quiere utilizar el auto_incremento
  BEGIN

    CASE 	accion
      WHEN 'alta' THEN
      IF _id_linea = 0 THEN
		insert into linea_montaje(modelo_id_modelo, produccion_mes) values (_modelo_id_modelo, _produccion_mes);
      ELSE
		insert into linea_montaje values (_id_linea, _modelo_id_modelo, _produccion_mes);
	  END IF;
		WHEN "baja" THEN
			delete from linea_montaje WHERE id_linea=_id_linea;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (produccion_mes), cualquier otro intento dara error
			update linea_montaje set
			produccion_mes=_produccion_mes where id_linea=_id_linea and modelo_id_modelo=_modelo_id_modelo;
	END CASE;
	select * from linea_montaje;
END
|


call abm_linea_montaje(3,1,50,"alta");
call abm_linea_montaje(0,2,50,"alta"); -- USO DEL AUTO_INCREMENTO		
call abm_linea_montaje(3,1,100,"mod");
call abm_linea_montaje(3,0,0,"baja");		
		
-- ****************** ABM tarea ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_tarea(IN _id_tarea int, IN _nombre varchar(50), IN _descripcion varchar(150), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
        IF _id_tarea = 0 THEN -- ingresar id = 0, si se quiere utilizar el auto_incremento
			insert into tarea(nombre, descripcion) values (_nombre, _descripcion);
            ELSE
			insert into tarea values (_id_tarea, _nombre, _descripcion);
		END IF;
		WHEN "baja" THEN
			delete from tarea WHERE id_tarea=_id_tarea;
		WHEN "mod" THEN 
			update tarea set
		nombre=_nombre, descripcion=_descripcion where id_tarea=_id_tarea;
	END CASE;
	select * from tarea;
END
|


call abm_tarea(6,"Otro","Prueba de alta","alta");		
call abm_tarea(6,"Otro 2","222222222222222 y 2","mod");
call abm_tarea(6,"","","baja");		
		


-- ****************** ABM proveedor ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_proveedor(IN _cuit int, IN _nombre varchar(50), IN _descripcion varchar(100), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
        IF _cuit = 0 THEN 			-- ingresar id = 0, si se quiere utilizar el auto_incremento
			insert into proveedor(nombre, descripcion) values (_nombre, _descripcion);
            ELSE
			insert into proveedor values (_cuit, _nombre, _descripcion);
		END IF;
		WHEN "baja" THEN
			delete from proveedor WHERE cuit=_cuit;
		WHEN "mod" THEN 
			update proveedor set
		nombre=_nombre, descripcion=_descripcion where cuit=_cuit;
	END CASE;
	select * from proveedor;
END
|


call abm_proveedor(12345678,"Empresa Nueva SA","Prueba de alta","alta");		
call abm_proveedor(12345678,"Empresa Mod SA","Prueba de mod","mod");
call abm_proveedor(12345678,"","","baja");		
		


-- ****************** ABM insumo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_insumo(IN _id_insumo int, IN _nombre varchar(50), IN _descripcion varchar(150), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
        IF _id_insumo = 0 THEN 			-- ingresar id = 0, si se quiere utilizar el auto_incremento
			insert into insumo(nombre, descripcion) values (_nombre, _descripcion);
            ELSE
			insert into insumo values (_id_insumo, _nombre, _descripcion);
		END IF;
		WHEN "baja" THEN
			delete from insumo WHERE id_insumo=_id_insumo;
		WHEN "mod" THEN 
			update insumo set
		nombre=_nombre, descripcion=_descripcion where id_insumo=_id_insumo;
	END CASE;
	select * from insumo;
END
|


call abm_insumo(39,"IIIIOOOO2020","Prueba de alta","alta");		
call abm_insumo(39,"Otro 2","Prueba de Mod","mod");
call abm_insumo(39,"","","baja");		
		


-- ****************** ABM concesionaria ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_concesionaria(IN _id_concesionaria int, IN _nombre varchar(50), IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
        IF _id_concesionaria = 0 THEN 			-- ingresar id = 0, si se quiere utilizar el auto_incremento
			insert into concesionaria(nombre) values (_nombre);
            ELSE
			insert into concesionaria values (_id_concesionaria, _nombre);
		END IF;
		WHEN "baja" THEN
			delete from concesionaria WHERE id_concesionaria=_id_concesionaria;
		WHEN "mod" THEN 
			update concesionaria set
		nombre=_nombre where id_concesionaria=_id_concesionaria;
	END CASE;
	select * from concesionaria;
END
|


call abm_concesionaria(399,"Unla Motors","alta");		
call abm_concesionaria(399,"Otro 2","mod");
call abm_concesionaria(399,"","baja");	



	

-- ****************** ABM pedido ***************************--
  

 DELIMITER |
  
CREATE PROCEDURE abm_pedido(IN _id_pedido int, IN _concesionaria_id_concesionaria int, IN _fecha_pedido date, IN _fecha_entrega date, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
BEGIN
	CASE accion
		WHEN "alta" THEN 
        IF _id_pedido = 0 THEN 			-- ingresar id = 0, si se quiere utilizar el auto_incremento
			insert into pedido(concesionaria_id_concesionaria, fecha_pedido, fecha_entrega) values (_concesionaria_id_concesionaria, _fecha_pedido, _fecha_entrega);
            ELSE
			insert into pedido values (_id_pedido, _concesionaria_id_concesionaria, _fecha_pedido, _fecha_entrega);
		END IF;
		WHEN "baja" THEN
			delete from pedido WHERE id_pedido=_id_pedido;
		WHEN "mod" THEN -- En este caso solo se pueden modificar las columnas que no son clave (fecha_pedido y fecha_entrega), cualquier otro intento dara error
			update pedido set
			fecha_pedido=_fecha_pedido, fecha_entrega=_fecha_entrega where id_pedido=_id_pedido and concesionaria_id_concesionaria=_concesionaria_id_concesionaria;
	END CASE;
	select * from pedido;
END
|


call abm_pedido(4,127,'20-08-15','20-12-15', "alta");		
call abm_pedido(4,127,'20-01-01','20-05-05',"mod");
call abm_pedido(4,127,'','',"baja");		

		
        
-- ****************** ABM vehiculo ***************************--
  

 DELIMITER |
  
  CREATE PROCEDURE abm_vehiculo(IN _id_chasis int, IN _modelo_id_modelo int, IN _pedido_id_pedido int, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
        IF _id_chasis = 0 THEN 			-- ingresar id = 0, si se quiere utilizar el auto_incremento
			insert into vehiculo(modelo_id_modelo, pedido_id_pedido) values (_modelo_id_modelo, _pedido_id_pedido);
            ELSE
			insert into vehiculo values (_id_chasis, _modelo_id_modelo, _pedido_id_pedido);
		END IF;
		WHEN "baja" THEN
			delete from vehiculo WHERE id_chasis=_id_chasis;
		WHEN "mod" THEN 
			update vehiculo set
			modelo_id_modelo=_modelo_id_modelo, pedido_id_pedido=_pedido_id_pedido where id_chasis=_id_chasis;
	END CASE;
	select * from vehiculo;
END
|


call abm_vehiculo(25,2,3, "alta");		
call abm_vehiculo(25,1,2,"mod");
call abm_vehiculo(25,0,0,"baja");		



-- ****************** ABM estacion_vehiculo ***************************--
  
  DELIMITER |
  
  CREATE PROCEDURE abm_estacion_vehiculo(IN _vehiculo_id_chasis int, IN _estacion_trabajo_id_estacion int, IN _ingreso datetime, IN _egreso datetime, IN accion varchar(10)) -- acciones posibles "alta", "baja", "mod"
  BEGIN
	CASE accion
		WHEN "alta" THEN 
			insert into estacion_vehiculo values (_vehiculo_id_chasis, _estacion_trabajo_id_estacion, _ingreso, _egreso);
		WHEN "baja" THEN
			delete from estacion_vehiculo WHERE vehiculo_id_chasis=_vehiculo_id_chasis and estacion_trabajo_id_estacion=_estacion_trabajo_id_estacion;
		WHEN "mod" THEN -- En este caso solo se puede modificar la columna que no es clave (ingreso y egreso), cualquier otro intento dara error
			update estacion_vehiculo set
			ingreso=_ingreso, egreso=_egreso where vehiculo_id_chasis=_vehiculo_id_chasis and estacion_trabajo_id_estacion=_estacion_trabajo_id_estacion;
	END CASE;
	select * from estacion_vehiculo;
END
|


call abm_estacion_vehiculo(15,3,'2013-11-24 17:15:10','2013-11-24 20:15:10',"alta");		
call abm_estacion_vehiculo(15,3,'2222-11-24 17:15:10','2222-11-24 20:15:10', "mod");
call abm_estacion_vehiculo(15,3,'2013-11-24 17:15:10','2013-11-24 20:15:10',"baja");		




