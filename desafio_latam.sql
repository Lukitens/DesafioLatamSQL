USE checkpoint_m2;

### ORDEN DE CONSULTAS SQL
# 1 SELECT
# 2 FROM
# 3 WHERE
# 4 GROUPBY
# 5 HAVING
# 6 ORDER BY
# 7 LIMIT
                        -- SELECCIONADO DE COLUMNAS
#Seleccionar todo de una tabla
SELECT * FROM canal_venta;

# Seleccionar una columna de una tabla
SELECT canal FROM canal_venta;

#Seleccionar una columna de una tabla y cambiar el nombre con el que se retorna la columna
SELECT canal AS cc FROM canal_venta;

################################################################

################################################################

                     -- Seleccionando filas

# Orden de las clausulas:
# 1 SELECT
# 2 FROM
# 3 WHERE

#Seleccionar columnas con mayor
SELECT Concepto, Precio FROM producto
WHERE precio > 100;

#Seleccionar columnas con menor
SELECT Concepto, Precio FROM producto
WHERE precio < 50;

#Seleccionar columnas con menor o igual
SELECT Concepto, Precio FROM producto
WHERE precio <= 125;

# Seleccionar el nombre de un producto
SELECT * FROM producto
WHERE Concepto = "EPSON COPYFAX 2000";

#Seleccionar los productos que contengan la palabra epson
SELECT * FROM producto
WHERE concepto LIKE "%EPSON%";

#Seleccionar valores booleanos EJEMPLO:
# SELECT * FROM producto WHERE disponibilidad = True

#Seleccionar usando OR
SELECT * FROM producto
WHERE concepto LIKE "%EPSON%" OR (precio < 1000 AND precio > 100);

#Seleccionar usando OR
# SELECT * FROM clientes
# WHERE ciudad = "Madrid" OR saldo < 0

#Seleccionar despues de una fecha determinada
#SELECT * FROM productos WHERE fecha_de_creacion > "2021-05-01"

# Seleccionar entre
SELECT * FROM producto
WHERE precio BETWEEN 100 AND 1000;

#Seleccionar en base a la primera letra
# Supongamos que queremos buscar todos los usuarios cuyo nombre empiece con la letra 'J' 
#en la tabla de usuarios. Podemos hacer esto utilizando la siguiente consulta:
#SELECT * FROM usuarios WHERE nombre LIKE 'J%'
SELECT * FROM producto
WHERE Concepto LIKE "A%";

#Seleccionar en base a la última letra
SELECT * FROM producto
WHERE concepto LIKE "%A";

# Seleccionar todas las filas que NO contengan nulos
SELECT * FROM producto WHERE concepto IS NOT NULL;

# Seleccionar las filas que TENGAN nulos
SELECT * FROM producto WHERE concepto IS NULL;

#################################################################################

#################################################################################

					-- ORDENAR FILAS
#Es importante tener en cuenta que las claúsulas tienen que especificarse justo en este orden:
#1 SELECT
#2 FROM
#3 ORDER BY

#Ordenar ascendentemente
SELECT * FROM producto
ORDER BY Precio ASC;

#Ordenar descendientemente
SELECT * FROM producto
ORDER BY Precio DESC;

# Ordenar los nulos todos juntos arriba
SELECT * FROM producto
ORDER BY precio IS NULL, precio ASC;

# Ordenar los nulos todos juntos abajo
SELECT * FROM producto
ORDER BY precio IS NULL, precio DESC;

###############################################################

###############################################################

						-- LIMIT
                        
SELECT * FROM producto
ORDER BY precio DESC LIMIT 5;

###############################################################

###############################################################

						-- OPERACIONES CON STRING
# Pasar todas las letras a mayusculas
SELECT UPPER(Concepto) FROM producto;

# Pasar todas las letras a minusculas
SELECT LOWER(Concepto) FROM producto;

# Eliminar los espacios iniciales y finales de un string
SELECT TRIM(Concepto) FROM producto;

#Ver la longitud de un string
SELECT LENGTH(Concepto) AS longitud, concepto FROM producto;

# Concatenar strings
SELECT CONCAT(concepto," " , tipo) AS CT from producto;

#Extraer una cantidad de caracteres de strings
#SELECT SUBSTR( string, inicio, largo )
SELECT SUBSTR(Concepto, 1, 5) FROM producto;

############################################################

############################################################

							-- Fechas
                            
# Obtener los registros que tengan la fecha y hora actual
SELECT * FROM venta 
WHERE Fecha = DATE(NOW());

#Obtener los registros que tengan solo la fecha actual
SELECT * FROM venta 
WHERE Fecha = CURDATE();

#Obtener solamente el año
SELECT *, YEAR(fecha) AS año_venta FROM venta;

#Obtener solamente el mes
SELECT *, MONTH(fecha) AS mes_venta FROM venta;

#Obtener solamente el día
SELECT *, DAY(fecha) AS dia_venta FROM venta;

