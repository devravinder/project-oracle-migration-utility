CREATE OR REPLACE EDITIONABLE TRIGGER "TRG_USERS_AUDIT" 
    AFTER INSERT OR UPDATE OR DELETE ON USERS
    FOR EACH ROW
DECLARE
    V_OPERATION VARCHAR2(10);
    V_OLD_VAL   CLOB;
    V_NEW_VAL   CLOB;
BEGIN
    IF INSERTING THEN
        V_OPERATION := 'INSERT';
        V_NEW_VAL   := '{"username":"' || :NEW.USERNAME || '","email":"' || :NEW.EMAIL || '","role_id":' || :NEW.ROLE_ID || '}';
    ELSIF UPDATING THEN
        V_OPERATION := 'UPDATE';
        V_OLD_VAL   := '{"username":"' || :OLD.USERNAME || '","email":"' || :OLD.EMAIL || '","is_active":' || :OLD.IS_ACTIVE || '}';
        V_NEW_VAL   := '{"username":"' || :NEW.USERNAME || '","email":"' || :NEW.EMAIL || '","is_active":' || :NEW.IS_ACTIVE || '}';
    ELSE
        V_OPERATION := 'DELETE';
        V_OLD_VAL   := '{"username":"' || :OLD.USERNAME || '","email":"' || :OLD.EMAIL || '}';
    END IF;

    INSERT INTO AUDIT_LOG (
        TABLE_NAME, OPERATION, RECORD_ID, OLD_VALUES, NEW_VALUES, CHANGED_BY
    ) VALUES (
        'USERS', V_OPERATION,
        COALESCE(:NEW.USER_ID, :OLD.USER_ID),
        V_OLD_VAL, V_NEW_VAL,
        SYS_CONTEXT('USERENV', 'SESSION_USER')
    );
END TRG_USERS_AUDIT;
ALTER TRIGGER "TRG_USERS_AUDIT" ENABLE
/
