unit uAutoMovel;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, uEnumerado;
type
  TAutoMovel = class
    private
      FVeiculo: String;
      FAno: Word;
      FMarca: String;
      FModelo: Word;
      FChassi: String;
      FPlaca: String;
      FCor: String;
      FPotencia: Double;
      FKilometro: Double;
      FVidroEletrico: Boolean;
      FArCondicionado: Boolean;
      FDirecao: string;

    public
      property Veiculo: String read FVeiculo write FVeiculo;
      property Ano: Word read FAno write FAno;
      property Marca : String read FMarca  write FMarca ;
      property Modelo: Word read FModelo write FModelo;
      property Chassi : String read FChassi write FChassi;
      property Placa: String read FPlaca write FPlaca;
      property Cor: String read FCor write FCor;
      property Potencia: Double read FPotencia write FPotencia;
      property Kilometro: Double read FKilometro write FKilometro;
      property VidroEletrico: Boolean read FVidroEletrico write FVidroEletrico;
      property ArCondicionado: Boolean read FArCondicionado write FArCondicionado;
      property Direcao: string read FDirecao write FDirecao;

  end;

implementation

{ TAutoMovel }

end.
