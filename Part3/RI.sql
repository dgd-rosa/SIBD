-- 2. Integrity Constraints

-- Checking pv corresponds to the voltage of the busbar identified by pbbid
CREATE OR REPLACE FUNCTION pv_check()
    RETURNS TRIGGER AS

$$
BEGIN
    IF NEW.pv <> (SELECT voltage FROM busbar WHERE id = NEW.pbbid) THEN
        RAISE EXCEPTION 'pv must match the voltage of the pbbid busbar';
    end if;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER pv_check_trigger
    BEFORE INSERT
    ON transformer
    FOR EACH ROW
EXECUTE PROCEDURE pv_check();


-- Checking sv corresponds to the voltage of the busbar identified by sbbid
CREATE OR REPLACE FUNCTION sv_check()
    RETURNS TRIGGER AS

$$
BEGIN
    IF NEW.sv <> (SELECT voltage FROM busbar WHERE id = NEW.sbbid) THEN
        RAISE EXCEPTION 'sv must match the voltage of the sbbid busbar';
    end if;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER sv_check_trigger
    BEFORE INSERT
    ON transformer
    FOR EACH ROW
EXECUTE PROCEDURE sv_check();


-- name, address values cannot coincide with sname, saddress values of the substation where the transformer is located
CREATE OR REPLACE FUNCTION name_address_check()
    RETURNS TRIGGER AS

$$
BEGIN
    IF (NEW.name, NEW.address) = (SELECT s.sname, s.saddress
                    FROM transformer t
                             JOIN substation s on t.gpslat = s.gpslat and t.gpslong = s.gpslong
                    WHERE t.id = NEW.id) THEN
        RAISE EXCEPTION 'Name and address of analyses cannot match the ones in the substation';
    end if;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER name_address_check_trigger
    BEFORE INSERT
    ON analyses
    FOR EACH ROW
EXECUTE PROCEDURE name_address_check();


