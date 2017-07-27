program zExpDemo;

{$APPTYPE CONSOLE}

{$R *.res}


uses
  System.SysUtils,
  Variants,
  zExpression in '..\..\zExpression.pas',
  Geometry2DUnit in '..\..\lib\Geometry2DUnit.pas',
  CoreClasses in '..\..\lib\CoreClasses.pas',
  ListEngine in '..\..\lib\ListEngine.pas',
  Geometry3DUnit in '..\..\lib\Geometry3DUnit.pas',
  UnicodeMixedLib in '..\..\lib\UnicodeMixedLib.pas',
  PascalStrings in '..\..\lib\PascalStrings.pas',
  DataFrameEngine in '..\..\lib\DataFrameEngine.pas',
  DoStatusIO in '..\..\lib\DoStatusIO.pas',
  TextDataEngine in '..\..\lib\TextDataEngine.pas',
  GeometryLib in '..\..\lib\GeometryLib.pas',
  MemoryStream64 in '..\..\lib\MemoryStream64.pas',
  TextParsing in '..\..\lib\TextParsing.pas',
  opCode in '..\..\opCode.pas';

var
  sym1, sym2: TSymbolExpression;
  op        : TOpCode;

begin
  try
    { TODO -oUser -cConsole Main : Insert code here }

    // Ԥ����һ�������Ժ����opCode ��������opCode ��󷵻�һ��ֵ
    // �ú���������һ����Ӳ����Դ����Ч���н���һ����BuildAsOpCode��Ȼ������SaveToStream��opcode�Զ����Ʒ�ʽ���棬ʹ��ʱ��LoadOpFromStream����
    DoStatus('Value:' + VarToStr(EvaluateExpressionValue(TTextParsing, '(1+1)*2/3.14', nil)));
    DoStatus('');

    // ���ĺ��������ı����ʽ�����ɷ��ű��ʽ
    // ����˼·������˫ԭ�ӻ����������ϻ��ƽ��������ַ��ͷ��ţ�����������ԭ�ӵ� ���� ������ǰ �ַ��ں� ��һ��������������е�ԭ��1���ڶ���������ַ���ǰ���������ٺ����ǵڶ���ԭ��2����������ศ���
    // �˺������Ӷ�ƫ�ߣ���ѭ����+ѧ������д���޵ݹ�Ԫ�أ��Ҹ�Ч����
    // zExpression ���в���ĵ�һ�����ǵõ�һ�׷��ű��Ӷ�Ϊ��һ���߼�����������׼��
    // TextEngClass ����ѡ����ͨ�ı����棬pascal�ı����棬c/c++�ı����棬����ҪӰ������ַ����ı��ʽ��c�ı�ʾ��"��ʾ�ַ�����pascal���ʽ��'��ʾ�ַ���
    // uName ��Ϊ�ϲ������׼���ģ���Ԫ˵��������unit name; include name; ����ʱ����֪���ĸ�ԭ�ļ������ڱ���Ԥ����ʱ���ͱ���
    // ExpressionText �Ǳ��ʽ���ı�����
    // OnGetValue �������˳����ͺ���ʱ��������ֵ�Դ��¼���ȡ
    // ���أ����ű��ʽ��TSymbolExpression��
    sym1 := ParseTextExpressionAsSymbol(TTextParsing, '', '(1+1)*2/3.14', nil);
    sym1.PrintDebug(True);

    // zExpression �ĺ����߼����������ڷ�������Ԥ��������Ժ����²𿪱��ʽ���ݽṹ�������ؽ�һ�������������Ͻ�TSymbolExpression������˳�򣬸ò���������
    // RebuildAllSymbol����ֱ�Ӵ�����ɵڶ����͵�����
    sym2 := RebuildAllSymbol(sym1);
    sym2.PrintDebug(True);

    // zExpression �ĺ����߼����Ĳ�������RebuildAllSymbol����Ͻ�TSymbolExpression����˳�򣬴�������ԭ�ӻ�ִ��
    // ����ԭ�ӻ�ִ�е�ʵ����ο�opCode����
    op := BuildAsOpCode(sym2, '', 0);
    if op <> nil then
      begin
        DoStatus('Value:' + VarToStr(op.Execute));
        DoStatus('');
        FreeObject(op);
      end;

    FreeObject([sym1, sym2]);

    readln;
  except
    on E: Exception do
        Writeln(E.ClassName, ': ', E.Message);
  end;

end.
