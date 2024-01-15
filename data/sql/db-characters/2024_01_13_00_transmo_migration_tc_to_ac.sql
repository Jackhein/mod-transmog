IF EXISTS (SELECT 1
	FROM   INFORMATION_SCHEMA.COLUMNS
	WHERE  TABLE_NAME = 'item_instance'
		AND COLUMN_NAME = 'transmog'
		AND TABLE_SCHEMA='DBO')
	BEGIN
		INSERT INTO `custom_transmogrification` (`GUID`, `FakeEntry`, `Owner`) select `guid`, `transmog`, `owner_guid` from `item_instance` where `transmog` != 0 and `owner_guid` != 0;
		ALTER TABLE item_instance DROP COLUMN transmog; 
	END
GO
