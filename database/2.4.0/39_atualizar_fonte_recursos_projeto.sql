DROP FUNCTION IF EXISTS portal.atualizar_fonte_recursos_projeto(fonte TEXT, osc INTEGER, dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, errolog BOOLEAN, deletevalido BOOLEAN, tipobusca INTEGER);

CREATE OR REPLACE FUNCTION portal.atualizar_fonte_recursos_projeto(fonte TEXT, osc INTEGER, dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, errolog BOOLEAN, deletevalido BOOLEAN, tipobusca INTEGER) RETURNS TABLE(
	mensagem TEXT, 
	flag BOOLEAN
)AS $$

DECLARE 
	nome_tabela TEXT;
	operacao TEXT;
	fonte_dados RECORD;
	objeto RECORD;
	dado_anterior RECORD;
	dado_posterior RECORD;
	registro_nao_delete INTEGER[];
	flag_update BOOLEAN;
	
BEGIN 
	nome_tabela := 'osc.tb_fonte_recursos_projeto';
	operacao := 'portal.atualizar_fonte_recursos_projeto(' || fonte::TEXT || ', ' || osc::TEXT || ', ' || dataatualizacao::TEXT || ', ' || json::TEXT || ', ' || nullvalido::TEXT || ', ' || errolog::TEXT || ', ' || deletevalido::TEXT || ', ' || tipobusca::TEXT || ')';
	
	SELECT INTO fonte_dados * FROM portal.verificar_fonte(fonte);
	
	IF fonte_dados.nome_fonte IS null THEN 
		flag := false;
		SELECT INTO mensagem a.mensagem FROM portal.verificar_erro('fonte_invalida', operacao, fonte, osc, dataatualizacao::TIMESTAMP, errolog) AS a;
	
	ELSIF osc != ALL(fonte_dados.representacao) THEN 
		flag := false;
		SELECT INTO mensagem a.mensagem FROM portal.verificar_erro('permissao_negada_usuario', operacao, fonte, osc, dataatualizacao::TIMESTAMP, errolog) AS a;
		
	ELSE 
		IF tipobusca IS null THEN 
			tipobusca := 1;
		END IF;
		
		registro_nao_delete := '{}';
		
		IF json_typeof(json::JSON) = 'object' THEN 
			json := ('[' || json || ']');
		END IF;
		
		FOR objeto IN (SELECT *FROM json_populate_recordset(null::osc.tb_fonte_recursos_projeto, json::JSON)) 
		LOOP 
			dado_anterior := null;
			
			IF tipobusca = 1 THEN 
				SELECT INTO dado_anterior * 
				FROM osc.tb_fonte_recursos_projeto 
				WHERE id_fonte_recursos_projeto = objeto.id_fonte_recursos_projeto 
				AND id_osc = osc;
				
			ELSIF tipobusca = 2 THEN 
				SELECT INTO dado_anterior * 
				FROM osc.tb_fonte_recursos_projeto 
				WHERE id_projeto = objeto.id_projeto 
				AND (
					cd_fonte_recursos_projeto = objeto.cd_fonte_recursos_projeto 
					OR cd_origem_fonte_recursos_projeto = objeto.cd_origem_fonte_recursos_projeto
				) 
				AND cd_tipo_parceria = objeto.cd_tipo_parceria 
				AND id_osc = osc;
			END IF;
			
			IF dado_anterior.id_fonte_recursos_projeto IS null THEN 
				IF objeto.id_projeto <> (SELECT id_osc FROM osc.tb_projeto WHERE tb_projeto.id_projeto = objeto.id_projeto) THEN 
					flag := false;
					SELECT INTO mensagem a.mensagem FROM portal.verificar_erro('permissao_negada_usuario', operacao, fonte, osc, dataatualizacao::TIMESTAMP, errolog) AS a;
				
				ELSE 
					INSERT INTO osc.tb_fonte_recursos_projeto (
						id_projeto, 
						cd_fonte_recursos_projeto, 
						cd_origem_fonte_recursos_projeto, 
						ft_fonte_recursos_projeto, 
						cd_tipo_parceria, 
						tx_tipo_parceria_outro, 
						ft_tipo_parceria, 
						tx_orgao_concedente, 
						ft_orgao_concedente
					) VALUES (
						objeto.id_projeto, 
						objeto.cd_fonte_recursos_projeto, 
						objeto.cd_origem_fonte_recursos_projeto, 
						fonte_dados.nome_fonte, 
						objeto.cd_tipo_parceria, 
						objeto.tx_tipo_parceria_outro, 
						fonte_dados.nome_fonte, 
						objeto.tx_orgao_concedente, 
						fonte_dados.nome_fonte
					) RETURNING * INTO dado_posterior;
					
					registro_nao_delete := array_append(registro_nao_delete, dado_posterior.id_fonte_recursos_projeto);
					
					INSERT INTO log.tb_log_alteracao(tx_nome_tabela, id_osc, id_usuario, dt_alteracao, tx_dado_anterior, tx_dado_posterior) 
					VALUES (nome_tabela, osc, fonte::INTEGER, dataatualizacao, null, row_to_json(dado_posterior));
				END IF;
			ELSE 
				dado_posterior := dado_anterior;
				registro_nao_delete := array_append(registro_nao_delete, dado_posterior.id_fonte_recursos_projeto);
				flag_update := false;
				
				IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.cd_fonte_recursos_projeto::TEXT, dado_anterior.ft_fonte_recursos_projeto, objeto.cd_fonte_recursos_projeto::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN 
					dado_posterior.cd_fonte_recursos_projeto := objeto.cd_fonte_recursos_projeto;
					dado_posterior.ft_fonte_recursos_projeto := fonte_dados.nome_fonte;
					flag_update := true;
				END IF;
				
				IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.cd_origem_fonte_recursos_projeto::TEXT, dado_anterior.ft_origem_fonte_recursos_projeto, objeto.cd_origem_fonte_recursos_projeto::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN 
					dado_posterior.cd_origem_fonte_recursos_projeto := objeto.cd_origem_fonte_recursos_projeto;
					dado_posterior.ft_fonte_recursos_projeto := fonte_dados.nome_fonte;
					flag_update := true;
				END IF;
				
				IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.cd_tipo_parceria::TEXT, dado_anterior.ft_tipo_parceria, objeto.cd_tipo_parceria::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN 
					dado_posterior.cd_tipo_parceria := objeto.cd_tipo_parceria;
					dado_posterior.ft_tipo_parceria := fonte_dados.nome_fonte;
					flag_update := true;
				END IF;
				
				IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_tipo_parceria_outro::TEXT, dado_anterior.ft_tipo_parceria_outro, objeto.tx_tipo_parceria_outro::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN 
					dado_posterior.tx_tipo_parceria_outro := objeto.tx_tipo_parceria_outro;
					dado_posterior.ft_tipo_parceria := fonte_dados.nome_fonte;
					flag_update := true;
				END IF;
				
				IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_orgao_concedente::TEXT, dado_anterior.ft_orgao_concedente, objeto.tx_orgao_concedente::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN 
					dado_posterior.tx_orgao_concedente := objeto.tx_orgao_concedente;
					dado_posterior.ft_orgao_concedente := fonte_dados.nome_fonte;
					flag_update := true;
				END IF;
				
				IF flag_update THEN 
					UPDATE osc.tb_fonte_recursos_projeto 
					SET cd_fonte_recursos_projeto = dado_posterior.cd_fonte_recursos_projeto, 
						cd_origem_fonte_recursos_projeto = dado_posterior.cd_origem_fonte_recursos_projeto, 
						ft_fonte_recursos_projeto = dado_posterior.ft_fonte_recursos_projeto, 
						cd_tipo_parceria = dado_posterior.cd_tipo_parceria, 
						tx_tipo_parceria_outro = dado_posterior.tx_tipo_parceria_outro, 
						ft_tipo_parceria = dado_posterior.ft_tipo_parceria, 
						tx_orgao_concedente = dado_posterior.tx_orgao_concedente, 
						ft_orgao_concedente = dado_posterior.ft_orgao_concedente 
					WHERE id_fonte_recursos_projeto = dado_posterior.id_fonte_recursos_projeto;
					
					INSERT INTO log.tb_log_alteracao(tx_nome_tabela, id_osc, id_usuario, dt_alteracao, tx_dado_anterior, tx_dado_posterior) 
					VALUES (nome_tabela, osc, fonte::INTEGER, dataatualizacao, row_to_json(dado_anterior), row_to_json(dado_posterior));
				END IF;
			
			END IF;
			
		END LOOP;
		
		IF deletevalido THEN 
			DELETE FROM osc.tb_fonte_recursos_projeto WHERE id_fonte_recursos_projeto != ALL(registro_nao_delete);
		END IF;
		
		flag := true;
		mensagem := 'Fonte de recursos de projeto atualizado.';
	END IF;
	
	RETURN NEXT;

EXCEPTION 
	WHEN others THEN 
		flag := false;
		SELECT INTO mensagem a.mensagem FROM portal.verificar_erro(SQLSTATE, operacao, fonte, osc, dataatualizacao::TIMESTAMP, errolog) AS a;
		
		RETURN NEXT;
		
END; 
$$ LANGUAGE 'plpgsql';
