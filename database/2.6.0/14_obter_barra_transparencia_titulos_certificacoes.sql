DROP FUNCTION IF EXISTS portal.obter_barra_transparencia_titulos_certificacoes();

CREATE OR REPLACE FUNCTION portal.obter_barra_transparencia_titulos_certificacoes() RETURNS TABLE (
	id_osc INTEGER, 
	transparencia NUMERIC, 
	peso DOUBLE PRECISION
) AS $$ 

DECLARE 
	peso_segmento DOUBLE PRECISION;
	peso_campo DOUBLE PRECISION;

BEGIN 
	peso_segmento := (SELECT peso_secao FROM portal.tb_peso_barra_transparencia WHERE id_peso_barra_transparencia = 4); 
	peso_campo := 100.0 / 1.0;
	
	RETURN QUERY 
        SELECT 
		titulos_certificacoes.id_osc, 
		(CAST(SUM(
			(CASE WHEN NOT(titulos_certificacoes.tx_nome_certificado IS NULL) THEN peso_campo ELSE 0 END)
		) / COUNT(*) AS NUMERIC(7, 2))), 
		peso_segmento 
	FROM 
		portal.vw_osc_certificado AS titulos_certificacoes
	GROUP BY 
		titulos_certificacoes.id_osc;
END;

$$ LANGUAGE 'plpgsql';
