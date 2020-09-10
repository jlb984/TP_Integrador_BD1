/* 
Carga de datos Terminal Automotriz 
*/

--  *********  Modelos ******** 

insert into modelo values
	(001, "Jonathan", "Sedan familiar de consumo masivo, opcional motores 1.2 y 1.4"),
    (002, "Luciano", "Superdeportivo con velocidad maxima de 300 km/h, solo en color rojo");
    
 -- ***** Linea de montaje  ******  
 
insert into linea_montaje values
	(1, 001, "45"),
    (2, 002, "15");
    
-- ******** tareas **********

insert into tarea values
	(1, "Chasis", "Armado de estructura, soldadura, colocacion de puertas, capot"),
    (2, "Pintura", "Proceso antioxidante, pintura y acabado final de brillo"),
    (3, "Tren delantero y trasero", "Armado y colocacion de sistema de traccion, frenos y direccion. Colocacion de llantas y cubiertas correspondientes"),
    (4, "Electricidad", "Cableado completo, instalacion de sistema de luces y electronicos, comprobacion y chequeo general"),
    (5, "Motorizacion y Banco De Prueba", "Instalacion y puesta a punto de motor. Sistema de embrague");
    
-- ********** Estacion de trabajo ********
 
 insert into estacion_trabajo values
	(1, 1, 1, "Jonathan_chasis"),
    (2, 1, 2, "Jonathan_pintura"),
    (3, 1, 3, "Jonathan_tren DYT"),
    (4, 1, 4, "Jonathan_electricidad"),
    (5, 1, 5, "Jonathan_motorizacion y BP"),
    (6, 2, 1, "Luciano_chasis"),
    (7, 2, 2, "Luciano_pintura"),
    (8, 2, 3, "Luciano_tren DYT"),
    (9, 2, 4, "Luciano_electricidad"),
    (10, 2, 5, "Luciano_motorizacion y BP");
    

-- ********** Proveedores **************

insert into proveedor values
	(111111111, "Pint S.R.L", "Proveedor de pinturas"),
    (222222222, "Mech S.A.", "Autopartes de chasis, puertas, capos, paragolpes, llantas, etc"),
    (333333333, "Tronics S.A.", "Provision de cables, luces, comp. electronicos"),
    (444444444, "Viña S.R.L", "Provision de embragues"),
    (555555555, "Fate S.A.", "Cubiertas"),
    (666666666, "Satellite S.A", "comp electronicos"),
    (777777777, "Arriaga Autopartes", "Componentes varios"),
    (888888888, "Bergandi motors inc", "proveedor de motores"),
    (999999999, "Allegue inc", ""),
    (100000000, "Moliterno", "");
-- ********* insumo **************

insert into insumo values
	(1,"CH47","parabrisas(chico)"),
    (2,"CH48","parabrisas(grande)"),
    (3,"CH49","puerta izq(chica)"),
    (4,"CH50","puerta der(chica)"),
    (5,"CH51","puerta izq(grande)"),
    (6,"CH52","puerta der(grande)"),
    (7,"CH53","optica izq(chica)"),
    (8,"CH54","optica der(grande)"),
    (9,"XZ30","antioxidante"), -- insumo comun
    (10,"XZ31","rojo"),
    (11,"XZ32","verde"),
    (12,"XZ33","azul"),
    (13,"XZ34","amarillo"),
    (14,"XZ35","purpura"),
    (15,"XZ36","gris"),
    (16,"ZZ10","freno chico"),
    (17,"ZZ11","freno grande"),
    (18,"ZZ12","llanta 13"),
    (19,"ZZ13","llanta 15"),
    (20,"ZZ14","cubierta 13"),
    (21,"ZZ15","cubierta 15"),
    (22,"ZZ16","trasmision grande"),
    (23,"ZZ17","trasmision chica"),
    (24,"EE1","luz trasera stop"), -- insumo comun 
    (25,"EE2","bateria grande"),
    (26,"EE3","bateria chica"),
    (27,"EE4","bombilla grande"),
    (28,"EE5","bombilla chica"),
    (29,"EE6","stereo standar"),
    (30,"EE7","stereo premium"),
    (31,"MO8","motor chico "),
    (32,"MO9","motor grande"),
    (33,"MO10","embrague chico"),
    (34,"MO11","embrague grande"),
    (35,"MO12","correa chica"),
    (36,"MO13","correa grande"),
    (37,"MO14","bomba de nafta chica"),
    (38,"MO15","bomba de nafta grande");
    
