CREATE FUNCTION public.CDB_CommonDataCatalog()
  RETURNS TABLE(
    name text,
    tabname text,
    description text,
    source text,
    license text,
    geometry_types text,
    rows real,
    size bigint,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    category text,
    image_url text)
  AS $$
    SELECT
      meta_dataset.name,
      meta_dataset.tabname,
      meta_dataset.description,
      meta_dataset.source,
      meta_dataset.license,
      meta_dataset.geometry_types,
      (
          SELECT reltuples
          FROM pg_class C LEFT JOIN pg_namespace N ON (N.oid = C.relnamespace)
          WHERE
              nspname NOT IN ('pg_catalog', 'information_schema')
              AND relkind='r'
              AND relname = meta_dataset.tabname
      ) as rows,
      pg_relation_size(meta_dataset.tabname) size,
      meta_dataset.created_at,
      meta_dataset.updated_at,
      meta_category.name category,
      meta_category.image_url category_image_url
    FROM meta_dataset, meta_category
    WHERE meta_dataset.meta_category_id = meta_category.cartodb_id;
$$ LANGUAGE SQL;

GRANT SELECT ON TABLE meta_dataset TO publicuser;
GRANT SELECT ON TABLE meta_category TO publicuser;
GRANT EXECUTE ON FUNCTION CDB_CommonDataCatalog() TO publicuser;
