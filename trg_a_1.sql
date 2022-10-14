CREATE OR REPLACE TRIGGER TRG_DEPARTMENTS_AUDIT
BEFORE INSERT OR UPDATE OR DELETE
ON TB_DEPARTMENTS

FOR EACH ROW

DECLARE

BEGIN
IF INSERTING THEN
INSERT INTO TB_DEPARTMENTS_AUDIT VALUES (:NEW.DEPARTMENT_ID,
                                         :NEW.DEPARTMENT_NAME,
                                         :NEW.MANAGER_ID,
                                         :NEW.LOCATION_ID,
                                         USER,
                                         'INSERT',
                                        SYSDATE
                                        );
                                         
ELSIF UPDATING THEN
INSERT INTO TB_DEPARTMENTS_AUDIT VALUES (:NEW.DEPARTMENT_ID,
                                         :NEW.DEPARTMENT_NAME,
                                         :NEW.MANAGER_ID,
                                         :NEW.LOCATION_ID,
                                         USER,
                                         'UPDATE_NEW',
                                           SYSDATE
                                         );
                                         
INSERT INTO TB_DEPARTMENTS_AUDIT VALUES (:OLD.DEPARTMENT_ID,
                                         :OLD.DEPARTMENT_NAME,
                                         :OLD.MANAGER_ID,
                                         :OLD.LOCATION_ID,
                                         USER,
                                         'UPDATE_OLD',
                                         SYSDATE
                                         );
                                         
ELSIF DELETING THEN
INSERT INTO TB_DEPARTMENTS_AUDIT VALUES (:OLD.DEPARTMENT_ID,
                                         :OLD.DEPARTMENT_NAME,
                                         :OLD.MANAGER_ID,
                                         :OLD.LOCATION_ID,
                                         USER,
                                         'DELETE',
                                         SYSDATE
                                         );
                                         
END IF;
END;