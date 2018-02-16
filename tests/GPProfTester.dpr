program GPProfTester;


{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  System.Diagnostics,
  testUnit in 'testUnit.pas',
  testThreads in 'testThreads.pas',
  testMultiDefines in 'testMultiDefines.pas';

const ITERATIONS = 1000000;
var I : integer;
    LWatch : TStopwatch;
begin
  try
    LWatch := TStopwatch.StartNew;
    for i := 0 to ITERATIONS do
      TestProcedure;
    for i := 0 to ITERATIONS do
      TestFunction;
    for i := 0 to ITERATIONS do
      TestFunctionNestedType;
    TestThread();
    Writeln('Needed '+LWatch.ElapsedMilliseconds.ToString + ' millis');
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.
