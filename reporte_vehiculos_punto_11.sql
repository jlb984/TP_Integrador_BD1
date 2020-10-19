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
