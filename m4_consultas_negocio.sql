---Consulta 1
SELECT 
  SUM(cantidad*precio_unitario) AS total_facturado,
  COUNT (id_venta) AS cant_pedidos,
  AVG (cantidad*precio_unitario)AS ticket_promedio
  FROM ventas
  GROUP BY EXTRACT(MONTH FROM fecha_venta) ---La base de datos no tiene el campo mes

 ---Consulta 2 
 SELECT
   id_producto,
   SUM (cantidad*precio_unitario)AS total_facturado,
   SUM (cantidad) AS cantidad_vendida
FROM ventas
GROUP BY id_producto
ORDER BY id_producto
LIMIT 5

---Consulta 3
SELECT
  id_cliente,
  COUNT(*)AS Cantidad_pedidos,
  SUM (cantidad*precio_unitario)AS total_gastado
 FROM ventas
 GROUP BY id_cliente
 HAVING COUNT(*)>1
 ORDER BY id_cliente

 ---Consulta 4
 ---La base de datos utilizada Ventas_Tech_DB creada en el modulo 3 no cuenta con informcion sobre ventas por mes, por lo cual no se puede realizar esta consulta
 --Si tuvieramos el dato del mes la consulta seria la siguiente
 SELECT
    mes,
    total_facturado,
    CASE
        WHEN total_facturado > promedio_mensual THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM (
    SELECT
        EXTRACT(MONTH FROM fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado,
        AVG(SUM(cantidad * precio_unitario)) OVER () AS promedio_mensual
    FROM ventas
    GROUP BY EXTRACT(MONTH FROM fecha_venta)
) AS resumen_mensual
ORDER BY mes;

---Bloque de cierre
-- El producto mas vendido (considerando la cantidad vendida)es el producto id_producto 3
-- El producto con mayor total facturado es el producto id_producto 1
-- El cliente que mas gasto fue el id_cliente 1

 
 