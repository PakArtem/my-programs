%% на всякий случай 

% Открывает и закрывакет соединение с прибором 1
function pushbuttonop_Callback(hObject, eventdata, handles)
global tbk col1

if col1==1
% fclose(tbk);
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Разъединение с прибором 1.');
set(handles.pushbuttonop,'BackgroundColor',[1 0 0]);
col1=-1;
else
% [tbk]=bondbk();
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Установлено соединение с прибором 1.');    
set(handles.pushbuttonop,'BackgroundColor',[0 1 0]); 
col1=1;
end

% Открывает и закрывакет соединение с прибором 2
function pushbuttonopen2_Callback(hObject, eventdata, handles)
global tbl col2

if col2==1
% fclose(tbl);
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Разъединение с прибором 2.');
set(handles.pushbuttonopen2,'BackgroundColor',[1 0 0]);
col2=-1;
else
% [tbl]=bondbl();;
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Установлено соединение с прибором 2.');    
set(handles.pushbuttonopen2,'BackgroundColor',[0 1 0]); 
col2=1;
end

% Открывает и закрывакет соединение с прибором 3
function pushbuttonopen3_Callback(hObject, eventdata, handles)
global tbg col3

if col3==1
% fclose(tbg);
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Разъединение с прибором 3.');
set(handles.pushbuttonopen3,'BackgroundColor',[1 0 0]);
col3=-1;
else
% [tbg]=bondbl();;
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Установлено соединение с прибором 3.');    
set(handles.pushbuttonopen3,'BackgroundColor',[0 1 0]); 
col3=1;
end

% Строим график 1 камеры 
function pushbuttoncamera1_Callback(hObject, eventdata, handles)
global ch1

if ch1==1
ch1=-1;
set(handles.pushbuttoncamera1,'BackgroundColor',[1 0 0]);
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 1 прибора отключен.');
else
ch1=1;
set(handles.pushbuttoncamera1,'BackgroundColor',[0 1 0]); 
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 1 прибора включен.');
end

% Строим график 2 камеры 
function pushbuttoncamera2_Callback(hObject, eventdata, handles)
global ch2

if ch2==1
ch2=-1;
set(handles.pushbuttoncamera2,'BackgroundColor',[1 0 0]);
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 2 прибора отключен.');
else
ch2=1;
set(handles.pushbuttoncamera2,'BackgroundColor',[0 1 0]); 
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 2 прибора включен.');
end

% Строим график 3 камеры 
function pushbuttoncamera3_Callback(hObject, eventdata, handles)
global ch3

if ch3==1
ch3=-1;
set(handles.pushbuttoncamera3,'BackgroundColor',[1 0 0]);
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 3 прибора отклювен.');
else
ch3=1;
set(handles.pushbuttoncamera3,'BackgroundColor',[0 1 0]); 
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 3 прибора включен.');
end

% Включение/отключение АЦП3, АЦП4
function com05_Callback(hObject, eventdata, handles)
global cm 
a=get(hObject,'Value');
if a==1
   o=1;
   disp(o)
else
   o=0;
end
 com05(cm,o)
 
 % % Включение/отключение АЦП3, АЦП4
function togglebutton23_Callback(hObject, eventdata, handles)
global cm tbk tbl tbg C
a=get(hObject,'Value');
if ((a==1) && (cm==tbk))
o=1;
% com05(cm,o)
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','Включены АЦП3, АЦП4');
C(1,2)={true};
set(handles.uitable4, 'data', C);
else
o=0;
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','отключены АЦП3, АЦП4');
% com05(cm,o)
end
if ((a==1) && (cm==tbl))
o=1;
% com05(cm,o)
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','Включены АЦП3, АЦП4');
else
o=0;
set(handles.togglebutton23,'BackgroundColor',[1 0 0]);
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','отключены АЦП3, АЦП4');
% com05(cm,o)
end
if ((a==1) && (cm==tbg))
o=1;
% com05(cm,o)
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','Включены АЦП3, АЦП4');
else
o=0;
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','отключены АЦП3, АЦП4');
% com05(cm,o)
end
 
% Питание узла синхронизация
function pushbutton27_Callback(hObject, eventdata, handles)
global cm
str=char([15,1]);
fwrite(cm,str); 


% a1=subplot(2,1,1,'Parent',handles.uipanel5); 
% a2=subplot(2,1,2,'Parent',handles.uipanel5); 
% a3=subplot(1,2,2,'Parent',handles.uipanel5); 
% a4=subplot(3,2,5,'Parent',handles.uipanel5); 

% set(a1,'position', [0.025 0.05 0.87 0.93]) % Токи [0.025 0.55 0.87 0.43]
% % set(a2,'position', [0.025 0.3 0.87 0.20])  % Напряжение
% set(a2,'position', [0.92 0.05 0.065 0.93]) % Смещение
% % set(a4,'position', [0.025 0.05 0.87 0.20]) % Температура

% a1=axes(handles.axes1);
% a2=axes(handles.axes2);
% % com255bl(pop, a2,tbl, mn1, mn2);
% % com255bk(pop, a1,tbk, mn1, mn2);

% % set(handles.editsm,'String',num2str(sg2)); 
% % set(handles.editins,'String',num2str(sk2));
% % 
% % set(handles.text4,'String','sum 1');
% % set(handles.text5,'String','sum 2');


%   xx=ms1(1);
%   yy=ms2(1);
% Коэффициенты, надо подумать над величиной

% Смещение и интенсивность 
% sm = k1*(xx-yy)/(xx+yy);
% ins = k2*(xx+yy);


% set(handles.editsm,'String',num2str(mn1)); 
% set(handles.editins,'String',num2str(mn2)); 
% 
% set(handles.editsm,'String',num2str(mn1)); 
% set(handles.editins,'String',num2str(mn2));
% 
% set(handles.text4,'String','mean 1');
% set(handles.text5,'String','mean 2');