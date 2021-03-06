unit DataFrameEngine;

interface

uses SysUtils, CoreClasses, Types, Variants,
  ListEngine, MemoryStream64,
  GeometryLib, TextDataEngine, Geometry2DUnit, Geometry3DUnit,
  UnicodeMixedLib, PascalStrings;

type
  TDataFrameBase = class(TCoreClassObject)
  protected
    FID: Byte; // data frame only id
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); virtual; abstract;
    procedure SaveToStream(stream: TCoreClassStream); virtual; abstract;
    function ComputeEncodeSize: Integer; virtual; abstract;
  end;

  TDataFrameString = class(TDataFrameBase)
  private
  protected
    FBuffer: string;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: string read FBuffer write FBuffer;
  end;

  TDataFrameInteger = class(TDataFrameBase)
  private
  protected
    FBuffer: Integer;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Integer read FBuffer write FBuffer;
  end;

  TDataFrameCardinal = class(TDataFrameBase)
  private
  protected
    FBuffer: Cardinal;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Cardinal read FBuffer write FBuffer;
  end;

  TDataFrameWord = class(TDataFrameBase)
  private
  protected
    FBuffer: Word;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Word read FBuffer write FBuffer;
  end;

  TDataFrameByte = class(TDataFrameBase)
  private
  protected
    FBuffer: Byte;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Byte read FBuffer write FBuffer;
  end;

  TDataFrameSingle = class(TDataFrameBase)
  private
  protected
    FBuffer: Single;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Single read FBuffer write FBuffer;
  end;

  TDataFrameDouble = class(TDataFrameBase)
  private
  protected
    FBuffer: Double;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Double read FBuffer write FBuffer;
  end;

  TDataFrameArrayInteger = class(TDataFrameBase)
  private
  protected
    FBuffer: TCoreClassList;

    function GetBuffer(idx: Integer): Integer;
    procedure SetBuffer(idx: Integer; Value: Integer);

  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(v: Integer);
    procedure Delete(idx: Integer);
    function Count: Integer;
    procedure WriteArray(const a: array of Integer);

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer[idx: Integer]: Integer read GetBuffer write SetBuffer; default;
  end;

  TDataFrameArrayShortInt = class(TDataFrameBase)
  private
  protected
    FBuffer: TCoreClassList;

    function GetBuffer(idx: Integer): ShortInt;
    procedure SetBuffer(idx: Integer; Value: ShortInt);

  public
    constructor Create(id: ShortInt);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(v: ShortInt);
    procedure Delete(idx: Integer);
    function Count: Integer;
    procedure WriteArray(const a: array of ShortInt);

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer[idx: Integer]: ShortInt read GetBuffer write SetBuffer; default;
  end;

  TDataFrameArraySingle = class(TDataFrameBase)
  private
  protected
    FBuffer: TCoreClassList;

    function GetBuffer(idx: Integer): Single;
    procedure SetBuffer(idx: Integer; Value: Single);

  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(v: Single);
    procedure Delete(idx: Integer);
    function Count: Integer;
    procedure WriteArray(const a: array of Single);

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer[idx: Integer]: Single read GetBuffer write SetBuffer; default;
  end;

  TDataFrameArrayDouble = class(TDataFrameBase)
  private
  protected
    FBuffer: TCoreClassList;

    function GetBuffer(idx: Integer): Double;
    procedure SetBuffer(idx: Integer; Value: Double);

  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure Clear;
    procedure Add(v: Double);
    procedure Delete(idx: Integer);
    function Count: Integer;
    procedure WriteArray(const a: array of Double);

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer[idx: Integer]: Double read GetBuffer write SetBuffer; default;
  end;

  TDataFrameStream = class(TDataFrameBase)
  private
  protected
    FBuffer: TMemoryStream64;
    function GetBuffer: TCoreClassStream;
    procedure SetBuffer(_Buffer: TCoreClassStream);
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure Clear;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: TCoreClassStream read GetBuffer write SetBuffer;
  end;

  TDataFrameVariant = class(TDataFrameBase)
  private
  protected
    FBuffer: Variant;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Variant read FBuffer write FBuffer;
  end;

  TDataFrameInt64 = class(TDataFrameBase)
  private
  protected
    FBuffer: Int64;
  public
    constructor Create(id: Byte);
    destructor Destroy; override;

    procedure LoadFromStream(stream: TCoreClassStream); override;
    procedure SaveToStream(stream: TCoreClassStream); override;
    function ComputeEncodeSize: Integer; override;

    property Buffer: Int64 read FBuffer write FBuffer;
  end;

  TRunTimeDataType = (rdtString, rdtInteger, rdtCardinal, rdtWORD, rdtByte, rdtSingle, rdtDouble,
    rdtArrayInteger, rdtArraySingle, rdtArrayDouble, rdtStream, rdtVariant, rdtInt64, rdtArrayShortInt);

  TDataFrameEngine = class;

  TDataFrameEngineReader = class(TCoreClassObject)
  private
    FOwner: TDataFrameEngine;
    FIndex: Integer;
  public
    constructor Create(AOwner: TDataFrameEngine);
    destructor Destroy; override;
    property index: Integer read FIndex write FIndex;
    function IsEnd: Boolean;
    function NotEnd: Boolean;
    procedure GoNext;

    function ReadString: string;
    function ReadInteger: Integer;
    function ReadCardinal: Cardinal;
    function ReadWord: Word;
    function ReadBool: Boolean;
    function ReadBoolean: Boolean;
    function ReadByte: Byte;
    function ReadSingle: Single;
    function ReadDouble: Double;
    function ReadArrayInteger: TDataFrameArrayInteger;
    function ReadArrayShortInt: TDataFrameArrayShortInt;
    function ReadArraySingle: TDataFrameArraySingle;
    function ReadArrayDouble: TDataFrameArrayDouble;
    procedure ReadStream(output: TCoreClassStream);
    function ReadVariant: Variant;
    function ReadInt64: Int64;
    procedure ReadStrings(output: TCoreClassStrings);
    procedure ReadDataFrame(output: TDataFrameEngine);
    procedure ReadVariantList(output: THashVariantList);
    procedure ReadSectionText(output: TSectionTextData);
    procedure ReadTextSection(output: TSectionTextData);
    function ReadRect: TRect;
    function ReadRectf: TRectf;
    function ReadPoint: TPoint;
    function ReadPointf: TPointf;
    function ReadVector: TVector;
    function ReadAffineVector: TAffineVector;
    function ReadVec3: TVec3;
    function ReadVec4: TVec4;
    function ReadVector3: TVector3;
    function ReadVector4: TVector4;
    function ReadMat4: TMat4;
    function ReadMatrix4: TMatrix4;
    function Read2DPoint: T2DPoint;
    function Read2DRect: T2DRect;

    // auto read buff from stream data
    procedure Read(var aBuf; aCount: Cardinal);
  end;

  TDataFrameEngine = class(TCoreClassObject)
  private
    FDataList: TCoreClassListForObj;
    FReader  : TDataFrameEngineReader;
  protected
    function DataTypeToByte(v: TRunTimeDataType): Byte;
    function ByteToDataType(v: Byte): TRunTimeDataType;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Clear;
    function AddData(v: TRunTimeDataType): TDataFrameBase;
    function GetData(idx: Integer): TDataFrameBase;
    function GetDataInfo(_Obj: TDataFrameBase): string;
    function Count: Integer;
    function Delete(idx: Integer): Boolean;
    function DeleteFirst: Boolean;
    function DeleteLast: Boolean; overload;
    function DeleteLastCount(cnt: Integer): Boolean; overload;
    function DeleteCount(idx, _Count: Integer): Boolean;
    procedure Assign(SameObj: TDataFrameEngine);

    procedure WriteString(v: string); overload;
    procedure WriteString(v: umlString); overload;
    procedure WriteInteger(v: Integer);
    procedure WriteCardinal(v: Cardinal);
    procedure WriteWORD(v: Word);
    procedure WriteBool(v: Boolean);
    procedure WriteBoolean(v: Boolean);
    procedure WriteByte(v: Byte);
    procedure WriteSingle(v: Single);
    procedure WriteDouble(v: Double);
    function WriteArrayInteger: TDataFrameArrayInteger;
    function WriteArrayShortInt: TDataFrameArrayShortInt;
    function WriteArraySingle: TDataFrameArraySingle;
    function WriteArrayDouble: TDataFrameArrayDouble;
    procedure WriteStream(v: TCoreClassStream);
    procedure WriteVariant(v: Variant);
    procedure WriteInt64(v: Int64);
    procedure WriteStrings(v: TCoreClassStrings);
    procedure WriteDataFrame(v: TDataFrameEngine);
    procedure WriteDataFrameCompressed(v: TDataFrameEngine);
    procedure WriteVariantList(v: THashVariantList);
    procedure WriteSectionText(v: TSectionTextData);
    procedure WriteTextSection(v: TSectionTextData);
    procedure WriteRect(v: TRect);
    procedure WriteRectf(v: TRectf);
    procedure WritePoint(v: TPoint);
    procedure WritePointf(v: TPointf);
    procedure WriteVector(v: TVector);
    procedure WriteAffineVector(v: TAffineVector);
    procedure WriteVec4(v: TVec4);
    procedure WriteVec3(v: TVec3);
    procedure WriteVector4(v: TVector4);
    procedure WriteVector3(v: TVector3);
    procedure WriteMat4(v: TMat4);
    procedure WriteMatrix4(v: TMatrix4);
    procedure Write2DPoint(v: T2DPoint);
    procedure Write2DRect(v: T2DRect);

    // auto append new stream and write
    procedure Write(const aBuf; aCount: Cardinal);

    property Reader: TDataFrameEngineReader read FReader;

    function ReadString(idx: Integer): string; overload;
    function ReadInteger(idx: Integer): Integer; overload;
    function ReadCardinal(idx: Integer): Cardinal; overload;
    function ReadWord(idx: Integer): Word; overload;
    function ReadBool(idx: Integer): Boolean; overload;
    function ReadBoolean(idx: Integer): Boolean; overload;
    function ReadByte(idx: Integer): Byte; overload;
    function ReadSingle(idx: Integer): Single; overload;
    function ReadDouble(idx: Integer): Double; overload;
    function ReadArrayInteger(idx: Integer): TDataFrameArrayInteger; overload;
    function ReadArrayShortInt(idx: Integer): TDataFrameArrayShortInt; overload;
    function ReadArraySingle(idx: Integer): TDataFrameArraySingle; overload;
    function ReadArrayDouble(idx: Integer): TDataFrameArrayDouble; overload;
    procedure ReadStream(idx: Integer; output: TCoreClassStream); overload;
    function ReadVariant(idx: Integer): Variant; overload;
    function ReadInt64(idx: Integer): Int64; overload;
    procedure ReadStrings(idx: Integer; output: TCoreClassStrings); overload;
    procedure ReadDataFrame(idx: Integer; output: TDataFrameEngine); overload;
    procedure ReadVariantList(idx: Integer; output: THashVariantList); overload;
    procedure ReadSectionText(idx: Integer; output: TSectionTextData); overload;
    procedure ReadTextSection(idx: Integer; output: TSectionTextData); overload;
    function ReadRect(idx: Integer): TRect; overload;
    function ReadRectf(idx: Integer): TRectf; overload;
    function ReadPoint(idx: Integer): TPoint; overload;
    function ReadPointf(idx: Integer): TPointf; overload;
    function ReadVector(idx: Integer): TVector; overload;
    function ReadAffineVector(idx: Integer): TAffineVector; overload;
    function ReadVec3(idx: Integer): TVec3; overload;
    function ReadVec4(idx: Integer): TVec4; overload;
    function ReadVector3(idx: Integer): TVector3; overload;
    function ReadVector4(idx: Integer): TVector4; overload;
    function ReadMat4(idx: Integer): TMat4; overload;
    function ReadMatrix4(idx: Integer): TMatrix4; overload;
    function Read2DPoint(idx: Integer): T2DPoint; overload;
    function Read2DRect(idx: Integer): T2DRect; overload;

    // auto read buff from stream data
    procedure Read(idx: Integer; var aBuf; aCount: Cardinal);

    function ComputeEncodeSize: Integer;

    function EncodeTo(output: TCoreClassStream): Integer;
    function EncodeToCompressed(output: TCoreClassStream): Integer;
    function DecodeFrom(source: TCoreClassStream): Integer;

    function EncodeToString: string;
    function EncodeToCompressedString: string;
    procedure DecodeFromString(const source: string);

    function EncodeToBytes: TBytes;
    function EncodeToCompressedBytes: TBytes;
    procedure DecodeFromBytes(var b: TBytes);

    procedure LoadFromStream(stream: TCoreClassStream);
    procedure SaveToStream(stream: TCoreClassStream);

    property Data[idx: Integer]: TDataFrameBase read GetData; default;
    property List: TCoreClassListForObj read FDataList;
  end;

  TDataWriter = class(TCoreClassPersistent)
  protected
    FEngine: TDataFrameEngine;
    FStream: TCoreClassStream;
  public
    constructor Create(AStream: TCoreClassStream);
    destructor Destroy; override;

    procedure Clear; virtual;

    procedure WriteString(v: string); virtual;
    procedure WriteInteger(v: Integer); virtual;
    procedure WriteCardinal(v: Cardinal); virtual;
    procedure WriteWORD(v: Word); virtual;
    procedure WriteBool(v: Boolean); virtual;
    procedure WriteBoolean(v: Boolean); virtual;
    procedure WriteByte(v: Byte); virtual;
    procedure WriteSingle(v: Single); virtual;
    procedure WriteDouble(v: Double); virtual;
    procedure WriteArrayInteger(v: array of Integer); virtual;
    procedure WriteArrayShortInt(v: array of ShortInt); virtual;
    procedure WriteArraySingle(v: array of Single); virtual;
    procedure WriteArrayDouble(v: array of Double); virtual;
    procedure WriteStream(v: TCoreClassStream); virtual;
    procedure WriteVariant(v: Variant); virtual;
    procedure WriteInt64(v: Int64); virtual;
    procedure WriteStrings(v: TCoreClassStrings); virtual;
    procedure WriteDataFrame(v: TDataFrameEngine); virtual;
    procedure WriteDataFrameCompressed(v: TDataFrameEngine); virtual;
    procedure WriteVariantList(v: THashVariantList); virtual;
    procedure WriteSectionText(v: TSectionTextData); virtual;
    procedure WriteRect(v: TRect); virtual;
    procedure WriteRectf(v: TRectf); virtual;
    procedure WritePoint(v: TPoint); virtual;
    procedure WritePointf(v: TPointf); virtual;
    procedure WriteVector(v: TVector); virtual;
    procedure WriteAffineVector(v: TAffineVector); virtual;
    procedure WriteVec4(v: TVec4); virtual;
    procedure WriteVec3(v: TVec3); virtual;
    procedure WriteVector4(v: TVector4); virtual;
    procedure WriteVector3(v: TVector3); virtual;
    procedure WriteMat4(v: TMat4); virtual;
    procedure WriteMatrix4(v: TMatrix4); virtual;
    procedure Write2DPoint(v: T2DPoint); virtual;
    procedure Write2DRect(v: T2DRect); virtual;
    procedure Write(const aBuf; aCount: Cardinal); virtual;
  end;

  TDataReader = class(TCoreClassPersistent)
  protected
    FEngine: TDataFrameEngine;
  public
    constructor Create(AStream: TCoreClassStream);
    destructor Destroy; override;

    function ReadString: string; virtual;
    function ReadInteger: Integer; virtual;
    function ReadCardinal: Cardinal; virtual;
    function ReadWord: Word; virtual;
    function ReadBool: Boolean; virtual;
    function ReadBoolean: Boolean; virtual;
    function ReadByte: Byte; virtual;
    function ReadSingle: Single; virtual;
    function ReadDouble: Double; virtual;
    procedure ReadArrayInteger(var Data: array of Integer); virtual;
    procedure ReadArrayShortInt(var Data: array of ShortInt); virtual;
    procedure ReadArraySingle(var Data: array of Single); virtual;
    procedure ReadArrayDouble(var Data: array of Double); virtual;
    procedure ReadStream(output: TCoreClassStream); virtual;
    function ReadVariant: Variant; virtual;
    function ReadInt64: Int64; virtual;
    procedure ReadStrings(output: TCoreClassStrings); virtual;
    procedure ReadDataFrame(output: TDataFrameEngine); virtual;
    procedure ReadVariantList(output: THashVariantList); virtual;
    procedure ReadSectionText(output: TSectionTextData); virtual;
    function ReadRect: TRect; virtual;
    function ReadRectf: TRectf; virtual;
    function ReadPoint: TPoint; virtual;
    function ReadPointf: TPointf; virtual;
    function ReadVector: TVector; virtual;
    function ReadAffineVector: TAffineVector; virtual;
    function ReadVec3: TVec3; virtual;
    function ReadVec4: TVec4; virtual;
    function ReadVector3: TVector3; virtual;
    function ReadVector4: TVector4; virtual;
    function ReadMat4: TMat4; virtual;
    function ReadMatrix4: TMatrix4; virtual;
    function Read2DPoint: T2DPoint; virtual;
    function Read2DRect: T2DRect; virtual;
    procedure Read(var aBuf; aCount: Cardinal); virtual;
  end;

