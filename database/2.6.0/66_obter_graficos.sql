DROP FUNCTION IF EXISTS portal.obter_graficos();

CREATE OR REPLACE FUNCTION portal.obter_graficos() RETURNS TABLE (
	nome_grafico TEXT,
	grafico JSONB
) AS $$ 

DECLARE
	graficos RECORD;

BEGIN 
	SELECT * INFO graficos FROM ('osc_natureza_juridica_regiao', (SELECT * FROM portal.obter_grafico_osc_natureza_juridica_regiao()) as a));
	--INSERT INTO ' || graficos || ' VALUES(''osc_natureza_juridica_regiao'', (SELECT row_to_json(a) FROM (SELECT * FROM portal.obter_grafico_osc_natureza_juridica_regiao()) as a));

	--EXECUTE 'INSERT INTO graficos (nome_grafico, grafico) VALUES (?, ?)' USING graficos.nome_grafico, graficos.grafico;

	--EXECUTE 'INSERT INTO ' || graficos || ' VALUES(''osc_natureza_juridica_regiao'', (SELECT row_to_json(a) FROM (SELECT * FROM portal.obter_grafico_osc_natureza_juridica_regiao()) as a))';
	
	RETURN NEXT;
	
EXCEPTION
	WHEN others THEN 
		RAISE NOTICE '%', SQLERRM;
		RETURN NEXT;
END;
$$ LANGUAGE 'plpgsql';

SELECT * FROM portal.obter_graficos();

