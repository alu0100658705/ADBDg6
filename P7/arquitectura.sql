--
-- Crear schema
--

CREATE SCHEMA arquitectura;

--
-- Tipo de datos para almacenar la dirección
--

CREATE TYPE arquitectura.t_Dir AS (
	calle VARCHAR,
	num INT,
	piso INT
);

--
-- Tipo de datos para almacenar las coordenadas
--

CREATE TYPE arquitectura.t_Coordenadas AS (
	x INT,
	y INT
);

--
-- Tabla JEFE
--

CREATE TABLE arquitectura.JEFE 
(
    JEFE_cod INT NOT NULL,
    Nombre VARCHAR UNIQUE NOT NULL,
    Telefono INT,
    Direccion arquitectura.t_Dir,
    PRIMARY KEY (JEFE_cod)
);

--
-- Tabla PROYECTO
--

CREATE TABLE arquitectura.PROYECTO 
(
    PROYECTO_cod INT NOT NULL,
    Nombre VARCHAR UNIQUE NOT NULL,
    Fecha_fin DATE NOT NULL,
    Refjefe INT NOT NULL,
    Plano INT NOT NULL,
    PRIMARY KEY (PROYECTO_cod),
    CONSTRAINT fk_refjefe
            FOREIGN KEY (Refjefe)
            REFERENCES arquitectura.JEFE (JEFE_cod)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

--
-- Tabla PLANO
--

CREATE TABLE arquitectura.PLANO 
(
    PLANO_id INT NOT NULL,
    Arquitectos VARCHAR(30)[],
    Num_figuras INT,
    Dibujo VARCHAR(35),
    Fecha DATE,
    Proyecto INT,
    PRIMARY KEY (PLANO_id),
    CONSTRAINT fk_proyectoplano
            FOREIGN KEY (Proyecto)
            REFERENCES arquitectura.PROYECTO (PROYECTO_cod)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

--
-- Tabla FIGURA
--

CREATE TABLE arquitectura.FIGURA
(
    FIGURA_id INT NOT NULL,
    Nombre VARCHAR(30),
    Perimetro NUMERIC,
    Area NUMERIC,
    Color VARCHAR,
    Tipo VARCHAR(35),
    N_lineas INT,
    Plano INT NOT NULL,
    Linea INT,
    PRIMARY KEY (FIGURA_id),
    CONSTRAINT fk_planofigura
            FOREIGN KEY (Plano)
            REFERENCES arquitectura.PLANO(PLANO_id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE
);

--
-- Tabla LINEA
--

CREATE TABLE arquitectura.LINEA 
(
    Origen arquitectura.t_Coordenadas NOT NULL,
    Destino arquitectura.t_Coordenadas NOT NULL,
    Longitud NUMERIC,
    LINEA_id INT NOT NULL,
    Fig_id INT NOT NULL,
    PRIMARY KEY (LINEA_id),
    CONSTRAINT fk_figura
            FOREIGN KEY (Fig_id)
            REFERENCES arquitectura.FIGURA(FIGURA_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE
);

--
-- Añadiendo nuevas restricciones para las relaciones
--

ALTER TABLE arquitectura.PROYECTO
ADD CONSTRAINT fk_planoid
            FOREIGN KEY (Plano)
            REFERENCES arquitectura.PLANO (PLANO_id)
            ON DELETE CASCADE
            ON UPDATE CASCADE;

ALTER TABLE arquitectura.FIGURA
ADD CONSTRAINT fk_lineafigura
            FOREIGN KEY (Linea)
            REFERENCES arquitectura.LINEA(LINEA_id)
            ON DELETE RESTRICT
            ON UPDATE CASCADE;