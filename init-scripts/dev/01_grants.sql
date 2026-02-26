-- ================================================================
-- Switch to XEPDB1 before granting — DEV_USER lives there, not CDB
-- ================================================================
ALTER SESSION SET CONTAINER = XEPDB1;

GRANT CREATE SESSION            TO DEV_USER;
GRANT CREATE TABLE              TO DEV_USER;
GRANT CREATE VIEW               TO DEV_USER;
GRANT CREATE SEQUENCE           TO DEV_USER;
GRANT CREATE PROCEDURE          TO DEV_USER;
GRANT CREATE TRIGGER            TO DEV_USER;
GRANT CREATE TYPE               TO DEV_USER;
GRANT UNLIMITED TABLESPACE      TO DEV_USER;
GRANT EXECUTE ON DBMS_METADATA  TO DEV_USER;
GRANT SELECT ON SYS.DBA_OBJECTS TO DEV_USER;
GRANT SELECT ON SYS.DBA_SOURCE  TO DEV_USER;