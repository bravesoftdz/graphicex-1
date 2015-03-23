program DU_graphicex_test;
{
  Delphi DUnit Test Project
  -------------------------

  Testing Suite for the GraphicEx units.
}


{$IFNDEF FPC}
{$IFNDEF FASTMM}
  !!!Alert. "FASTMM" required in project conditionals!
{$ENDIF}
{$ENDIF}

uses
  {$IFNDEF FPC}
  FastMM4,
  D6Support,                           // Ignore known memory leaks
  {$ELSE}
  Forms, Interfaces,
  fpcunittestrunner,
  {$ENDIF}
  GUITestRunner,
  DU_graphicex_TestFramework,          // Test unit GraphicEx
  DU_GraphicColor_Tests;               // Test unit GraphicColor

{$R *.RES}

begin
  {$IFNDEF FPC}
  GUITestRunner.RunRegisteredTests;
  {$ELSE}
  Application.Initialize;
  Application.CreateForm(TGuiTestRunner, TestRunner);
  Application.Run;
  {$ENDIF}
end.
