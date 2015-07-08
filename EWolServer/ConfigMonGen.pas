unit ConfigMonGen;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, M2Share, Grobal2;

type
  TfrmConfigMonGen = class(TForm)
    ListBoxMonGen: TListBox;
  private
    { Private declarations }
  public
    procedure Open();
    { Public declarations }
  end;

var
  frmConfigMonGen: TfrmConfigMonGen;

implementation

uses UsrEngn;

{$R *.dfm}

{ TfrmConfigMonGen }

procedure TfrmConfigMonGen.Open;
var
  I: Integer;
  MonGen: pTMonGenInfo;
begin
  for I := 0 to UserEngine.m_MonGenList.Count - 1 do
  begin
    MonGen := UserEngine.m_MonGenList.Items[I];
    ListBoxMonGen.Items.AddObject(MonGen.sMapName + '(' + IntToStr(MonGen.nX) + ':' + IntToStr(MonGen.nY) + ')' + ' - ' + MonGen.sMonName, TObject(MonGen));
  end;
  Self.ShowModal;
end;

end.
