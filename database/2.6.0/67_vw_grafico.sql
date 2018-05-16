-- object: portal.vw_grafico | type: MATERIALIZED VIEW --
DROP MATERIALIZED VIEW IF EXISTS portal.vw_grafico CASCADE;
CREATE MATERIALIZED VIEW portal.vw_grafico
AS

SELECT 
	(SELECT row_to_json(a) FROM (SELECT * FROM portal.obter_grafico_osc_natureza_juridica_regiao()) as a) AS osc_natureza_juridica_regiao,
	(SELECT row_to_json(a) FROM (SELECT * FROM portal.obter_grafico_distribuicao_osc_empregados_regiao()) as a) AS distribuicao_osc_empregados_regiao,
	(SELECT row_to_json(a) FROM (SELECT * FROM portal.obter_grafico_osc_titulos_certificados()) as a) AS osc_titulos_certificados;

-- ddl-end --
ALTER MATERIALIZED VIEW portal.vw_grafico OWNER TO postgres;
-- ddl-end --

