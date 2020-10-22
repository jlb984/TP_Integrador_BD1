USE `terminal_automotriz`;
DROP procedure IF EXISTS `Pedido_ListaInsumo`;
DELIMITER $$
USE `terminal_automotriz`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Pedido_ListaInsumo`(in _id_pedido int ,out
_mensaje varchar (45))
pro : begin
declare _modelo int;
declare codigo_insumos int ;
declare _cantidad int;
declare finished int DEFAULT 0;
declare conteo int;
declare cantidad_insumo int;
DECLARE curEstacion_Insumo CURSOR FOR
SELECT pedido_id_pedido, insumo_id_insumo, cantidad from
estacion_insumo ;
 DECLARE CONTINUE HANDLER
 FOR NOT FOUND SET finished = 1;

Select modelo_id_modelo into _modelo from pedido_del_modelo where
pedido_id_pedido = _id_pedido;
Select cantidad into _cantidad from pedido_del_modelo where pedido_id_pedido =
_pedido and modelo_id_modelo = _modelo;

set @existe_pedido =0;
 -- busca el pedido
 Select count(*) into @existe_pedido from pedido_del_modelo where pedido_id_pedido =
_id_pedido;

 if @existe_pedido = 0 then
 set _mensaje = ' Pedido inexistente ';
 leave pro;
 else

 set _mensaje ='pedido existe';
 end if;
 drop table if exists modelo_pedidos;
 create temporary table if not exists modelo_pedidos(
id_pedido int,
modelo int,
codigo_insumos int,
 cantidad_insumo int,
cant_total_insumo int
 );
 OPEN curEstacion_Insumo;
 set conteo =0;
 getPedido : LOOP

 FETCH curEstacion_Insumo into _id_pedido, codigo_insumos, cantidad_insumo ;
 if pedido_id_pedido = id_pedido and _modelo =1 then
while conteo = 5 do
Insert into modelo_pedidos
(id_pedido,modelo,codigo_insumos,cantidad_insumo,cant_total_insumo) values (_id_pedido,
_modelo,codigo_insumos,cantidad_insumo,sum(cantidad_insumo));
set conteo = conteo +1;
 IF conteo = 5 THEN
 LEAVE getPedido;
END IF;
end while;
end if;
 if pedido_id_pedido = id_pedido and _modelo =2 then
while conteo = 10 do
Insert into modelo_pedidos
(id_pedido,modelo,codigo_insumos,cantidad_insumo,cant_total_insumo) values
(_id_pedido,_modelo,codigo_insumos,cantidad_insumo,sum(cantidad_insumo));
set conteo = 5 +1;
 IF conteo = 10 THEN
 set finished =1;
 END IF;
end while;
 end if;


 END LOOP getPedido;
CLOSE curEstacion_Insumo;

Select * from modelo_pedidos;
truncate modelo_pedidos;

END$$
DELIMITER ;
--Consulta
call Pedido_ListaInsumo(1,@c_mensaje);
Select @c_mensaje;