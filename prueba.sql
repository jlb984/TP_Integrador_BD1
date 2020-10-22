-- creacion de un pedido
CALL `terminal_automotriz`.`abm_pedido`(206, 834, curdate(), null, "alta", @_respuesta);
select @_respuesta;

-- carga de datos en pedido

insert into pedido_del_modelo values (206,1,13);
insert into pedido_del_modelo values (206,2,13);

select * from pedido
inner join pedido_del_modelo on id_pedido=pedido_id_pedido
where id_pedido=206;

-- creacion de id's de vehiculos segun pedido
CALL `terminal_automotriz`.`cargar_pedidoXXX`(206, @_mensaje);
select @_mensaje;

select count(*) from vehiculo where id_chasis>0 and id_chasis<100 ;  -- muestro detalle del pedido con todos los id de chasis incluidos
select * from vehiculo where id_chasis>0 and id_chasis<100;







CALL `terminal_automotriz`.`validaChasis`(22, _existe);
select @_existe;
CALL `terminal_automotriz`.`validaChasis`(30, _existe);
select @_existe;
