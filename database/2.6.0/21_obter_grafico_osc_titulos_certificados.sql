DROP FUNCTION IF EXISTS portal.obter_grafico_osc_titulos_certificados() CASCADE;

CREATE OR REPLACE FUNCTION portal.obter_grafico_osc_titulos_certificados() RETURNS TABLE (
	titulo TEXT, 
	tipo TEXT, 
	dados JSONB, 
	fontes TEXT[]
) AS $$ 

BEGIN 
	RETURN QUERY 
		SELECT 
			'Número de organizações civis com títulos e certificações'::TEXT AS titulo, 
			'barras'::TEXT AS tipo, 
			b.dados::JSONB AS dados, 
			b.fontes::TEXT[] AS fontes 
		FROM (
			SELECT 
				'[{' || RTRIM(LTRIM(REPLACE(REPLACE(REPLACE(REPLACE((TRANSLATE(ARRAY_AGG('{"rotulo": "' || a.rotulo::TEXT || '", "valor": ' || a.valor::TEXT || '}')::TEXT, '\', '') || '}'), '""', '"'), '}",', '},'), '"}', '}'), '"{', '{'), '{'), '}') || '}]' AS dados, 
				REPLACE(REPLACE(TRANSLATE((ARRAY_AGG(DISTINCT REPLACE(TRIM(TRANSLATE(a.fontes::TEXT, '"\{}', ''), ','), '","', ',')))::TEXT, '"', ''), '{,', '{'), ',}', '}')::TEXT[] AS fontes 
			FROM (
				SELECT 
					COALESCE(dc_certificado.tx_nome_certificado, 'Sem informação') AS rotulo, 
					count(*) AS valor, 
					ARRAY_AGG(DISTINCT REPLACE(COALESCE(tb_certificado.ft_certificado, ''), '${ETL}', '')) AS fontes 
				FROM osc.tb_osc 
				LEFT JOIN osc.tb_certificado 
				ON tb_osc.id_osc = tb_certificado.id_osc
				LEFT JOIN syst.dc_certificado 
				ON tb_certificado.cd_certificado = dc_certificado.cd_certificado
				WHERE tb_osc.bo_osc_ativa 
				GROUP BY rotulo
			) AS a
		) AS b;
END;

$$ LANGUAGE 'plpgsql';

SELECT * FROM portal.obter_grafico_osc_titulos_certificados();

