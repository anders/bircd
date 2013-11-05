
(*
 *  beware IRC services, mkpasswd.pas
 *  Copyright (C) 2002 Bas Steendijk
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 *)

{$g+,n-,e-,r-,s-,q-,d-,l-,y-,x+}

{note this is turbo pascal 7/freepascal code, not delphi}

program mkpasswd;
uses 
  {$ifdef fpc}
    crt,
    {$ifdef unix}
      {$ifdef VER1_0}
        linux,
      {$else}
        baseunix,unix,unixutil,sockets,
      {$endif}
      lcoreselect,unitfork,
    {$endif}
  {$endif}
 
  passcryp;

{$ifdef unix}
  {$i unixstuff.inc}
  procedure write(s:string);
  begin
    fdwrite(1,s[1],length(s));   
  end;
  procedure writeln(s:string);
  begin
    write(s+#13#10);  
  end;
{$endif}

{$ifndef fpc}
  function readkey:string;assembler;
  asm
    mov     ah,0h
    int     16h
    les     di,@result
    mov     dl,1
    or      al,al
    jnz     @nee
    inc     dl
  @nee:
    mov     es:[di],dl
    mov     es:[di+1],ax
  end;
{$endif}

var
  s:string;
  c:string;
begin
  randomize;
  writeln('');
  write('Enter password: ');
  s := '';
  repeat
    c := readkey;
    if (c >= #32) and (c < #128) then s := s + c;
  until c = #13;
  writeln('');
  writeln('');
  write(passnewcrypt(s));
  readkey;
  writeln('');
end.
