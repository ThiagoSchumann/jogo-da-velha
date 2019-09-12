
unit Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Grids, Vcl.ExtCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage;

type
  TFrmPrincipal = class(TForm)
    Tabuleiro: TDrawGrid;
    BtnJogar: TButton;
    GroupBox1: TGroupBox;
    RdPeca: TRadioGroup;
    RdInicio: TRadioGroup;
    GroupBox2: TGroupBox;
    EdColunas: TEdit;
    Label2: TLabel;
    EdLinhas: TEdit;
    Label1: TLabel;
    GroupBox3: TGroupBox;
    ImgX: TImage;
    Img0: TImage;
    ImgBola: TImage;
    ImgXis: TImage;
    ImgGlobo: TImage;
    ImgAlmoco: TImage;
    ImgZero: TImage;
    ImgXisPintura: TImage;
    ImgXisCursivo: TImage;
    ImgDonuts: TImage;
    RadioGroup1: TRadioGroup;
    procedure EdColunasKeyPress(Sender: TObject; var Key: Char);
    procedure EdColunasKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnJogarClick(Sender: TObject);
    procedure ImgDonutsClick(Sender: TObject);
    procedure ImgGloboClick(Sender: TObject);
    procedure ImgBolaClick(Sender: TObject);
    procedure ImgZeroClick(Sender: TObject);
    procedure ImgXisCursivoClick(Sender: TObject);
    procedure ImgXisPinturaClick(Sender: TObject);
    procedure ImgAlmocoClick(Sender: TObject);
    procedure ImgXisClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Jogar(Tamanho: Integer);
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

{$R *.dfm}

{ TFrmPrincipal }

procedure TFrmPrincipal.BtnJogarClick(Sender: TObject);
begin
  if (EdColunas.Text = '') or (StrToInt(EdColunas.Text) = 0) then
  begin
    EdColunas.Text := '3';
    EdLinhas.Text  := '3';
  end
  else
  begin
    if StrToInt(EdColunas.Text) > 15 then
      begin
        Application.MessageBox('O tamanho máximo do tabuleiro é 15.', 'Atenção...', MB_ICONERROR);
        EdColunas.SetFocus;
        Abort;
      end;
  end;
  Jogar(StrToInt(EdColunas.Text));
end;

procedure TFrmPrincipal.EdColunasKeyPress(Sender: TObject; var Key: Char);
begin
  if  not ( Key in ['0'..'9', Chr(8)] ) then
  begin
    Key := #0;
  end;

end;


procedure TFrmPrincipal.EdColunasKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  EdLinhas.Text := EdColunas.Text;
end;

procedure TFrmPrincipal.ImgAlmocoClick(Sender: TObject);
begin
  ImgX.Picture := ImgAlmoco.Picture;
end;

procedure TFrmPrincipal.ImgBolaClick(Sender: TObject);
begin
  Img0.Picture := ImgBola.Picture;
end;

procedure TFrmPrincipal.ImgDonutsClick(Sender: TObject);
begin
  Img0.Picture := ImgDonuts.Picture;
end;

procedure TFrmPrincipal.ImgGloboClick(Sender: TObject);
begin
  Img0.Picture := ImgGlobo.Picture;
end;

procedure TFrmPrincipal.ImgXisClick(Sender: TObject);
begin
  ImgX.Picture := ImgXis.Picture;
end;

procedure TFrmPrincipal.ImgXisCursivoClick(Sender: TObject);
begin
  ImgX.Picture := ImgXisCursivo.Picture;
end;

procedure TFrmPrincipal.ImgXisPinturaClick(Sender: TObject);
begin
  ImgX.Picture := ImgXisPintura.Picture;
end;

procedure TFrmPrincipal.ImgZeroClick(Sender: TObject);
begin
  Img0.Picture := ImgZero.Picture;
end;

procedure TFrmPrincipal.Jogar(Tamanho: Integer);
  var
    Matriz: array of array of integer;
begin
  Tabuleiro.Enabled := True;
  Tabuleiro.DefaultColWidth  := Trunc(405/Tamanho);
  Tabuleiro.DefaultRowHeight := Trunc(405/Tamanho);
  Tabuleiro.ColCount         := Tamanho;
  Tabuleiro.RowCount         := Tamanho;
  SetLength(Matriz, Tamanho, Tamanho);

end;

end.
