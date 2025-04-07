-- GRUPO:
-- DIEGO JAVIER OLIVERA
-- IVÁN FERNÁNDEZ
-- PRISCILLA ESCOBAR
-- MAURO PERALTA

CREATE DATABASE IF NOT EXISTS controlStock;
USE controlStock;


CREATE TABLE `Roles_empleados` (
	`rol_empleado_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_rol` ENUM('Estibador', 'Gerente', 'Inspector', 'Repositor'),
	PRIMARY KEY(`rol_empleado_id`)
);

CREATE TABLE `Empleados` (
	`empleado_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_empleado` VARCHAR(50),
	`apellido` VARCHAR(50),
	`rol_empleado_id` INTEGER,
	`dni` INTEGER,
	PRIMARY KEY(`empleado_id`),
	FOREIGN KEY(rol_empleado_id) REFERENCES Roles_empleados(rol_empleado_id)
);

CREATE TABLE `Proveedor` (
	`proveedor_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_proveedor` VARCHAR(50),
	`marca` ENUM('NIKE', 'ADIDAS', 'PUMA', 'NEW BALANCE', 'VANS'),
	PRIMARY KEY(`proveedor_id`)
);

CREATE TABLE `Guia_despacho` (
	`guia_despacho_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`numero_guia` INTEGER,
	`fecha` DATE,
	`proveedor_id` INTEGER,
	PRIMARY KEY(`guia_despacho_id`),
	FOREIGN KEY(proveedor_id) REFERENCES Proveedor(proveedor_id)
);

CREATE TABLE `Guia_despacho_detalles` (
	`guia_despacho_detalles_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`guia_despacho_id` INTEGER,
	`ejemplar_producto_id` INTEGER,
	`cantidad_recibida` INTEGER,
	PRIMARY KEY(`guia_despacho_detalles_id`),
	FOREIGN KEY(guia_despacho_id) REFERENCES Guia_despacho(guia_despacho_id)
);

CREATE TABLE `Categorias` (
	`categoria_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_categoria` VARCHAR(30),
	PRIMARY KEY(`categoria_id`)
);

CREATE TABLE `Subcategorias` (
	`subcategoria_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_subcategoria` VARCHAR(30),
	PRIMARY KEY(`subcategoria_id`)
);

CREATE TABLE `Categoria_subcategoria` (
	`categoria_subcategoria_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`categoria_id` INTEGER,
	`subcategoria_id` INTEGER,
	PRIMARY KEY(`categoria_subcategoria_id`),
	FOREIGN KEY(`categoria_id`) REFERENCES Categorias(categoria_id),
	FOREIGN KEY(`subcategoria_id`) REFERENCES Subcategorias(subcategoria_id)
);

CREATE TABLE `Productos` (
	`producto_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`nombre_producto` VARCHAR(50),
	`precio` DOUBLE,
	`categoria_subcategoria_id` INTEGER,
	`proveedor_id` INTEGER,
	PRIMARY KEY(`producto_id`),
	FOREIGN KEY(categoria_subcategoria_id) REFERENCES Categoria_subcategoria(categoria_subcategoria_id),
	FOREIGN KEY(proveedor_id) REFERENCES Proveedor(proveedor_id)
);

CREATE TABLE `Ordenes_de_compra` (
	`orden_de_compra_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`numero_orden` INTEGER,
	`fecha_orden` DATE,
	`proveedor_id` INTEGER,
	`estado_orden_compra` ENUM('PENDIENTE', 'COMPLETADA', 'CANCELADA'),
	`costo` DOUBLE,
	PRIMARY KEY(`orden_de_compra_id`),
	FOREIGN KEY(proveedor_id) REFERENCES Proveedor(proveedor_id)
);

CREATE TABLE `Talles` (
	`talle_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`talle` CHAR(5),
	PRIMARY KEY(`talle_id`)
);

