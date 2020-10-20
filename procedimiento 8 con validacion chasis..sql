USE `terminal_automotriz`;
DROP procedure IF EXISTS `cargar_pedido2`;

DELIMITER $$
USE `terminal_automotriz`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `cargar_pedido2`(IN _id_pedido int,out _mensaje varchar(60))
BEGIN

DECLARE idPedidoParametro INTEGER DEFAULT 0;
DECLARE idChasis INTEGER DEFAULT 0;
DECLARE dFechaIngreso DATETIME;

DECLARE _modelo_id_modelo INTEGER;
DECLARE nCantidadDetalle INT;
DECLARE finished INT DEFAULT 0; 
declare existe int;

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
		SET existe=0 ;
		validaChasis: LOOP
			SET idChasis= FLOOR(RAND() * 1000); -- genera id aleatorio entre 0 y 100.000
			--  genero un bloque nuevo con un cursor y recorro todo el listado de chasis existentes para asegurar que no exista el que acabo de generar
            BEGIN
					DECLARE n_chasis int;
                    DECLARE curChasis CURSOR FOR 
                    SELECT id_chasis FROM vehiculo;
					DECLARE CONTINUE HANDLER
					FOR NOT FOUND SET finished = 1;
                    OPEN curChasis;
					getChasis: LOOP
						FETCH curChasis INTO n_chasis;
						IF finished = 1 THEN
						LEAVE getChasis;
						END IF;
                        IF n_chasis=idChasis THEN
							SET existe=1;
						END IF;
					END LOOP getChasis;
                    CLOSE curChasis;
			END;
		IF existe=0 THEN
        insert into vehiculo values (idChasis,_modelo_id_modelo, _id_pedido);
			LEAVE validaChasis;
            end if;
		if existe =1 then
			ITERATE validaChasis;
           set conteo = 0;
		END IF;
	END LOOP ;
		
	-- insert into vehiculo values (idChasis,_modelo_id_modelo, _id_pedido);
	

	SET conteo = conteo  +1;

	END WHILE;

    END LOOP getDetalle;
-- 
-- Elimino el cursor de memoria

    CLOSE curDetallePedido;

END$$

DELIMITER ;

