
---- Creacion de Ids Incrementadas
CREATE SEQUENCE seq_gerente START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_condicion START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_provincia START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_distrito START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_sede START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_hospital START WITH 1 INCREMENT BY 1;


DROP TABLE gerente CASCADE CONSTRAINTS;
CREATE TABLE gerente(
    idGerente INT DEFAULT seq_gerente.NEXTVAL PRIMARY KEY,
    descGerente VARCHAR2(255),
    fechaRegistro DATE
);


DROP TABLE condicion CASCADE CONSTRAINTS;
CREATE TABLE condicion(
    idCondicion INT DEFAULT seq_condicion.NEXTVAL PRIMARY KEY,
    descCondicion VARCHAR2(255),
    fechaRegistro DATE
);

DROP TABLE provincia CASCADE CONSTRAINTS;
CREATE TABLE provincia(
    idProvincia INT DEFAULT seq_provincia.NEXTVAL PRIMARY KEY,
    descProvincia VARCHAR2(255),
    fechaRegistro DATE
);

DROP TABLE distrito CASCADE CONSTRAINTS;
CREATE TABLE distrito(
    idDistrito INT DEFAULT seq_distrito.NEXTVAL PRIMARY KEY,
    idProvincia INT,
    descDistrito VARCHAR2(255),
    fechaRegistro DATE,
    CONSTRAINT fk_distrito_provincia FOREIGN KEY (idProvincia) REFERENCES provincia(idProvincia)
);

DROP TABLE sede CASCADE CONSTRAINTS;
CREATE TABLE sede(
    idSede INT DEFAULT seq_sede.NEXTVAL PRIMARY KEY,
    descSede VARCHAR2(255),
    fechaRegistro DATE
);


DROP TABLE hospital CASCADE CONSTRAINTS;
CREATE TABLE hospital(
    idHospital INT DEFAULT seq_hospital.NEXTVAL PRIMARY KEY, 
    idDistrito INT,
    Nombre VARCHAR2(255),
    Antiguedad INT,
    Area DECIMAL(5,2),
    idSede INT,
    idGerente INT,
    idCondicion INT,
    fechaRegistro DATE,
    CONSTRAINT fk_hospital_distrito FOREIGN KEY (idDistrito) REFERENCES distrito(idDistrito),
    CONSTRAINT fk_hospital_sede FOREIGN KEY (idSede) REFERENCES sede(idSede),
    CONSTRAINT fk_hospital_gerente FOREIGN KEY (idGerente) REFERENCES GERENTE(idGerente),
    CONSTRAINT fk_hospital_condicion FOREIGN KEY (idCondicion) REFERENCES Condicion(idCondicion)
);


INSERT INTO GERENTE (descGerente, fechaRegistro) VALUES ('Erih HC', TO_DATE('2024-07-08', 'YYYY-MM-DD'));

INSERT INTO Condicion (descCondicion, fechaRegistro) VALUES ('Activo', TO_DATE('2024-07-02', 'YYYY-MM-DD'));

INSERT INTO provincia (descProvincia, fechaRegistro) VALUES ('Lima', TO_DATE('2024-07-01', 'YYYY-MM-DD'));
INSERT INTO provincia (descProvincia, fechaRegistro) VALUES ('Cusco', TO_DATE('2024-07-01', 'YYYY-MM-DD'));


INSERT INTO distrito (idProvincia, descDistrito, fechaRegistro) VALUES (1, 'La Victoria', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO distrito (idProvincia, descDistrito, fechaRegistro) VALUES (2, 'San Sebastian', TO_DATE('2024-02-01', 'YYYY-MM-DD'));


INSERT INTO sede (descSede, fechaRegistro) VALUES ('Sede Central', TO_DATE('2024-01-01', 'YYYY-MM-DD'));
INSERT INTO sede (descSede, fechaRegistro) VALUES ('Sede Regional', TO_DATE('2024-02-01', 'YYYY-MM-DD'));

SELECT * FROM CONDICION;
SELECT * FROM DISTRITO;
SELECT * FROM GERENTE;
SELECT * FROM HOSPITAL;
SELECT * FROM PROVINCIA;
SELECT * FROM SEDE;



