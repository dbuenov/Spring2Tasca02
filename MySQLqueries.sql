-- Base de Dades Tienda
USE tienda;
SELECT nombre FROM producto;
SELECT nombre, precio FROM producto;
SELECT * FROM producto;
SELECT nombre, precio, precio*1.13 FROM producto;
SELECT nombre AS "Nom de producte", precio AS Euros, precio*1.13 AS Dolars FROM producto;
SELECT ucase(nombre) AS NOMBRE ,precio FROM producto;
SELECT lcase(nombre) AS nombre ,precio FROM producto;
SELECT nombre, ucase(substring(nombre,1,2)) FROM fabricante;
SELECT nombre, ceil(precio) FROM producto;
SELECT nombre, floor(precio) FROM producto;
SELECT f.codigo FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante;
SELECT f.codigo FROM fabricante f JOIN producto p ON f.codigo = p.codigo_fabricante GROUP BY f.codigo;
SELECT nombre FROM fabricante ORDER BY nombre;
SELECT nombre FROM fabricante ORDER BY nombre DESC;
SELECT nombre FROM producto ORDER BY nombre, precio DESC;
SELECT * FROM fabricante LIMIT 5;
SELECT * FROM fabricante LIMIT 3,2;
SELECT nombre, precio FROM producto ORDER BY precio LIMIT 1;
SELECT nombre, precio FROM producto ORDER BY precio DESC LIMIT 1;
SELECT nombre FROM producto where codigo_fabricante = 2;
SELECT p.nombre, p.precio, f.nombre as fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre, p.precio, f.nombre as fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY f.nombre;
SELECT p.codigo, p.nombre, f.codigo, f.nombre as fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo;
SELECT p.nombre, p.precio, f.nombre as fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio LIMIT 1;
SELECT p.nombre, p.precio, f.nombre as fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo ORDER BY p.precio DESC LIMIT 1;
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "lenovo";
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "crucial" AND p.precio>200;
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "asus" OR f.nombre = "hewlett-packard" OR f.nombre =  "seagate";
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre IN ("asus", "hewlett-packard", "seagate");
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%e";
SELECT p.nombre, p.precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre LIKE "%w%";
SELECT p.nombre, p.precio, f.nombre AS fabricante FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE p.precio >= 180 ORDER BY p.precio DESC, p.nombre;
SELECT f.codigo, f.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo GROUP BY f.codigo;
SELECT f.nombre AS fabricante, p.nombre FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante;
SELECT f.nombre AS fabricante FROM fabricante f LEFT JOIN producto p ON f.codigo = p.codigo_fabricante WHERE p.nombre IS NULL;
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "lenovo");
SELECT * FROM producto WHERE precio = (SELECT precio FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = "lenovo") ORDER BY precio DESC LIMIT 1);
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "lenovo" ORDER BY precio DESC LIMIT 1;
SELECT p.nombre FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "hewlett-packard" ORDER BY precio LIMIT 1;
SELECT * FROM producto WHERE precio >= (SELECT precio FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "lenovo" ORDER BY precio DESC LIMIT 1);
SELECT * FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "asus" AND p.precio>(SELECT sum(p.precio)/count(p.codigo) FROM producto p JOIN fabricante f ON p.codigo_fabricante = f.codigo WHERE f.nombre = "asus");

-- Base de dades Universidad
USE universidad;
SELECT apellido1, apellido2, nombre FROM persona WHERE tipo = "alumno" ORDER BY apellido1, apellido2, nombre;
SELECT nombre, apellido1, apellido2 FROM persona WHERE tipo = "alumno" AND telefono IS NULL;
SELECT * FROM persona WHERE tipo = "alumno" AND fecha_nacimiento BETWEEN "1999-01-01" AND "1999-12-31";
SELECT * FROM persona WHERE tipo = "profesor" AND telefono IS NULL AND nif LIKE "%k";
SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;
SELECT p.apellido1, p.apellido2, p.nombre, d.nombre AS Departament FROM persona p JOIN profesor pr ON p.id = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id WHERE tipo="profesor" ;
SELECT a.nombre AS asignatura, c.anyo_inicio, c.anyo_fin FROM persona p JOIN alumno_se_matricula_asignatura m ON p.id = m.id_alumno JOIN asignatura a ON m.id_asignatura = a.id JOIN curso_escolar c ON m.id_curso_escolar = c.id WHERE p.nif="26902806M" ;
SELECT d.nombre FROM departamento d JOIN profesor p ON d.id = p.id_departamento JOIN asignatura a ON p.id_profesor = a.id_profesor JOIN grado g ON a.id_grado = g.id WHERE g.nombre = "Grado en Ingeniería Informática (Plan 2015)" GROUP BY d.nombre;
SELECT * FROM persona p JOIN alumno_se_matricula_asignatura m ON p.id =m.id_alumno JOIN curso_escolar c ON m.id_curso_escolar = c.id WHERE tipo="alumno" AND c.anyo_inicio = 2018 GROUP BY p.id;