implementation

uses DoStatusIO;

constructor TDataFrameBase.Create(id: Byte);
begin
  inherited Create;
  FID := id;
end;

destructor TDataFrameBase.Destroy;
begin
  inherited Destroy;
end;

constructor TDataFrameString.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := '';
end;

destructor TDataFrameString.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameString.LoadFromStream(stream: TCoreClassStream);
var
  _Len: Integer;
  b   : TBytes;
begin
  stream.ReadBuffer(_Len, umlIntegerLength);
  SetLength(b, _Len);
  if (_Len > 0) then
      stream.ReadBuffer(b[0], _Len);

  FBuffer := umlStringOf(b).Text;
end;

procedure TDataFrameString.SaveToStream(stream: TCoreClassStream);
var
  b   : TBytes;
  _Len: Integer;
begin
  b := umlBytesOf(FBuffer);
  _Len := Length(b);
  stream.WriteBuffer(_Len, umlIntegerLength);
  if _Len > 0 then
      stream.WriteBuffer(b[0], _Len);
end;

function TDataFrameString.ComputeEncodeSize: Integer;
var
  b: TBytes;
begin
  b := umlBytesOf(FBuffer);
  Result := umlIntegerLength + Length(b);
end;

constructor TDataFrameInteger.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := 0;
end;

destructor TDataFrameInteger.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameInteger.LoadFromStream(stream: TCoreClassStream);
begin
  stream.ReadBuffer(FBuffer, umlIntegerLength);
end;

procedure TDataFrameInteger.SaveToStream(stream: TCoreClassStream);
begin
  stream.WriteBuffer(FBuffer, umlIntegerLength);
end;

function TDataFrameInteger.ComputeEncodeSize: Integer;
begin
  Result := umlIntegerLength;
end;

constructor TDataFrameCardinal.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := 0;
end;

destructor TDataFrameCardinal.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameCardinal.LoadFromStream(stream: TCoreClassStream);
begin
  stream.ReadBuffer(FBuffer, umlCardinalLength);
end;

procedure TDataFrameCardinal.SaveToStream(stream: TCoreClassStream);
begin
  stream.WriteBuffer(FBuffer, umlCardinalLength);
end;

function TDataFrameCardinal.ComputeEncodeSize: Integer;
begin
  Result := umlCardinalLength;
end;

constructor TDataFrameWord.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := 0;
end;

destructor TDataFrameWord.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameWord.LoadFromStream(stream: TCoreClassStream);
begin
  stream.ReadBuffer(FBuffer, umlWordLength);
end;

procedure TDataFrameWord.SaveToStream(stream: TCoreClassStream);
begin
  stream.WriteBuffer(FBuffer, umlWordLength);
end;

function TDataFrameWord.ComputeEncodeSize: Integer;
begin
  Result := umlWordLength;
end;

constructor TDataFrameByte.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := 0;
end;

destructor TDataFrameByte.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameByte.LoadFromStream(stream: TCoreClassStream);
begin
  stream.ReadBuffer(FBuffer, umlByteLength);
end;

procedure TDataFrameByte.SaveToStream(stream: TCoreClassStream);
begin
  stream.WriteBuffer(FBuffer, umlByteLength);
end;

function TDataFrameByte.ComputeEncodeSize: Integer;
begin
  Result := umlByteLength;
end;

constructor TDataFrameSingle.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := 0;
end;

destructor TDataFrameSingle.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameSingle.LoadFromStream(stream: TCoreClassStream);
begin
  stream.ReadBuffer(FBuffer, umlSingleLength);
end;

procedure TDataFrameSingle.SaveToStream(stream: TCoreClassStream);
begin
  stream.WriteBuffer(FBuffer, umlSingleLength);
end;

function TDataFrameSingle.ComputeEncodeSize: Integer;
begin
  Result := umlSingleLength;
end;

constructor TDataFrameDouble.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := 0;
end;

destructor TDataFrameDouble.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameDouble.LoadFromStream(stream: TCoreClassStream);
begin
  stream.ReadBuffer(FBuffer, umlDoubleLength);
end;

procedure TDataFrameDouble.SaveToStream(stream: TCoreClassStream);
begin
  stream.WriteBuffer(FBuffer, umlDoubleLength);
end;

