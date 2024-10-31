CREATE TABLE ALUMNO
(
   dni          VARCHAR2(10) CONSTRAINT alu_dni_pk PRIMARY KEY, 
   nombre       VARCHAR2(25), 
   apellido1    VARCHAR2(25), 
   telefono     VARCHAR2(30), 
   fechanac     DATE, 
   sexo         VARCHAR2(10)
);
  
CREATE TABLE MONITOR 
(
   dni		VARCHAR2(10) CONSTRAINT mon_dni_pk PRIMARY KEY, 
   nombre	VARCHAR2(25), 
   apellido1	VARCHAR2(25), 
   telefono 	VARCHAR2(30) CONSTRAINT mon_tel_nn NOT NULL
);

CREATE TABLE TIENDA 
(
   cif      	VARCHAR2(10) CONSTRAINT tie_cif_pk PRIMARY KEY, 
   nombre   	VARCHAR2(50), 
   telefono 	VARCHAR2(30)
);

CREATE TABLE ASIGNAR 
(
   dnimonitor 	VARCHAR2(10) CONSTRAINT asi_dni_mon_fk REFERENCES MONITOR(dni), 
   ciftienda  	VARCHAR2(10) CONSTRAINT asi_cif_tie_fk REFERENCES TIENDA, 
   descuento  	NUMBER(4,2),
   CONSTRAINT asi_dni_cif_pk PRIMARY KEY (dnimonitor,ciftienda)
);

CREATE TABLE COMPRAR 
(
   dnialumno	VARCHAR2(10) CONSTRAINT com_dnia_alu_fk REFERENCES ALUMNO, 
   dnimonitor	VARCHAR2(10) CONSTRAINT com_dnim_mon_fk REFERENCES MONITOR, 
   ciftienda	VARCHAR2(10) CONSTRAINT com_cif_tie_fk REFERENCES TIENDA, 
   fecha	DATE, 
   importeinicial NUMBER(8,2), 
   importefinal	  NUMBER(8,2),
   CONSTRAINT com_dnia_dnim_cif_fec_pk PRIMARY KEY (dnialumno, dnimonitor, ciftienda, fecha)
);

CREATE TABLE NIVEL 
(
   numero	NUMBER(2) CONSTRAINT niv_num_pk PRIMARY KEY, 
   nombre	VARCHAR2(10), 
   descripcion	VARCHAR2(50)
);


CREATE TABLE PISTA 
(
   codigo		VARCHAR2(10) CONSTRAINT pis_cod_pk PRIMARY KEY, 
   estado		VARCHAR2(20), 
   observaciones	VARCHAR2(45)
);

CREATE TABLE CURSO 
(
   numnivel	NUMBER(2) CONSTRAINT cur_numn_niv_fk REFERENCES NIVEL, 
   numero	NUMBER(3), 
   fechaini	DATE, 
   horario	VARCHAR2(100), 
   numhoras	NUMBER(3), 
   precio	NUMBER(8,2), 
   pista	VARCHAR2(10), 
   dnimonitor	CONSTRAINT cur_dni_mon_fk REFERENCES MONITOR,
   CONSTRAINT  cur_niv_num_pk PRIMARY KEY (numnivel,numero)
);

CREATE TABLE MATRICULAR 
(
   dnialumno	CONSTRAINT mat_dni_alu_fk REFERENCES alumno, 
   nivel	NUMBER(2), 
   curso	NUMBER(3), 
   diasasiste	NUMBER(3),
   CONSTRAINT mat_dni_niv_cur_pk PRIMARY KEY (dnialumno, nivel, curso),
   CONSTRAINT mat_niv_cur_cur_fk FOREIGN KEY (nivel,curso) REFERENCES CURSO
);









