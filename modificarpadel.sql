/*Actividades
Las actividades se realizarán en SQL-Plus desde un usuario llamado USUARIO1 con
contraseña USU1. Crea dicho usuario y dale permisos para conectarse y crear recursos. Si
no recuerdas cómo hacerlo, en la práctica 1 se indicaban las instrucciones necesarias.
Ejecuta desde el usuario USUARIO1 el fichero crearbdpadel.sql que creaste para la
práctica 1. Si no tienes el fichero utiliza el fichero adjunto.
Fichero adjunto:
• crearbdpadel.sql: fichero con la creación de las tablas de la práctica 1.
NOTA: Si utilizas un ordenador personal y ya tienes creados el usuario y la base de datos
de la práctica 1 no tienes que realizar los pasos anteriores.
Realiza las siguientes modificaciones en la estructura de las tablas utilizando la instrucción
ALTER TABLE. Guarda todas las instrucciones ALTER TABLE en un fichero llamado
modificarbdpadel.sql.*/


/*1.- Tabla PISTA
El tipo de datos del código de la pista debe ser un texto de longitud 10. En caso de que no
lo sea, haz las modificaciones oportunas en la tabla.*/

/*RECORDAMOS TABLA PISTA

CREATE TABLE PISTA 
(
   codigo		VARCHAR2(10) CONSTRAINT pis_cod_pk PRIMARY KEY, 
   estado		VARCHAR2(20), 
   observaciones	VARCHAR2(45)
);

YA ES VARCHAR2(10)

 DESC PISTA
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CODIGO                                    NOT NULL VARCHAR2(10)
 ESTADO                                             VARCHAR2(20)
 OBSERVACIONES                                      VARCHAR2(45)

 */

   /*2.- Tabla ALUMNO
   Añade una columna llamada email para guardar el correo electrónico de un alumno. Este
   dato tendrá como mucho 30 caracteres. Verifica que se añade la columna. 

   CREATE TABLE ALUMNO
   (
      dni          VARCHAR2(10) CONSTRAINT alu_dni_pk PRIMARY KEY, 
      nombre       VARCHAR2(25), 
      apellido1    VARCHAR2(25), 
      telefono     VARCHAR2(30), 
      fechanac     DATE, 
      sexo         VARCHAR2(10)
   );

   DESC ALUMNO
   Name                                      Null?    Type
   ----------------------------------------- -------- ----------------------------
   DNI                                       NOT NULL VARCHAR2(10)
   NOMBRE                                             VARCHAR2(25)
   APELLIDO1                                          VARCHAR2(25)
   TELEFONO                                           VARCHAR2(30)
   FECHANAC                                           DATE
   SEXO                                               VARCHAR2(10)
   
   Como no tiene la columna... Añadimos la columna.

   */

ALTER TABLE ALUMNO 
ADD email VARCHAR2(30);

/* Si ahora observamos DESC TABLE... Observamos lo siguiente...
 DESC ALUMNO
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 DNI                                       NOT NULL VARCHAR2(10)
 NOMBRE                                             VARCHAR2(25)
 APELLIDO1                                          VARCHAR2(25)
 TELEFONO                                           VARCHAR2(30)
 FECHANAC                                           DATE
 SEXO                                               VARCHAR2(10)
 EMAIL                                              VARCHAR2(30)
*/

/*3.- Tabla ALUMNO
El sexo se guarda con 1 único carácter. Comprueba que el tipo de datos de esta columna
se ajusta a esta especificación. En caso contrario, modifícalo. */

ALTER TABLE ALUMNO MODIFY (SEXO VARCHAR2(1));

/*
   DESC ALUMNO
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 DNI                                       NOT NULL VARCHAR2(10)
 NOMBRE                                             VARCHAR2(25)
 APELLIDO1                                          VARCHAR2(25)
 TELEFONO                                           VARCHAR2(30)
 FECHANAC                                           DATE
 SEXO                                               VARCHAR2(1)
 EMAIL                                              VARCHAR2(30)
*/

/*4.- Tabla ALUMNO
El sexo solamente puede tener dos posibles valores ‘H’ para hombre y ‘M’ para mujer. Haz
los cambios y verifica que la restricción funciona correctamente. */

ALTER TABLE ALUMNO MODIFY (SEXO CONSTRAINT sexo_h_m CHECK (SEXO IN ('H','M')));



/*5.- Tabla MONITOR
El responsable del club quiere que sea obligatorio tener el teléfono de los monitores.
Modifica la tabla para dar respuesta a este requerimiento y verifica que se han hecho los
cambios en la estructura de la tabla.

Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 DNI                                       NOT NULL VARCHAR2(10)
 NOMBRE                                             VARCHAR2(25)
 APELLIDO1                                          VARCHAR2(25)
 TELEFONO                                  NOT NULL VARCHAR2(30)

 Este requerimiento ya se recoge ya que es NOT NULL
*/


/*6.- Tabla MONITOR
El responsable del club quiere asignar a cada monitor un código único para identificarlos.
Añade una columna llamada codigo para almacenar este valor de forma que sea una clave
alternativa de la tabla. El tipo de datos de este campo es texto de longitud 15.
Comprueba que se han creado el campo y las restricciones e inserta los siguientes
monitores para verificar si las restricciones funcionan adecuadamente.
*/

/*FALTA PONER NOMBRE RESTRICCIÓN OBLIGATORIO*/
ALTER TABLE MONITOR ADD CODIGO VARCHAR2(15) NOT NULL;

