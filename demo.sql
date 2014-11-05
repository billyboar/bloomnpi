SELECT row_to_json(t)
FROM (
  SELECT npis.*, (
    SELECT array_to_json(array_agg(row_to_json(d)))
    FROM (
      SELECT npi_licenses.*
      FROM npi_licenses
      WHERE npi_licenses.npi_id = npis.id
    ) d
  ) as npi_licenses,
  (
    SELECT row_to_json(bl)
    FROM (
      SELECT npi_locations.*
      FROM npi_locations
      WHERE npi_locations.id = npis.business_location_id
    ) bl
  ) as business_location,
  (
    SELECT row_to_json(bl)
    FROM (
      SELECT npi_locations.*
      FROM npi_locations
      WHERE npi_locations.id = npis.practice_location_id
    ) bl
  ) as practice_location,
    (
    SELECT row_to_json(bl)
    FROM (
      SELECT npi_organization_officials.*
      FROM npi_organization_officials
      WHERE npi_organization_officials.id = npis.organization_official_id
    ) bl
  ) as organization_official,
  (
    SELECT array_to_json(array_agg(row_to_json(d)))
    FROM (
      SELECT npi_other_identifiers.*
      FROM npi_other_identifiers
      WHERE npi_other_identifiers.npi_id = npis.id
    ) d
  ) as other_identifiers,
  (
    SELECT row_to_json(bl)
    FROM (
      SELECT npi_parent_orgs.*
      FROM npi_parent_orgs
      WHERE npi_parent_orgs.id = npis.parent_orgs_id
    ) bl
  ) as parent_org,
  (
    SELECT array_to_json(array_agg(row_to_json(d)))
    FROM (
      SELECT npi_taxonomy_groups.*
      FROM npi_taxonomy_groups
      WHERE npi_taxonomy_groups.npi_id = npis.id
    ) d
  ) as taxonomy_groups
  FROM npis
  WHERE npi = 1174836860
  limit 1000
) t