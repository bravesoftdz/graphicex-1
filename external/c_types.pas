// Unit defining some types often used in C to make conversion easier
// Jacob Boerema, 2015.

unit C_Types;

{$IFDEF FPC}
  {$mode delphi}
{$ELSE}
  {$IFDEF CPUX64}
    {$DEFINE CPU64}
  {$ENDIF}
{$ENDIF}

interface

uses
  Classes, SysUtils;

type
  // For compatibility with older Delphi versions
  {$IF NOT Declared(NativeInt)}
  NativeInt = Integer;
  {$IFEND}
  {$IF NOT Declared(NativeUInt)}
  NativeUInt = Cardinal;
  {$IFEND}
  {$IF NOT Declared(UInt64)}
  UInt64 = Int64;
  {$IFEND}
  {$IF NOT Declared(PUInt64)}
  // Fpc has UInt64 but not PUint64 so handle this separately from UInt64
  PUint64 = ^Uint64;
  {$IFEND}


  // C specific
  {$IF Defined(CPU64) OR Defined(CPUX64)}
  size_t = NativeUInt;
  {$ELSE}
  size_t = Cardinal;
  {$IFEND}
  Psize_t = ^size_t;

  float = Single;
  pfloat = ^float;



implementation

end.