/* DESC MONITOR
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 DNI                                       NOT NULL VARCHAR2(10)
 NOMBRE                                             VARCHAR2(25)
 APELLIDO1                                          VARCHAR2(25)
 TELEFONO                                  NOT NULL VARCHAR2(30)
 CODIGO                                    NOT NULL VARCHAR2(15)
 
 A conitnuación añadimos el UNIQUE
 
 */

ALTER TABLE MONITOR ADD CONSTRAINT monitor_codigo UNIQUE(CODIGO);

/*A continuación se insertan los usuarios...*/

INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('11222333A', '605112233', 'Toni');
INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('22333444M', '649001122, 965714030', 'Lola');
INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('44333555S', '605001122', 'Toni'); -- This should raise a UNIQUE constraint violation
INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('44555666C', '965437657', NULL); -- This should raise a NOT NULL constraint violation
/*
dni telefono codigo
1 11222333A 605112233 Toni
2 22333444M 649001122, 965714030 Lola
3 44333555S 605001122 Toni
4 44555666C 965437657

Los monitores de las líneas 1 y 2 deben poder insertarse. Los monitores de las líneas 3 y 4
no. ¿Qué mensaje de error se muestra en estos dos últimos casos?*/

/*

SQL> INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('44333555S', '605001122', 'Toni');
INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('44333555S', '605001122', 'Toni')

ERROR at line 1:
ORA-00001: unique constraint (USUARIO1.MONITOR_CODIGO) violated


SQL> INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('44555666C', '965437657', NULL);
INSERT INTO MONITOR (dni, telefono, codigo) VALUES ('44555666C', '965437657', NULL)
                                                                              
ERROR at line 1:
ORA-01400: cannot insert NULL into ("USUARIO1"."MONITOR"."CODIGO")

*/


/*7.- Tabla CURSO
En el modelo lógico de la práctica 1 no se incluyó la clave ajena de CURSO a PISTA que
hace referencia a la relación REALIZAR. Inclúyela en la BD y comprueba que la restricción
se añade en USER_CONSTRAINTS.
CURSO (numnivel, número, fechaini, horario, numhoras, precio, pista, dnimonitor)
C.P.: numnivel, número
C.Ajena: numnivel  NIVEL
C.Ajena: dnimonitor  MONITOR
C.Ajena: pista  PISTA */

/*
DESC CURSO
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 NUMNIVEL                                  NOT NULL NUMBER(2)
 NUMERO                                    NOT NULL NUMBER(3)
 FECHAINI                                           DATE
 HORARIO                                            VARCHAR2(100)
 NUMHORAS                                           NUMBER(3)
 PRECIO                                             NUMBER(8,2)
 PISTA                                              VARCHAR2(10)
 DNIMONITOR                                         VARCHAR2(10)
*/

ALTER TABLE CURSO ADD CONSTRAINT fk_curso_pista FOREIGN KEY (PISTA) REFERENCES PISTA;

/*

8.- Tabla CURSO
En la descripción del sistema de información de la práctica 1 se indica que no puede haber
cursos sin monitor asignado. Sin embargo, esta restricción no está incluida en el diseño
lógico. Modifica la tabla para reflejar este requerimiento y verifica que funciona
correctamente. Por ejemplo, puedes verificarlo insertando los siguientes cursos:
numnivel numero fechaini horario numhoras precio pista dnimonitor
1 1 1 22/12/2022 L,X: 10:00-11:30 50 350 ORO 11222333A
2 1 2 04/03/2023 M,J: 12:00-13:00 100 700 ORO
*/

ALTER TABLE CURSO MODIFY (CONSTRAINT curso_dni_mon DNIMONITOR NOT NULL);

/*DAR DE ALTA NIVEL 1*/

INSERT INTO NIVEL (NUMERO, NOMBRE, DESCRIPCION) 
VALUES (1, 'Nivel 1', 'Descripción del Nivel 1');

/*DAR DE ALTA LOS USUARIOS*/

INSERT INTO CURSO (NUMNIVEL, NUMERO, FECHAINI, HORARIO, NUMHORAS, PRECIO, PISTA, DNIMONITOR)
VALUES (1, 1, TO_DATE('22/12/2022', 'DD/MM/YYYY'), 'L,X: 10:00-11:30', 50, 350, 'ORO', '11222333A');

/*INSERT INTO CURSO (NUMNIVEL, NUMERO, FECHAINI, HORARIO, NUMHORAS, PRECIO, PISTA, DNIMONITOR)
*
ERROR at line 1:
ORA-02291: integrity constraint (USUARIO1.FK_CURSO_PISTA) violated - parent key
not found*/

INSERT INTO CURSO (NUMNIVEL, NUMERO, FECHAINI, HORARIO, NUMHORAS, PRECIO, PISTA, DNIMONITOR)
VALUES (1, 2, TO_DATE('04/03/2023', 'DD/MM/YYYY'), 'M,J: 12:00-13:00', 100, 700, 'ORO', NULL);

/*VALUES (1, 2, TO_DATE('04/03/2023', 'DD/MM/YYYY'), 'M,J: 12:00-13:00', 100, 700, 'ORO', NULL)
                                                                                        *
ERROR at line 2:
ORA-01400: cannot insert NULL into ("USUARIO1"."CURSO"."DNIMONITOR")*/

/*Observamos que la constraint de monitor funciona...

Intentamos arreglar el primer registro.*/


