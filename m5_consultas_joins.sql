--- Consulta 1
-- En la base de datos Ventas_Tech_DB no hay informacion sobre segmento/canales, por lo que no se incluye dicha informacion en la consulta
-- Para suplir esto se reemplaza el “region/territorio” por clientes.ciudad
 SELECT
  ventas.fecha_venta,
  clientes.nombre AS nombre_cliente,
  clientes.ciudad,
  productos.nombre_producto,
  categorias.nombre_categoria AS categoria_producto,
  ventas.cantidad AS cantidad_vendida,
  ventas.precio_unitario,
  ventas.cantidad*ventas.precio_unitario AS total_facturado
 FROM
   ventas
 INNER JOIN
   clientes ON ventas.id_cliente=clientes.id_cliente
 INNER JOIN
   productos on ventas.id_producto=productos.id_producto
 INNER JOIN 
   categorias ON productos.id_categoria=categorias.id_categoria
 ORDER BY ventas.fecha_venta

 --- Consulta 2
 SELECT
   c.nombre,
   c.email,
   c.fecha_registro
FROM
   clientes AS c
 LEFT JOIN 
    ventas AS v 
	ON C.id_cliente=v.id_cliente
WHERE v.id_cliente IS NULL

--- Consulta 3
 SELECT
   p.nombre_producto,
   ca.nombre_categoria,
   p.precio
FROM
   productos AS p
 LEFT JOIN 
    ventas AS v 
	ON p.id_producto=v.id_producto
LEFT JOIN
   categorias AS ca
   ON p.id_categoria=ca.id_categoria
WHERE v.id_producto IS NULL

--- Consulta 4
-- En la base de datos Ventas_Tech_DB no hay informacion sobre ventas online/presencil, por lo que no se puede realizar esta consulta
-- Para suplir esto se realiza la consulta por categorias de producto. Se seleccionan las categorias "computcion" y"audio" para hacer la consulta
SELECT 
  categoria,
  SUM (total_venta) AS total_por_categoria
  FROM (
    SELECT 
	v.cantidad*v.precio_unitario AS total_venta,
	 'Computación' AS categoria
	FROM ventas v
	JOIN productos p
	  ON v.id_producto=p.id_producto
	JOIN categorias c
	   ON p.id_categoria=c.id_categoria
	WHERE c.nombre_categoria='Computación'

UNION ALL

 SELECT 
	v.cantidad*v.precio_unitario AS total_venta,
	 'Audio' AS categoria
	FROM ventas v
	JOIN productos p
	  ON v.id_producto=p.id_producto
	JOIN categorias c
	   ON p.id_categoria=c.id_categoria
	WHERE c.nombre_categoria='Audio'

  )AS consolidado

  GROUP BY categoria;

   
   


 

  