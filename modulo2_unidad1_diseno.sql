-- Ejercicio de diseño de base de datos: Sistema de gestión de ventas

CREATE TABLE Clientes (
idCliente int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) Primary Key,
nombreCliente varchar(50) not null, 
direccionCliente varchar(50) not null,
correoCliente varchar(50) not null,
perfilBio text not null,
fechaRegistro timestamp not null
);

-- El idCliente se elige ppara poder posteriormente relacionar la tabla con otroas (aplicando el modelo relacional), el nombreCliente permite posteriormente poder llamar al cliente de manera pesonalizada en caso de realizar una campaña de MKT vía mailing, por esew motivo tamvién se solicita correoCliente. fechaREgistro nos permite identificar la fecha con la cual el cliente comenzó a elegirnos. direccionCliente nos permite localizar gegráficamente al cliente para posteriores anális de datos. perfilBio nos permite comenar con mayor detalle algun aspecto clave del usuario.

CREATE TABLE productos (
idProducto int GENERATED ALWAYS AS IDENTITY (START WITH 1 INCREMENT BY 1) Primary Key,
descripcionProducto varchar(55) not null,
precio NUMERIC(10,2) not null,
enInevntario BOOLEAN not null default false,
cantidadStock INTEGER not null default 0 check (cantidadStock >=0)
);

-- idProducto se elige para poder posteriormente relacionar la tabla con otroas (aplicando el modelo relacional),, descripcionProducto se elgie para poder contar con información de las especificaciones del producto, precio se establece para contar con su valor monetario, enInventario se elige para determinar si el artículo está actualmente en stock, cantidadStock para conocer el número exacto de su cantidad.