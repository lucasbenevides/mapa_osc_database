DROP FUNCTION IF EXISTS portal.obter_grafico_distribuicao_osc_empregados_regiao() CASCADE;

CREATE OR REPLACE FUNCTION portal.obter_grafico_distribuicao_osc_empregados_regiao() RETURNS TABLE (
	titulo TEXT, 
	tipo TEXT, 
	dados JSONB, 
	fontes TEXT[]
) AS $$ 

BEGIN 
	RETURN QUERY 
		SELECT 
			'Distribuição de OSCs por número de empregados e região'::TEXT AS titulo, 
			'barras'::TEXT AS tipo, 
			c.dados::JSONB AS dados, 
			c.fontes::TEXT[] AS fontes 
		FROM (
			SELECT 
				('[{' || RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE((TRANSLATE(ARRAY_AGG(b.dados)::TEXT, '\', '') || '}'), '""', '"'), '}",', '},'), '"}', '}'), '"{', '{'), '{'), '}') || '}]') AS dados, 
				(SELECT ARRAY(SELECT DISTINCT UNNEST(('{' || BTRIM(REPLACE(REPLACE(RTRIM(LTRIM(TRANSLATE(ARRAY_AGG(b.fontes::TEXT)::TEXT, '"\', ''), '{'), '}'), '},{', ','), ',,', ','), ',') || '}')::TEXT[]))) AS fontes
			FROM (
				SELECT 
					'{"rotulo": "' || a.rotulo_1 || '", "valor": ' || '[{' || RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE((TRANSLATE(ARRAY_AGG('{"rotulo": "' || a.rotulo_2::TEXT || '", "valor": ' || a.valor::TEXT || '}')::TEXT, '\', '') || '}'), '""', '"'), '}",', '},'), '"}', '}'), '"{', '{'), '{'), '}') || '}]}' AS dados, 
					(SELECT ARRAY(SELECT DISTINCT UNNEST(('{' || BTRIM(REPLACE(REPLACE(RTRIM(LTRIM(TRANSLATE(ARRAY_AGG(a.fontes::TEXT)::TEXT, '"\', ''), '{'), '}'), '},{', ','), ',,', ','), ',') || '}')::TEXT[]))) AS fontes 
				FROM (
					SELECT 
						COALESCE(ed_regiao.edre_nm_regiao, 'Outro') AS rotulo_1, 
						(
							CASE 
								WHEN (tb_relacoes_trabalho.nr_trabalhadores_vinculo = 0) THEN '0' 
								WHEN (tb_relacoes_trabalho.nr_trabalhadores_vinculo BETWEEN 1 AND 4) THEN '1 a 4' 
								WHEN (tb_relacoes_trabalho.nr_trabalhadores_vinculo BETWEEN 5 AND 19) THEN '5 a 19' 
								WHEN (tb_relacoes_trabalho.nr_trabalhadores_vinculo BETWEEN 20 AND 99) THEN '20 a 99' 
								WHEN (tb_relacoes_trabalho.nr_trabalhadores_vinculo >= 100) THEN '100 ou mais' 
								ELSE '0'
							END
						) AS rotulo_2, 
						count(*) AS valor, 
						ARRAY_AGG(DISTINCT(COALESCE(REPLACE(tb_relacoes_trabalho.ft_trabalhadores_vinculo, '${ETL}', ''), '') || ',' || COALESCE(REPLACE(tb_localizacao.ft_municipio, '${ETL}', ''), ''))) AS fontes 
					FROM osc.tb_dados_gerais 
					INNER JOIN osc.tb_relacoes_trabalho 
					ON tb_dados_gerais.id_osc = tb_relacoes_trabalho.id_osc 
					INNER JOIN osc.tb_localizacao 
					ON tb_dados_gerais.id_osc = tb_localizacao.id_osc 
					INNER JOIN spat.ed_regiao 
					ON (SELECT SUBSTR(tb_localizacao.cd_municipio::TEXT, 1, 1))::NUMERIC(1, 0) = ed_regiao.edre_cd_regiao 
					GROUP BY rotulo_1, rotulo_2
				) AS a 
				GROUP BY a.rotulo_1
			) AS b
		) AS c;
END;

$$ LANGUAGE 'plpgsql';

SELECT * FROM portal.obter_grafico_distribuicao_osc_empregados_regiao();

