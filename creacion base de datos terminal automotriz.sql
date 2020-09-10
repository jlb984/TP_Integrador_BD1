create schema  if not exists Terminal_Automotriz;
use Terminal_Automotriz;


create table modelo (
	id_modelo int not null primary key AUTO_INCREMENT,
    nombre varchar(50)  not null ,
    descripcion varchar(100)
    );
    
create table linea_montaje (
	id_linea int not null primary key AUTO_INCREMENT,
    modelo_id_modelo int not null,
    foreign key (modelo_id_modelo) references modelo(id_modelo),
    produccion_mes int
    );
    

    
create table tarea (
	id_tarea int not null primary key AUTO_INCREMENT,
    nombre char(50),
    descripcion char(150)
    );
    
create table estacion_trabajo (
	id_estacion int not null primary key AUTO_INCREMENT,
    linea_id_linea int not null,
    tarea_id_tarea int not null,
    foreign key (linea_id_linea) references linea_montaje(id_linea),
    foreign key (tarea_id_tarea) references tarea(id_tarea),
    nombre_estacion char(50)
    );

create table proveedor (
	cuit int not null primary key AUTO_INCREMENT,
    nombre char(50),
    descripcion char(100)
    );
    
create table insumo (
	id_insumo int not null primary key AUTO_INCREMENT,
    nombre char(50),
    descripcion char(100)
    );
    
create table estacion_insumo (
	estacion_id_estacion int not null,
    insumo_id_insumo int not null,
    primary key (estacion_id_estacion, insumo_id_insumo),
    foreign key (estacion_id_estacion) references estacion_trabajo(id_estacion),
    foreign key (insumo_id_insumo) references insumo(id_insumo),
    cantidad int
    );
    

create table concesionaria (
	id_concesionaria int not null primary key AUTO_INCREMENT,
    nombre char(50)
    );
    
create table pedido (
	id_pedido int not null primary key AUTO_INCREMENT,
    concesionaria_id_concesionaria int not null,
    foreign key (concesionaria_id_concesionaria) references concesionaria(id_concesionaria),
    fecha_pedido date,
    fecha_entrega date
);
    
create table vehiculo (
	id_chasis int not null primary key AUTO_INCREMENT,
    modelo_id_modelo int not null,
    foreign key (modelo_id_modelo) references modelo(id_modelo),
    pedido_id_pedido int not null,
    foreign key (pedido_id_pedido) references pedido(id_pedido)
);

create table pedido_del_modelo (
	pedido_id_pedido int not null,
    modelo_id_modelo int not null,
    primary key (pedido_id_pedido, modelo_id_modelo),
    foreign key (pedido_id_pedido) references pedido(id_pedido),
    foreign key (modelo_id_modelo) references modelo(id_modelo),
    cantidad int
);
    
create table estacion_vehiculo (
	vehiculo_id_chasis int not null,
    estacion_trabajo_id_estacion int not null,
    primary key (vehiculo_id_chasis, estacion_trabajo_id_estacion),
    foreign key (vehiculo_id_chasis) references vehiculo(id_chasis),
    foreign key (estacion_trabajo_id_estacion) references estacion_trabajo(id_estacion),
    ingreso datetime default null,
    egreso datetime default null
    );
    
create table proveedor_detalle_insumo (
	proveedor_cuit int not null,
    insumo_id_insumo int not null,
    precio int,
    primary key (proveedor_cuit, insumo_id_insumo),
    foreign key (proveedor_cuit) references proveedor(cuit),
    foreign key (insumo_id_insumo) references insumo(id_insumo)
);
    
