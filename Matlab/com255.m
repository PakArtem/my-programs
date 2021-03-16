function [s1,s2]=com255(pop, a1, a3, tbk, mn1, mn2)
% команда 255 отправляет фрагмент данных
tic
% Этот if нужен чтобы обнулить шумы в случае если не сделали их подсчет 
if isempty(mn1)
    clear mn1
 mn1=0;  
 mn2=0;
end

% Создание файла и запись в него токов
r=fix(clock);
clk='%d-%d-%d %d-%d-%d';
tm=sprintf(clk,  r(1), r(2), r(3), r(4), r(5), r(6));
namefile=[num2str(tm),'.txt'];
fid=fopen(namefile,'w'); 

pp=300; % Количество точек на графике
l1=0:pp-1;
ms1=zeros(pp,1); 
ms2=zeros(pp,1);
ms3=zeros(pp,1);
ms4=zeros(pp,1);
i=0;

flm=0;
mm1=[];
mm2=[];

while i<pop
i=i+1; 
pause(0.05);
fwrite(tbk,255);

bts=get(tbk, 'BytesAvailable');

if bts==0
   
end

if bts ~=0
c=uint32(fread(tbk, bts/4, 'uint32')); 
for iz=1:bts/4
% Частота дискритизации 
facp(iz)=bitand(bitshift(c(iz),-24),hex2dec('f'));
nacp(iz)=bitshift(c(iz),-30);
end
y=0; 
m1=0;
m2=0;
m3=0;
m4=0;
dat.acp1 = [ ];
dat.acp2 = [ ];
dat.acp3 = [ ];
dat.acp4 = [ ];

% Сортировка 
 while y<bts/4
 y=y+1;    
   switch nacp(y)
       case 0
        m1=m1+1;
        dat.acp1(m1)=bitand(c(y),hex2dec('ffffff')); 
       case 1
        m2=m2+1;
        dat.acp2(m2)=bitand(c(y),hex2dec('ffffff'));
       case 2
        m3=m3+1;
        dat.acp3(m3)=bitand(c(y),hex2dec('ffffff'));
       case 3
        m4=m4+1;
        dat.acp4(m4)=bitand(c(y),hex2dec('ffffff'));    
   end    
 end
 
% Графики
 ms1=circshift(ms1,m1);
 ms2=circshift(ms2,m2);
 ms3=circshift(ms3,m3); 
 ms4=circshift(ms4,m4); 
 
 for p=1:m1          % x=1:m1  
x=m1+1-p;   
flm=flm+1; % Флаг для интегрирования
R=10^-6;
% Токи      
if   bitand(dat.acp1(x),hex2dec('800000'))==0
ms1(x)=double(dat.acp1(x)/2^23/10^9*10^15) -mn1; 
% ms1(x)=double(dat.acp1(x)/(2^23-1)*(10^-6)/R) -mn1;  
else    
% ms1(x)=(-double(bitxor(dat.acp1(x),hex2dec('7FFFFF'))))/2^23/10^9*10^15 -mn1;

ms1(x)=-double((8388607-(dat.acp1(x)-8388608)))/2^23/10^9*10^15 -mn1;

% ms1(x)=-double(bitxor(dat.acp1(x),8388607)/(2^23-1)*(10^-6)/R) -mn1;
end

if   bitand(dat.acp2(x),hex2dec('800000'))==0
ms2(x)=double(dat.acp2(x)/2^23/10^9*10^15) -mn2;  
% ms2(x)=double(dat.acp2(x)/(2^23-1)*(10^-6)/R) -mn2;  
else 
% ms2(x)=(-double(bitxor(dat.acp2(x),8388607)))/2^23/10^9*10^15 -mn2;

ms2(x)=-double((8388607-(dat.acp2(x)-8388608)))/2^23/10^9*10^15 -mn2;

% ms2(x)=-double(bitxor(dat.acp2(x),8388607)/(2^23-1)*(10^-6)/R) -mn2;
end

% Текст 
fprintf(fid, '%d || %d\r\n', ms2(x),ms1(x));

% fid=fopen(namefile,'r');
% B=fscanf(fid, '%d  %d');
% disp(B)

% Запись токов в массив
mm1(flm,1)=ms1(x);
mm2(flm,1)=ms2(x);

  xx=ms1(1);
  yy=ms2(1);
% Коэффициенты, надо подумать над величиной
k1 = 1;
k2 = 1;
% Смещение и интенсивность 
sm = k1*(xx-yy)/(xx+yy);
ins = k2*(xx+yy);

plot(a3,[-1 1], [sm sm], 'LineWidth',2, 'Color','g');
axis([-1 1 -4 4]) 
text(-0.6, -3.5, ['' num2str(sm) ''],'HorizontalAlignment','left')
text(-0.6, -3.1, ['' num2str(ins) ''],'HorizontalAlignment','left')


plot(a1,l1,ms2','b',l1,ms1','r');
% plot(a1,l1,ms2','r');
tt=toc;
text(-0.5, 3.5, ['' num2str(tt) ''])

% text(60, 8*10^6, 'текст')
 end

for z=1:m3
    
% Напаряжение
ms3(z)=dat.acp3(z);
if dat.acp3(z)==8388608
  ms3(z)=0;  
end
if dat.acp3(z)>8388608
  ms3(z)=2.56*dat.acp3(z)/2^24;  
end
if dat.acp3(z)<8388608
 ms3(z)=-2.56*dat.acp3(z)/2^23;  
end

% Температура
zz=bitand(dat.acp4(z),hex2dec('FF0000'));
ms4(z)=bitshift(zz,-16)-128;
% plot(a4,l1,ms4','r');
% plot(a2,l1,ms3','b');
end
end

end

% Интегрирование 
s1=sum(mm1);
s2=sum(mm2);


