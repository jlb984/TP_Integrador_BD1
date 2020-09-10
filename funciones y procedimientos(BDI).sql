use terminal_automotriz;
select * from insumo;

CREATE procedure alta_insumo (id_insumo INT, nombre CHAR, descripcion CHAR, precio INT)
insert into insumo values (id_insumo=id_insumo, nombre=nombre, descripcion=descripcion, precio=precio);



CALL alta_insumo (39, "MO16", "radiador", 502);

insert into insumo values (40, "MO50", "filtro aceite", 701);


CREATE PROCEDURE consulta_insumo(precio int)
	select * from insumo where (precio)=precio;
    
CALL consulta_insumo(103);

select * from insumo where precio=103;