DROP FUNCTION IF EXISTS portal.obter_barra_transparencia_relacoes_trabalho_governanca();

CREATE OR REPLACE FUNCTION portal.obter_barra_transparencia_relacoes_trabalho_governanca() RETURNS TABLE (
	id_osc INTEGER, 
	transparencia NUMERIC, 
	peso DOUBLE PRECISION
) AS $$ 

DECLARE 
	peso DOUBLE PRECISION;

BEGIN 
	peso := (SELECT peso_secao FROM portal.tb_peso_barra_transparencia WHERE id_peso_barra_transparencia = 5); 
	
	RETURN QUERY 
        SELECT 
			relacoes_trabalho.id_osc, 
			(CAST(SUM(
				(CASE WHEN NOT(relacoes_trabalho.nr_trabalhadores_voluntarios IS NULL) THEN 20 ELSE 0 END) + 
				(CASE WHEN NOT(governanca.tx_cargo_dirigente IS NULL) AND NOT(governanca.tx_nome_dirigente is null) THEN 60 ELSE 0 END) + 
				(CASE WHEN NOT(conselho_fiscal.tx_nome_conselheiro IS NULL) THEN 20 ELSE 0 END)
			) / COUNT(*) AS NUMERIC(7, 2))), 
			peso 
		FROM 
			portal.vw_osc_relacoes_trabalho AS relacoes_trabalho FULL JOIN 
			portal.vw_osc_governanca AS governanca ON relacoes_trabalho.id_osc = governanca.id_osc FULL JOIN 
			portal.vw_osc_conselho_fiscal AS conselho_fiscal ON relacoes_trabalho.id_osc = conselho_fiscal.id_osc 
		GROUP BY 
			relacoes_trabalho.id_osc;
END;

$$ LANGUAGE 'plpgsql';
