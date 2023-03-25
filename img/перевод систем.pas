uses
  CRT;
 
const
  a: string[36] = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ';
var
  n, r: real;
  rez, s, s2, s3: string;
  t, cc, ind, cc2, k: integer;
 
procedure Del(var ss: string);
var
  i: integer;
begin
  ind := 0;  
  s2 := '';
  for i := 1 to length(ss) do  
    if ss[i] in [',', '.'] then 
    begin
      ind := i; 
      break
    end
    else    
      s2 := s2 + ss[i]; 
  s3 := '';
  if ind <> 0 then 
  begin
    delete(s, 1, ind); 
    s3 := ss; 
  end;
end;
 

function ToDec(var ss: string; cc: byte): integer;
var
  i, n, sum: integer;
begin
  sum := 0;
  n := length(ss); 
  for i := 1 to n do 
  begin
    dec(n); 
    sum := sum + round((pos(ss[i], a) - 1) * exp(ln(cc) * n)); 
  end;
  ToDec := sum;
end;
 
function Cel(d: real; c: integer): string;
var
  s: string;
  n2: integer;
begin
  n2 := round(int(d)); 
  s := '';   
  repeat
    s := ((a[n2 mod c + 1]) + s); 
    n2 := n2 div c;
  until (n2 = 0);
  Cel := s;
end;
function Drob(var d: real; t, c: integer): string;
var
  s: string;
  l2, k, n3: real;
  i, l: integer;
begin
  k := d - int(d);
  s := '';
  i := 0;
  if t <> 0 then  
  begin
    repeat
      l2 := k * c;
      k := frac(l2); 
      s := s + a[round(int(l2)) + 1];
      inc(i); 
    until i = t;
  end
  else  
   s := '0';
  Drob := s;
end;
 
function drob2(ss: string; c: integer): real;
var
  i: integer;
  sum: real;
begin
  for i := 1 to length(ss) do 
    sum := sum + (pos(ss[i], a) - 1) * exp(ln(c) * -i); 
  drob2 := sum;
end;
 
begin
  ClrScr;
  repeat
    write('система исчисления: ');
    readln(cc2)
  until cc2 in [2..36]; 
  write('в какую перевести: ');
  readln(cc);
  if cc2 = 10 then 
  begin
    write('ведите число в ', cc2, ':');
    readln(n);

    if ((n - round(int(n))) = 0) then 
      rez := Cel(n, cc)
    else     
      rez := Cel(n, cc) + ',' + Drob(n, t, cc);
  end
  else 
  begin
    write('Введите число в ', cc2, '-й СС: ');
    readln(s);
    Del(s); 
    if ind = 0 then
      rez := Cel(ToDec(s2, cc2), cc) 
    else
    begin
      r := drob2(s3, cc2);
      rez := Cel(ToDec(s2, cc2), cc) + ',' + drob(r, length(s3), cc); 
    end;
  end;
  write(rez); 
  readkey
end.