CREATE TABLE `Sectores` (
	`sector_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`sector` CHAR(1),
	PRIMARY KEY(`sector_id`)
);

CREATE TABLE `Ejemplar_producto` (
	`ejemplar_producto_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`producto_id` INTEGER,
	`talle_id` INTEGER,
	`codigo_barras` INTEGER,
	`stock` INTEGER,
	`sector_id` INTEGER,
	PRIMARY KEY(`ejemplar_producto_id`),
	FOREIGN KEY(`producto_id`) REFERENCES Productos(producto_id),
	FOREIGN KEY(`talle_id`) REFERENCES Talles(talle_id),
	FOREIGN KEY(`sector_id`) REFERENCES Sectores(sector_id)
);

CREATE TABLE `Ordenes_de_compra_detalles` (
	`orden_de_compra_detalle_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`orden_de_compra_id` INTEGER,
	`ejemplar_producto_id` INTEGER,
	`cantidad` INTEGER,
	PRIMARY KEY(`orden_de_compra_detalle_id`),
	FOREIGN KEY(`orden_de_compra_id`) REFERENCES Ordenes_de_compra(orden_de_compra_id),
	FOREIGN KEY(`ejemplar_producto_id`) REFERENCES Ejemplar_producto(ejemplar_producto_id)
);

CREATE TABLE `Entrada_productos` (
	`entrada_producto_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`fecha_entrada` DATE,
	`tipo_entrada` ENUM('REABASTECIMIENTO', 'DEVOLUCION_CLIENTE'),
	`empleado_id` INTEGER,
	`ejemplar_producto_id` INTEGER,
	`cantidad_ingreso` INTEGER,
	PRIMARY KEY(`entrada_producto_id`),
	FOREIGN KEY(`empleado_id`) REFERENCES Empleados(empleado_id),
	FOREIGN KEY(`ejemplar_producto_id`) REFERENCES Ejemplar_producto(ejemplar_producto_id)
);

CREATE TABLE `Salida_productos` (
	`salida_productos_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`ejemplar_producto_id` INTEGER,
	`fecha_salida` DATE,
	`cantidad` INTEGER,
	`tipo_salida` ENUM('VENTA', 'PERDIDA', 'DEVOLUCION_PROVEEDOR'),
	PRIMARY KEY(`salida_productos_id`),
	FOREIGN KEY(`ejemplar_producto_id`) REFERENCES Ejemplar_producto(ejemplar_producto_id)
);

CREATE TABLE `Telefono_proveedor` (
	`telefono_proveedor_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`proveedor_id` INTEGER,
	`telefono` VARCHAR(25),
	PRIMARY KEY(`telefono_proveedor_id`),
	FOREIGN KEY(`proveedor_id`) REFERENCES Proveedor(proveedor_id)
);

CREATE TABLE `Email_proveedor` (
	`email_proveedor_id` INTEGER NOT NULL AUTO_INCREMENT UNIQUE,
	`proveedor_id` INTEGER,
	`email` VARCHAR(50),
	PRIMARY KEY(`email_proveedor_id`),
	FOREIGN KEY(`proveedor_id`) REFERENCES Proveedor(proveedor_id)
);

-- INSERTS:

-- Insertar roles de empleados
INSERT INTO `Roles_empleados` (`nombre_rol`) 
VALUES 
('Estibador'), 
('Gerente'), 
('Inspector'), 
('Repositor');

-- Insertar empleados
INSERT INTO `Empleados` (`nombre_empleado`, `apellido`, `rol_empleado_id`, `dni`) 
VALUES 
('Carlos', 'González', 1, 12345678),
('Maria', 'Jesus', 1, 46393854),
('María', 'López', 4, 87654321),
('Juan', 'Pérez', 3, 45678912),
('Sebastian', 'Real', 2, 47294023),
('Norman', 'Glaves', 4, 23493854),
('Ana', 'Martínez', 4, 78912345);