function TDataFrameDouble.ComputeEncodeSize: Integer;
begin
  Result := umlDoubleLength;
end;

function TDataFrameArrayInteger.GetBuffer(idx: Integer): Integer;
begin
  Result := PInteger(FBuffer[idx])^;
end;

procedure TDataFrameArrayInteger.SetBuffer(idx: Integer; Value: Integer);
begin
  PInteger(FBuffer[idx])^ := Value;
end;

constructor TDataFrameArrayInteger.Create(id: Byte);
begin
  inherited Create(id);
  FBuffer := TCoreClassList.Create;
end;

destructor TDataFrameArrayInteger.Destroy;
begin
  Clear;
  DisposeObject(FBuffer);
  inherited Destroy;
end;

procedure TDataFrameArrayInteger.Clear;
var
  i: Integer;
  p: PInteger;
begin
  for i := 0 to FBuffer.Count - 1 do
    begin
      p := FBuffer[i];
      Dispose(p);
    end;
  FBuffer.Clear;
end;

procedure TDataFrameArrayInteger.Add(v: Integer);
var
  _PV: PInteger;
begin
  New(_PV);
  _PV^ := v;
  FBuffer.Add(_PV);
end;

procedure TDataFrameArrayInteger.Delete(idx: Integer);
begin
  Dispose(PInteger(FBuffer[idx]));
  FBuffer.Delete(idx);
end;

function TDataFrameArrayInteger.Count: Integer;
begin
  Result := FBuffer.Count;
end;

procedure TDataFrameArrayInteger.WriteArray(const a: array of Integer);
var
  i: Integer;
begin
  for i := low(a) to high(a) do
      Add(a[i]);
end;

procedure TDataFrameArrayInteger.LoadFromStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: Integer;
begin
  Clear;
  stream.ReadBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      stream.ReadBuffer(_Data, umlIntegerLength);
      Add(_Data);
    end;
end;

procedure TDataFrameArrayInteger.SaveToStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: Integer;
begin
  _L := Count;
  stream.WriteBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      _Data := Buffer[i];
      stream.WriteBuffer(_Data, umlIntegerLength);
    end;
end;

function TDataFrameArrayInteger.ComputeEncodeSize: Integer;
begin
  Result := umlIntegerLength + umlIntegerLength * Count;
end;

function TDataFrameArrayShortInt.GetBuffer(idx: Integer): ShortInt;
begin
  Result := PShortInt(FBuffer[idx])^;
end;

procedure TDataFrameArrayShortInt.SetBuffer(idx: Integer; Value: ShortInt);
begin
  PShortInt(FBuffer[idx])^ := Value;
end;

constructor TDataFrameArrayShortInt.Create(id: ShortInt);
begin
  inherited Create(id);
  FBuffer := TCoreClassList.Create;
end;

destructor TDataFrameArrayShortInt.Destroy;
begin
  Clear;
  DisposeObject(FBuffer);
  inherited Destroy;
end;

procedure TDataFrameArrayShortInt.Clear;
var
  i: Integer;
  p: PShortInt;
begin
  for i := 0 to FBuffer.Count - 1 do
    begin
      p := FBuffer[i];
      Dispose(p);
    end;
  FBuffer.Clear;
end;

procedure TDataFrameArrayShortInt.Add(v: ShortInt);
var
  _PV: PShortInt;
begin
  New(_PV);
  _PV^ := v;
  FBuffer.Add(_PV);
end;

procedure TDataFrameArrayShortInt.Delete(idx: Integer);
begin
  Dispose(PShortInt(FBuffer[idx]));
  FBuffer.Delete(idx);
end;

function TDataFrameArrayShortInt.Count: Integer;
begin
  Result := FBuffer.Count;
end;

procedure TDataFrameArrayShortInt.WriteArray(const a: array of ShortInt);
var
  i: Integer;
begin
  for i := low(a) to high(a) do
      Add(a[i]);
end;

procedure TDataFrameArrayShortInt.LoadFromStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: ShortInt;
begin
  Clear;
  stream.ReadBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      stream.ReadBuffer(_Data, umlShortIntLength);
      Add(_Data);
    end;
end;

procedure TDataFrameArrayShortInt.SaveToStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: ShortInt;
begin
  _L := Count;
  stream.WriteBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      _Data := Buffer[i];
      stream.WriteBuffer(_Data, umlShortIntLength);
    end;
end;

function TDataFrameArrayShortInt.ComputeEncodeSize: Integer;
begin
  Result := umlIntegerLength + umlShortIntLength * Count;
end;

function TDataFrameArraySingle.GetBuffer(idx: Integer): Single;
begin
  Result := PSingle(FBuffer[idx])^;
end;

procedure TDataFrameArraySingle.SetBuffer(idx: Integer; Value: Single);
begin
  PSingle(FBuffer[idx])^ := Value;
end;

constructor TDataFrameArraySingle.Create(id: Byte);
begin
  inherited Create(id);
  FBuffer := TCoreClassList.Create;
end;

destructor TDataFrameArraySingle.Destroy;
begin
  Clear;
  DisposeObject(FBuffer);
  inherited Destroy;
end;

procedure TDataFrameArraySingle.Clear;
var
  i: Integer;
  p: PSingle;
begin
  for i := 0 to FBuffer.Count - 1 do
    begin
      p := FBuffer[i];
      Dispose(p);
    end;
  FBuffer.Clear;
end;

procedure TDataFrameArraySingle.Add(v: Single);
var
  _PV: PSingle;
begin
  New(_PV);
  _PV^ := v;
  FBuffer.Add(_PV);
end;

procedure TDataFrameArraySingle.Delete(idx: Integer);
begin
  Dispose(PSingle(FBuffer[idx]));
  FBuffer.Delete(idx);
end;

function TDataFrameArraySingle.Count: Integer;
begin
  Result := FBuffer.Count;
end;

procedure TDataFrameArraySingle.WriteArray(const a: array of Single);
var
  i: Integer;
begin
  for i := low(a) to high(a) do
      Add(a[i]);
end;

procedure TDataFrameArraySingle.LoadFromStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: Single;
begin
  Clear;
  stream.ReadBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      stream.ReadBuffer(_Data, umlSingleLength);
      Add(_Data);
    end;
end;

procedure TDataFrameArraySingle.SaveToStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: Single;
begin
  _L := Count;
  stream.WriteBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      _Data := Buffer[i];
      stream.WriteBuffer(_Data, umlSingleLength);
    end;
end;

function TDataFrameArraySingle.ComputeEncodeSize: Integer;
begin
  Result := umlIntegerLength + umlSingleLength * Count;
end;

function TDataFrameArrayDouble.GetBuffer(idx: Integer): Double;
begin
  Result := PDouble(FBuffer[idx])^;
end;

procedure TDataFrameArrayDouble.SetBuffer(idx: Integer; Value: Double);
begin
  PDouble(FBuffer[idx])^ := Value;
end;

constructor TDataFrameArrayDouble.Create(id: Byte);
begin
  inherited Create(id);
  FBuffer := TCoreClassList.Create;
end;

destructor TDataFrameArrayDouble.Destroy;
begin
  Clear;
  DisposeObject(FBuffer);
  inherited Destroy;
end;

procedure TDataFrameArrayDouble.Clear;
var
  i: Integer;
  p: PDouble;
begin
  for i := 0 to FBuffer.Count - 1 do
    begin
      p := FBuffer[i];
      Dispose(p);
    end;
  FBuffer.Clear;
end;

procedure TDataFrameArrayDouble.Add(v: Double);
var
  _PV: PDouble;
begin
  New(_PV);
  _PV^ := v;
  FBuffer.Add(_PV);
end;

procedure TDataFrameArrayDouble.Delete(idx: Integer);
begin
  Dispose(PDouble(FBuffer[idx]));
  FBuffer.Delete(idx);
end;

function TDataFrameArrayDouble.Count: Integer;
begin
  Result := FBuffer.Count;
end;

procedure TDataFrameArrayDouble.WriteArray(const a: array of Double);
var
  i: Integer;
begin
  for i := low(a) to high(a) do
      Add(a[i]);
end;

procedure TDataFrameArrayDouble.LoadFromStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: Double;
begin
  Clear;
  stream.ReadBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      stream.ReadBuffer(_Data, umlDoubleLength);
      Add(_Data);
    end;
end;

procedure TDataFrameArrayDouble.SaveToStream(stream: TCoreClassStream);
var
  i, _L: Integer;
  _Data: Double;
begin
  _L := Count;
  stream.WriteBuffer(_L, umlIntegerLength);
  for i := 0 to _L - 1 do
    begin
      _Data := Buffer[i];
      stream.WriteBuffer(_Data, umlDoubleLength);
    end;
end;

function TDataFrameArrayDouble.ComputeEncodeSize: Integer;
begin
  Result := umlIntegerLength + umlDoubleLength * Count;
end;

function TDataFrameStream.GetBuffer: TCoreClassStream;
begin
  Result := FBuffer;
end;

procedure TDataFrameStream.SetBuffer(_Buffer: TCoreClassStream);
var
  _P: Int64;
begin
  FBuffer.Clear;
  _P := _Buffer.Position;
  _Buffer.Position := 0;
  if _Buffer.Size > 0 then
      FBuffer.CopyFrom(_Buffer, _Buffer.Size);
  _Buffer.Position := _P;
end;

constructor TDataFrameStream.Create(id: Byte);
begin
  inherited Create(id);
  FBuffer := TMemoryStream64.Create;
end;

destructor TDataFrameStream.Destroy;
begin
  DisposeObject(FBuffer);
  inherited Destroy;
end;

procedure TDataFrameStream.Clear;
begin
  FBuffer.Clear;
end;

procedure TDataFrameStream.LoadFromStream(stream: TCoreClassStream);
var
  _Len: Integer;
begin
  FBuffer.Clear;
  stream.ReadBuffer(_Len, umlIntegerLength);
  if (_Len > 0) then
      FBuffer.CopyFrom(stream, _Len);
end;

procedure TDataFrameStream.SaveToStream(stream: TCoreClassStream);
var
  _Len: Integer;
begin
  _Len := FBuffer.Size;
  stream.WriteBuffer(_Len, umlIntegerLength);
  if _Len > 0 then
    begin
      FBuffer.Position := 0;
      stream.CopyFrom(FBuffer, _Len);
    end;
end;

function TDataFrameStream.ComputeEncodeSize: Integer;
begin
  Result := umlIntegerLength + FBuffer.Size;
end;

constructor TDataFrameVariant.Create(id: Byte);
begin
  inherited Create(id);
end;

destructor TDataFrameVariant.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameVariant.LoadFromStream(stream: TCoreClassStream);
var
  r: TCoreClassReader;
begin
  r := TCoreClassReader.Create(stream, 1024 * 4);
  r.IgnoreChildren := True;
  FBuffer := r.ReadVariant;
  DisposeObject(r);
