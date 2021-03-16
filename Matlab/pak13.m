function pak13(pop, a1, a2, tbk, tbl, ch1, ch2, ch3)
% команда 255 отправляет фрагмент данных

% Этот if нужен чтобы обнулить шумы в случае если не сделали их подсчет 
% if isempty(mn1)
%     clear mn1
%  mn1=0;  
%  mn2=0;
% end

if isempty(ch1)
ch1=0;
end

if isempty(ch2)
ch2=0;
end

if isempty(ch3)
ch3=0;
end



pp=300; % Количество точек на графике
l1=0:pp-1;
ms1k=zeros(pp,1); 
ms2k=zeros(pp,1);
ms3k=zeros(pp,1);
ms4k=zeros(pp,1);

ms1l=zeros(pp,1); 
ms2l=zeros(pp,1);
ms3l=zeros(pp,1);
ms4l=zeros(pp,1);

i=0;

tic;
while i<pop
pause(0.05);

% Отправка команды
fwrite(tbk,255);
fwrite(tbl,255);
% Определение количества байтов 
btsk=get(tbk, 'BytesAvailable'); 
btsl=get(tbl, 'BytesAvailable');

if ((btsk~=0)&&(ch1==1))

ck=uint32(fread(tbk, btsk/4, 'uint32')); 

for iz=1:btsk/4
% Частота дискритизации 
facpk(iz)=bitand(bitshift(ck(iz),-24),hex2dec('f'));
nacpk(iz)=bitshift(ck(iz),-30);
end

yk=0; 
m1k=0;
m2k=0;
m3k=0;
m4k=0;
dat.acp1k = [ ];
dat.acp2k = [ ];
dat.acp3k = [ ];
dat.acp4k = [ ];  

% Сортировка 
 while yk<btsk/4
 yk=yk+1;    
   switch nacpk(yk)
       case 0
        m1k=m1k+1;
        dat.acp1k(m1k)=bitand(ck(yk),hex2dec('ffffff')); 
       case 1
        m2k=m2k+1;
        dat.acp2k(m2k)=bitand(ck(yk),hex2dec('ffffff'));
       case 2
        m3k=m3k+1;
        dat.acp3k(m3k)=bitand(ck(yk),hex2dec('ffffff'));
       case 3
        m4k=m4k+1;
        dat.acp4k(m4k)=bitand(ck(yk),hex2dec('ffffff'));    
   end    
 end
 
% Графики
ms1k=circshift(ms1k,m1k);
ms2k=circshift(ms2k,m2k);
ms3k=circshift(ms3k,m3k); 
ms4k=circshift(ms4k,m4k); 
 
for pk=1:m1k         
xk=m1k+1-pk;   
% Токи      
if   bitand(dat.acp1k(xk),hex2dec('800000'))==0
ms1k(xk)=double(dat.acp1k(xk)/2^23/10^9*10^15); 
else    
ms1k(xk)=-double((8388607-(dat.acp1k(xk)-8388608)))/2^23/10^9*10^15 ;
end

if   bitand(dat.acp2k(xk),hex2dec('800000'))==0
ms2k(xk)=double(dat.acp2k(xk)/2^23/10^9*10^15) ;  
else 
ms2k(xk)=-double((8388607-(dat.acp2k(xk)-8388608)))/2^23/10^9*10^15 ;
end

plot(a1,l1,ms2k','b',l1,ms1k','r');
end
else
disp(1)  
end

%%
if ((btsl~=0)&&(ch2==1))   
cl=uint32(fread(tbl, btsl/4, 'uint32'));

for iz=1:btsl/4
% Частота дискритизации 
facpl(iz)=bitand(bitshift(cl(iz),-24),hex2dec('f'));
nacpl(iz)=bitshift(cl(iz),-30);
end

yl=0; 
m1l=0;
m2l=0;
m3l=0;
m4l=0;
dat.acp1l = [ ];
dat.acp2l = [ ];
dat.acp3l = [ ];
dat.acp4l = [ ];

 % Сортировка 
 while yl<btsl/4
 yl=yl+1;    
   switch nacpl(yl)
       case 0
        m1l=m1l+1;
        dat.acp1l(m1l)=bitand(cl(yl),hex2dec('ffffff')); 
       case 1
        m2l=m2l+1;
        dat.acp2l(m2l)=bitand(cl(yl),hex2dec('ffffff'));
       case 2
        m3l=m3l+1;
        dat.acp3l(m3l)=bitand(cl(yl),hex2dec('ffffff'));
       case 3
        m4l=m4l+1;
        dat.acp4l(m4l)=bitand(cl(yl),hex2dec('ffffff'));    
   end

 end
 
 % Графики
 ms1l=circshift(ms1l,m1l);
 ms2l=circshift(ms2l,m2l);
 ms3l=circshift(ms3l,m3l); 
 ms4l=circshift(ms4l,m4l); 
 
 for pl=1:m1l        
xl=m1l+1-pl;   
% Токи      
if   bitand(dat.acp1l(xl),hex2dec('800000'))==0
ms1l(xl)=double(dat.acp1l(xl)/2^23/10^9*10^15); 
else    
ms1l(xl)=-double((8388607-(dat.acp1l(xl)-8388608)))/2^23/10^9*10^15 ;
end

if   bitand(dat.acp2l(xl),hex2dec('800000'))==0
ms2l(xl)=double(dat.acp2l(xl)/2^23/10^9*10^15) ;  
else 
ms2l(xl)=-double((8388607-(dat.acp2l(xl)-8388608)))/2^23/10^9*10^15 ;
end

plot(a2,l1,ms2l','b',l1,ms1l','r');
 end
else  
disp(2) 

end
i=toc;
end