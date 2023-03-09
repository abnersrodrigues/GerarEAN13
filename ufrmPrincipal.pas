unit ufrmPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmPrincipal = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  Gerar.EAN13;

{$R *.dfm}

procedure TfrmPrincipal.Button1Click(Sender: TObject);
var
  s : string;
begin

  repeat
    s := InputBox('Pergunta', 'Digite o código produto (Máximo de 6 digitos)', '');
  until s <> '';

  TGeraEAN13.New.Gerar(s);
end;

end.