end;

procedure TDataFrameVariant.SaveToStream(stream: TCoreClassStream);
var
  w: TCoreClassWriter;
begin
  w := TCoreClassWriter.Create(stream, 1024 * 4);
  w.IgnoreChildren := True;
  w.WriteVariant(FBuffer);
  DisposeObject(w);
end;

function TDataFrameVariant.ComputeEncodeSize: Integer;
var
  tmp: TCoreClassMemoryStream;
  w  : TCoreClassWriter;
begin
  tmp := TCoreClassMemoryStream.Create;
  w := TCoreClassWriter.Create(tmp, 1024 * 4);
  w.IgnoreChildren := True;
  w.WriteVariant(FBuffer);
  DisposeObject(w);
  Result := tmp.Size;
  DisposeObject(tmp);
end;

constructor TDataFrameInt64.Create(id: Byte);
begin
  inherited Create(id);
  Buffer := 0;
end;

destructor TDataFrameInt64.Destroy;
begin
  inherited Destroy;
end;

procedure TDataFrameInt64.LoadFromStream(stream: TCoreClassStream);
begin
  stream.ReadBuffer(FBuffer, umlInt64Length);
end;

procedure TDataFrameInt64.SaveToStream(stream: TCoreClassStream);
begin
  stream.WriteBuffer(FBuffer, umlInt64Length);
end;

function TDataFrameInt64.ComputeEncodeSize: Integer;
begin
  Result := umlInt64Length;
end;

constructor TDataFrameEngineReader.Create(AOwner: TDataFrameEngine);
begin
  inherited Create;
  FOwner := AOwner;
  FIndex := 0;
end;

destructor TDataFrameEngineReader.Destroy;
begin
  inherited Destroy;
end;

function TDataFrameEngineReader.IsEnd: Boolean;
begin
  Result := FIndex >= FOwner.Count;
end;

function TDataFrameEngineReader.NotEnd: Boolean;
begin
  Result := FIndex < FOwner.Count;
end;

