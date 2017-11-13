DROP FUNCTION IF EXISTS portal.atualizar_area_atuacao_osc(fonte TEXT, osc INTEGER, dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, deletevalido BOOLEAN, errolog BOOLEAN, idcarga INTEGER, tipobusca INTEGER);

DROP FUNCTION IF EXISTS portal.atualizar_area_atuacao_osc(fonte TEXT, cnpj INTEGER, dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, deletevalido BOOLEAN, errolog BOOLEAN, idcarga INTEGER, tipobusca INTEGER);

DROP FUNCTION IF EXISTS portal.atualizar_area_atuacao_osc(fonte TEXT, identificador NUMERIC, tipo_identificador TEXT , dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, deletevalido BOOLEAN, errolog BOOLEAN, idcarga INTEGER, tipobusca INTEGER);

CREATE OR REPLACE FUNCTION portal.atualizar_area_atuacao_osc(fonte TEXT, identificador NUMERIC, tipo_identificador TEXT , dataatualizacao TIMESTAMP, json JSONB, nullvalido BOOLEAN, deletevalido BOOLEAN, errolog BOOLEAN, idcarga INTEGER, tipobusca INTEGER) RETURNS TABLE(
	mensagem TEXT,

	flag BOOLEAN
)AS $$

DECLARE
	nome_tabela TEXT;
	fonte_dados RECORD;
	objeto RECORD;
	dado_anterior RECORD;
	dado_posterior RECORD;
	registro_nao_delete INTEGER[];
	flag_update BOOLEAN;
	osc INTEGER;

BEGIN
	nome_tabela := 'osc.tb_area_atuacao';
	tipo_identificador := lower(tipo_identificador);
	SELECT INTO fonte_dados * FROM portal.verificar_fonte(fonte);

	IF fonte_dados IS null THEN
		RAISE EXCEPTION 'fonte_invalida';
	ELSIF osc != ALL(fonte_dados.representacao) THEN
		RAISE EXCEPTION 'permissao_negada_usuario';
	ELSIF tipo_identificador != 'cnpj' OR tipo_identificador != 'id_osc' THEN
		RAISE EXCEPTION 'tipo_identificador';
	END IF;

	IF tipo_identificador = 'cnpj' THEN
		SELECT id_osc INTO osc FROM osc.tb_osc WHERE cd_identificador_osc = identificador;
	ELSE
		osc:=identificador;
	END IF;

	registro_nao_delete := '{}';

	IF json_typeof(json::JSON) = 'object' THEN
		json := ('[' || json || ']');
	END IF;

	FOR objeto IN (SELECT * FROM json_populate_recordset(null::osc.tb_area_atuacao, json::JSON))
	LOOP
		dado_anterior := null;

		IF tipobusca = 1 THEN
			SELECT INTO dado_anterior *
			FROM osc.tb_area_atuacao
			WHERE id_area_atuacao = objeto.id_area_atuacao;

		ELSIF tipobusca = 2 THEN
			SELECT INTO dado_anterior *
			FROM osc.tb_area_atuacao
			WHERE (id_osc = osc AND cd_area_atuacao = objeto.cd_area_atuacao AND cd_subarea_atuacao = objeto.cd_subarea_atuacao);

		ELSE
			RAISE EXCEPTION 'dado_invalido';

		END IF;

		IF dado_anterior.id_area_atuacao IS null THEN
			INSERT INTO osc.tb_area_atuacao (
				id_osc,
				cd_area_atuacao,
				cd_subarea_atuacao,
				tx_nome_outra,
				ft_area_atuacao
			) VALUES (
				osc,
				objeto.cd_area_atuacao,
				objeto.cd_subarea_atuacao,
				objeto.tx_nome_outra,
				fonte_dados.nome_fonte
			) RETURNING * INTO dado_posterior;

			registro_nao_delete := array_append(registro_nao_delete, dado_posterior.id_area_atuacao);

			PERFORM * FROM portal.inserir_log_atualizacao(nome_tabela, osc, fonte, dataatualizacao, null, row_to_json(dado_posterior));

		ELSE

			dado_posterior := dado_anterior;
			registro_nao_delete := array_append(registro_nao_delete, dado_posterior.id_area_atuacao);
			flag_update := false;

			IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.cd_area_atuacao::TEXT, dado_anterior.ft_area_atuacao, objeto.cd_area_atuacao::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
				dado_posterior.cd_area_atuacao := objeto.cd_area_atuacao;
				dado_posterior.ft_area_atuacao := fonte_dados.nome_fonte;
				flag_update := true;
			END IF;

			IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.cd_subarea_atuacao::TEXT, dado_anterior.ft_area_atuacao, objeto.cd_subarea_atuacao::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
				dado_posterior.cd_subarea_atuacao := objeto.cd_subarea_atuacao;
				dado_posterior.ft_area_atuacao := fonte_dados.nome_fonte;
				flag_update := true;
			END IF;

			IF (SELECT a.flag FROM portal.verificar_dado(dado_anterior.tx_nome_outra::TEXT, dado_anterior.ft_area_atuacao, objeto.tx_nome_outra::TEXT, fonte_dados.prioridade, nullvalido) AS a) THEN
				dado_posterior.tx_nome_outra := objeto.tx_nome_outra;
				dado_posterior.ft_area_atuacao := fonte_dados.nome_fonte;
				flag_update := true;
			END IF;

			IF flag_update THEN
				UPDATE osc.tb_area_atuacao
				SET	cd_area_atuacao = dado_posterior.cd_area_atuacao,
					cd_subarea_atuacao = dado_posterior.cd_subarea_atuacao,
					tx_nome_outra = dado_posterior.tx_nome_outra,
					ft_area_atuacao = dado_posterior.ft_area_atuacao
				WHERE id_area_atuacao = dado_posterior.id_area_atuacao;

				PERFORM * FROM portal.inserir_log_atualizacao(nome_tabela, osc, fonte, dataatualizacao, row_to_json(dado_anterior), row_to_json(dado_posterior));
			END IF;

		END IF;

	END LOOP;

	IF deletevalido THEN
		DELETE FROM osc.tb_area_atuacao WHERE id_area_atuacao != ALL(registro_nao_delete);
	END IF;

	flag := true;
	mensagem := 'Área de atuação de OSC atualizado.';

	RETURN NEXT;

EXCEPTION
	WHEN others THEN
		flag := false;
		SELECT INTO mensagem a.mensagem FROM portal.verificar_erro(SQLSTATE, SQLERRM, fonte, osc, dataatualizacao::TIMESTAMP, errolog, idcarga) AS a;
		RETURN NEXT;

END;
$$ LANGUAGE 'plpgsql';