-- ********* concesionaria **************
insert into concesionaria values
	(834,"Moliternos Cars"),
    (127,"Brigstone"),
    (235,"Ford");
    
insert into concesionaria values
	(555,"Escalada Motors");
-- ********* pedido **************
insert into pedido values
	(1,834, '19-07-15','19-12-15'), -- pedido pendiente
    (2,127, '19-08-15','19-12-15'), -- pedido completo
    (3,235, '19-9-15','19-12-15'); -- pedido medio completar
    
    
-- ********* estacion_insumo **************
insert into estacion_insumo values
	(1,1,12),
    (1,2,12),
	(1,3,12),
    (1,4,12),
    (6,5,12),
    (6,6,12),
    (6,7,12),
    (6,8,12),
    (2,9,12), -- insumo comun
    (7,9,13),
    (2,10,12),
    (2,11,12),
    (2,12,12),
    (7,13,12),
    (7,14,12),
    (7,15,12),
    (3,16,12),
    (3,17,12),
    (3,18,12),
    (3,19,12),
    (8,20,12),
    (8,21,12),
    (8,22,12),
    (8,23,12),
    (4,24,12), -- insumo comun
    (9,24,15),
    (4,25,12),
    (4,26,12),
    (4,27,12),
    (9,28,12),
    (9,29,12),
    (9,30,12),
    (5,31,12),
    (5,32,12),
    (5,33,12),
    (5,34,12),
    (10,35,12),
    (10,36,12),
    (10,37,12),
    (10,38,12); -- alternar tareas por chico y grande
    
-- ********* proveedor_detalle_insumo **************
insert into proveedor_detalle_insumo values
	(111111111,1,200),
	(111111111,2,201),
    (111111111,3,202),
    (111111111,4,203),
    (111111111,5,205),
    (333333333,4,300),
    (333333333,5,301),
    (333333333,6,302),
    (333333333,7,303),
    (333333333,8,310),
    (222222222,7,365),
    (222222222,8,357),
    (222222222,9,395),
    (222222222,10,367),
    (222222222,11,123),
    (444444444,10,124),
    (444444444,11,125),
    (444444444,12,128),
    (444444444,13,129),
    (444444444,14,110),
    (555555555,13,112),
    (555555555,14,115),
    (555555555,15,117),
    (555555555,16,116),
    (555555555,17,118),
    (666666666,15,119),
    (666666666,16,145),
    (666666666,17,147),
    (666666666,18,149),
    (666666666,19,156),
    (777777777,18,157),
    (777777777,19,159),
    (777777777,20,151),
    (777777777,21,152),
    (777777777,22,153),
    (888888888,21,170),
    (888888888,22,179),
    (888888888,23,172),
    (888888888,24,171),
    (888888888,25,174),
    (999999999,24,184),
    (999999999,25,181),
    (999999999,26,183),
    (999999999,27,186),
    (999999999,28,185),
    (100000000,29,182),
    (100000000,30,100),
    (100000000,31,101),
    (100000000,32,102),
    (100000000,33,103);

-- *********pedido_del_modelo**************
insert into pedido_del_modelo values
	(1,001,3),
	(1,002,3),
	(2,001,3),
	(2,002,6),
	(3,001,4),
	(3,002,5);

-- *********vehiculo**************
insert into vehiculo values
	(1,001,1),
    (2,001,1),
    (3,001,1),
    (4,002,1),
    (5,002,1),
    (6,002,1),
    (7,001,2),
    (8,001,2),
    (9,001,2),
    (10,002,2),
    (11,002,2),
    (12,002,2),
    (13,002,2),
    (14,002,2),
    (15,002,2),
    (16,001,3),
    (17,001,3),
    (18,001,3),
    (19,001,3),
    (20,002,3),
    (21,002,3),
    (22,002,3),
    (23,002,3),
    (24,002,3);

