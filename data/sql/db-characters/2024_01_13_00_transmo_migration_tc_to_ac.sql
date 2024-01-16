DROP PROCEDURE IF EXISTS transmogrification_migration_tc_to_ac;

DELIMITER //

CREATE PROCEDURE transmogrification_migration_tc_to_ac()
BEGIN
    DECLARE column_count INT;

    -- Check if transmog column exists
    SELECT COUNT(*)
    INTO column_count
    FROM information_schema.columns
    WHERE table_name = 'item_instance'
    AND column_name = 'transmog';

    -- If the column exists, perform migration and deletion
    IF column_count > 0 THEN
        -- Copy previous transmog
	INSERT IGNORE INTO `custom_transmogrification` (`GUID`, `FakeEntry`, `Owner`) select `guid`, `transmog`, `owner_guid` from `item_instance` where `transmog` != 0 and `owner_guid` != 0;

        -- Remove old transmog column
	ALTER TABLE item_instance DROP COLUMN transmog;
    END IF;
END //

DELIMITER ;

CALL transmogrification_migration_tc_to_ac();
