UPDATE osc.tb_recursos_osc AS o
SET cd_origem_fonte_recursos_osc = s.cd_origem_fonte_recursos_osc
FROM syst.dc_fonte_recursos_osc AS s
WHERE o.cd_fonte_recursos_osc = s.cd_fonte_recursos_osc
