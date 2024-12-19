--EJERCICIOS PARA BASE DE DATOS ORDENES DE MANTENIMIENTO
USE gestion_ordenes_mantenimiento

-- 1. Seleccionar la cantidad de trabajos por taller
SELECT 
    t.id AS taller_id,
    t.nombre_taller,
    COUNT(o.id) AS total_ordenes
FROM 
    talleres t
JOIN 
    ordenes_mantenimiento o ON t.id = o.taller_id
GROUP BY 
    t.id, t.nombre_taller
ORDER BY 
    t.nombre_taller;

-- 2. Seleccionar todas las ordenes que estan listas para ser ejecutadas

SELECT 
    r.id AS reserva_id, 
    r.numero_reserva, 
    r.qty_solicitada, 
    r.qty_retirada, 
    e.qty_stock, 
    (r.qty_solicitada - (r.qty_retirada + e.qty_stock)) AS cantidad_diferencia,
    o.id AS orden_id,
    o.orden_trabajo,
    o.tipo_orden,
    o.descripcion_trabajo,
    o.equipo,
    o.descripcion_equipo,
    o.numero_horas
FROM 
    reservas r
JOIN 
    materiales m ON r.material_id = m.id
JOIN 
    existencias e ON m.id = e.material_id
JOIN 
    ordenes_mantenimiento o ON r.orden_mantenimiento_id = o.id
WHERE 
    r.qty_solicitada - (r.qty_retirada + e.qty_stock) <= 0;

-- 3. Cantidad de Pedidos con fecha atrasada
SELECT 
    p.id AS pedido_id,
    p.numero_pedido,
    p.fecha_generacion,
    p.fecha_entrega,
    p.costo_total,
    p.qty_pedido,
    p.qty_pendiente_entrega,
    DATEDIFF(DAY, p.fecha_entrega, GETDATE()) AS dias_retraso
FROM 
    pedidos p
WHERE 
    p.fecha_entrega < GETDATE();


-- 4. Vista de trabajos y carga laboral por taller
CREATE VIEW vw_resumen_talleres_carga_laboral AS
SELECT 
    t.id AS taller_id,
    t.nombre_taller,
    COUNT(o.id) AS cantidad_ordenes,
    SUM(o.numero_horas * o.qty_personas) AS total_carga_laboral_HH
FROM 
    talleres t
LEFT JOIN 
    ordenes_mantenimiento o ON t.id = o.taller_id
GROUP BY 
    t.id, t.nombre_taller;

	SELECT*FROM vw_resumen_talleres_carga_laboral

-- 5. Vista de pedidos por proveedor
CREATE VIEW vw_pedidos_por_proveedor AS
SELECT 
    p.proveedor_id,
    pr.nombre_proveedor,
    COUNT(p.id) AS total_pedidos,
    SUM(p.qty_pedido) AS total_qty_pedido,
    SUM(p.qty_pendiente_entrega) AS total_qty_entregada
FROM 
    pedidos p
JOIN 
    proveedores pr ON p.proveedor_id = pr.id
GROUP BY 
    p.proveedor_id, pr.nombre_proveedor;

	SELECT*FROM vw_pedidos_por_proveedor

-- 6. Vista de estado de ordenes con materiales

CREATE VIEW vw_estado_ordenes_materiales AS
SELECT 
    o.id AS orden_mantenimiento_id,
    o.orden_trabajo,
    o.descripcion_trabajo,
    r.material_id,
    m.descripcion_material,
    r.qty_solicitada,
    r.qty_retirada,
    e.qty_stock,
    (r.qty_solicitada - r.qty_retirada) AS cantidad_pendiente
FROM 
    ordenes_mantenimiento o
JOIN 
    reservas r ON o.id = r.orden_mantenimiento_id
JOIN 
    materiales m ON r.material_id = m.id
LEFT JOIN 
    existencias e ON m.id = e.material_id;

	SELECT*FROM vw_estado_ordenes_materiales

-- 7. Procedimiento para actualizar la cantidad de materiales retirados
CREATE PROCEDURE sp_actualizar_qty_retirada
    @reserva_id INT,
    @qty_retirada INT
AS
BEGIN
    UPDATE reservas
    SET qty_retirada = @qty_retirada
    WHERE id = @reserva_id;
END;

EXEC sp_actualizar_qty_retirada @reserva_id =24, @qty_retirada = 3

-- 8. Procedimiento para eliminar una orden de mantenimiento
CREATE PROCEDURE sp_eliminar_orden_mantenimiento
    @id INT
AS
BEGIN
    DELETE FROM ordenes_mantenimiento
    WHERE id = @id;
END;