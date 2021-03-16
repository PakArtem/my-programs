function [str] = com14(cm)
%Str5, Str6, Str7, Str9, Str10, Str11, Str12, Str13, Str14, Str15, Str16, Str17, Str18
%Настройки
fwrite(cm,14); %отправка команды
pause(0.1);
bts=get(cm,'BytesAvailable');
if bts==0
disp('0 байтов')
else
p = fread(cm,bts,'uint8');

str=cell(13,1);

for i=1:bts-1
c1=p(bts-(i-1));
c2=p(bts-i);

% Различная иформация 
if c1==18 && c2==255 
  a1 = p(bts-(i-3)); 
  cc1='Буферный усилитель отключен';
  cc2='Отключена автоматическая колибровка';
  cc3='Отключены АЦП3,АЦП4';
  cc4='Параметры не по умолчанию';
  cc5='Не максимальная тактовая частота';
  cc6='Отключено питание узлу синхонизации';
  for o=0:5
  oo=bitshift(1,o);
  c = bitand(a1,oo);
  switch c
      case 1
      cc1='Задействован буферный усилитель';
      case 2
      cc2='Включена автоматическая колибровка';
      case 4
      cc3='Включены АЦП3, АЦП4';
      case 8
      cc4='Параметры стоят по умолчанию';
      case 16
      cc5='Установлена максимальная токтовая частота микроконтроллера';
      case 32
      cc6='Подано питание узлу синхронизации';
  end    
  end
end 

% Значение высокого напряжения
if c1==19 && c2==255 
  a1 = p(bts-(i-2));
  a2 = p(bts-(i-3));
% Преобразования байтов в число 
  x = a1*256+a2;
  V1 = ceil(x/65535*1030);
end

% Приращение высокого напряжения
if c1==20 && c2==255 
  a1 = p(bts-(i-2));
  a2 = p(bts-(i-3));
% Преобразования байтов в число 
  x = a1*256+a2;
  V2 = ceil(x/65535*1030);
end

% Время ожидания 
if c1==21 && c2==255 
  b = p(bts-(i-2));
  bc = p(bts-(i-3));
end

% Значение скважности
if c1==23 && c2==255 
  a1 = p(bts-(i-2));
  a2 = p(bts-(i-3));
% Преобразования байтов в число 
  x = a1*256+a2;
  V5 = ceil(x/65535*1030);
end

% MAC
if c1==24 && c2==255 
  mac1 = p(bts-(i-2));
  mac2 = p(bts-(i-3));
  mac3 = p(bts-(i-6));
  mac4 = p(bts-(i-7));
  mac5 = p(bts-(i-10));
  mac6 = p(bts-(i-11));
end

% IP
if c1==27 && c2==255 
  ip1 = p(bts-(i-2));
  ip2 = p(bts-(i-3));
  ip3 = p(bts-(i-6));
  ip4 = p(bts-(i-7));
end

% MASK
if c1==29 && c2==255 
  mask1 = p(bts-(i-2));
  mask2 = p(bts-(i-3));
  mask3 = p(bts-(i-6));
  mask4 = p(bts-(i-7));
end

end

s5='Значение высокого напряжения %d';
str{1,1} = sprintf (s5, V1);

s6='Приращение высокого напряжения %d';
str{2,1} = sprintf (s6, V2);

s7='Интервал до перезагрузки прибора %d, время ожидания импульса синхронизации %d';
str{3,1} = sprintf (s7, b, bc);

s9='Значение скважности %d';
str{4,1} = sprintf (s9, V5);

s10='MAC %d.%d.%d.%d.%d.%d';
str{5,1} = sprintf (s10, mac1, mac2, mac3, mac4, mac5, mac6);

s11='IP %d.%d.%d.%d.%d.%d';
str{6,1} = sprintf (s11, ip1, ip2, ip3, ip4);

s12='MASK %d.%d.%d.%d.%d.%d';
str{7,1} = sprintf (s12, mask1, mask2, mask3, mask4);

str{8,1} = sprintf (cc1);
str{9,1} = sprintf (cc2);
str{10,1} = sprintf (cc3);
str{11,1} = sprintf (cc4);
str{12,1} = sprintf (cc5);
str{13,1} = sprintf (cc6);

end
