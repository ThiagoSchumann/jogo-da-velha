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
    RdIniciar: TRadioGroup;
    procedure EdColunasKeyPress(Sender: TObject; var Key: Char);
    procedure EdColunasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BtnJogarClick(Sender: TObject);
    procedure ImgDonutsClick(Sender: TObject);
    procedure ImgGloboClick(Sender: TObject);
    procedure ImgBolaClick(Sender: TObject);
    procedure ImgZeroClick(Sender: TObject);
    procedure ImgXisCursivoClick(Sender: TObject);
    procedure ImgXisPinturaClick(Sender: TObject);
    procedure ImgAlmocoClick(Sender: TObject);
    procedure ImgXisClick(Sender: TObject);
    procedure TabuleiroDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
    procedure TabuleiroClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    private
      { Private declarations }
      function vitoria(valor: integer): integer;
      procedure LanceComputador(PrimeiroLance: Boolean = False);
      procedure Iniciar;
      procedure Jogar(Tamanho: integer);
      function VerificaVitoria(soma: integer): Boolean;
      function VerificaVitoria2: Boolean;
    public
      { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;
  IntCasas: integer;
  Matriz: array of array of integer;
  Lance: Boolean;
  Jogador: integer;
  computador: integer;
  intGanhador: integer;

implementation

{$R *.dfm}
{ TFrmPrincipal }

procedure TFrmPrincipal.BtnJogarClick(Sender: TObject);
begin
  if (EdColunas.Text = '') or (StrToInt(EdColunas.Text) = 0) then
  begin
    EdColunas.Text := '3';
    EdLinhas.Text := '3';
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
  if not(Key in ['0' .. '9', Chr(8)]) then
  begin
    Key := #0;
  end;

end;

procedure TFrmPrincipal.EdColunasKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  EdLinhas.Text := EdColunas.Text;
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  Tabuleiro.ColCount := 3;
  Tabuleiro.RowCount := 3;
  SetLength(Matriz, 3, 3);
  IntCasas := 2;
  Iniciar;
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

procedure TFrmPrincipal.Iniciar;
var
  i, j: integer;
begin
  for i := 0 to IntCasas do
  begin
    for j := 0 to IntCasas do
    begin
      Matriz[i][j] := 100;
    end;
  end;
end;

procedure TFrmPrincipal.Jogar(Tamanho: integer);
begin
  IntCasas := Tamanho - 1;
  // Tabuleiro.Enabled := True;
  Tabuleiro.Visible := True;
  Tabuleiro.DefaultColWidth := Trunc(425 / Tamanho) - 2;
  Tabuleiro.DefaultRowHeight := Trunc(425 / Tamanho) - 2;
  Tabuleiro.ColCount := Tamanho;
  Tabuleiro.RowCount := Tamanho;
  SetLength(Matriz, Tamanho, Tamanho);
  Iniciar;
  if RdPeca.ItemIndex = 0 then
  begin
    Jogador := 1;
    computador := 0;
  end
  else
  begin
    Jogador := 0;
    computador := 1;
  end;
  Lance := RdPeca.ItemIndex = RdIniciar.ItemIndex;
  if not Lance then
    LanceComputador(True);
end;

procedure TFrmPrincipal.LanceComputador(PrimeiroLance: Boolean = False);
var
  row, col: integer;

begin
  if not PrimeiroLance then
  begin
    for row := 0 to IntCasas do
    begin
      for col := 0 to IntCasas do
      begin
        if Matriz[col][row] = 100 then
        begin
          Matriz[col][row] := computador;
          Tabuleiro.Refresh;
          Lance := True;
          Break;
        end;
      end;
      if Lance then
        Break;
    end;
  end
  else
  begin
    Matriz[Random(IntCasas + 1)][Random(IntCasas + 1)] := computador;
    Tabuleiro.Refresh;
  end;

  if (VerificaVitoria2) and (intGanhador = computador) then
  begin
    ShowMessage('Vitória do Computador!');
    exit;
  end;

  Lance := True;
end;

procedure TFrmPrincipal.TabuleiroClick(Sender: TObject);
begin
  if Lance then
  begin
    if Matriz[Tabuleiro.col][Tabuleiro.row] = 100 then
    begin
      Matriz[Tabuleiro.col][Tabuleiro.row] := Jogador;
      Tabuleiro.Refresh;
      { if Jogador = 0 then
        begin
        if VerificaVitoria(0) then
        begin
        ShowMessage('Jogador venceu!');
        Tabuleiro.Enabled := False;
        exit;
        end;
        end
        else
        begin
        if VerificaVitoria(IntCasas + 1) then
        begin
        ShowMessage('Jogador venceu!');
        Tabuleiro.Enabled := False;
        exit;
        end;
        end; }
      if (VerificaVitoria2) and (intGanhador = Jogador) then
      begin
        ShowMessage('Vitória do Jogador!');
        exit;
      end;
      Lance := False;
      LanceComputador;
    end;
  end;
end;

procedure TFrmPrincipal.TabuleiroDrawCell(Sender: TObject; ACol, ARow: integer; Rect: TRect; State: TGridDrawState);
var
  i, j: integer;
begin
  for i := 0 to IntCasas do
  begin
    for j := 0 to IntCasas do
    begin
      if (ACol = i) and (ARow = j) then
      begin
        if Matriz[i][j] = 1 then
        begin
          Tabuleiro.Canvas.FillRect(Rect);
          Tabuleiro.Canvas.StretchDraw(Rect, ImgX.Picture.Graphic);
        end;
        if Matriz[i][j] = 0 then
        begin
          Tabuleiro.Canvas.FillRect(Rect);
          Tabuleiro.Canvas.StretchDraw(Rect, Img0.Picture.Graphic);
        end;
      end;
    end;
  end;

end;

function TFrmPrincipal.VerificaVitoria(soma: integer): Boolean;
var
  i, j, x: integer;
  somaDiagonal, somaLinha, somaColuna: integer;
begin
  somaDiagonal := 0;
  somaLinha := 0;
  somaColuna := 0;
  x := 0;
  for i := 0 to IntCasas do
  begin
    for j := 0 to IntCasas do
    begin
      if i = j then
        somaDiagonal := somaDiagonal + Matriz[i][j];
    end;
    somaColuna := somaColuna + Matriz[i][x];
    x := x + 1;
  end;
  result := soma = somaColuna;
  result := soma = somaDiagonal;
end;

function TFrmPrincipal.VerificaVitoria2: Boolean;

  function VerificaVitoriaLinhas: Boolean;
  var
    i, j, jogadorAnterior: integer;
  begin
    // inicializa o resultado da função com zero;
    result := False;
    // percorre as linhas
    for i := 0 to IntCasas do
    begin
      // caso a execução anterior tenha encontrado um vencedor, sai do laço de linhas
      if result then
        exit;
      // Ao iniciar a linha assumo que houve um ganhador
      result := True;
      // percorre as colunas
      for j := 0 to IntCasas do
      begin
        // caso o valor do campo seja 100, significa que é um campo livre no tabuleiro
        if Matriz[j][i] <> 100 then
        begin
          // caso estiber na primeira colula a variável jogadorAnterior recebe a posição atual
          if j = 0 then
            jogadorAnterior := Matriz[i][i];
          // Caso o valor do campo atual ser diferente do anterior, significa que não temos uma sequencia perfeita
          if Matriz[j][i] <> jogadorAnterior then
          begin
            // Retorno recebe False e saí do laço
            result := False;
            Break;
          end;
        end
        else
        begin
          // Caso o valor seja 100 significa que esta linha não está completa
          result := False;
          Break;
        end;
      end;
    end;

  end;

begin
  result := VerificaVitoriaLinhas;
end;

function TFrmPrincipal.vitoria(valor: integer): integer;
begin
  if valor = 0 then
    result := -10
  else if valor = IntCasas then
    result := 10
  else
    result := 0;
end;

end.