-- Utilitzant LEFT JOIN i RIGHT JOIN
SELECT d.nombre AS departamento, p.apellido1, p.apellido2, p.nombre FROM persona p JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN departamento d ON pr.id_departamento = d.id ORDER BY d.nombre, p.apellido1, p.nombre;
SELECT * FROM persona p JOIN profesor pr ON p.id = pr.id_profesor WHERE pr.id_departamento IS NULL;
SELECT d.nombre FROM departamento d LEFT JOIN profesor pr ON pr.id_departamento = d.id WHERE pr.id_profesor IS NULL;
SELECT * FROM persona p LEFT JOIN asignatura a ON p.id = a.id_profesor WHERE p.tipo = "profesor" AND a.id_profesor IS NULL;
SELECT * FROM asignatura a LEFT JOIN profesor pr ON a.id_profesor = pr.id_profesor WHERE a.id_profesor IS NULL;
SELECT d.nombre FROM alumno_se_matricula_asignatura m RIGHT JOIN asignatura a ON m.id_asignatura = a.id RIGHT JOIN profesor pr ON a.id_profesor = pr.id_profesor JOIN departamento d ON pr.id_departamento = d.id WHERE a.id IS NULL GROUP BY d.nombre;

-- Consultes Resum
SELECT count(id) FROM persona WHERE tipo="alumno";
SELECT count(id) FROM persona WHERE tipo="alumno" AND fecha_nacimiento BETWEEN "1999-01-01" AND "1999-12-31";
SELECT d.nombre, count(pr.id_profesor) AS quantitat FROM profesor pr JOIN departamento d ON pr.id_departamento = d.id GROUP BY id_departamento ORDER BY quantitat DESC;
SELECT d.nombre, count(pr.id_profesor) AS quantitat FROM profesor pr RIGHT JOIN departamento d ON pr.id_departamento = d.id GROUP BY id_departamento ORDER BY quantitat DESC;
SELECT g.nombre, count(a.id) AS quantitat FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id ORDER BY quantitat DESC;
SELECT * FROM (SELECT count(a.id) AS quantitat, g.nombre FROM grado g LEFT JOIN asignatura a ON g.id = a.id_grado GROUP BY g.id) as tabla WHERE quantitat>40;
SELECT  g.nombre, a.tipo, sum(a.creditos) FROM asignatura a JOIN grado g ON a.id_grado = g.id GROUP BY a.id_grado, a.tipo;
SELECT c.anyo_inicio, count(distinct(m.id_alumno)) FROM alumno_se_matricula_asignatura m JOIN curso_escolar c ON m.id_curso_escolar = c.id GROUP BY m.id_curso_escolar;
SELECT p.id, p.nombre, p.apellido1, p.apellido2, count(a.id) AS numero_asignaturas FROM asignatura a RIGHT JOIN persona p ON a.id_profesor = p.id WHERE p.tipo = "profesor" GROUP BY p.id ORDER BY numero_asignaturas DESC;
SELECT * FROM persona p JOIN alumno_se_matricula_asignatura m ON p.id = m.id_alumno JOIN asignatura a ON m.id_asignatura = a.id JOIN grado g ON a.id_grado = g.id WHERE p.tipo = "alumno" AND p.fecha_nacimiento = (SELECT max(fecha_nacimiento) FROM persona WHERE tipo="alumno");
SELECT * FROM persona p JOIN profesor pr ON p.id = pr.id_profesor LEFT JOIN asignatura a ON pr.id_profesor = a.id_profesor WHERE a.id IS NULL;




