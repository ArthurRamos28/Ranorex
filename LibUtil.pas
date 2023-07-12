unit LibUtil;

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
   Winapi.WinSvc, Data.Win.ADODB, System.ImageList, Vcl.ImgList, JclSysUtils, dprocess;

const
  cgDirBarra = {$IFDEF linux}'/'{$ELSE}'\'{$ENDIF};

  cgModuloCadastro: array [1..10] of string = ('Todos', 'Utilitarios', 'CRM', 'Almoxarifado', 'Financeiro',
  'PDV', 'Recepção', 'Eventos', 'Ordem de Serviço', 'Reservas');

  cgModuloProcedimento: array [1..11] of string = ('Todos', 'Eventos', 'Reservas', 'Recepção', 'PDV', 'Almoxarifado',
  'Financeiro', 'Utilitarios', 'Relatorios', 'Extra', 'CRM');

  cgTipo: array[1..2] of string = ('Cadastro', 'Procedimento');

  procedure CarregarComboBox(mComboBox: TComboBox; const cgModulos, cgTipo: array of string; cgTipoIndex: Integer);
  procedure CarregarPromptComand(gCaminhoCadastro : String);

implementation



procedure CarregarComboBox(mComboBox: TComboBox; const cgModulos, cgTipo: array of string; cgTipoIndex: Integer);
var
  mI: Integer;
begin
  mComboBox.Clear;

  for mI := Low(cgModulos) to High(cgModulos) do
    mComboBox.Items.Add(cgModulos[mI] + ' ' + cgTipo[cgTipoIndex]);
end;

procedure CarregarPromptComand(gCaminhoCadastro : String);
var
  StartupInfo : TStartupInfo;
  ProcessInfo : TProcessInformation;
begin
  ZeroMemory(@StartupInfo, SizeOf(TStartupInfo));
  StartupInfo.cb          := SizeOf(StartupInfo);
  StartupInfo.dwFlags     := STARTF_USESTDHANDLES;
  StartupInfo.wShowWindow := SW_NORMAL;

  if not CreateProcess(nil, PChar(gCaminhoCadastro), nil, nil, False, CREATE_NEW_CONSOLE, nil, nil, StartupInfo, ProcessInfo) then
    begin
      RaiseLastOSError;
      Exit;
    end;

  WaitForSingleObject(ProcessInfo.hProcess, INFINITE);

  CloseHandle(ProcessInfo.hProcess);
  CloseHandle(ProcessInfo.hThread);
end;

end.
