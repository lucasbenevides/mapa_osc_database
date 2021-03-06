﻿-- Materialized View: portal.vw_osc_recursos_osc

DROP MATERIALIZED VIEW portal.vw_osc_recursos_osc;

CREATE MATERIALIZED VIEW portal.vw_osc_recursos_osc AS 
 SELECT tb_osc.id_osc,
    tb_osc.tx_apelido_osc,
    tb_recursos_osc.id_recursos_osc,
    tb_recursos_osc.cd_fonte_recursos_osc,
    ( SELECT dc_origem_fonte_recursos_osc.tx_nome_origem_fonte_recursos_osc
           FROM syst.dc_origem_fonte_recursos_osc
          WHERE dc_origem_fonte_recursos_osc.cd_origem_fonte_recursos_osc = (( SELECT dc_fonte_recursos_osc.cd_origem_fonte_recursos_osc
                   FROM syst.dc_fonte_recursos_osc
                  WHERE dc_fonte_recursos_osc.cd_fonte_recursos_osc = tb_recursos_osc.cd_fonte_recursos_osc))) AS tx_nome_origem_fonte_recursos_osc,
    ( SELECT dc_fonte_recursos_osc.tx_nome_fonte_recursos_osc
           FROM syst.dc_fonte_recursos_osc
          WHERE dc_fonte_recursos_osc.cd_fonte_recursos_osc = tb_recursos_osc.cd_fonte_recursos_osc) AS tx_nome_fonte_recursos_osc,
    tb_recursos_osc.ft_fonte_recursos_osc,
    "substring"(tb_recursos_osc.dt_ano_recursos_osc::text, 1, 4) AS dt_ano_recursos_osc,
    tb_recursos_osc.ft_ano_recursos_osc,
    tb_recursos_osc.nr_valor_recursos_osc,
    tb_recursos_osc.ft_valor_recursos_osc,
    tb_recursos_osc.bo_nao_possui,
	tb_recursos_osc.ft_nao_possui
   FROM osc.tb_osc
     JOIN osc.tb_recursos_osc ON tb_osc.id_osc = tb_recursos_osc.id_osc
  WHERE tb_osc.bo_osc_ativa
WITH DATA;

ALTER TABLE portal.vw_osc_recursos_osc
  OWNER TO postgres;
