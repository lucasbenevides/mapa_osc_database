DROP FUNCTION IF EXISTS portal.obter_grafico(TEXT);

CREATE OR REPLACE FUNCTION portal.obter_grafico(param TEXT) RETURNS TABLE (
	resultado JSONB, 
	mensagem TEXT, 
	codigo INTEGER
) AS $$ 

DECLARE
	linha RECORD;

BEGIN 
	SELECT INTO linha
		id, 
		titulo, 
		tipo, 
		dados, 
		data_atualizacao 
	FROM 
		portal.vw_graficos
	WHERE 
		id = param::INTEGER;

	IF linha != (null::INTEGER, null::TEXT, null::TEXT, null::JSONB, null::TIMESTAMP WITH TIME ZONE)::RECORD THEN 
		resultado := to_jsonb(linha);
		codigo := 200;
		mensagem := 'Dados de gráfico retornado.';
	ELSE 
		codigo := 404;
		mensagem := 'Gráfico não encontrada.';
	END IF;

	RETURN NEXT;
	
EXCEPTION
	WHEN others THEN 
		codigo := 400;
		SELECT INTO mensagem a.mensagem FROM portal.verificar_erro(SQLSTATE, SQLERRM, null, null, null, false, null) AS a;
		RETURN NEXT;
END;
$$ LANGUAGE 'plpgsql';
