--- Consulta 1 — Resumen ejecutivo mensual
SELECT 
  EXTRACT(MONTH FROM fecha_venta) AS mes,
  SUM(cantidad*precio_unitario)AS total_facturado,
  COUNT (DISTINCT id_cliente)AS cantidad_pedidos,
  ROUND (SUM(cantidad*precio_unitario)/COUNT(DISTINCT id_venta),2)AS ticket_promedio
FROM
  ventas
GROUP BY 
   EXTRACT(MONTH FROM fecha_venta)
ORDER BY
  mes ASC

--- Consulta 2 — Ranking de productos
 SELECT
   id_producto AS producto,
   SUM (cantidad*precio_unitario)AS total_facturado,
   SUM (cantidad) AS cantidad_vendida
FROM 
   ventas
GROUP BY 
  id_producto
ORDER BY 
  cantidad_vendida DESC
LIMIT 5

--- Consulta 3 — Clientes recurrentes 
SELECT
  id_cliente AS cliente,
  COUNT(*)AS Cantidad_pedidos,
  SUM (cantidad*precio_unitario)AS total_gastado
 FROM 
   ventas
 GROUP BY 
   id_cliente
 HAVING COUNT(*)>1
 ORDER BY  
   id_cliente

 --- Consulta 4 — Meses por encima/por debajo del promedio
WITH ventas_mensuales AS (
  SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad*precio_unitario)AS total_facturado
 FROM
     ventas
 GROUP BY
    EXTRACT(MONTH FROM fecha_venta) 
 )
SELECT 
 mes,
 total_facturado,
 ROUND(AVG(total_facturado)OVER(),2)AS promedio_general,

 CASE
  WHEN total_facturado>AVG(total_facturado)OVER() THEN 'Por encima'
  WHEN total_facturado<AVG(total_facturado)OVER() THEN 'Por debajo'
  ELSE 'Igual al promedio'
 END AS etiqueta_promedio
FROM 
  ventas_mensuales
ORDER BY 
  mes

---Bloque de cierre
-- Todas las ventas ingresadas en la base de datos corresponden a marzo, por lo que no encontre hallazgos en relacion al mes de venta
-- El producto mas vendido (considerando la cantidad vendida)es el producto id_producto 2, con 13 unidades
-- Todos los clientes son igualmente recurrentes, ya que cada uno realizo 2 compras en el mes de marzo
-- Al tenes solo informacion del mes de marzo, el promedio por mes coincide con el promedio general