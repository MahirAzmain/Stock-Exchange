BEGIN
   
   FOR cur_rec IN (SELECT object_name, object_type
                   FROM user_objects
                   WHERE object_type IN ('TABLE', 'VIEW', 'MATERIALIZED VIEW', 'PACKAGE', 'PROCEDURE', 'FUNCTION', 'SEQUENCE', 'SYNONYM', 'PACKAGE BODY'))
   LOOP
      BEGIN
      
         IF cur_rec.object_type = 'TABLE' THEN
            EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '" CASCADE CONSTRAINTS';
         ELSE
            -- Drop other types of objects normally
            EXECUTE IMMEDIATE 'DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS THEN
            -- Output any errors encountered during the drop
            DBMS_OUTPUT.put_line('FAILED: DROP ' || cur_rec.object_type || ' "' || cur_rec.object_name || '"');
      END;
   END LOOP;

   FOR cur_rec IN (SELECT synonym_name
                   FROM all_synonyms
                   WHERE table_owner IN (SELECT USER FROM dual))
   LOOP
      BEGIN
         -- Drop public synonyms
         EXECUTE IMMEDIATE 'DROP PUBLIC SYNONYM ' || cur_rec.synonym_name;
      EXCEPTION
         WHEN OTHERS THEN
            DBMS_OUTPUT.put_line('FAILED: DROP PUBLIC SYNONYM ' || cur_rec.synonym_name);
      END;
   END LOOP;
END;