-- Insertar proveedores
INSERT INTO `Proveedor` (`nombre_proveedor`, `marca`) 
VALUES 
('Distribuidora Deportiva Nike', 'NIKE'),
('Deportes Globales Adidas', 'ADIDAS'),
('Suministros Puma', 'PUMA'),
('New Balance Proveedores', 'NEW BALANCE'),
('Vans Internacional', 'VANS');

-- Insertar guías de despacho
INSERT INTO `Guia_despacho` (`numero_guia`, `fecha`, `proveedor_id`) 
VALUES 
(1003, '2024-11-15', 3),  -- Suministros Puma
(1004, '2024-11-16', 4),  -- New Balance Proveedores
(1005, '2024-11-17', 5),  -- Vans Internacional
(1006, '2024-11-18', 1),  -- Distribuidora Deportiva
(1007, '2024-11-19', 2);  -- Deportes Globales Adidas

-- Insertar categorías
INSERT INTO `Categorias` (`nombre_categoria`) 
VALUES 
('Calzado'),
('Pantalones'),
('Hoodies'),
('Chaquetas'),
('Remeras'),
('Musculosas'),
('Calzas'),
('Shorts'),
('Conjuntos'),
('Accesorios');

-- Insertar subcategorías
INSERT INTO `Subcategorias` (`nombre_subcategoria`) 
VALUES 
('Running'),
('Training'),
('Moda'),
('Futbol'),
('Rugby'),
('Natacion'),
('Outdoor'),
('Life Style'),
('Skateboarding');

-- Relacionar categorías y subcategorías
INSERT INTO `Categoria_subcategoria` (`categoria_id`, `subcategoria_id`) 
VALUES 
-- Relaciones para Calzado
(1, 1),  -- Running
(1, 2),  -- Training
(1, 4),  -- Futbol
(1, 6),  -- Natacion
(1, 8),  -- Life Style

-- Relaciones para Pantalones
(2, 2),  -- Training
(2, 3),  -- Moda
(2, 7),  -- Outdoor
(2, 8),  -- Life Style

-- Relaciones para Hoodies
(3, 2),  -- Training
(3, 3),  -- Moda
(3, 7),  -- Outdoor
(3, 8),  -- Life Style

-- Relaciones para Chaquetas
(4, 3),  -- Moda
(4, 7),  -- Outdoor
(4, 8),  -- Life Style
(4, 9),  -- Skateboarding

-- Relaciones para Remeras
(5, 1),  -- Running
(5, 2),  -- Training
(5, 3),  -- Moda
(5, 4),  -- Futbol
(5, 5),  -- Rugby

-- Relaciones para Musculosas
(6, 1),  -- Running
(6, 2),  -- Training
(6, 6),  -- Natacion
(6, 7),  -- Outdoor

-- Relaciones para Calzas
(7, 1),  -- Running
(7, 2),  -- Training
(7, 7),  -- Outdoor

-- Relaciones para Shorts
(8, 1),  -- Running
(8, 4),  -- Futbol
(8, 6),  -- Natacion
(8, 8),  -- Life Style

-- Relaciones para Conjuntos
(9, 2),  -- Training
(9, 3),  -- Moda
(9, 7),  -- Outdoor
(9, 8),  -- Life Style

-- Relaciones para Accesorios
(10, 1),  -- Running
(10, 4),  -- Futbol
(10, 5),  -- Rugby
(10, 6),  -- Natacion
(10, 8);  -- Life Style

-- Insertar más productos
INSERT INTO `Productos` (`nombre_producto`, `precio`, `categoria_subcategoria_id`, `proveedor_id`)
VALUES
-- Productos de Nike
('Zapatillas Nike Air Zoom Pegasus', 130.99, 1, 1),
('Pantalones Nike Dri-FIT', 49.99, 6, 1),
('Hoodie Nike Sportswear Club', 55.00, 13, 1),
('Chaqueta Nike Windrunner', 89.99, 12, 1),
('Camiseta Nike Strike', 29.99, 19, 1),

