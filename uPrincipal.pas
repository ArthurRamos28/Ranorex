unit uPrincipal;

interface

uses
   Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
   Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Winapi.ShellAPI,
   JvExComCtrls, JvProgressBar, Vcl.WinXCtrls, Vcl.ComCtrls,
   JvBaseDlg, JvBrowseFolder, JvDialogs, Vcl.Mask, JvExMask, JvToolEdit, System.Generics.Collections,
   System.StrUtils, System.JSON,REST.Types, System.DateUtils, System.Types, System.IOUtils, FireDAC.Phys.IB,
   FireDAC.Stan.Def, FireDAC.Phys, FireDAC.Phys.IBDef, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
   FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.VCLUI.Wait, Data.DB,
   FireDAC.Comp.Client, FireDAC.Dapt, FireDAC.Phys.FB, FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, System.Zip, System.UITypes,
   Winapi.WinSvc, Data.Win.ADODB, System.ImageList, Vcl.ImgList, JclSysUtils, dprocess, LibUtil;



type
  TRanorex = class(TForm)
    pnl1: TPanel;
    btnIniciar: TButton;
    lblTitulo: TLabel;
    chkProcedimento: TCheckBox;
    chkCadastro: TCheckBox;
    cbbModulosCadastro: TComboBox;
    cbbModulosProcedimentos: TComboBox;
    procedure btnIniciarClick(Sender: TObject);
    procedure chkCadastroClick(Sender: TObject);
    procedure chkProcedimentoClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure cbbModulosCadastroChange(Sender: TObject);

  private
    fCaminhoCompletoCadastro : String;
    fCaminhoCompletoProcedimento : String;
    fCadastro : String;
    fProcedimento : String;


    procedure Cadastro;
    procedure Procedimento;
    function GetDiretorioExe: String;
    procedure Checkbox;
    procedure CarregaComboBox;
    procedure CaminhoEscolhidoCadastro;
    procedure CaminhoEscolhidoProcedimento;
    function GetCaminho(mTipo: String; mIndice: Integer): String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Ranorex: TRanorex;

implementation

{$R *.dfm}

procedure TRanorex.btnIniciarClick(Sender: TObject);
begin
  if (chkCadastro.Checked) and (chkProcedimento.Checked) then
    begin
      Cadastro;
      Procedimento;
    end

  else if (chkProcedimento.Checked) then
    Procedimento

  else if (chkCadastro.Checked) then
    Cadastro;
end;

procedure TRanorex.Cadastro;
var
  mI : Integer;
begin
  if cbbModulosCadastro.ItemIndex = 0 then
    begin
      for mI := 2 to cbbModulosCadastro.Items.Count -1 do
        CarregarPromptComand(GetCaminho('Cadastro', mI));
    end
  else
    CarregarPromptComand(fCaminhoCompletoCadastro);
end;

procedure TRanorex.FormClose(Sender: TObject; var Action: TCloseAction);
var
  ProcessInfo : TProcessInformation;
begin
  TerminateProcess(ProcessInfo.hProcess, 0);
end;

procedure TRanorex.FormCreate(Sender: TObject);
begin
  CarregaComboBox;
end;

procedure TRanorex.Procedimento;
var
  mI : Integer;
begin
  if cbbModulosProcedimentos.ItemIndex = 0 then
    begin
      for mI := 2 to cbbModulosProcedimentos.Items.Count -1 do
        CarregarPromptComand(GetCaminho('Procedimento', mI));
    end
  else
    CarregarPromptComand(fCaminhoCompletoProcedimento);
end;

procedure TRanorex.Checkbox;
var
  mI : Integer;
begin

  if chkCadastro.Checked then
    CaminhoEscolhidoCadastro;

  if chkProcedimento.Checked then
    CaminhoEscolhidoProcedimento;

  if not (chkCadastro.Checked) then
    fCaminhoCompletoCadastro := ''
  else
    fCaminhoCompletoCadastro := GetDiretorioExe + fCadastro;

  if not (chkProcedimento.Checked) then
    fCaminhoCompletoProcedimento := ''
  else
    fCaminhoCompletoProcedimento := GetDiretorioExe + fProcedimento;
end;

procedure TRanorex.CaminhoEscolhidoCadastro;
var
  mI : Integer;
begin
  mI := cbbModulosCadastro.ItemIndex;
  if (mI >= Low(cgModuloCadastro) - 1) and (mI <= High(cgModuloCadastro) - 1) then
    fCadastro := 'Cadastro\' + cgModuloCadastro[mI + 1] + '\Hotel.exe';
end;

procedure TRanorex.CaminhoEscolhidoProcedimento;
var
  mI : Integer;
begin
  mI := cbbModulosProcedimentos.ItemIndex;
  if (mI >= Low(cgModuloProcedimento) - 1) and (mI <= High(cgModuloProcedimento)- 1) then
    fProcedimento := 'Procedimento\' + cgModuloProcedimento[mI + 1] + '\Hotel.exe';
end;

procedure TRanorex.chkCadastroClick(Sender: TObject);
begin
  Checkbox;
end;

procedure TRanorex.chkProcedimentoClick(Sender: TObject);
begin
  Checkbox;
end;

procedure TRanorex.CarregaComboBox;
begin
  CarregarComboBox(cbbModulosCadastro, cgModuloCadastro, cgTipo, 0);
  CarregarComboBox(cbbModulosProcedimentos, cgModuloProcedimento, cgTipo, 1);

  cbbModulosCadastro.ItemIndex      := 0;
  cbbModulosProcedimentos.ItemIndex := 0;
end;

procedure TRanorex.cbbModulosCadastroChange(Sender: TObject);
begin
  CheckBox;
end;

function TRanorex.GetDiretorioExe: String;
begin
  {$IFDEF linux}
  Result := System.SysUtils.GetCurrentDir;
  {$ELSE}
  Result:= ExtractFilePath(Application.ExeName);
  {$ENDIF}
  if (RightStr(Result, 1) <> cgDirBarra) then
    Result:= Result + cgDirBarra;
end;

function TRanorex.GetCaminho(mTipo: String; mIndice: Integer): String;
begin
  if chkCadastro.Checked then
    Result := GetDiretorioExe + mTipo + '\' + cgModuloCadastro[mIndice] + '\Hotel.exe';

  if chkProcedimento.Checked then
    Result := GetDiretorioExe + mTipo + '\' + cgModuloProcedimento[mIndice] + '\Hotel.exe';
end;

end.
