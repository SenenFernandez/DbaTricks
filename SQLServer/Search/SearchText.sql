SELECT SCHEMA_NAME(schema_id) AS [Schema], name AS [Object], OBJECT_DEFINITION(object_id) [Text]
FROM sys.procedures
WHERE OBJECT_DEFINITION(object_id) LIKE '%Senen%'