-- Productos de Adidas
('Zapatillas Adidas Ultraboost', 180.00, 1, 2),
('Pantalones Adidas Tiro 23', 45.00, 8, 2),
('Hoodie Adidas Essentials', 60.00, 11, 2),
('Shorts Adidas Aeroready', 35.00, 30, 2),
('Gorra Adidas 3-Stripes', 20.00, 42, 2),

-- Productos de Puma
('Zapatillas Puma RS-X', 110.00, 5, 3),
('Pantalones Puma Essentials', 40.00, 8, 3),
('Chaqueta Puma Evostripe', 75.00, 14, 3),
('Musculosa Puma Training', 25.00, 24, 3),
('Mochila Puma Phase', 30.00, 42, 3),

-- Productos de New Balance
('Zapatillas New Balance 574', 100.00, 5, 4),
('Calzas New Balance Impact Run', 50.00, 27, 4),
('Hoodie New Balance Core', 60.00, 11, 4),
('Chaqueta New Balance NB Heat', 120.00, 15, 4),
('Shorts New Balance Accelerate', 35.00, 30, 4),

-- Productos de Vans
('Zapatillas Vans Old Skool', 85.00, 5, 5),
('Camiseta Vans Classic', 25.00, 20, 5),
('Gorra Vans Curved Bill', 20.00, 42, 5),
('Hoodie Vans Realm', 65.00, 11, 5),
('Mochila Vans Authentic', 40.00, 42, 5);

-- Insertar talles adicionales
INSERT INTO `Talles` (`talle`) 
VALUES 
('XS'), 
('S'), 
('M'), 
('L'), 
('XL'), 
('1'), 
('2'), 
('3'), 
('4'), 
('5'), 
('6');

-- Insertar sectores
INSERT INTO `Sectores` (`sector`) 
VALUES 
('A'), -- Sector: calzado y accesorios, 
('B'), -- Sector: Pantalones, Hoodies y Chaquetas, 
('D'), -- Sector: Remeras, Musculosas, Shorts, 
('C'); -- Sector: Calzas, Conjuntos y categorías varias;

-- Insertar ejemplares de productos
INSERT INTO `Ejemplar_producto` (`producto_id`, `talle_id`, `codigo_barras`, `stock`, `sector_id`) 
VALUES 
-- Ejemplares de Nike
(1, 9, 100000001, 50, 1), -- Zapatillas Nike Air Zoom Pegasus - 4 - Sector A
(2, 4, 100000002, 30, 2), -- Pantalones Nike Dri-FIT - L - Sector B
(3, 3, 100000003, 25, 3), -- Hoodie Nike Sportswear Club - M - Sector C
(4, 5, 100000004, 20, 4), -- Chaqueta Nike Windrunner - XL - Sector D
(5, 2, 100000005, 40, 2), -- Camiseta Nike Strike - S - Sector B

-- Ejemplares de Adidas
(6, 7, 100000006, 60, 1), -- Zapatillas Adidas Ultraboost - 2 - Sector A
(7, 3, 100000007, 35, 2), -- Pantalones Adidas Tiro 23 - M - Sector B
(8, 2, 100000008, 25, 3), -- Hoodie Adidas Essentials - S - Sector C
(9, 5, 100000009, 45, 3), -- Shorts Adidas Aeroready - XL - Sector C
(10, 6, 100000010, 50, 4), -- Gorra Adidas 3-Stripes - 1 - Sector D

-- Ejemplares de Puma
(11, 10, 100000011, 55, 1), -- Zapatillas Puma RS-X - 5 - Sector A
(12, 3, 100000012, 30, 2), -- Pantalones Puma Essentials - M - Sector B
(13, 4, 100000013, 40, 4), -- Chaqueta Puma Evostripe - L - Sector D
(14, 2, 100000014, 20, 3), -- Musculosa Puma Training - S - Sector C
(15, 6, 100000015, 35, 4), -- Mochila Puma Phase - 1 - Sector D