#Extraer día y mes en una misma columna
SELECT *, CONCAT(MONTH(fecha), "-" ,DAY(fecha)) AS "MES-DIA" FROM venta;

#Filtrar en base a fechas
SELECT * FROM venta
WHERE Fecha = "2017-10-23";

################################################################

################################################################

									-- Funciones de agregación

#Sacar el valor maximo
SELECT MAX(Cantidad) FROM venta;

#Sacar el valor mínimo
SELECT MIN(Cantidad) FROM venta;

#Sacar el valor promedio
SELECT AVG(Cantidad) FROM venta;

#Sumar todos los registros de una columna
SELECT SUM(Cantidad) FROM venta;

#Contar todos los registros
SELECT COUNT(*) FROM producto;

#Funciones de agregacion con where
SELECT SUM(Cantidad) FROM venta
WHERE Precio > 10000;

SELECT COUNT(*) FROM producto
WHERE Concepto LIKE "%a";

#####################################################

#####################################################

										-- DISTINCT
                                      
#Seleccionar los valores únicos
SELECT DISTINCT IdProducto FROM venta;

#Seleccionar los valores unicos de los meses
SELECT DISTINCT MONTH(fecha) FROM venta
ORDER BY 1;

#Seleccionar y contar los valores unicos de los años
SELECT COUNT(DISTINCT YEAR(Fecha)) FROM venta;

#Obtener combinaciones de valores unicos de dos columnas
SELECT DISTINCT Tipo, Precio FROM producto;

###############################################################

###############################################################

									-- Group by
            
# Agrupar en base a la id de la sucursal
SELECT IdSucursal, count(*) FROM venta
GROUP BY IdSucursal
ORDER BY 1;

#Agrupar y sumar
SELECT IdProducto, SUM(Cantidad) AS cantidad_total FROM venta
GROUP BY IdProducto;

#Agrupar y hacer el promedio
SELECT IdProducto, AVG(cantidad) AS cantidad_AVG FROM venta
GROUP BY IdProducto;

#Agrupar y sacar el MAYOR de cada grupo
SELECT idProducto, MAX(cantidad) AS venta_max FROM venta
GROUP BY IdProducto;

#Agrupar y sacar el MENOR de cada grupo
SELECT idProducto, MIN(cantidad) AS venta_max FROM venta
GROUP BY IdProducto;

#Agrupar y sumar por mes
SELECT MONTH(Fecha), SUM(precio) AS valor_total FROM venta
GROUP BY MONTH(fecha);

#####################################################

#####################################################

										-- HAVING
-- En SQL, la cláusula GROUP BY nos permite agrupar datos. Si queremos filtrar la información obtenida utilizaremos HAVING.

-- HAVING se emplea para filtrar los resultados de una consulta que involucra funciones agregadas. En otras palabras, 
-- HAVING permite aplicar condiciones de filtrado a los resultados de funciones como COUNT, MAX, 
-- MIN, SUM y AVG después de que se han agrupado los datos con la cláusula GROUP BY.

# Contamos los registros en la que hubo la mayor cantidad de productos agrupandolos por año y mes y usamos el
# having para filtrar los que la cantidad fue mayor a 2
SELECT CONCAT(YEAR(fecha), "-", MONTH(fecha)) AS "año-mes", MAX(Cantidad) AS cantidad_maxima FROM venta
GROUP BY CONCAT(YEAR(fecha), "-", MONTH(fecha))
HAVING cantidad_maxima > 2;

# Ver duplicados
SELECT IdCanal, COUNT(*) FROM venta
GROUP BY IdCanal
HAVING COUNT(*) > 1;

################################################################

################################################################

									-- SUB CONSULTAS
                                    
-- Sacar los productos que valgan mas que el promedio con sub consultas
SELECT * FROM producto WHERE Precio > (SELECT AVG(precio) FROM producto);

#DELETE FROM producto WHERE IDProducto = '42803' OR IDProducto = '42804' OR IDProducto = '42805' OR IDProducto = '42808';

-- Mostrar los productos que valgan mas que el promedio de los productos que contengan la palabra epson
SELECT * FROM producto WHERE Precio > (SELECT AVG(Precio) FROM producto WHERE Concepto LIKE "%EPSON%");

-- Motras los productos que valgan mas que el producto mas caro de epson
SELECT * FROM producto WHERE precio > (SELECT MAX(Precio) FROM producto WHERE Concepto LIKE "%EPSON%");

### OPERADOR IN
# El operador IN es un operador muy útil en subconsultas. Para entenderlo, primero probaremos una 
# consulta sencilla utilizandolo directamente sin subconsultas.

# Queremos seleccionar todos los códigos de Argentina, Brasil, Chile o Colombia. Una forma de abordar 
#el problema sería combinar todas las opciones con where y múltiples operadores or. 
#Otra opción es utilizando el operador IN de la siguiente manera:
#SELECT * FROM paises WHERE pais IN ("Argentina", "Brazil", "chile")