-- *********estacion_vehiculo************** (detalle estado de chasis)
insert into estacion_vehiculo values
	(1,1,'2013-11-24 17:15:10','2013-11-24 17:15:10'),
    (1,2,'2013-12-24 17:15:10','2013-12-24 18:15:10'),
    (1,3,'2014-1-24 17:15:10','2013-1-24 18:15:10'),
    (1,4,'2014-2-24 17:15:10','2014-2-24 17:15:10'),
    (1,5,'2014-3-24 17:15:10','2014-3-24 17:15:10'),
    (2,1,'2014-4-24 17:15:10','2014-4-24 17:15:10'),
    (2,2,'2014-5-24 17:15:10','2014-5-24 17:15:10'),
    (2,3,'2014-6-24 17:15:10','2014-6-24 17:15:10'),
    (2,4,'2014-7-24 17:15:10','2014-7-24 17:15:10'),
    (2,5,'2014-8-24 17:15:10','2014-8-24 17:15:10'),
    (3,1,'2014-9-24 17:15:10','2014-9-24 17:15:10'),
	(3,2,'2014-10-24 17:15:10','2014-10-24 17:15:10'),
	(3,3,'2014-11-24 17:15:10','2014-11-24 17:15:10'),
	(3,4,'2014-12-24 17:15:10','2014-12-24 17:15:10'),
    (3,5,'2015-1-24 17:15:10','2015-1-24 17:15:10'),
    (4,6,'2015-2-24 17:15:10','2015-2-24 17:15:10'),
    (4,7,'2015-3-24 17:15:10','2015-3-24 17:15:10'),
    (4,8,'2015-4-24 17:15:10','2015-4-24 17:15:10'),
    (4,9,'2015-5-24 17:15:10','2015-5-24 17:15:10'),
    (4,10,'2015-6-24 17:15:10','2015-6-24 17:15:10'),
    (5,6,'2015-7-24 17:15:10','2015-7-24 17:15:10'),
    (5,7,'2015-8-24 17:15:10','2015-8-24 17:15:10'),
    (5,8,'2015-9-24 17:15:10','2015-9-24 17:15:10'),
    (5,9,'2015-10-24 17:15:10','2015-10-24 17:15:10'),
    (5,10,'2015-11-24 17:15:10','2015-11-24 17:15:10'),
    (6,6,'2015-12-24 17:15:10','2015-12-24 17:15:10'),
    (6,7,'2016-1-24 17:15:10','2016-1-24 17:15:10'),
    (6,8,'2016-2-24 17:15:10','2016-2-24 17:15:10'),
    (6,9,'2016-3-24 17:15:10','2016-3-24 17:15:10'),
    (6,10,'2016-4-24 17:15:10','2016-11-24 17:15:10'),
    (7,1,null, null),
    (8,1,'2016-6-24 17:15:10','2016-6-24 17:15:10'),
    (8,2,'2016-7-24 17:15:10', null),
    (9,1,'2016-8-24 17:15:10','2016-8-24 17:15:10'),
    (9,2,'2016-9-24 17:15:10','2016-9-24 17:15:10'),
    (9,3,'2016-10-24 17:15:10', null),
    (10,6,null, null),
    (11,6,'2016-12-24 17:15:10', null),
    (12,6,'2016-1-24 17:15:10','2016-1-24 17:15:10'),
    (12,7,'2017-2-24 17:15:10', null),
    (13,6,'2017-3-24 17:15:10','2017-3-24 17:15:10'),
    (13,7,'2017-4-24 17:15:10', null),
    (14,6,'2017-5-24 17:15:10','2017-5-24 17:15:10'),
    (14,7,'2017-6-24 17:15:10','2017-6-24 17:15:10'),
    (14,8,'2017-7-24 17:15:10', null),
    (15,6,'2017-8-24 17:15:10','2017-8-24 17:15:10'),
    (15,7,'2017-9-24 17:15:10','2013-9-24 17:15:10'),
    (15,8,'2017-10-24 17:15:10', null);
    update estacion_vehiculo set egreso='2014-6-24 17:15:10',ingreso='2014-6-24 17:15:10' where vehiculo_id_chasis=2 and estacion_trabajo_id_estacion=5;
    