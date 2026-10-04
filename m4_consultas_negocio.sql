-- == Motor SQl utilizadopaa el ejercicio: POstgre SQL
 
-- == CONSULTA 1 ==
-- Resumen ejecutivo mensual: total facturado, cantidad de pedidos, y ticket promedio  

SELECT
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM 
	ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

-- == CONSULTA 2 ==
-- Ranking de productos: top 5 de productos de mayor facturacion, mostrando las unidades vendidas de manera individual, y lo generado 

SELECT
	id_producto,
	SUM(cantidad) AS unidades_vendidas,
	SUM(cantidad * precio_unitario) AS total_generado
FROM 
	ventas
GROUP BY id_producto
ORDER BY total_generado DESC
LIMIT 5;

-- == CONSULTA 3 ==
-- Clientes recurrentes: clientes que hayan realizado mas de un pedido, mostrando la cantidad y el total gastado 

SELECT
	id_cliente,
	COUNT(*) AS cantidad_pedidos,
	SUM(cantidad * precio_unitario) AS total_gastado
FROM 
	ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1 
ORDER BY total_gastado DESC;

-- == CONSULTA 4 ==
-- Meses por encima/por debajo del promedio: total facturado por mes, con una columna adicional que etiquete cuando un mes estuvo por encima o debajo del promedio mensual facturado 

WITH facturacion_mensual AS (
    SELECT
        EXTRACT(MONTH FROM fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY EXTRACT(MONTH FROM fecha_venta)
)
SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > AVG(total_facturado) OVER () THEN 'Por encima'
        WHEN total_facturado < AVG(total_facturado) OVER () THEN 'Por debajo'
        ELSE 'En promedio'
    END AS comparacion_promedio
FROM facturacion_mensual
ORDER BY mes;

-- == Bloque de cierre ==

-- Hallazgo N1: El producto 1 concentra $3.600,00 de facturación, equivalente al 55,9% del total mensual.
-- Hallazgo N2: El cliente 1 es quien más gastó, con $2.640,00 distribuidos en 2 pedidos.
-- Hallazgo N3: El producto 2 fue el más vendido en unidades (13), pero quedó quinto en facturación ($364,00) por su menor precio unitario.