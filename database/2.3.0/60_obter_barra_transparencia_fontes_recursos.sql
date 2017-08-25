DROP FUNCTION IF EXISTS portal.obter_barra_transparencia_fontes_recursos();

CREATE OR REPLACE FUNCTION portal.obter_barra_transparencia_fontes_recursos() RETURNS TABLE (
	id_osc INTEGER, 
	transparencia NUMERIC
) AS $$ 

BEGIN 
	RETURN QUERY 
        SELECT 
			recursos.id_osc, 
			(CAST(SUM(
				(CASE WHEN NOT(recursos.tx_nome_origem_fonte_recursos_osc IS NULL) AND (recursos.tx_nome_origem_fonte_recursos_osc = 'Recursos públicos') THEN 1.25 ELSE 0 END) + 
				(CASE WHEN NOT(recursos.tx_nome_origem_fonte_recursos_osc IS NULL) AND (recursos.tx_nome_origem_fonte_recursos_osc = 'Recursos privados') THEN 1.25 ELSE 0 END) + 
				(CASE WHEN NOT(recursos.tx_nome_origem_fonte_recursos_osc IS NULL) AND (recursos.tx_nome_origem_fonte_recursos_osc = 'Recursos não financeiros') THEN 1.25 ELSE 0 END) + 
				(CASE WHEN NOT(recursos.tx_nome_origem_fonte_recursos_osc IS NULL) AND (recursos.tx_nome_origem_fonte_recursos_osc = 'Recursos próprios') THEN 1.25 ELSE 0 END)
			) / COUNT(*) AS NUMERIC(7, 2))) 
		FROM 
			portal.vw_osc_recursos_osc AS recursos
		GROUP BY 
			recursos.id_osc;
END;

$$ LANGUAGE 'plpgsql';
