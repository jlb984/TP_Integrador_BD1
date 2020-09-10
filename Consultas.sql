-- Se deben realizar las consultas SQL necesarias para:



-- 1) Listar cantidad mensual de automóviles fabricados discriminados por modelo, con el
-- objeto de analizar si es necesario agregar líneas de montaje para un modelo en
-- particular.

select month(egreso) as mes , modelo_id_modelo as modelo,  count(vehiculo_id_chasis) as total_produccion from estacion_vehiculo
inner join estacion_trabajo et on id_estacion=estacion_trabajo_id_estacion
inner join vehiculo v on vehiculo_id_chasis=id_chasis
where tarea_id_tarea=5 and egreso>0 
group by month(egreso), modelo_id_modelo
;




-- 2) Listar cantidad mensual de automóviles pedidos discriminados por modelo y
-- concesionaria solicitante.

select month(p.fecha_pedido) as Mes, m.nombre as Modelo, c.nombre as concesionaria ,sum(pm.cantidad) as Total_x_mes from pedido p 
inner join pedido_del_modelo pm 
on id_pedido=pedido_id_pedido 
inner join concesionaria c
on id_concesionaria=concesionaria_id_concesionaria
inner join modelo m 
on id_modelo=modelo_id_modelo
group by month(p.fecha_pedido), concesionaria_id_concesionaria, modelo_id_modelo;


-- 3) Emitir listados de concesionarios, indicando si han realizado pedidos alguna vez

select c.nombre as concesionaria ,sum(p.id_pedido) as pedidos_realizados from concesionaria c 
left join pedido p on id_concesionaria=concesionaria_id_concesionaria
left join vehiculo pm on id_pedido=pedido_id_pedido 
group by concesionaria
order by pedidos_realizados;




-- 4) Emitir listados de modelos.

select * from modelo
order by nombre desc;

-- 5) Emitir listado de automóviles, indicando número de chasis, modelo y fecha hora de
-- entrada a fabricación.


select id_chasis as Num_Chasis, m.nombre as Modelo, ingreso from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo 
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=1 and ingreso is not null;

-- 6) Listado similar al anterior, indicando en qué estado se encuentra. Si aún no entró a
-- la línea de montaje el estado es “A fabricar”. Si se encuentra terminado, el estado es
-- “Terminado”. En cualquier otro caso, el estado es el nombre de la estación en la que
-- se encuentra.

select id_chasis as Num_Chasis, m.nombre as Modelo, "A fabricar" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=1 and ingreso is null
union
select id_chasis as Num_Chasis, m.nombre as Modelo, "Chasis" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=1 and egreso is  null and ingreso is not null
union
select id_chasis as Num_Chasis, m.nombre as Modelo, "Pintura" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=2 and egreso is  null and ingreso is not null
union
select id_chasis as Num_Chasis, m.nombre as Modelo, "Tren delantero y trasero" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=3 and egreso is  null and ingreso is not null
union
select id_chasis as Num_Chasis, m.nombre as Modelo, "Electricidad" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=4 and egreso is  null and ingreso is not null
union
select id_chasis as Num_Chasis, m.nombre as Modelo, "Motorizacion y banco de prueba" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=5 and egreso is  null and ingreso is not null
union
select id_chasis as Num_Chasis, m.nombre as Modelo, "Terminado" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=5 and egreso is not null;







-- 7) Listado similar al anterior, filtrado por pedido para el que se fabrican. Se debe
-- agregar el número de pedido al listado

select v.pedido_id_pedido as pedido, id_chasis as Num_Chasis, m.nombre as Modelo, "A fabricar" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=1 and ingreso is null
union
select v.pedido_id_pedido as pedido, id_chasis as Num_Chasis, m.nombre as Modelo, "Chasis" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=1 and egreso is  null and ingreso is not null
union
select v.pedido_id_pedido as pedido, id_chasis as Num_Chasis, m.nombre as Modelo, "Pintura" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=2 and egreso is  null and ingreso is not null
union
select v.pedido_id_pedido as pedido, id_chasis as Num_Chasis, m.nombre as Modelo, "Tren delantero y trasero" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=3 and egreso is  null and ingreso is not null
union
select v.pedido_id_pedido as pedido, id_chasis as Num_Chasis, m.nombre as Modelo, "Electricidad" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=4 and egreso is  null and ingreso is not null
union
select v.pedido_id_pedido as pedido, id_chasis as Num_Chasis, m.nombre as Modelo, "Motorizacion y banco de prueba" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=5 and egreso is  null and ingreso is not null
union
select v.pedido_id_pedido as pedido, id_chasis as Num_Chasis, m.nombre as Modelo, "Terminado" as Estado from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=5 and egreso is not null
order by pedido;




-- 8) Listado similar al 4, filtrado por concesionaria para la que se fabrican. Se debe
-- agregar el nombre de concesionaria al listado

select m.nombre, c.nombre from vehiculo
inner join pedido p on id_pedido=pedido_id_pedido
inner join modelo m on id_modelo=modelo_id_modelo
inner join concesionaria c on id_concesionaria=concesionaria_id_concesionaria
where c.nombre= "Moliternos Cars"
group by modelo_id_modelo
;
select m.nombre, c.nombre from vehiculo
inner join pedido p on id_pedido=pedido_id_pedido
inner join modelo m on id_modelo=modelo_id_modelo
inner join concesionaria c on id_concesionaria=concesionaria_id_concesionaria
where c.nombre= "Brigstone"
group by modelo_id_modelo
;
select m.nombre, c.nombre from vehiculo
inner join pedido p on id_pedido=pedido_id_pedido
inner join modelo m on id_modelo=modelo_id_modelo
inner join concesionaria c on id_concesionaria=concesionaria_id_concesionaria
where c.nombre= "Ford"
group by modelo_id_modelo
;


-- 9) Emitir listado de compras necesarias para fabricar los automóviles pendientes (que
-- aún no hayan entrado a fabricación)


select insumo_id_insumo, cantidad*suma_vehiculos.suma as total from estacion_insumo
inner join (select count(id_chasis) as suma from vehiculo v
inner join estacion_vehiculo ev on v.id_chasis=ev.vehiculo_id_chasis
inner join modelo m on id_modelo=modelo_id_modelo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=1 and ingreso is null) as suma_vehiculos
;


-- 10) Emitir listados de pedidos pendientes (que no hayan entrado en la estación inicial o
-- que no hayan salido de la estación final), con detalle de los modelos faltantes y sus
-- cantidades. Los campos a listar son: número de pedido, modelo, cantidad faltante


select pedido_id_pedido, modelo_id_modelo ,count(id_chasis) as cantidad from vehiculo
where vehiculo.id_chasis in (select vehiculo_id_chasis from estacion_vehiculo
inner join estacion_trabajo on id_estacion=estacion_trabajo_id_estacion
where tarea_id_tarea=1 and ingreso is null 
or tarea_id_tarea=1 and egreso is null 
or tarea_id_tarea=2 and egreso is null
or tarea_id_tarea=3 and egreso is null
or tarea_id_tarea=4 and egreso is null
or tarea_id_tarea=5 and egreso is null )
group by pedido_id_pedido, modelo_id_modelo;



