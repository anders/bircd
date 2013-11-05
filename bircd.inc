{$ifndef win32}
  {$define noicon}
  {$define nosignal}
  {$define nodnsapi}
  {$define nowinnt}
{$endif}


{$ifdef win32}
  {$ifdef console}
  {$apptype console}
  {$else}
  {$apptype gui}
  {$endif}
{$endif}

