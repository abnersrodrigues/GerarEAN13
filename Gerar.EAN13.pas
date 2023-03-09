unit Gerar.EAN13;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Gerar.Interfaces;

Type

  TGeraEAN13 = class(TInterfacedObject, iGerarEAN13)

    private

      FEAN13 : string;

    public

      Constructor Create;
      Destructor Destroy; Override;

      Class Function New: iGerarEAN13;

      function Gerar(num: string): iGerarEAN13;

  end;

implementation


constructor TGeraEAN13.Create;
begin

end;

destructor TGeraEAN13.Destroy;
begin

  inherited;
end;

function TGeraEAN13.Gerar(num: string): iGerarEAN13;
Const Padrao  = '789';
      CNPJ    = '145'; // 3 ultimos digitos CNPJ
Var
  A : Array [ 1 .. 13 ] of Integer;
  I, T, P : integer;
  O : Boolean;

  {
    A = Array com matriz EAN13
    I = ponteiro do for
    T = Soma dos resultados do Array (Total)
    P = Proximo numero multiplo de 10
    O = Operador para verificar par

    Num = Numero do Codigo Produto com 6 digitos;

    ** ver fonte com explicação
    ** fonte: https://www.gs1.org/services/how-calculate-check-digit-manually

    Formato do Num antes do digito verificador:
      ( Padrão: "789" ) + ( CNPJ: "145" ) + ( Código Produto: "000001" )
      =====>>>>>>     Value Final := "789145000001"
   }
Begin
  Result := Self;

  { tratando cód do produto recebido }
  if Length(num) > 6 then  { se maior vai pegar somente os 6 primeiros }
    Begin
      num := Copy(num, 1, 6);
      num := concat(Padrao, CNPJ, num);
    End
  else
  if Length(num) < 6 then { se menor vai colocar 0 (zeros) a esquerda }
    Begin
      num := FormatFloat('000000',StrToFloat(num));
      num := concat(Padrao, CNPJ, num);
    End
  else
    num := concat(Padrao, CNPJ, num); { deixa o recebido }

  { iniciando formação do digito verificador }
  O := true;

  T := 0;

  for i := 1 to Length(A) -1 do
    Begin

      if O then
        A[i] := Copy(num, i, 1).ToInteger()*1
      else
        A[i] := Copy(num, i, 1).ToInteger()*3;

      T := T + A[I];
      O := not O;
    End;

  P := T;
  while ((P mod 10) <> 0) do
    P := P + 1;

  A[13] := P - T;

  { finalizado enviando resultado }
  FEAN13 := num + A[13].ToString;

  //ShowMessage('código produto é '+ ArrayEAN13(s));
  ShowMessage('código produto é '+ FEAN13);
End;

class function TGeraEAN13.New: iGerarEAN13;
begin
  Result := Self.Create;
end;

end.