-- Ejemplares de New Balance
(16, 8, 100000016, 45, 1), -- Zapatillas New Balance 574 - 3 - Sector A
(17, 5, 100000017, 25, 2), -- Calzas New Balance Impact Run - XL - Sector B
(18, 3, 100000018, 20, 3), -- Hoodie New Balance Core - M - Sector C
(19, 2, 100000019, 30, 4), -- Chaqueta New Balance NB Heat - S - Sector D
(20, 1, 100000020, 40, 3), -- Shorts New Balance Accelerate - XS - Sector C

-- Ejemplares de Vans
(21, 11, 100000021, 50, 1), -- Zapatillas Vans Old Skool - 6 - Sector A
(22, 2, 100000022, 35, 2), -- Camiseta Vans Classic - S - Sector B
(23, 4, 100000023, 45, 3), -- Gorra Vans Curved Bill - L - Sector C
(24, 5, 100000024, 25, 3), -- Hoodie Vans Realm - XL - Sector C
(25, 6, 100000025, 30, 4); -- Mochila Vans Authentic - 1 - Sector D

-- Insertar órdenes de compra
INSERT INTO `Ordenes_de_compra` (`numero_orden`, `fecha_orden`, `proveedor_id`, `estado_orden_compra`, `costo`) 
VALUES 
(101, '2024-11-01', 1, 'PENDIENTE', 900.00),   -- Orden a Distribuidora Deportiva
(102, '2024-11-05', 2, 'PENDIENTE', 800.00),   -- Orden a Deportes Globales
(103, '2024-11-07', 3, 'PENDIENTE', 700.00),   -- Orden a Puma
(104, '2024-11-10', 4, 'COMPLETADA', 750.00),   -- Orden a New Balance Proveedores
(105, '2024-11-12', 5, 'COMPLETADA', 600.00),   -- Orden a Vans Internacional
(105, '2024-11-12', 3, 'CANCELADA', 600.00);   -- Orden a Puma

-- Insertar detalles de órdenes de compra
INSERT INTO `Ordenes_de_compra_detalles` (`orden_de_compra_id`, `ejemplar_producto_id`, `cantidad`) 
VALUES 
(1, 1, 10),  -- Zapatillas Nike Air Zoom Pegasus
(1, 2, 5),   -- Pantalones Nike Dri-FIT
(1, 3, 8),   -- Hoodie Nike Sportswear Club
(1, 4, 12),  -- Chaqueta Nike Windrunner
(2, 6, 10),  -- Zapatillas Adidas Ultraboost
(2, 7, 6),   -- Pantalones Adidas Tiro 23
(2, 8, 8),   -- Hoodie Adidas Essentials
(3, 9, 15),  -- Shorts Adidas Aeroready
(3, 10, 20), -- Gorra Adidas 3-Stripes
(4, 11, 10), -- Zapatillas Puma RS-X
(4, 12, 7),  -- Pantalones Puma Essentials
(4, 13, 5),  -- Chaqueta Puma Evostripe
(5, 14, 10), -- Musculosa Puma Training
(5, 15, 15); -- Mochila Puma Phase