procedure TDataFrameEngineReader.GoNext;
begin
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadString: string;
begin
  Result := FOwner.ReadString(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadInteger: Integer;
begin
  Result := FOwner.ReadInteger(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadCardinal: Cardinal;
begin
  Result := FOwner.ReadCardinal(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadWord: Word;
begin
  Result := FOwner.ReadWord(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadBool: Boolean;
begin
  Result := FOwner.ReadBool(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadBoolean: Boolean;
begin
  Result := ReadBool;
end;

function TDataFrameEngineReader.ReadByte: Byte;
begin
  Result := FOwner.ReadByte(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadSingle: Single;
begin
  Result := FOwner.ReadSingle(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadDouble: Double;
begin
  Result := FOwner.ReadDouble(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadArrayInteger: TDataFrameArrayInteger;
begin
  Result := FOwner.ReadArrayInteger(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadArrayShortInt: TDataFrameArrayShortInt;
begin
  Result := FOwner.ReadArrayShortInt(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadArraySingle: TDataFrameArraySingle;
begin
  Result := FOwner.ReadArraySingle(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadArrayDouble: TDataFrameArrayDouble;
begin
  Result := FOwner.ReadArrayDouble(FIndex);
  Inc(FIndex);
end;

procedure TDataFrameEngineReader.ReadStream(output: TCoreClassStream);
begin
  FOwner.ReadStream(FIndex, output);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadVariant: Variant;
begin
  Result := FOwner.ReadVariant(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadInt64: Int64;
begin
  Result := FOwner.ReadInt64(FIndex);
  Inc(FIndex);
end;

procedure TDataFrameEngineReader.ReadStrings(output: TCoreClassStrings);
begin
  FOwner.ReadStrings(FIndex, output);
  Inc(FIndex);
end;

procedure TDataFrameEngineReader.ReadDataFrame(output: TDataFrameEngine);
begin
  FOwner.ReadDataFrame(FIndex, output);
  Inc(FIndex);
end;

procedure TDataFrameEngineReader.ReadVariantList(output: THashVariantList);
begin
  FOwner.ReadVariantList(FIndex, output);
  Inc(FIndex);
end;

procedure TDataFrameEngineReader.ReadSectionText(output: TSectionTextData);
begin
  FOwner.ReadSectionText(FIndex, output);
  Inc(FIndex);
end;

procedure TDataFrameEngineReader.ReadTextSection(output: TSectionTextData);
begin
  ReadSectionText(output);
end;

function TDataFrameEngineReader.ReadRect: TRect;
begin
  Result := FOwner.ReadRect(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadRectf: TRectf;
begin
  Result := FOwner.ReadRectf(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadPoint: TPoint;
begin
  Result := FOwner.ReadPoint(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadPointf: TPointf;
begin
  Result := FOwner.ReadPointf(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadVector: TVector;
begin
  Result := FOwner.ReadVector(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadAffineVector: TAffineVector;
begin
  Result := FOwner.ReadAffineVector(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadVec3: TVec3;
begin
  Result := FOwner.ReadVec3(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadVec4: TVec4;
begin
  Result := FOwner.ReadVec4(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadVector3: TVector3;
begin
  Result := FOwner.ReadVector3(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadVector4: TVector4;
begin
  Result := FOwner.ReadVector4(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadMat4: TMat4;
begin
  Result := FOwner.ReadMat4(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.ReadMatrix4: TMatrix4;
begin
  Result := FOwner.ReadMatrix4(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.Read2DPoint: T2DPoint;
begin
  Result := FOwner.Read2DPoint(FIndex);
  Inc(FIndex);
end;

function TDataFrameEngineReader.Read2DRect: T2DRect;
begin
  Result := FOwner.Read2DRect(FIndex);
  Inc(FIndex);
end;

procedure TDataFrameEngineReader.Read(var aBuf; aCount: Cardinal);
begin
  FOwner.Read(FIndex, aBuf, aCount);
  Inc(FIndex);
end;

function TDataFrameEngine.DataTypeToByte(v: TRunTimeDataType): Byte;
begin
  Result := Byte(v);
end;

function TDataFrameEngine.ByteToDataType(v: Byte): TRunTimeDataType;
begin
  Result := TRunTimeDataType(v);
end;

constructor TDataFrameEngine.Create;
begin
  inherited Create;
  FDataList := TCoreClassListForObj.Create;
  FReader := TDataFrameEngineReader.Create(Self);
end;

destructor TDataFrameEngine.Destroy;
begin
  Clear;
  DisposeObject(FDataList);
  DisposeObject(FReader);
  inherited Destroy;
end;

procedure TDataFrameEngine.Clear;
var
  i  : Integer;
  obj: TDataFrameBase;
begin
  for i := 0 to FDataList.Count - 1 do
    begin
      obj := TDataFrameBase(FDataList[i]);
      try
          DisposeObject(obj);
      except
      end;
    end;

  try
      FDataList.Clear;
  except
  end;

  FReader.Index := 0;
end;

function TDataFrameEngine.AddData(v: TRunTimeDataType): TDataFrameBase;
begin
  case v of
    rdtString:
      Result := TDataFrameString.Create(DataTypeToByte(v));
    rdtInteger:
      Result := TDataFrameInteger.Create(DataTypeToByte(v));
    rdtCardinal:
      Result := TDataFrameCardinal.Create(DataTypeToByte(v));
    rdtWORD:
      Result := TDataFrameWord.Create(DataTypeToByte(v));
    rdtByte:
      Result := TDataFrameByte.Create(DataTypeToByte(v));
    rdtSingle:
      Result := TDataFrameSingle.Create(DataTypeToByte(v));
    rdtDouble:
      Result := TDataFrameDouble.Create(DataTypeToByte(v));
    rdtArrayInteger:
      Result := TDataFrameArrayInteger.Create(DataTypeToByte(v));
    rdtArraySingle:
      Result := TDataFrameArraySingle.Create(DataTypeToByte(v));
    rdtArrayDouble:
      Result := TDataFrameArrayDouble.Create(DataTypeToByte(v));
    rdtStream:
      Result := TDataFrameStream.Create(DataTypeToByte(v));
    rdtVariant:
      Result := TDataFrameVariant.Create(DataTypeToByte(v));
    rdtInt64:
      Result := TDataFrameInt64.Create(DataTypeToByte(v));
    rdtArrayShortInt:
      Result := TDataFrameArrayShortInt.Create(DataTypeToByte(v));
    else
      Result := nil;
  end;
  if Result <> nil then
      FDataList.Add(Result);
end;

function TDataFrameEngine.GetData(idx: Integer): TDataFrameBase;
begin
  if (idx >= 0) and (idx < FDataList.Count) then
      Result := TDataFrameBase(FDataList[idx])
  else
      Result := nil;
end;

function TDataFrameEngine.GetDataInfo(_Obj: TDataFrameBase): string;
begin
  case ByteToDataType(_Obj.FID) of
    rdtString:
      Result := 'String';
    rdtInteger:
      Result := 'Integer';
    rdtCardinal:
      Result := 'Cardinal';
    rdtWORD:
      Result := 'WORD';
    rdtByte:
      Result := 'Byte';
    rdtSingle:
      Result := 'Single';
    rdtDouble:
      Result := 'Double';
    rdtArrayInteger:
      Result := 'ArrayInteger';
    rdtArraySingle:
      Result := 'ArraySingle';
    rdtArrayDouble:
      Result := 'ArrayDouble';
    rdtStream:
      Result := 'Stream';
    rdtVariant:
      Result := 'Variant';
    rdtInt64:
      Result := 'Int64';
    rdtArrayShortInt:
      Result := 'ShortInt';
    else
      Result := '';
  end;
end;

function TDataFrameEngine.Count: Integer;
begin
  Result := FDataList.Count;
end;

function TDataFrameEngine.Delete(idx: Integer): Boolean;
begin
  try
    DisposeObject(TDataFrameBase(FDataList[idx]));
    FDataList.Delete(idx);
    Result := True;
  except
      Result := False;
  end;
end;

function TDataFrameEngine.DeleteFirst: Boolean;
begin
  Result := Delete(0);
end;

function TDataFrameEngine.DeleteLast: Boolean;
begin
  Result := Delete(Count - 1);
end;

function TDataFrameEngine.DeleteLastCount(cnt: Integer): Boolean;
begin
  Result := True;
  while cnt > 0 do
    begin
      Result := Result and DeleteLast;
      Dec(cnt);
    end;
end;

function TDataFrameEngine.DeleteCount(idx, _Count: Integer): Boolean;
var
  i: Integer;
begin
  Result := True;
  for i := 0 to _Count - 1 do
      Result := Result and Delete(idx);
end;

procedure TDataFrameEngine.Assign(SameObj: TDataFrameEngine);
var
  s: TMemoryStream64;
begin
  Clear;
  s := TMemoryStream64.Create;
  SameObj.EncodeTo(s);
  s.Position := 0;
  DecodeFrom(s);
  DisposeObject(s);
end;

procedure TDataFrameEngine.WriteString(v: string);
var
  _Obj: TDataFrameString;
begin
  _Obj := TDataFrameString.Create(DataTypeToByte(rdtString));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteString(v: umlString);
begin
  WriteString(v.Text);
end;

procedure TDataFrameEngine.WriteInteger(v: Integer);
var
  _Obj: TDataFrameInteger;
begin
  _Obj := TDataFrameInteger.Create(DataTypeToByte(rdtInteger));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteCardinal(v: Cardinal);
var
  _Obj: TDataFrameCardinal;
begin
  _Obj := TDataFrameCardinal.Create(DataTypeToByte(rdtCardinal));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteWORD(v: Word);
var
  _Obj: TDataFrameWord;
begin
  _Obj := TDataFrameWord.Create(DataTypeToByte(rdtWORD));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteBool(v: Boolean);
begin
  if v then
      WriteByte(1)
  else
      WriteByte(0);
end;

procedure TDataFrameEngine.WriteBoolean(v: Boolean);
begin
  WriteBool(v);
end;

procedure TDataFrameEngine.WriteByte(v: Byte);
var
  _Obj: TDataFrameByte;
begin
  _Obj := TDataFrameByte.Create(DataTypeToByte(rdtByte));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteSingle(v: Single);
var
  _Obj: TDataFrameSingle;
begin
  _Obj := TDataFrameSingle.Create(DataTypeToByte(rdtSingle));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteDouble(v: Double);
var
  _Obj: TDataFrameDouble;
begin
  _Obj := TDataFrameDouble.Create(DataTypeToByte(rdtDouble));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

function TDataFrameEngine.WriteArrayInteger: TDataFrameArrayInteger;
begin
  Result := TDataFrameArrayInteger.Create(DataTypeToByte(rdtArrayInteger));
  FDataList.Add(Result);
end;

function TDataFrameEngine.WriteArrayShortInt: TDataFrameArrayShortInt;
begin
  Result := TDataFrameArrayShortInt.Create(DataTypeToByte(rdtArrayShortInt));
  FDataList.Add(Result);
end;

function TDataFrameEngine.WriteArraySingle: TDataFrameArraySingle;
begin
  Result := TDataFrameArraySingle.Create(DataTypeToByte(rdtArraySingle));
  FDataList.Add(Result);
end;

function TDataFrameEngine.WriteArrayDouble: TDataFrameArrayDouble;
begin
  Result := TDataFrameArrayDouble.Create(DataTypeToByte(rdtArrayDouble));
  FDataList.Add(Result);
end;

procedure TDataFrameEngine.WriteStream(v: TCoreClassStream);
var
  _Obj: TDataFrameStream;
begin
  _Obj := TDataFrameStream.Create(DataTypeToByte(rdtStream));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteVariant(v: Variant);
var
  _Obj: TDataFrameVariant;
begin
  _Obj := TDataFrameVariant.Create(DataTypeToByte(rdtVariant));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteInt64(v: Int64);
var
  _Obj: TDataFrameInt64;
begin
  _Obj := TDataFrameInt64.Create(DataTypeToByte(rdtInt64));
  _Obj.Buffer := v;
  FDataList.Add(_Obj);
end;

procedure TDataFrameEngine.WriteStrings(v: TCoreClassStrings);
var
  _Data: TMemoryStream64;
begin
  _Data := TMemoryStream64.Create;
  {$IFDEF FPC}
  v.SaveToStream(_Data);
  {$ELSE}
  v.SaveToStream(_Data, TEncoding.UTF8);
  {$ENDIF}
  _Data.Position := 0;
  WriteStream(_Data);
  DisposeObject(_Data);
end;

procedure TDataFrameEngine.WriteDataFrame(v: TDataFrameEngine);
var
  _Data: TMemoryStream64;
begin
  _Data := TMemoryStream64.Create;
  v.EncodeTo(_Data);
  _Data.Position := 0;
  WriteStream(_Data);
  DisposeObject(_Data);
end;

procedure TDataFrameEngine.WriteDataFrameCompressed(v: TDataFrameEngine);
var
  _Data: TMemoryStream64;
begin
  _Data := TMemoryStream64.Create;
  v.EncodeToCompressed(_Data);
  _Data.Position := 0;
  WriteStream(_Data);
  DisposeObject(_Data);
end;

procedure TDataFrameEngine.WriteVariantList(v: THashVariantList);
var
  ms: TMemoryStream64;
  h : THashVariantTextStream;
begin
  ms := TMemoryStream64.Create;
  h := THashVariantTextStream.Create(v);
  h.SaveToStream(ms);
  DisposeObject(h);
  ms.Position := 0;
  WriteStream(ms);
  DisposeObject(ms);
end;

procedure TDataFrameEngine.WriteSectionText(v: TSectionTextData);
var
  ms: TMemoryStream64;
begin
  ms := TMemoryStream64.Create;
  v.SaveToStream(ms);
  ms.Position := 0;
  WriteStream(ms);
  DisposeObject(ms);
end;

procedure TDataFrameEngine.WriteTextSection(v: TSectionTextData);
begin
  WriteSectionText(v);
end;

procedure TDataFrameEngine.WriteRect(v: TRect);
begin
  with WriteArrayInteger do
    begin
      Add(v.Left);
      Add(v.Top);
      Add(v.Right);
      Add(v.Bottom);
    end;
end;

procedure TDataFrameEngine.WriteRectf(v: TRectf);
begin
  with WriteArraySingle do
    begin
      Add(v.Left);
      Add(v.Top);
      Add(v.Right);
      Add(v.Bottom);
    end;
end;

procedure TDataFrameEngine.WritePoint(v: TPoint);
begin
  with WriteArrayInteger do
    begin
      Add(v.X);
      Add(v.Y);
    end;
end;

procedure TDataFrameEngine.WritePointf(v: TPointf);
begin
  with WriteArraySingle do
    begin
      Add(v.X);
      Add(v.Y);
    end;
end;

procedure TDataFrameEngine.WriteVector(v: TVector);
begin
  WriteArraySingle.WriteArray(v);
end;

procedure TDataFrameEngine.WriteAffineVector(v: TAffineVector);
begin
  WriteArraySingle.WriteArray(v);
end;

procedure TDataFrameEngine.WriteVec4(v: TVec4);
begin
  WriteArraySingle.WriteArray(v);
end;

procedure TDataFrameEngine.WriteVec3(v: TVec3);
begin
  WriteArraySingle.WriteArray(v);
end;

procedure TDataFrameEngine.WriteVector4(v: TVector4);
begin
  WriteArraySingle.WriteArray(v.Link);
end;

procedure TDataFrameEngine.WriteVector3(v: TVector3);
begin
  WriteArraySingle.WriteArray(v.Link);
end;

procedure TDataFrameEngine.WriteMat4(v: TMat4);
begin
  with WriteArraySingle do
    begin
      WriteArray(v[0]);
      WriteArray(v[1]);
      WriteArray(v[2]);
      WriteArray(v[3]);
    end;
end;

procedure TDataFrameEngine.WriteMatrix4(v: TMatrix4);
begin
  WriteMat4(v.Link);
end;

procedure TDataFrameEngine.Write2DPoint(v: T2DPoint);
begin
  with WriteArraySingle do
      WriteArray(v);
end;

procedure TDataFrameEngine.Write2DRect(v: T2DRect);
begin
  with WriteArraySingle do
    begin
      WriteArray(v[0]);
      WriteArray(v[1]);
    end;
end;

// append new stream and write
procedure TDataFrameEngine.Write(const aBuf; aCount: Cardinal);
var
  s: TMemoryStream64;
begin
  s := TMemoryStream64.Create;
  s.Write(aBuf, aCount);
  WriteStream(s);
  DisposeObject(s);
end;

function TDataFrameEngine.ReadString(idx: Integer): string;
var
  _Obj : TDataFrameBase;
  i    : Integer;
  _Data: TCoreClassStream;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameString then
      Result := TDataFrameString(_Obj).Buffer
  else if _Obj is TDataFrameInteger then
      Result := IntToStr(TDataFrameInteger(_Obj).Buffer)
  else if _Obj is TDataFrameCardinal then
      Result := IntToStr(TDataFrameCardinal(_Obj).Buffer)
  else if _Obj is TDataFrameWord then
      Result := IntToStr(TDataFrameWord(_Obj).Buffer)
  else if _Obj is TDataFrameByte then
      Result := IntToStr(TDataFrameByte(_Obj).Buffer)
  else if _Obj is TDataFrameSingle then
      Result := FloatToStr(TDataFrameSingle(_Obj).Buffer)
  else if _Obj is TDataFrameDouble then
      Result := FloatToStr(TDataFrameDouble(_Obj).Buffer)
  else if _Obj is TDataFrameArrayInteger then
    begin
      Result := '(';
      with TDataFrameArrayInteger(_Obj) do
        begin
          for i := 0 to Count - 1 do
            if Result <> '(' then
                Result := Result + ',' + IntToStr(Buffer[i])
            else
                Result := Result + IntToStr(Buffer[i]);
        end;
      Result := Result + ')';
    end
  else if _Obj is TDataFrameArraySingle then
    begin
      Result := '(';
      with TDataFrameArraySingle(_Obj) do
        begin
          for i := 0 to Count - 1 do
            if Result <> '(' then
                Result := Result + ',' + FloatToStr(Buffer[i])
            else
                Result := Result + FloatToStr(Buffer[i]);
        end;
      Result := Result + ')';
    end
  else if _Obj is TDataFrameArrayDouble then
    begin
      Result := '(';
      with TDataFrameArrayDouble(_Obj) do
        begin
          for i := 0 to Count - 1 do
            if Result <> '(' then
                Result := Result + ',' + FloatToStr(Buffer[i])
            else
                Result := Result + FloatToStr(Buffer[i]);
        end;
      Result := Result + ')';
    end
  else if _Obj is TDataFrameVariant then
      Result := VarToStr(TDataFrameVariant(_Obj).Buffer)
  else if _Obj is TDataFrameInt64 then
      Result := IntToStr(TDataFrameInt64(_Obj).Buffer)
  else
      Result := '';
end;

function TDataFrameEngine.ReadInteger(idx: Integer): Integer;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameString then
      Result := umlStrToInt(TDataFrameString(_Obj).Buffer, 0)
  else if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameSingle then
      Result := Trunc(TDataFrameSingle(_Obj).Buffer)
  else if _Obj is TDataFrameDouble then
      Result := Trunc(TDataFrameDouble(_Obj).Buffer)
  else if _Obj is TDataFrameVariant then
      Result := (TDataFrameVariant(_Obj).Buffer)
  else if _Obj is TDataFrameInt64 then
      Result := (TDataFrameInt64(_Obj).Buffer)
  else
      Result := 0;
end;

function TDataFrameEngine.ReadCardinal(idx: Integer): Cardinal;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameString then
      Result := umlStrToInt(TDataFrameString(_Obj).Buffer, 0)
  else if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameSingle then
      Result := Trunc(TDataFrameSingle(_Obj).Buffer)
  else if _Obj is TDataFrameDouble then
      Result := Trunc(TDataFrameDouble(_Obj).Buffer)
  else if _Obj is TDataFrameVariant then
      Result := (TDataFrameVariant(_Obj).Buffer)
  else if _Obj is TDataFrameInt64 then
      Result := (TDataFrameInt64(_Obj).Buffer)
  else
      Result := 0;
end;

function TDataFrameEngine.ReadWord(idx: Integer): Word;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameString then
      Result := umlStrToInt(TDataFrameString(_Obj).Buffer, 0)
  else if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameSingle then
      Result := Trunc(TDataFrameSingle(_Obj).Buffer)
  else if _Obj is TDataFrameDouble then
      Result := Trunc(TDataFrameDouble(_Obj).Buffer)
  else if _Obj is TDataFrameVariant then
      Result := (TDataFrameVariant(_Obj).Buffer)
  else if _Obj is TDataFrameInt64 then
      Result := (TDataFrameInt64(_Obj).Buffer)
  else
      Result := 0;
end;

function TDataFrameEngine.ReadBool(idx: Integer): Boolean;
begin
  Result := ReadByte(idx) = 1;
end;

function TDataFrameEngine.ReadBoolean(idx: Integer): Boolean;
begin
  Result := ReadBool(idx);
end;

function TDataFrameEngine.ReadByte(idx: Integer): Byte;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameString then
      Result := umlStrToInt(TDataFrameString(_Obj).Buffer, 0)
  else if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameSingle then
      Result := Trunc(TDataFrameSingle(_Obj).Buffer)
  else if _Obj is TDataFrameDouble then
      Result := Trunc(TDataFrameDouble(_Obj).Buffer)
  else if _Obj is TDataFrameVariant then
      Result := (TDataFrameVariant(_Obj).Buffer)
  else if _Obj is TDataFrameInt64 then
      Result := (TDataFrameInt64(_Obj).Buffer)
  else
      Result := 0;
end;

function TDataFrameEngine.ReadSingle(idx: Integer): Single;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameSingle then
      Result := TDataFrameSingle(_Obj).Buffer
  else if _Obj is TDataFrameString then
      Result := umlStrToFloat(TDataFrameString(_Obj).Buffer, 0)
  else if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameDouble then
      Result := TDataFrameDouble(_Obj).Buffer
  else if _Obj is TDataFrameVariant then
      Result := (TDataFrameVariant(_Obj).Buffer)
  else if _Obj is TDataFrameInt64 then
      Result := (TDataFrameInt64(_Obj).Buffer)
  else
      Result := 0;
end;

function TDataFrameEngine.ReadDouble(idx: Integer): Double;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameDouble then
      Result := TDataFrameDouble(_Obj).Buffer
  else if _Obj is TDataFrameString then
      Result := umlStrToFloat(TDataFrameString(_Obj).Buffer, 0)
  else if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameSingle then
      Result := TDataFrameSingle(_Obj).Buffer
  else if _Obj is TDataFrameVariant then
      Result := (TDataFrameVariant(_Obj).Buffer)
  else if _Obj is TDataFrameInt64 then
      Result := (TDataFrameInt64(_Obj).Buffer)
  else
      Result := 0;
end;

function TDataFrameEngine.ReadArrayInteger(idx: Integer): TDataFrameArrayInteger;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameArrayInteger then
      Result := TDataFrameArrayInteger(_Obj)
  else
      Result := nil;
end;

function TDataFrameEngine.ReadArrayShortInt(idx: Integer): TDataFrameArrayShortInt;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameArrayShortInt then
      Result := TDataFrameArrayShortInt(_Obj)
  else
      Result := nil;
end;

function TDataFrameEngine.ReadArraySingle(idx: Integer): TDataFrameArraySingle;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameArraySingle then
      Result := TDataFrameArraySingle(_Obj)
  else
      Result := nil;
end;

function TDataFrameEngine.ReadArrayDouble(idx: Integer): TDataFrameArrayDouble;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameArrayDouble then
      Result := TDataFrameArrayDouble(_Obj)
  else
      Result := nil;
end;

procedure TDataFrameEngine.ReadStream(idx: Integer; output: TCoreClassStream);
var
  _Obj         : TDataFrameBase;
  AneedResetPos: Boolean;
begin
  _Obj := Data[idx];
  AneedResetPos := output.Size = 0;
  if _Obj is TDataFrameStream then
    begin
      with TDataFrameStream(_Obj) do
        begin
          Buffer.Position := 0;
          output.CopyFrom(Buffer, Buffer.Size);
          Buffer.Position := 0;
        end;
    end
  else
      _Obj.SaveToStream(output);
  if AneedResetPos then
      output.Position := 0;
end;

function TDataFrameEngine.ReadVariant(idx: Integer): Variant;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameVariant then
      Result := TDataFrameVariant(_Obj).Buffer
  else if _Obj is TDataFrameString then
      Result := TDataFrameString(_Obj).Buffer
  else if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameSingle then
      Result := TDataFrameSingle(_Obj).Buffer
  else if _Obj is TDataFrameDouble then
      Result := TDataFrameDouble(_Obj).Buffer
  else if _Obj is TDataFrameInt64 then
      Result := (TDataFrameInt64(_Obj).Buffer)
  else
      Result := 0;
end;

function TDataFrameEngine.ReadInt64(idx: Integer): Int64;
var
  _Obj: TDataFrameBase;
begin
  _Obj := Data[idx];
  if _Obj is TDataFrameInt64 then
      Result := TDataFrameInt64(_Obj).Buffer
  else if _Obj is TDataFrameInteger then
      Result := TDataFrameInteger(_Obj).Buffer
  else if _Obj is TDataFrameCardinal then
      Result := TDataFrameCardinal(_Obj).Buffer
  else if _Obj is TDataFrameWord then
      Result := TDataFrameWord(_Obj).Buffer
  else if _Obj is TDataFrameByte then
      Result := TDataFrameByte(_Obj).Buffer
  else if _Obj is TDataFrameSingle then
      Result := Trunc(TDataFrameSingle(_Obj).Buffer)
  else if _Obj is TDataFrameDouble then
      Result := Trunc(TDataFrameDouble(_Obj).Buffer)
  else if _Obj is TDataFrameVariant then
      Result := TDataFrameVariant(_Obj).Buffer
  else
      Result := 0;
end;

procedure TDataFrameEngine.ReadStrings(idx: Integer; output: TCoreClassStrings);
var
  _Data: TMemoryStream64;
begin
  _Data := TMemoryStream64.Create;
  ReadStream(idx, _Data);
  _Data.Position := 0;

  {$IFDEF FPC}
  output.LoadFromStream(_Data);
  {$ELSE}
  output.LoadFromStream(_Data, TEncoding.UTF8);
  {$ENDIF}
  DisposeObject(_Data);
end;

procedure TDataFrameEngine.ReadDataFrame(idx: Integer; output: TDataFrameEngine);
var
  _Data: TMemoryStream64;
begin
  _Data := TMemoryStream64.Create;
  ReadStream(idx, _Data);
  _Data.Position := 0;
  output.DecodeFrom(_Data);
  DisposeObject(_Data);
end;

procedure TDataFrameEngine.ReadVariantList(idx: Integer; output: THashVariantList);
var
  _Data: TMemoryStream64;
  h    : THashVariantTextStream;
begin
  _Data := TMemoryStream64.Create;
  ReadStream(idx, _Data);
  _Data.Position := 0;
  h := THashVariantTextStream.Create(output);
  h.LoadFromStream(_Data);
  DisposeObject(h);
  DisposeObject(_Data);
end;

procedure TDataFrameEngine.ReadSectionText(idx: Integer; output: TSectionTextData);
var
  _Data: TMemoryStream64;
begin
  _Data := TMemoryStream64.Create;
  ReadStream(idx, _Data);
  _Data.Position := 0;
  output.LoadFromStream(_Data);
  DisposeObject(_Data);
end;

procedure TDataFrameEngine.ReadTextSection(idx: Integer; output: TSectionTextData);
begin
  ReadSectionText(idx, output);
end;

function TDataFrameEngine.ReadRect(idx: Integer): TRect;
begin
  with ReadArrayInteger(idx) do
    begin
      Result := Rect(Buffer[0], Buffer[1], Buffer[2], Buffer[3]);
    end;
end;

function TDataFrameEngine.ReadRectf(idx: Integer): TRectf;
begin
  with ReadArraySingle(idx) do
    begin
      Result := Rectf(Buffer[0], Buffer[1], Buffer[2], Buffer[3]);
    end;
end;

function TDataFrameEngine.ReadPoint(idx: Integer): TPoint;
begin
  with ReadArrayInteger(idx) do
    begin
      Result := Point(Buffer[0], Buffer[1]);
    end;
end;

function TDataFrameEngine.ReadPointf(idx: Integer): TPointf;
begin
  with ReadArraySingle(idx) do
    begin
      Result := Pointf(Buffer[0], Buffer[1]);
    end;
end;

function TDataFrameEngine.ReadVector(idx: Integer): TVector;
begin
  with ReadArraySingle(idx) do
    begin
      Result[0] := Buffer[0];
      Result[1] := Buffer[1];
      Result[2] := Buffer[2];
      Result[3] := Buffer[3];
    end;
end;

function TDataFrameEngine.ReadAffineVector(idx: Integer): TAffineVector;
begin
  with ReadArraySingle(idx) do
    begin
      Result[0] := Buffer[0];
      Result[1] := Buffer[1];
      Result[2] := Buffer[2];
    end;
end;

function TDataFrameEngine.ReadVec3(idx: Integer): TVec3;
begin
  with ReadArraySingle(idx) do
    begin
      Result[0] := Buffer[0];
      Result[1] := Buffer[1];
      Result[2] := Buffer[2];
    end;
end;

function TDataFrameEngine.ReadVec4(idx: Integer): TVec4;
begin
  with ReadArraySingle(idx) do
    begin
      Result[0] := Buffer[0];
      Result[1] := Buffer[1];
      Result[2] := Buffer[2];
      Result[3] := Buffer[3];
    end;
end;

function TDataFrameEngine.ReadVector3(idx: Integer): TVector3;
begin
  with ReadArraySingle(idx) do
    begin
      Result := Vector3(Buffer[0], Buffer[1], Buffer[2]);
    end;
end;

function TDataFrameEngine.ReadVector4(idx: Integer): TVector4;
begin
  with ReadArraySingle(idx) do
    begin
      Result := Vector4(Buffer[0], Buffer[1], Buffer[2], Buffer[3]);
    end;
end;

function TDataFrameEngine.ReadMat4(idx: Integer): TMat4;
var
  i, j: Integer;
begin
  with ReadArraySingle(idx) do
    begin
      for i := 0 to 3 do
        for j := 0 to 3 do
            Result[i][j] := Buffer[i * 4 + j];
    end;
end;

function TDataFrameEngine.ReadMatrix4(idx: Integer): TMatrix4;
begin
  Result.Link := ReadMat4(idx);
end;

function TDataFrameEngine.Read2DPoint(idx: Integer): T2DPoint;
begin
  with ReadArraySingle(idx) do
    begin
      Result[0] := Buffer[0];
      Result[1] := Buffer[1];
    end;
end;

function TDataFrameEngine.Read2DRect(idx: Integer): T2DRect;
begin
  with ReadArraySingle(idx) do
    begin
      Result[0][0] := Buffer[0];
      Result[0][1] := Buffer[1];
      Result[1][0] := Buffer[2];
      Result[1][1] := Buffer[3];
    end;
end;

procedure TDataFrameEngine.Read(idx: Integer; var aBuf; aCount: Cardinal);
var
  s: TMemoryStream64;
begin
  s := TMemoryStream64.Create;
  ReadStream(idx, s);
  s.Read(aBuf, aCount);
  DisposeObject(s);
end;

function TDataFrameEngine.ComputeEncodeSize: Integer;
var
  i: Integer;
begin
  Result := umlIntegerLength;
  for i := 0 to Count - 1 do
      Result := Result + umlByteLength + GetData(i).ComputeEncodeSize;
end;

function TDataFrameEngine.EncodeTo(output: TCoreClassStream): Integer;
var
  i                   : Integer;
  b                   : TDataFrameBase;
  StoreStream, nStream: TMemoryStream64;
  id                  : Byte;

  editionFlag: Byte;
  sizeInfo   : Integer;
  compFlag   : Boolean;
  md5        : TMD5;
begin
  Result := Count;
  StoreStream := TMemoryStream64.Create;

  // make body
  StoreStream.WriteBuffer(Result, umlIntegerLength);

  nStream := TMemoryStream64.Create;
  for i := 0 to Count - 1 do
    begin
      b := GetData(i);
      id := b.FID;
      b.SaveToStream(nStream);

      StoreStream.WriteBuffer(id, umlByteLength);
      nStream.Position := 0;
      StoreStream.CopyFrom(nStream, nStream.Size);
      nStream.Clear;
    end;

  // make header
  editionFlag := $FF;
  sizeInfo := StoreStream.Size;
  compFlag := False;
  StoreStream.Position := 0;
  md5 := umlStreamMD5(StoreStream);
  nStream.Clear;
  nStream.Write(editionFlag, umlByteLength);
  nStream.Write(sizeInfo, umlIntegerLength);
  nStream.Write(compFlag, umlBoolLength);
  nStream.Write(md5[0], 16);

  // write header
  nStream.Position := 0;
  output.CopyFrom(nStream, nStream.Size);
  DisposeObject(nStream);

  // write body
  StoreStream.Position := 0;
  output.CopyFrom(StoreStream, StoreStream.Size);
  DisposeObject(StoreStream);
end;

function TDataFrameEngine.EncodeToCompressed(output: TCoreClassStream): Integer;
var
  i                               : Integer;
  b                               : TDataFrameBase;
  StoreStream, nStream, compStream: TMemoryStream64;
  ZCompStream                     : TCompressionStream;
  id                              : Byte;

  editionFlag : Byte;
  sizeInfo    : Integer;
  compFlag    : Boolean;
  compSizeInfo: Integer;
  md5         : TMD5;
begin
  Result := Count;
  StoreStream := TMemoryStream64.Create;

  // make body
  StoreStream.WriteBuffer(Result, umlIntegerLength);

  nStream := TMemoryStream64.Create;
  for i := 0 to Count - 1 do
    begin
      b := GetData(i);
      id := b.FID;
      b.SaveToStream(nStream);

      StoreStream.WriteBuffer(id, umlByteLength);
      nStream.Position := 0;
      StoreStream.CopyFrom(nStream, nStream.Size);
      nStream.Clear;
    end;

  // compress body and make header
  compSizeInfo := StoreStream.Size;
  StoreStream.Position := 0;
  md5 := umlStreamMD5(StoreStream);

  compStream := TMemoryStream64.Create;
  ZCompStream := TCompressionStream.Create(compStream);
  StoreStream.Position := 0;
  ZCompStream.CopyFrom(StoreStream, StoreStream.Size);
  DisposeObject(ZCompStream);
  DisposeObject(StoreStream);

  editionFlag := $FF;
  sizeInfo := compStream.Size;
  compFlag := True;

  nStream.Clear;
  nStream.Write(editionFlag, umlByteLength);
  nStream.Write(sizeInfo, umlIntegerLength);
  nStream.Write(compFlag, umlBoolLength);
  nStream.Write(compSizeInfo, umlIntegerLength);
  nStream.Write(md5[0], 16);

  // write header
  nStream.Position := 0;
  output.CopyFrom(nStream, nStream.Size);
  DisposeObject(nStream);

  // write body
  compStream.Position := 0;
  output.CopyFrom(compStream, compStream.Size);
  DisposeObject(compStream);
end;

function TDataFrameEngine.DecodeFrom(source: TCoreClassStream): Integer;
var
  i, cnt       : Integer;
  id           : Byte;
  StoreStream  : TCoreClassStream;
  ZDecompStream: TDecompressionStream;
  b            : TDataFrameBase;

  editionFlag : Byte;
  sizeInfo    : Integer;
  compFlag    : Boolean;
  compSizeInfo: Integer;
  md5         : TMD5;
begin
  Clear;

  Result := 0;

  StoreStream := TMemoryStream64.Create;

  source.Read(editionFlag, umlByteLength);
  if editionFlag = $FF then
    begin
      source.Read(sizeInfo, umlIntegerLength);
      source.Read(compFlag, umlBoolLength);
      if compFlag then
        begin
          source.Read(compSizeInfo, umlIntegerLength);
          source.Read(md5[0], 16);

          ZDecompStream := TDecompressionStream.Create(source);
          StoreStream.CopyFrom(ZDecompStream, compSizeInfo);
          DisposeObject(ZDecompStream);

          StoreStream.Position := 0;
          if not umlMD5Compare(umlStreamMD5(StoreStream), md5) then
            begin
              DoStatus('dataframe md5 error!');
              DisposeObject(StoreStream);
              Exit;
            end;
        end
      else
        begin
          source.Read(md5[0], 16);

          StoreStream.CopyFrom(source, sizeInfo);

          StoreStream.Position := 0;
          if not umlMD5Compare(umlStreamMD5(StoreStream), md5) then
            begin
              DoStatus('dataframe md5 error!');
              DisposeObject(StoreStream);
              Exit;
            end;
        end;
    end
  else
    begin
      DoStatus('dataframe decode error!');
      DisposeObject(StoreStream);
      Exit;
    end;

  StoreStream.Position := 0;

  StoreStream.ReadBuffer(cnt, umlIntegerLength);
  for i := 0 to cnt - 1 do
    begin
      StoreStream.ReadBuffer(id, umlByteLength);
      b := AddData(ByteToDataType(id));
      b.LoadFromStream(StoreStream);
    end;
  DisposeObject(StoreStream);
  Result := cnt;
end;

function TDataFrameEngine.EncodeToString: string;
var
  enStream: TMemoryStream64;
  b       : TBytes;
begin
  enStream := TMemoryStream64.Create;
  EncodeTo(enStream);
  SetLength(b, enStream.Size);
  enStream.Position := 0;
  enStream.ReadBuffer(b[0], enStream.Size);
  DisposeObject(enStream);
  Result := (umlStringOf(umlBase64EncodeBytes(b)).Text);
end;

function TDataFrameEngine.EncodeToCompressedString: string;
var
  enStream: TMemoryStream64;
  b       : TBytes;
begin
  enStream := TMemoryStream64.Create;
  EncodeToCompressed(enStream);
  SetLength(b, enStream.Size);
  enStream.Position := 0;
  enStream.ReadBuffer(b[0], enStream.Size);
  DisposeObject(enStream);
  Result := (umlStringOf(umlBase64EncodeBytes(b)).Text);
end;

procedure TDataFrameEngine.DecodeFromString(const source: string);
var
  nb, b   : TBytes;
  enStream: TMemoryStream64;
begin
  nb := umlBytesOf(source);
  b := umlBase64DecodeBytes(nb);

  enStream := TMemoryStream64.Create;
  enStream.WriteBuffer(b[0], Length(b));
  enStream.Position := 0;
  DecodeFrom(enStream);
  DisposeObject(enStream);
end;

function TDataFrameEngine.EncodeToBytes: TBytes;
var
  enStream: TMemoryStream64;
begin
  enStream := TMemoryStream64.Create;
  EncodeTo(enStream);
  SetLength(Result, enStream.Size);
  enStream.Position := 0;
  enStream.ReadBuffer(Result[0], enStream.Size);
  DisposeObject(enStream);
end;

function TDataFrameEngine.EncodeToCompressedBytes: TBytes;
var
  enStream: TMemoryStream64;
begin
  enStream := TMemoryStream64.Create;
  EncodeToCompressed(enStream);
  SetLength(Result, enStream.Size);
  enStream.Position := 0;
  enStream.ReadBuffer(Result[0], enStream.Size);
  DisposeObject(enStream);
end;

procedure TDataFrameEngine.DecodeFromBytes(var b: TBytes);
var
  enStream: TMemoryStream64;
begin
  enStream := TMemoryStream64.Create;
  enStream.WriteBuffer(b[0], Length(b));
  enStream.Position := 0;
  DecodeFrom(enStream);
  DisposeObject(enStream);
end;

procedure TDataFrameEngine.LoadFromStream(stream: TCoreClassStream);
begin
  try
      DecodeFrom(stream);
  except
  end;
end;

procedure TDataFrameEngine.SaveToStream(stream: TCoreClassStream);
begin
  try
    if ComputeEncodeSize > 8 * 1024 then
        EncodeToCompressed(stream)
    else
        EncodeTo(stream);
  except
  end;
end;

constructor TDataWriter.Create(AStream: TCoreClassStream);
begin
  inherited Create;
  FEngine := TDataFrameEngine.Create;
  FStream := AStream;
end;

destructor TDataWriter.Destroy;
var
  FlagCompressed: Boolean;
  verflag       : TBytes;
  len           : Int64;
  m             : TMemoryStream64;
begin
  if FStream <> nil then
    begin
      m := TMemoryStream64.Create;
      FEngine.EncodeTo(m);
      len := m.Size;

      // write version flag
      verflag := umlBytesOf('0001');
      FStream.Write(verflag, 4);

      // write compressed flag
      FlagCompressed := False;
      FStream.Write(FlagCompressed, umlBooleanLength);

      // write length info
      FStream.Write(len, umlInt64Length);

      // write buffer
      m.Position := 0;
      FStream.CopyFrom(m, len);
      DisposeObject(m);
    end;

  DisposeObject(FEngine);
  inherited Destroy;
end;

procedure TDataWriter.Clear;
begin
  FEngine.Clear;
end;

procedure TDataWriter.WriteString(v: string);
begin
  FEngine.WriteString(v);
end;

procedure TDataWriter.WriteInteger(v: Integer);
begin
  FEngine.WriteInteger(v);
end;

procedure TDataWriter.WriteCardinal(v: Cardinal);
begin
  FEngine.WriteCardinal(v);
end;

procedure TDataWriter.WriteWORD(v: Word);
begin
  FEngine.WriteWORD(v);
end;

procedure TDataWriter.WriteBool(v: Boolean);
begin
  FEngine.WriteBool(v);
end;

procedure TDataWriter.WriteBoolean(v: Boolean);
begin
  FEngine.WriteBoolean(v);
end;

procedure TDataWriter.WriteByte(v: Byte);
begin
  FEngine.WriteByte(v);
end;

procedure TDataWriter.WriteSingle(v: Single);
begin
  FEngine.WriteSingle(v);
end;

procedure TDataWriter.WriteDouble(v: Double);
begin
  FEngine.WriteDouble(v);
end;

procedure TDataWriter.WriteArrayInteger(v: array of Integer);
begin
  FEngine.WriteArrayInteger.WriteArray(v);
end;

procedure TDataWriter.WriteArrayShortInt(v: array of ShortInt);
begin
  FEngine.WriteArrayShortInt.WriteArray(v);
end;

procedure TDataWriter.WriteArraySingle(v: array of Single);
begin
  FEngine.WriteArraySingle.WriteArray(v);
end;

procedure TDataWriter.WriteArrayDouble(v: array of Double);
begin
  FEngine.WriteArrayDouble.WriteArray(v);
end;

procedure TDataWriter.WriteStream(v: TCoreClassStream);
begin
  FEngine.WriteStream(v);
end;

procedure TDataWriter.WriteVariant(v: Variant);
begin
  FEngine.WriteVariant(v);
end;

procedure TDataWriter.WriteInt64(v: Int64);
begin
  FEngine.WriteInt64(v);
end;

procedure TDataWriter.WriteStrings(v: TCoreClassStrings);
begin
  FEngine.WriteStrings(v);
end;

procedure TDataWriter.WriteDataFrame(v: TDataFrameEngine);
begin
  FEngine.WriteDataFrame(v);
end;

procedure TDataWriter.WriteDataFrameCompressed(v: TDataFrameEngine);
begin
  FEngine.WriteDataFrameCompressed(v);
end;

procedure TDataWriter.WriteVariantList(v: THashVariantList);
begin
  FEngine.WriteVariantList(v);
end;

procedure TDataWriter.WriteSectionText(v: TSectionTextData);
begin
  FEngine.WriteSectionText(v);
end;

procedure TDataWriter.WriteRect(v: TRect);
begin
  FEngine.WriteRect(v);
end;

procedure TDataWriter.WriteRectf(v: TRectf);
begin
  FEngine.WriteRectf(v);
end;

procedure TDataWriter.WritePoint(v: TPoint);
begin
  FEngine.WritePoint(v);
end;

procedure TDataWriter.WritePointf(v: TPointf);
begin
  FEngine.WritePointf(v);
end;

procedure TDataWriter.WriteVector(v: TVector);
begin
  FEngine.WriteVector(v);
end;

procedure TDataWriter.WriteAffineVector(v: TAffineVector);
begin
  FEngine.WriteAffineVector(v);
end;

procedure TDataWriter.WriteVec4(v: TVec4);
begin
  FEngine.WriteVec4(v);
end;

procedure TDataWriter.WriteVec3(v: TVec3);
begin
  FEngine.WriteVec3(v);
end;

procedure TDataWriter.WriteVector4(v: TVector4);
begin
  FEngine.WriteVector4(v);
end;

procedure TDataWriter.WriteVector3(v: TVector3);
begin
  FEngine.WriteVector3(v);
end;

procedure TDataWriter.WriteMat4(v: TMat4);
begin
  FEngine.WriteMat4(v);
end;

procedure TDataWriter.WriteMatrix4(v: TMatrix4);
begin
  FEngine.WriteMatrix4(v);
end;

procedure TDataWriter.Write2DPoint(v: T2DPoint);
begin
  FEngine.Write2DPoint(v);
end;

procedure TDataWriter.Write2DRect(v: T2DRect);
begin
  FEngine.Write2DRect(v);
end;

procedure TDataWriter.Write(const aBuf; aCount: Cardinal);
begin
  FEngine.Write(aBuf, aCount);
end;

constructor TDataReader.Create(AStream: TCoreClassStream);
var
  verflag       : TBytes;
  FlagCompressed: Boolean;
  len           : Int64;
  m             : TMemoryStream64;
begin
  inherited Create;
  FEngine := TDataFrameEngine.Create;
  if AStream <> nil then
    begin
      // read version flag
      SetLength(verflag, 4);
      AStream.Read(verflag, 4);
      if umlStringOf(verflag) <> '0001' then
          raise Exception.Create('Version flag Does not match!');

      // read compressed flag
      AStream.Read(FlagCompressed, umlBooleanLength);

      // read length info
      AStream.Read(len, umlInt64Length);

      // write buffer
      m := TMemoryStream64.Create;
      m.CopyFrom(AStream, len);
      m.Position := 0;
      FEngine.DecodeFrom(m);
      DisposeObject(m);
    end;
end;

destructor TDataReader.Destroy;
begin
  DisposeObject(FEngine);
  inherited Destroy;
end;

function TDataReader.ReadString: string;
begin
  Result := FEngine.Reader.ReadString;
end;

function TDataReader.ReadInteger: Integer;
begin
  Result := FEngine.Reader.ReadInteger;
end;

function TDataReader.ReadCardinal: Cardinal;
begin
  Result := FEngine.Reader.ReadCardinal;
end;

function TDataReader.ReadWord: Word;
begin
  Result := FEngine.Reader.ReadWord;
end;

function TDataReader.ReadBool: Boolean;
begin
  Result := FEngine.Reader.ReadBool;
end;

function TDataReader.ReadBoolean: Boolean;
begin
  Result := FEngine.Reader.ReadBoolean;
end;

function TDataReader.ReadByte: Byte;
begin
  Result := FEngine.Reader.ReadByte;
end;

function TDataReader.ReadSingle: Single;
begin
  Result := FEngine.Reader.ReadSingle;
end;

function TDataReader.ReadDouble: Double;
begin
  Result := FEngine.Reader.ReadDouble;
end;

procedure TDataReader.ReadArrayInteger(var Data: array of Integer);
var
  i : Integer;
  rb: TDataFrameArrayInteger;
begin
  rb := FEngine.Reader.ReadArrayInteger;
  for i := low(Data) to high(Data) do
      Data[i] := rb[i];
end;

procedure TDataReader.ReadArrayShortInt(var Data: array of ShortInt);
var
  i : Integer;
  rb: TDataFrameArrayShortInt;
begin
  rb := FEngine.Reader.ReadArrayShortInt;
  for i := low(Data) to high(Data) do
      Data[i] := rb[i];
end;

procedure TDataReader.ReadArraySingle(var Data: array of Single);
var
  i : Integer;
  rb: TDataFrameArraySingle;
begin
  rb := FEngine.Reader.ReadArraySingle;
  for i := low(Data) to high(Data) do
      Data[i] := rb[i];
end;

procedure TDataReader.ReadArrayDouble(var Data: array of Double);
var
  i : Integer;
  rb: TDataFrameArrayDouble;
begin
  rb := FEngine.Reader.ReadArrayDouble;
  for i := low(Data) to high(Data) do
      Data[i] := rb[i];
end;

procedure TDataReader.ReadStream(output: TCoreClassStream);
begin
  FEngine.Reader.ReadStream(output);
end;

function TDataReader.ReadVariant: Variant;
begin
  Result := FEngine.Reader.ReadVariant;
end;

function TDataReader.ReadInt64: Int64;
begin
  Result := FEngine.Reader.ReadInt64;
end;

procedure TDataReader.ReadStrings(output: TCoreClassStrings);
begin
  FEngine.Reader.ReadStrings(output);
end;

procedure TDataReader.ReadDataFrame(output: TDataFrameEngine);
begin
  FEngine.Reader.ReadDataFrame(output);
end;

procedure TDataReader.ReadVariantList(output: THashVariantList);
begin
  FEngine.Reader.ReadVariantList(output);
end;

procedure TDataReader.ReadSectionText(output: TSectionTextData);
begin
  FEngine.Reader.ReadSectionText(output);
end;

function TDataReader.ReadRect: TRect;
begin
  Result := FEngine.Reader.ReadRect;
end;

function TDataReader.ReadRectf: TRectf;
begin
  Result := FEngine.Reader.ReadRectf;
end;

function TDataReader.ReadPoint: TPoint;
begin
  Result := FEngine.Reader.ReadPoint;
end;

function TDataReader.ReadPointf: TPointf;
begin
  Result := FEngine.Reader.ReadPointf;
end;

function TDataReader.ReadVector: TVector;
begin
  Result := FEngine.Reader.ReadVector;
end;

function TDataReader.ReadAffineVector: TAffineVector;
begin
  Result := FEngine.Reader.ReadAffineVector;
end;

function TDataReader.ReadVec3: TVec3;
begin
  Result := FEngine.Reader.ReadVec3;
end;

function TDataReader.ReadVec4: TVec4;
begin
  Result := FEngine.Reader.ReadVec4;
end;

function TDataReader.ReadVector3: TVector3;
begin
  Result := FEngine.Reader.ReadVector3;
end;

function TDataReader.ReadVector4: TVector4;
begin
  Result := FEngine.Reader.ReadVector4;
end;

function TDataReader.ReadMat4: TMat4;
begin
  Result := FEngine.Reader.ReadMat4;
end;

function TDataReader.ReadMatrix4: TMatrix4;
begin
  Result := FEngine.Reader.ReadMatrix4;
end;

function TDataReader.Read2DPoint: T2DPoint;
begin
  Result := FEngine.Reader.Read2DPoint;
end;

function TDataReader.Read2DRect: T2DRect;
begin
  Result := FEngine.Reader.Read2DRect;
end;

procedure TDataReader.Read(var aBuf; aCount: Cardinal);
begin
  FEngine.Reader.Read(aBuf, aCount);
end;

end.