# OTRO EJEMPLO: SELECT nombre AS nombres_seleccionados FROM libros WHERE libro_id IN (SELECT libro_id FROM valoraciones WHERE valoracion_promedio > 4)

# Averiguar el promedio que vende cada sucursal
SELECT AVG(ventas_sucursal) FROM (
SELECT SUM(precio * cantidad) AS ventas_sucursal
FROM venta
GROUP BY IdSucursal) AS subquery;

################################################################

################################################################

									-- COMBINACIÓN DE CONSULTAS CON UNION
                                    
USE colegio;

# El operador UNION en SQL se utiliza para combinar el resultado de dos o más SELECT en un solo conjunto de resultados.
# LA sintaxis básica de un union es:
# SELECT columna FROM tabla
# UNION SELECT columna FROM tabla;
# UNION TAMBIEN ELIMINA LOS RESULTADOS DUPLICADOS

#En este caso juntamos todos los apellidos en una misma columna
SELECT apellido AS apellidos FROM alumno
UNION
SELECT apellido FROM profesor;

# SI QUEREMOS CONSERVAR LOS RESULTADOS DUPLICADOS DEBEMOS USAR UNION ALL
SELECT * FROM alumno UNION ALL SELECT * FROM profesor;

# Con INTERSECT podemos aplicar la union de los datos que se repitan en ambas tablas
# Ejemplo si en una tabla se repite juan y pepe y en otra tambien podemos usar intersect para averiguar cuales son
#los nombres que estan en ambas tablas, en Mysql no existe un intersect pero se puede hacer de la siguiente forma:

#SELECT DISTINCT (columna en comun)
# FROM tabla1
# WHERE (columna en comun) IN (SELECT columna_en_comun FROM tabla2)

# Ejemplo en SQLITE
# SELECT cliente FROM lista1 INTERSECT SELECT cliente FROM lista2

# EXCEPT: Solo devuelve las filas que sean unicas de esa tabla, que no se repitan en otra
USE checkpoint_m2;
SELECT IDProducto FROM producto EXCEPT SELECT IDProducto FROM venta;

################################################################

################################################################

									-- Inserción de registros
                                    
USE colegio;

#El null es para que tome el auto increment
INSERT INTO alumno VALUES (NULL , "Augusto", "Henry", 76545456);
SELECT * FROM alumno;

# Insertar registros en columnas especificas
INSERT INTO alumno (nombre, idAlumno, apellido, dni) VALUES ("Julian" , NULL, "Villegas", 76545456);

#Insertar varios registros
INSERT INTO alumno (nombre, apellido, dni) VALUES ("Lucas", "Raña", "46706236"), ("Agustin", "Sagasta", "43432342"), ("Maxi", "Wainberg", "3129030");

#Crear un campo auto incremental y que sea primary key
CREATE TABLE materias (idMateria INT PRIMARY KEY AUTO_INCREMENT, 
						nombre VARCHAR(50));

#Crear un campo primary key, auto incremental y que por defecto tenga un valor
DROP TABLE materias;
CREATE TABLE materias (idMateria INT PRIMARY KEY AUTO_INCREMENT, 
						nombre VARCHAR(50) DEFAULT("Rawn puto"));
                        
################################################################

################################################################

									-- ELIMINAR REGISTROS
								
# Eliminar todos los registros de una tabla
DELETE FROM materias;

# Eliminar los registros con WHERE
DELETE FROM materias WHERE nombre = "Matematica";

################################################################

################################################################

									-- ACTUALIZAR REGISTROS
                                    
# Update para realizar modificaciones en datos existentes con WHERE
# SIN EL WHERE AFECTA A TODAS LAS FILAS
UPDATE producto SET precio = precio + 1
WHERE IDProducto = 42779;

# Editar multiples columnas
#UPDATE producto SET
#	columna 1 = "nuevo valor",
#    columna 2 = "nuevo valor",
#    columna 3 = "nuevo valor"
#WHERE ID = 1;

################################################################

################################################################

									-- ACTUALIZAR TABLAS Y REESTRICCIONES
# Agregar una columna en una tabla
#ALTER TABLE nombre_tabla ADD COLUMN nombre_columna tipo_dato;

#con NOT NULL hacemos que ciertas columnas tengan que tener si o si un dato                                    
CREATE TABLE prueba (numero INT NOT NULL,
					nombre VARCHAR(30) NOT NULL);
			
# Copiar los datos a otra tabla y agregarle una condición
/*
INSERT INTO personas2 (nombre, apellido)
    SELECT nombre, apellido
    FROM personas; */

#Renombrar una tabla
ALTER TABLE prueba RENAME tabla_vacia;

################################################################

################################################################

									-- JOIN

SELECT A.idproducto, concepto, A.precio, cantidad FROM venta A
JOIN producto B ON (A.idproducto = B.idproducto);

USE adventureworks;
SELECT A.OrderDate, A.SubTotal, B.OrderQty, B.ProductID FROM salesorderheader A
JOIN salesorderdetail B ON (A.SalesORderID = B.SalesorderID);