-- Insertar entradas de productos
INSERT INTO `Entrada_productos` (`fecha_entrada`, `tipo_entrada`, `empleado_id`, `ejemplar_producto_id`, `cantidad_ingreso`) 
VALUES 
('2024-11-10', 'REABASTECIMIENTO', 1, 1, 50),  -- Zapatillas Nike Air Zoom Pegasus
('2024-11-11', 'REABASTECIMIENTO', 1, 2, 40),  -- Pantalones Nike Dri-FIT
('2024-11-12', 'REABASTECIMIENTO', 2, 3, 60),  -- Hoodie Nike Sportswear Club
('2024-11-13', 'REABASTECIMIENTO', 1, 4, 35),  -- Chaqueta Nike Windrunner
('2024-11-14', 'REABASTECIMIENTO', 2, 6, 30),  -- Zapatillas Adidas Ultraboost
('2024-11-15', 'REABASTECIMIENTO', 2, 7, 25),  -- Pantalones Adidas Tiro 23
('2024-11-16', 'REABASTECIMIENTO', 2, 8, 45),  -- Hoodie Adidas Essentials
('2024-11-17', 'REABASTECIMIENTO', 1, 9, 50),  -- Shorts Adidas Aeroready
('2024-11-18', 'REABASTECIMIENTO', 1, 10, 20),  -- Gorra Adidas 3-Stripes
('2024-11-19', 'REABASTECIMIENTO', 6, 11, 25),  -- Zapatillas Puma RS-X
('2024-11-20', 'REABASTECIMIENTO', 7, 12, 55),  -- Pantalones Puma Essentials
('2024-11-21', 'REABASTECIMIENTO', 6, 13, 40),  -- Chaqueta Puma Evostripe
('2024-11-22', 'REABASTECIMIENTO', 1, 14, 30),  -- Musculosa Puma Training
('2024-11-24', 'DEVOLUCION_CLIENTE', 2, 3, 2),  -- Hoodie Nike Sportswear Club
('2024-11-23', 'REABASTECIMIENTO', 1, 15, 15);  -- Mochila Puma Phase

-- Insertar salidas de productos
INSERT INTO `Salida_productos` (`ejemplar_producto_id`, `fecha_salida`, `cantidad`, `tipo_salida`) 
VALUES 
(1, '2024-11-12', 2, 'VENTA'),  -- Zapatillas Nike Air Zoom Pegasus (VENTA)
(2, '2024-11-13', 1, 'VENTA'),  -- Pantalones Nike Dri-FIT (VENTA)
(3, '2024-11-14', 3, 'VENTA'),  -- Hoodie Nike Sportswear Club (VENTA)
(4, '2024-11-15', 1, 'VENTA'),  -- Chaqueta Nike Windrunner (VENTA)
(5, '2024-11-16', 1, 'VENTA'),  -- Zapatillas Adidas Ultraboost (VENTA)
(6, '2024-11-17', 2, 'VENTA'),  -- Pantalones Adidas Tiro 23 (VENTA)
(7, '2024-11-18', 4, 'VENTA'),  -- Hoodie Adidas Essentials (VENTA)
(8, '2024-11-19', 1, 'VENTA'),  -- Shorts Adidas Aeroready (VENTA)
(9, '2024-11-20', 6, 'VENTA'),  -- Gorra Adidas 3-Stripes (VENTA)
(10, '2024-11-21', 1, 'VENTA'),  -- Zapatillas Puma RS-X (VENTA)
(11, '2024-11-22', 3, 'VENTA'),  -- Pantalones Puma Essentials (VENTA)
(12, '2024-11-23', 1, 'VENTA'),  -- Chaqueta Puma Evostripe (VENTA)
(13, '2024-11-24', 2, 'VENTA'),  -- Musculosa Puma Training (VENTA)
(14, '2024-11-25', 15, 'DEVOLUCION_PROVEEDOR'),  -- Mochila Puma Phase (DEVOLUCION_CLIENTE)
(15, '2024-11-26', 1, 'PERDIDA');  -- Zapatillas Nike Air Zoom Pegasus (PERDIDA)

-- Insertar teléfonos de proveedores
INSERT INTO `Telefono_proveedor` (`proveedor_id`, `telefono`) 
VALUES 
(1, '+54 9 11 1122-3344'),  -- Nike
(2, '+54 9 11 2233-4455'),  -- Adidas
(3, '+54 9 11 3344-5566'),  -- Puma
(3, '+54 9 11 6677-8899'),  -- Puma (segundo teléfono)
(4, '+54 9 11 4455-6677'),  -- New Balance
(5, '+54 9 11 5566-7788'),  -- Vans
(5, '+54 9 11 9988-7766');  -- Vans (segundo teléfono)

