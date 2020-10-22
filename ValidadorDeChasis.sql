USE `terminal_automotriz`;
DROP procedure IF EXISTS `cargar_pedidoXXX`;

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

-- procedimiento extra validaChasis
USE `terminal_automotriz`;
DROP procedure IF EXISTS `validaChasis`;

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
