{******************************************************************************}
{ Projeto: Componente ACBrNFSe                                                 }
{  Biblioteca multiplataforma de componentes Delphi                            }
{                                                                              }
{  Voc� pode obter a �ltima vers�o desse arquivo na pagina do Projeto ACBr     }
{ Componentes localizado em http://www.sourceforge.net/projects/acbr           }
{                                                                              }
{                                                                              }
{  Esta biblioteca � software livre; voc� pode redistribu�-la e/ou modific�-la }
{ sob os termos da Licen�a P�blica Geral Menor do GNU conforme publicada pela  }
{ Free Software Foundation; tanto a vers�o 2.1 da Licen�a, ou (a seu crit�rio) }
{ qualquer vers�o posterior.                                                   }
{                                                                              }
{  Esta biblioteca � distribu�da na expectativa de que seja �til, por�m, SEM   }
{ NENHUMA GARANTIA; nem mesmo a garantia impl�cita de COMERCIABILIDADE OU      }
{ ADEQUA��O A UMA FINALIDADE ESPEC�FICA. Consulte a Licen�a P�blica Geral Menor}
{ do GNU para mais detalhes. (Arquivo LICEN�A.TXT ou LICENSE.TXT)              }
{                                                                              }
{  Voc� deve ter recebido uma c�pia da Licen�a P�blica Geral Menor do GNU junto}
{ com esta biblioteca; se n�o, escreva para a Free Software Foundation, Inc.,  }
{ no endere�o 59 Temple Street, Suite 330, Boston, MA 02111-1307 USA.          }
{ Voc� tamb�m pode obter uma copia da licen�a em:                              }
{ http://www.opensource.org/licenses/lgpl-license.php                          }
{                                                                              }
{ Daniel Sim�es de Almeida  -  daniel@djsystem.com.br  -  www.djsystem.com.br  }
{              Pra�a Anita Costa, 34 - Tatu� - SP - 18270-410                  }
{                                                                              }
{******************************************************************************}

{$I ACBr.inc}

unit pnfsNFSeW_Governa;

interface

uses
{$IFDEF FPC}
  LResources, Controls, Graphics, Dialogs,
{$ELSE}

{$ENDIF}
  SysUtils, Classes, StrUtils,
  synacode, ACBrConsts,
  pnfsNFSeW,
  pcnAuxiliar, pcnConversao, pcnGerador,
  pnfsNFSe, pnfsConversao;

type
  { TNFSeW_Governa }

  TNFSeW_Governa = class(TNFSeWClass)
  private
  protected

    procedure GerarIdentificacaoRPS;
    procedure GerarRPSSubstituido;

    procedure GerarPrestador;
    procedure GerarTomador;
    procedure GerarIntermediarioServico;

    procedure GerarServicoValores;
    procedure GerarListaServicos;
    procedure GerarValoresServico;

    procedure GerarConstrucaoCivil;
    procedure GerarCondicaoPagamento;

    procedure GerarXML_Governa;

  public
    constructor Create(ANFSeW: TNFSeW); override;

    function ObterNomeArquivo: String; override;
    function GerarXml: Boolean; override;
  end;

implementation

uses
  ACBrUtil;

{==============================================================================}
{ Essa unit tem por finalidade exclusiva de gerar o XML do RPS segundo o       }
{ layout do Governa.                                                       }
{ Sendo assim s� ser� criado uma nova unit para um novo layout.                }
{==============================================================================}

{ TNFSeW_Governa }

procedure TNFSeW_Governa.GerarIdentificacaoRPS;
begin
  // N�o Definido
end;

procedure TNFSeW_Governa.GerarRPSSubstituido;
begin
  // N�o Definido
end;

procedure TNFSeW_Governa.GerarPrestador;
begin
  // N�o Definido
end;

procedure TNFSeW_Governa.GerarTomador;
begin
  Gerador.wCampoNFSE(tcStr, '', 'NumDocTmd', 11, 014, 1, NFSe.Tomador.IdentificacaoTomador.CpfCnpj,'');
  Gerador.wCampoNFSE(tcStr, '', 'InsEstTmd', 01, 020, 1, NFSe.Tomador.IdentificacaoTomador.InscricaoEstadual,'');
  Gerador.wCampoNFSE(tcStr, '', 'InsMunTmd', 01, 020, 1, NFSe.Tomador.IdentificacaoTomador.InscricaoMunicipal, '');
  Gerador.wCampoNFSe(tcStr, '', 'NomTmd'   , 05, 100, 1, NFSe.Tomador.RazaoSocial, '');
  Gerador.wCampoNFSe(tcStr, '', 'DesEndTmd', 05, 100, 1, NFSe.Tomador.Endereco.Endereco, '');
  Gerador.wCampoNFSe(tcStr, '', 'NomBaiTmd', 01, 060, 1, NFSe.Tomador.Endereco.Bairro, '');
  Gerador.wCampoNFSe(tcStr, '', 'NomCidTmd', 01, 060, 1, NFSe.Tomador.Endereco.xMunicipio, '');
  Gerador.wCampoNFSe(tcStr, '', 'CodEstTmd', 02, 002, 1, NFSe.Tomador.Endereco.UF, '');
  Gerador.wCampoNFSe(tcStr, '', 'CEPTmd'   , 08, 008, 1, NFSe.Tomador.Endereco.CEP, '');
  Gerador.wCampoNFSe(tcStr, '', 'EmlTmd'   , 01, 050, 1, '','');
end;

procedure TNFSeW_Governa.GerarIntermediarioServico;
begin
  // N�o Definido
end;

procedure TNFSeW_Governa.GerarServicoValores;
begin
  // N�o Definido
end;

procedure TNFSeW_Governa.GerarListaServicos;
begin
  Gerador.Prefixo := Prefixo4;
  Gerador.wGrupoNFSe('ItensRps');
  Gerador.wGrupoNFSe('ItemRps');

  Gerador.Prefixo := Prefixo3;
  Gerador.wCampoNFSe(tcInt, '', 'SeqItem', 01, 02, 1, 1, '');
  Gerador.wCampoNFSe(tcDe2, '', 'QdeSvc', 01, 09, 1, 1, '');
  Gerador.wCampoNFSe(tcDe2, '', 'VlrUnt', 01, 16, 1, NFSe.Servico.Valores.ValorLiquidoNfse, '');
  Gerador.wCampoNFSe(tcStr, '', 'DesSvc', 00, 100, 1, NFSe.Servico.Discriminacao, '');

  Gerador.Prefixo := Prefixo4;
  Gerador.wGrupoNFSe('/ItemRps');
  Gerador.wGrupoNFSe('/ItensRps');
end;

procedure TNFSeW_Governa.GerarValoresServico;
begin
  Gerador.wCampoNFSe(tcStr, '', 'CodAti', 4, 10, 1, NFSe.Servico.CodigoTributacaoMunicipio, '');
  Gerador.wCampoNFSe(tcDe2, '', 'PerAlq', 01, 15, 1, NFSe.Servico.Valores.Aliquota, '');
  Gerador.wCampoNFSe(tcStr, '', 'FrmTrb', 01, 02, 1, '11', '');
  Gerador.wCampoNFSe(tcStr, '', 'TipRec', 01, 01, 1, NFSe.TipoRecolhimento , '');
  Gerador.wCampoNFSe(tcStr, '', 'DatEmsRps', 08, 08, 1, StringReplace(FormatDateTime('yyyymmdd',NFSe.DataEmissao),'/', '',[rfReplaceAll]), '');
  Gerador.wCampoNFSe(tcStr, '', 'DatEmsNFSe', 08, 08, 1, '' , '');
  Gerador.wCampoNFSe(tcDe2, '', 'VlrDed', 01, 16, 1, NFSe.Servico.Valores.ValorDeducoes, '');
  //**analisar valores maximos, dependendo do tipo de servi�o** campo - VLrDed
  Gerador.wCampoNFSe(tcDe2, '', 'VlrDsc', 01, 01, 1, NFSe.Servico.Valores.DescontoCondicionado, '');
  //**valor fixo 0 para desconto
  gerador.wCampoNFSe(tcDe2, '', 'VlrPIS', 01, 16, 1, NFSe.Servico.Valores.ValorPis, '');
  Gerador.wCampoNFSe(tcDe2, '', 'VlrINSS', 01, 16, 1, NFSe.Servico.Valores.ValorInss, '');
  Gerador.wCampoNFSe(tcDe2, '', 'VlrCofins', 01, 16, 1, NFSe.Servico.Valores.ValorCofins, '');
  Gerador.wCampoNFSe(tcDe2, '', 'VlrIR', 01, 16, 1, NFSe.Servico.Valores.ValorIr, '');
  Gerador.wCampoNFSe(tcDe2, '', 'VlrCSLL', 01, 16, 1, NFSe.Servico.Valores.ValorCsll, '');
  Gerador.wCampoNFSe(tcDe2, '', 'VlrOtrRtn', 01, 16, 1, NFSe.Servico.Valores.valorOutrasRetencoes , '');
  Gerador.wCampoNFSe(tcStr, '', 'DesOtrRtn', 01, 16, 1, NFSe.Servico.Valores.DescricaoOutrasRetencoes, '');
  Gerador.wCampoNFSe(tcStr, '', 'Obs', 01, 16, 1, NFSe.OutrasInformacoes, '');
end;

procedure TNFSeW_Governa.GerarConstrucaoCivil;
begin
  // N�o Definido
end;

procedure TNFSeW_Governa.GerarCondicaoPagamento;
begin
  // N�o Definido
end;

procedure TNFSeW_Governa.GerarXML_Governa;
begin
  Gerador.Prefixo := Prefixo4;
  Gerador.wGrupoNFSe('Rps');
  Gerador.wGrupoNFSe('InfRps');

  Gerador.Prefixo := Prefixo3;
  Gerador.wCampoNFSe(tcStr, '', 'NumRps', 01, 10, 1, NFSe.IdentificacaoRps.Numero, '');
  Gerador.wCampoNFSe(tcStr, '', 'CodVer', 01, 10, 1, NFSe.CodigoVerificacao, '');
  //** Vers�o fixo 3**
  Gerador.wCampoNFSe(tcStr, '', 'VrsImp', 01, 01, 1, '3', '');

  GerarTomador;
  GerarValoresServico;
  GerarListaServicos;

  Gerador.wGrupoNFSe('/InfRps');
  Gerador.wGrupoNFSe('/Rps');
end;

////////////////////////////////////////////////////////////////////////////////

constructor TNFSeW_Governa.Create(ANFSeW: TNFSeW);
begin
  inherited Create(ANFSeW);
end;

function TNFSeW_Governa.ObterNomeArquivo: String;
begin
  Result := OnlyNumber(NFSe.infID.ID) + '.xml';
end;

function TNFSeW_Governa.GerarXml: Boolean;
begin
  Gerador.Opcoes.DecimalChar := ',';

  Gerador.Prefixo := Prefixo4;
  Gerador.wGrupoNFSe('LoteRps');

  Gerador.wCampoNFSe(tcStr, '', 'CodCadBic', 01, 15, 1, NFSe.Prestador.InscricaoMunicipal, '');
  Gerador.wCampoNFSe(tcStr, '', 'VrsArq', 01, 01, 1, '1', '');
  Gerador.wCampoNFSe(tcStr, '', 'ChvAcs', 30, 30, 1, NFSe.Prestador.ChaveAcesso, '');

  GerarXML_Governa;

  Gerador.wGrupoNFSe('/LoteRps');

  Gerador.gtAjustarRegistros(NFSe.InfID.ID);
  Result := (Gerador.ListaDeAlertas.Count = 0);
end;

end.