-- Insertar emails de proveedores
INSERT INTO `Email_proveedor` (`proveedor_id`, `email`) 
VALUES 
(1, 'contacto@nike.com'),   -- Nike
(2, 'info@adidas.com'),      -- Adidas
(3, 'atencion@puma.com'),    -- Puma
(3, 'ventas@puma.com'),      -- Puma (segundo email)
(4, 'ventas@newbalance.com'), -- New Balance
(5, 'soporte@vans.com'),     -- Vans
(5, 'contacto@vans.com');    -- Vans (segundo email)



-- PROCEDIMIENTOS ALMACENADOS


-- Agregar un nuevo producto
DELIMITER //

CREATE PROCEDURE AgregarProducto(
    IN nombreProducto VARCHAR(50),
    IN precioProducto DOUBLE,
    IN categoriaSubcategoriaID INT,
    IN proveedorID INT
)
BEGIN
    INSERT INTO Productos (nombre_producto, precio, categoria_subcategoria_id, proveedor_id)
    VALUES (nombreProducto, precioProducto, categoriaSubcategoriaID, proveedorID);
END //

DELIMITER ;

-- TEST :
call AgregarProducto("Pantuflas",2650.0,2,3);
select * from Productos;


-- Registra la salida de productos
DELIMITER //

CREATE PROCEDURE RegistrarSalidaProducto(
    IN ejemplarProductoID INT,
    IN cantidadSalida INT,
    IN tipoSalida ENUM('VENTA', 'PERDIDA', 'DEVOLUCION_PROVEEDOR')
)
BEGIN
    INSERT INTO Salida_productos (ejemplar_producto_id, fecha_salida, cantidad, tipo_salida)
    VALUES (ejemplarProductoID, CURDATE(), cantidadSalida, tipoSalida);

    UPDATE Ejemplar_producto
    SET stock = stock - cantidadSalida
    WHERE ejemplar_producto_id = ejemplarProductoID;
END //

DELIMITER ;

-- TEST:
call RegistrarSalidaProducto(1,5,'VENTA');
select * from Ejemplar_producto;


-- Registrar entrada de productos.
DELIMITER //

CREATE PROCEDURE RegistrarEntradaProducto(
    IN ejemplarProductoID INT,
    IN cantidadIngreso INT,
    IN empleadoID INT,
    IN tipoEntrada ENUM('REABASTECIMIENTO', 'DEVOLUCION_CLIENTE')
)
BEGIN
    INSERT INTO Entrada_productos (fecha_entrada, tipo_entrada, empleado_id, ejemplar_producto_id, cantidad_ingreso)
    VALUES (CURDATE(), tipoEntrada, empleadoID, ejemplarProductoID, cantidadIngreso);

    UPDATE Ejemplar_producto
    SET stock = stock + cantidadIngreso
    WHERE ejemplar_producto_id = ejemplarProductoID;
END //

DELIMITER ;

-- TEST:
call RegistrarEntradaProducto(1,5,3,'REABASTECIMIENTO');
select * from Ejemplar_producto;


-- Checkear stock de un producto.
DELIMITER //

CREATE PROCEDURE consultarStockProducto(
    IN p_codigo_barras INT
)
BEGIN
    SELECT 
        p.nombre_producto AS Producto,
        e.stock AS Stock,
        t.talle AS Talle,
        s.sector AS Sector
    FROM Ejemplar_producto e
    INNER JOIN Productos p ON e.producto_id = p.producto_id
    INNER JOIN Talles t ON e.talle_id = t.talle_id
    INNER JOIN Sectores s ON e.sector_id = s.sector_id
    WHERE e.codigo_barras = p_codigo_barras;
END //

DELIMITER ;

-- TEST:
call consultarStockProducto(100000020);