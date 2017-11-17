DROP FUNCTION IF EXISTS portal.verificar_erro(codigoerro TEXT, mensagemerro TEXT, fonte TEXT, identificador NUMERIC, dataoperacao TIMESTAMP, errolog BOOLEAN, idcarga INTEGER);

CREATE OR REPLACE FUNCTION portal.verificar_erro(codigoerro TEXT, mensagemerro TEXT, fonte TEXT, identificador NUMERIC, dataoperacao TIMESTAMP, errolog BOOLEAN, idcarga INTEGER) RETURNS TABLE(
	mensagem TEXT
) AS $$

DECLARE 
	mensagem_log TEXT;
	status_log INTEGER;
	
BEGIN 
	mensagem_log := mensagemerro;
	status_log := 2;
	
	IF codigoerro = 'P0001' THEN 
		IF mensagemerro = 'fonte_invalida' THEN 
			mensagem := 'Fonte de dados inválida.';
			
		ELSIF mensagemerro = 'permissao_negada_usuario' THEN 
			mensagem := 'Usuário não tem permissão para acessar o conteúdo informado.';
			
		ELSIF mensagemerro = 'tipo_busca_invalido' THEN 
			mensagem := 'Tipo de busca inválido.';
			
		ELSIF mensagemerro = 'dado_invalido' THEN 
			mensagem := 'Dado inválido.';
			
		ELSIF mensagemerro = 'tipo_identificador_invalido' THEN 
			mensagem := 'Tipo de identificador inválido.';
			
		ELSIF mensagemerro = 'osc_nao_encontrada' THEN 
			mensagem := 'OSC não encontrada.';
			status_log := 1;
			
		ELSIF mensagemerro = 'projeto_nao_encontrado' THEN 
			mensagem := 'Projeto não encontrado.';
			status_log := 1;
			
		END IF;
		
		mensagem_log := mensagem;
		
	ELSE 
		IF codigoerro = '23502' THEN -- not_null_violation
			mensagem := 'Dado(s) obrigatório(s) não enviado(s).';
			
		ELSIF codigoerro = '23505' THEN -- unique_violation
			mensagem := 'Dado(s) único(s) violado(s).';
			
		ELSIF codigoerro = '23503' THEN -- foreign_key_violation
			mensagem := 'Dado(s) com chave(s) estrangeira(s) violada(s).';
			
		ELSE 
			mensagem := 'Ocorreu um erro.';
			
		END IF;
		
	END IF;
	
	IF errolog AND identificador IS NOT null THEN 
		INSERT INTO log.tb_log_erro_carga (cd_identificador_osc, cd_status, tx_mensagem, dt_carregamento_dados, tx_fonte_dados, id_carga) 
		VALUES (identificador, status_log, mensagem_log, dataoperacao, fonte, idcarga);
	END IF;
	
	RETURN NEXT;
	
END;
$$ LANGUAGE 'plpgsql';
