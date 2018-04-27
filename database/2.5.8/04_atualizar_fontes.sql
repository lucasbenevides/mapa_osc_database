ALTER TABLE osc.tb_area_atuacao DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_area_atuacao_outra DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_area_atuacao_outra_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_area_atuacao_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_certificado DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_conselho_fiscal DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_contato DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_dados_gerais DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_financiador_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_fonte_recursos_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_governanca DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_localizacao_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_objetivo_osc DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_objetivo_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_osc_parceira_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conferencia DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conferencia_outra DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conselho DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conselho_outro DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_outra DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_publico_beneficiado_projeto DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_recursos_osc DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_recursos_outro_osc DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_relacoes_trabalho DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_relacoes_trabalho_outra DISABLE TRIGGER ALL;
ALTER TABLE osc.tb_representante_conselho DISABLE TRIGGER ALL;


  SELECT * FROM syst.atualizar_fontes_dados_geral('3', 'Galileo');
  SELECT * FROM syst.atualizar_fontes_dados_geral('1', 'Representante de OSC');
  SELECT * FROM syst.atualizar_fontes_dados_geral('Representante', 'Representante de OSC');
  SELECT * FROM syst.atualizar_fontes_dados_geral('Representate', 'Representante de OSC');
  SELECT * FROM syst.atualizar_fontes_dados_geral('FNDCT/FINEP', 'FINEP/FNDCT');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MCID/MCMV-E', 'MCMV-E/MCID');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MDS/Base', 'Base/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MDS/CEBAS', 'CEBAS/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MS/AS', 'CEBAS/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MDS/Censo SUAS', 'Censo SUAS/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MEC/CEBAS', 'CEBAS/MEC');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MESP/LIE', 'LIE/MESP');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MINC/SALICWEB', 'SALICWEB/MINC');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MJ/CNES/OSCIP', 'OSCIP/MJ');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MJ/CNES/UPF', 'UPF/MJ');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MMA/CNEA', 'CNEA/MMA');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MPOG/SICONV', 'SICONV/MPOG');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MS/CEBAS', 'CEBAS/MS');
  SELECT * FROM syst.atualizar_fontes_dados_geral('MTE/RAIS', 'RAIS/MTE');
  SELECT * FROM syst.atualizar_fontes_dados_geral('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_projeto('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_projeto('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_area_atuacao_projeto('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_fonte_recursos_projeto('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao_projeto('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_localizacao('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_localizacao('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_objetivo_projeto('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_parceria_projeto('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conferencia('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_conselho('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_participacao_social_outra('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_publico_beneficiado_projeto('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_relacoes_trabalho_outra('SGPR/Conselhos', 'Conselhos/SGPR');

	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('3', 'Galileo');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('1', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('Representante', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('Representate', 'Representante de OSC');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('FNDCT/FINEP', 'FINEP/FNDCT');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MCID/MCMV-E', 'MCMV-E/MCID');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MDS/Base', 'Base/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MDS/CEBAS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MS/AS', 'CEBAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MDS/Censo SUAS', 'Censo SUAS/MDS');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MEC/CEBAS', 'CEBAS/MEC');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MESP/LIE', 'LIE/MESP');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MINC/SALICWEB', 'SALICWEB/MINC');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MJ/CNES/OSCIP', 'OSCIP/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MJ/CNES/UPF', 'UPF/MJ');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MMA/CNEA', 'CNEA/MMA');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MPOG/SICONV', 'SICONV/MPOG');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MS/CEBAS', 'CEBAS/MS');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('MTE/RAIS', 'RAIS/MTE');
	SELECT * FROM syst.atualizar_fontes_dados_representante_conselho('SGPR/Conselhos', 'Conselhos/SGPR');

  SELECT * FROM syst.atualizar_fontes_dados_governanca('3', 'Galileo');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('1', 'Representante de OSC');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('Representante', 'Representante de OSC');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('Representate', 'Representante de OSC');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('FNDCT/FINEP', 'FINEP/FNDCT');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MCID/MCMV-E', 'MCMV-E/MCID');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MDS/Base', 'Base/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MDS/CEBAS', 'CEBAS/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MS/AS', 'CEBAS/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MDS/Censo SUAS', 'Censo SUAS/MDS');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MEC/CEBAS', 'CEBAS/MEC');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MESP/LIE', 'LIE/MESP');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MINC/SALICWEB', 'SALICWEB/MINC');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MJ/CNES/OSCIP', 'OSCIP/MJ');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MJ/CNES/UPF', 'UPF/MJ');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MMA/CNEA', 'CNEA/MMA');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MPOG/SICONV', 'SICONV/MPOG');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MS/CEBAS', 'CEBAS/MS');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('MTE/RAIS', 'RAIS/MTE');
  SELECT * FROM syst.atualizar_fontes_dados_governanca('SGPR/Conselhos', 'Conselhos/SGPR');


ALTER TABLE osc.tb_area_atuacao ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_area_atuacao_outra ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_area_atuacao_outra_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_area_atuacao_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_certificado ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_conselho_fiscal ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_contato ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_dados_gerais ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_financiador_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_fonte_recursos_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_governanca ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_localizacao_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_objetivo_osc ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_objetivo_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_osc_parceira_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conferencia ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conferencia_outra ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conselho ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_conselho_outro ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_participacao_social_outra ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_publico_beneficiado_projeto ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_recursos_osc ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_recursos_outro_osc ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_relacoes_trabalho ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_relacoes_trabalho_outra ENABLE TRIGGER ALL;
ALTER TABLE osc.tb_representante_conselho ENABLE TRIGGER ALL;

select * from RefreshAllMaterializedViewsC('osc');
select * from RefreshAllMaterializedViewsC('portal');