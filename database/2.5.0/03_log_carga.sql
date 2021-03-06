-- Table: log.tb_log_carga

DROP TABLE IF EXISTS log.tb_log_erro_carga;
DROP TABLE IF EXISTS log.tb_log_alteracao;
DROP TABLE IF EXISTS log.tb_log_carga;

CREATE TABLE log.tb_log_carga
(
    id_carga serial NOT NULL,
    tx_carga text COLLATE pg_catalog."default" NOT NULL,
    dt_inicio timestamp without time zone NOT NULL,
    dt_fim timestamp without time zone,
    cd_status integer,
    CONSTRAINT pk_id_carga PRIMARY KEY (id_carga),
    CONSTRAINT fk_cd_status FOREIGN KEY (cd_status)
        REFERENCES syst.dc_status_carga (cd_status) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE log.tb_log_carga
    OWNER to postgres;

-- Table: log.tb_log_erro_carga

CREATE TABLE log.tb_log_erro_carga
(
    id_log_erro_carga serial NOT NULL,
    cd_identificador_osc numeric NOT NULL,
    cd_status smallint NOT NULL,
    tx_mensagem text COLLATE pg_catalog."default" NOT NULL,
    dt_carregamento_dados timestamp without time zone,
    id_carga integer,
    CONSTRAINT pk_tb_log_carga PRIMARY KEY (id_log_erro_carga),
    CONSTRAINT fk_cd_status FOREIGN KEY (cd_status)
        REFERENCES syst.dc_status_carga (cd_status) MATCH FULL
        ON UPDATE NO ACTION
        ON DELETE NO ACTION,
    CONSTRAINT fk_id_carga FOREIGN KEY (id_carga)
        REFERENCES log.tb_log_carga (id_carga) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION
)
WITH (
    OIDS = FALSE
)
TABLESPACE pg_default;

ALTER TABLE log.tb_log_erro_carga
    OWNER to postgres;
COMMENT ON TABLE log.tb_log_erro_carga
    IS 'Log da carga dos dados';

COMMENT ON COLUMN log.tb_log_erro_carga.id_log_erro_carga
    IS 'Código sequência do log';

COMMENT ON COLUMN log.tb_log_erro_carga.cd_identificador_osc
    IS 'Número do CNPJ da OSC';

COMMENT ON COLUMN log.tb_log_erro_carga.cd_status
    IS 'Chave estrangeira';

COMMENT ON COLUMN log.tb_log_erro_carga.tx_mensagem
    IS 'Mensagem de log';

COMMENT ON COLUMN log.tb_log_erro_carga.dt_carregamento_dados
    IS 'Data de carregamento dos dados';

CREATE TABLE log.tb_log_alteracao
(
  id_log_alteracao serial NOT NULL, -- Identificador do log de alteração
  tx_nome_tabela text NOT NULL, -- Nome da tabela alterada
  id_osc integer NOT NULL, -- Identificador do tabela alterada
  tx_fonte_dados text NOT NULL, -- Identificador do usuário
  dt_alteracao timestamp without time zone NOT NULL, -- Data de alteração do dado
  tx_dado_anterior json, -- Valor dado anterior
  tx_dado_posterior json, -- Valor do dado atualizado
  CONSTRAINT pk_tb_log_alteracao PRIMARY KEY (id_log_alteracao) -- Chave primária da tabela de log de alteração
);

ALTER TABLE log.tb_log_alteracao
ADD COLUMN id_carga INTEGER,
ADD CONSTRAINT fk_id_carga FOREIGN KEY (id_carga)
    REFERENCES log.tb_log_carga (id_carga);
