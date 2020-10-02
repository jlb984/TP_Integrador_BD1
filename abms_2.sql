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
call abm_modelo(5,"Emma","Infantil","alta",@_respuesta);
Select @_respuesta;
call abm_modelo(0, "Uso de IF ", "Utiliza el Auto incremento", "alta",@_respuesta);
Select @_respuesta;
call abm_modelo(5,"Emma2","Version 2","mod",@_respuesta);
Select @_respuesta;
call abm_modelo(10,"","","baja",@_respuesta);  
Select @_respuesta;
call abm_modelo(4,'Marcos',' minicoper','alta',@_respuesta);
Select @_respuesta;
call abm_modelo(5,'Juan',' minicoper','alta',@_respuesta);
Select @_respuesta;

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

call abm_proveedor(0,"juan", " Es un Proovedor repetido","alta",@_respuesta);
Select @_respuesta; -- funcionó
call abm_proveedor(546545650,"juan", " Es un Proovedor que no existe","baja",@_respuesta);
Select @_respuesta; -- funcionó

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
call abm_insumo(2," CH22","limpieza aceite","alta",@_respuesta); -- id insumo repetido
Select @_respuesta; -- funcionó

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

call abm_concesionaria(127,"Concesionaria_x","alta",@_respuesta); -- esta concesionaria es repetida
Select@_respuesta;
call abm_concesionaria(111,"Concesionaria_x","alta",@_respuesta); -- esta concesionaria es repetida
Select@_respuesta;
call abm_concesionaria(399,"Unla Motors","alta",@_respuesta);	
Select@_respuesta;	
call abm_concesionaria(399,"Otro 2","mod",@_respuesta);
Select@_respuesta;
call abm_concesionaria(399,"","baja",@_respuesta);
Select@_respuesta;	

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

call abm_pedido (1,834,'2020-10-01','2020-10-30',"alta",@_respuesta);-- id pedido repetido
Select @_respuesta; -- funcionó bien 
call abm_pedido (4,002,'2020-10-01','2020-10-30',"alta",@_respuesta); -- concecionaria que no existe.
Select @_respuesta; -- funcionó bien 	
call abm_pedido(4,127,'20-08-15','20-12-15', "alta",@_respuesta);
Select @_respuesta;		
call abm_pedido(4,127,'20-01-01','20-05-05',"mod",@_respuesta);
Select @_respuesta;
call abm_pedido(4,127,'','',"baja",@_respuesta);
Select @_respuesta;	