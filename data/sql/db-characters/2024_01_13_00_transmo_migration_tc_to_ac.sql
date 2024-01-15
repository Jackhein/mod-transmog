INSERT INTO `custom_transmogrification` (`GUID`, `FakeEntry`, `Owner`) select `guid`, `transmog`, `owner_guid` from `item_instance` where `transmog` != 0 and `owner_guid` != 0;
ALTER TABLE item_instance DROP COLUMN transmog;
