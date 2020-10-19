<<<<<<< HEAD
=======
DELIMITER |
>>>>>>> fb28f4db6129c3670e6a411046810dfc7533a2b5
CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_pedido`(IN _id_pedido int,out _mensaje varchar(60))
BEGIN

DECLARE idPedidoParametro INTEGER DEFAULT 0;
DECLARE idChasis INTEGER DEFAULT 0;
DECLARE dFechaIngreso DATETIME;

DECLARE _modelo_id_modelo INTEGER;
DECLARE nCantidadDetalle INT;
DECLARE finished INT DEFAULT 0; 


DECLARE conteo INT;
-- Aca declaro el cursos para recorrer los detalles pero solo del pedido indicado en el parametro

    DECLARE curDetallePedido
        CURSOR FOR
            SELECT modelo_id_modelo, cantidad FROM pedido_del_modelo WHERE pedido_id_pedido = _id_pedido;

    DECLARE CONTINUE HANDLER
        FOR NOT FOUND SET finished = 1;
set @auto_repetido =0; 
select count(*) into @auto_repetido from vehiculo where pedido_id_pedido = _id_pedido;
    OPEN curDetallePedido;
 if @auto_repetido > 0 then
		
	SET _mensaje= 'El auto ya está pedido';
   
    else
    SET _mensaje= 'El auto se proceso con exito';
	end if;
   -- Aca comienzo el loop recorriendo el cursor.
    getDetalle: LOOP

        FETCH curDetallePedido INTO _modelo_id_modelo, nCantidadDetalle;

        IF finished = 1 THEN
            LEAVE getDetalle;
        END IF;

	SET conteo = 0;

	-- Aca loopeo para hacer N inserts.
	WHILE 	conteo < nCantidadDetalle and @auto_repetido =0 DO
<<<<<<< HEAD
SET idChasis= FLOOR(RAND() * 100000); -- genera id aleatorio entre 0 y 100.000
=======
	SET idChasis= FLOOR(RAND() * 100000); -- genera id aleatorio entre 0 y 100.000
>>>>>>> fb28f4db6129c3670e6a411046810dfc7533a2b5
	insert into vehiculo values (idChasis,_modelo_id_modelo, _id_pedido);
	

SET conteo = conteo  +1;

	END WHILE;

    END LOOP getDetalle;

-- Elimino el cursor de memoria

    CLOSE curDetallePedido;

<<<<<<< HEAD
END
=======
END
|
>>>>>>> fb28f4db6129c3670e6a411046810dfc7533a2b5
