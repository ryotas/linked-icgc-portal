# gene_summary.sql
SELECT DISTINCT
  (?approved_symbol AS ?Symbol)
  (?approved_name AS ?Name)
  (?synonym AS ?Synonym)
  (?hgnc_id AS ?HGNC_Gene)
  (?gene_id AS ?Ensembl_Gene)
  (?omim_id AS ?OMIM)
  (?uniprot_id AS ?UniProt)
WHERE {
  ?gene_hgnc hgnc_vocabulary:approved-symbol ?approved_symbol .
  OPTIONAL { ?gene_hgnc hgnc_vocabulary:approved-name ?approved_name . }
  OPTIONAL { ?gene_hgnc hgnc_vocabulary:synonym ?synonym . }
  OPTIONAL { ?gene_hgnc bio2rdf_vocabulary:identifier ?hgnc_id . }
  OPTIONAL { ?gene_hgnc hgnc_vocabulary:x-omim [ bio2rdf_vocabulary:identifier ?omim_id ] . }
  OPTIONAL { ?gene_hgnc hgnc_vocabulary:x-uniprot [ bio2rdf_vocabulary:identifier ?uniprot_id ] . }
  {
    SELECT
      ?ssm_effect
      ?gene_id
      ?gene_hgnc
    WHERE {
      ?ssm_effect icgc:gene_affected "$gene_id" .
      ?ssm_effect icgc:gene_affected ?gene_id .
      ?ssm_effect icgc:gene_affected_bio2rdf ?gene_ensembl .
      ?gene_hgnc hgnc_vocabulary:x-ensembl ?gene_ensembl .
    }
  }
}
