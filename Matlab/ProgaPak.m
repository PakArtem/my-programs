function varargout = ProgaPak(varargin)
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ProgaPak_OpeningFcn, ...
                   'gui_OutputFcn',  @ProgaPak_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function ProgaPak_OpeningFcn(hObject, eventdata, handles, varargin)
handles.output = hObject;
guidata(hObject, handles);

% --- Outputs from this function are returned to the command line.
function varargout = ProgaPak_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

% Настройки
function com14_Callback(hObject, eventdata, handles)
global cm

[str] = com14(cm);
set(handles.listboxINF,'String',[])

for i=1:13
lst = get(handles.listboxINF, 'String');
lst{end + 1} = str{i,1};
% размещение текста
set(handles.listboxINF,'String',lst)
% задание цвета текста
set(handles.listboxINF,'ForegroundColor','k')
% задание размера шрифта
set(handles.listboxINF,'FontSize',14)
end
axes(handles.axes4);
smil=imread('setting.png');
imshow(smil)
set(handles.bluee,'String','Настройки прибора.');

% Отправка фрагмента данных
function com255_Callback(hObject, eventdata, handles)
global tbk tbl tbg mnk1 mnk2 mnl1 mnl2 mng1 mng2 ch1 ch2 ch3 ch4 en1 en2 en3 n

axes(handles.axes4);
smil=imread('current.png');
imshow(smil)

set(handles.bluee,'String','Измеряю токи. Жди.');

pop=get(handles.txtcom255,'string');
pop=str2double(pop);

% Эти if нужны чтобы обнулить переменные если они пустые
if isempty(ch1)
ch1=-1;
end

if isempty(ch2)
ch2=-1;
end

if isempty(ch3)
ch3=-1;
end

% Куча if для графиков, для удобного их расположения
% Условие для 1 тока
if((ch1==1 && ch2~=1 && ch3~=1)||(ch1~=1 && ch2==1 && ch3~=1)||(ch1~=1 && ch2~=1 && ch3==1))    
 if (ch1==1 && ch2~=1 && ch3~=1)
 a1=subplot(4,1,1,'Parent',handles.uipanel5);
 a2=0;
 a3=0;
set(a1,'position', [0.04 0.05 0.94 0.90]) 
 end

 if (ch1~=1 && ch2==1 && ch3~=1)
 a1=0;
 a2=subplot(4,1,1,'Parent',handles.uipanel5); 
 a3=0;
set(a2,'position', [0.04 0.05 0.94 0.90])
 end

 if (ch1~=1 && ch2~=1 && ch3==1)
 a1=0;
 a2=0;
 a3=subplot(4,1,1,'Parent',handles.uipanel5); 
set(a3,'position', [0.04 0.05 0.94 0.90]) 
 end
end
% Условие для 2 токов 
if((ch1==1 && ch2==1 && ch3~=1)||(ch1==1 && ch2~=1 && ch3==1)||(ch1~=1 && ch2==1 && ch3==1))
    
if (ch1==1 && ch2==1 && ch3~=1)
 a1=subplot(4,1,1,'Parent',handles.uipanel5);
 a2=subplot(4,1,2,'Parent',handles.uipanel5);
 a3=0;
 set(a1,'position', [0.025 0.53 0.95 0.43])
 set(a2,'position', [0.025 0.05 0.95 0.43])
end

if (ch1==1 && ch2~=1 && ch3==1)
 a1=subplot(4,1,1,'Parent',handles.uipanel5);
 a2=0;
 a3=subplot(4,1,2,'Parent',handles.uipanel5);
 set(a1,'position', [0.025 0.53 0.95 0.43])
 set(a3,'position', [0.025 0.05 0.95 0.43]) 
end

if (ch1~=1 && ch2==1 && ch3==1)
 a1=subplot(4,1,1,'Parent',handles.uipanel5);
 a2=subplot(4,1,2,'Parent',handles.uipanel5);   
 a3=0;
 set(a2,'position', [0.025 0.53 0.95 0.43])
 set(a3,'position', [0.025 0.05 0.95 0.43]) 
end

end

if ch4==1
a4=subplot(4,1,4,'Parent',handles.uipanel5);
set(a4,'position', [0.025 0.03 0.95 0.2]) 
else
a4=0;
end

% Условие для 3 токов 
if((ch1==1)&&(ch2==1)&&(ch3==1))
a1=subplot(4,1,1,'Parent',handles.uipanel5);
a2=subplot(4,1,2,'Parent',handles.uipanel5);
a3=subplot(4,1,3,'Parent',handles.uipanel5);
set(a1,'position', [0.025 0.77 0.95 0.2])
set(a2,'position', [0.025 0.53 0.95 0.2])
set(a3,'position', [0.025 0.28 0.95 0.2]) 
end

[str]=com255255(pop, a1, a2, a3, a4, tbk, tbl, tbg, mnk1, mnk2, mnl1, mnl2, mng1, mng2, ch1, ch2, ch3, ch4, en1, en2, en3, n);
set(handles.listboxINF,'String',[])

for i=1:6
lst = get(handles.listboxINF, 'String');
lst{end + 1} = str{i,1};
% размещение текста
set(handles.listboxINF,'String',lst)
% задание цвета текста
set(handles.listboxINF,'ForegroundColor','k')
% задание размера шрифта
set(handles.listboxINF,'FontSize',14)
end

set(handles.bluee,'String','Закончил!');

% Шумы
function mean_Callback(hObject, eventdata, handles)
global tbk tbl tbg ch1 ch2 ch3 mnk1 mnk2 mnl1 mnl2 mng1 mng2 en1 en2 en3

axes(handles.axes4);
smil=imread('current.png');
imshow(smil)
set(handles.bluee,'String','Вычисляю средний ток. Жди.');

pop=get(handles.meantxt,'string');
pop=str2double(pop);

% Эти if нужны чтобы обнулить переменные если они пустые
if isempty(ch1)
ch1=-1;
end

if isempty(ch2)
ch2=-1;
end

if isempty(ch3)
ch3=-1;
end

% Куча if для графиков, для удобного их расположения
% Условие для 1 тока
if((ch1==1 && ch2~=1 && ch3~=1)||(ch1~=1 && ch2==1 && ch3~=1)||(ch1~=1 && ch2~=1 && ch3==1))    
 if (ch1==1 && ch2~=1 && ch3~=1)
 a1=subplot(1,1,1,'Parent',handles.uipanel5);
 a2=0;
 a3=0;
set(a1,'position', [0.025 0.05 0.95 0.93])  
 end

 if (ch1~=1 && ch2==1 && ch3~=1)
 a1=0;
 a2=subplot(1,1,1,'Parent',handles.uipanel5); 
 a3=0;
set(a2,'position', [0.025 0.05 0.95 0.93])
 end

 if (ch1~=1 && ch2~=1 && ch3==1)
 a1=0;
 a2=0;
 a3=subplot(1,1,1,'Parent',handles.uipanel5); 
set(a3,'position', [0.025 0.05 0.95 0.93]) 
 end
end
% Условие для 2 токов 
if((ch1==1 && ch2==1 && ch3~=1)||(ch1==1 && ch2~=1 && ch3==1)||(ch1~=1 && ch2==1 && ch3==1))
    
if (ch1==1 && ch2==1 && ch3~=1)
 a1=subplot(2,1,1,'Parent',handles.uipanel5);
 a2=subplot(2,1,2,'Parent',handles.uipanel5);
 a3=0;
 set(a1,'position', [0.025 0.55 0.95 0.43])
 set(a2,'position', [0.025 0.05 0.95 0.43])
end

if (ch1==1 && ch2~=1 && ch3==1)
 a1=subplot(2,1,1,'Parent',handles.uipanel5);
 a2=0;
 a3=subplot(2,1,2,'Parent',handles.uipanel5);
 set(a1,'position', [0.025 0.55 0.95 0.43])
 set(a3,'position', [0.025 0.05 0.95 0.43]) 
end

if (ch1~=1 && ch2==1 && ch3==1)
 a1=subplot(2,1,1,'Parent',handles.uipanel5);
 a2=subplot(2,1,2,'Parent',handles.uipanel5);   
 a3=0;
 set(a2,'position', [0.025 0.55 0.95 0.43])
 set(a3,'position', [0.025 0.05 0.95 0.43]) 
end

end

a4=subplot(1,1,1,'Parent',handles.uipanel22);
set(a4,'position', [0.025 0.05 0.95 0.93]) 

% Условие для 3 токов 
if((ch1==1)&&(ch2==1)&&(ch3==1))
a1=subplot(3,1,1,'Parent',handles.uipanel5);
a2=subplot(3,1,2,'Parent',handles.uipanel5);
a3=subplot(3,1,3,'Parent',handles.uipanel5);
set(a1,'position', [0.025 0.70 0.95 0.28])
set(a2,'position', [0.025 0.37 0.95 0.28])
set(a3,'position', [0.025 0.05 0.95 0.28]) 
end

[str,mnk1,mnk2,mnl1,mnl2,mng1,mng2]=darkcurrent(pop, a1, a2, a3, tbk, tbl, tbg, ch1, ch2, ch3, en1, en2, en3);

set(handles.listboxINF,'String',[])

for i=1:6
lst = get(handles.listboxINF, 'String');
lst{end + 1} = str{i,1};
% размещение текста
set(handles.listboxINF,'String',lst)
% задание цвета текста
set(handles.listboxINF,'ForegroundColor','k')
% задание размера шрифта
set(handles.listboxINF,'FontSize',14)
end

axes(handles.axes4);
smil=imread('current.png');
imshow(smil)

set(handles.bluee,'String','Закончил!');

function txtcom255_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtcom255_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Высокое напряжение
function com08_Callback(hObject, eventdata, handles)
global cm C con
V=get(handles.txtcom08,'string');
V=str2double(V);
com08(V,cm)

C{con,1}=V;
set(handles.uitable4, 'data', C);

axes(handles.axes4);
smil=imread('voltage.png');
imshow(smil)

set(handles.bluee,'String','Ты поменял напряжение. Не ударься током!');

function txtcom08_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function txtcom08_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Непрерывный режим передачи данных
function com24_Callback(hObject, eventdata, handles)
global tbl tbk ch1 ch2 ch3 mnk1 mnk2 mnl1 mnl2 sk1 sk2 sl1 sl2 

axes(handles.axes4);
smil=imread('current.png');
imshow(smil)

set(handles.bluee,'String','Измеряю токи. Жди.');

pop=get(handles.txtcom255,'string');
pop=str2double(pop);
a1=subplot(1,2,1,'Parent',handles.uipanel5); 
a2=subplot(2,2,2,'Parent',handles.uipanel5); 
% a3=subplot(1,2,2,'Parent',handles.uipanel5); 
% a4=subplot(3,2,5,'Parent',handles.uipanel5); 

set(a1,'position', [0.025 0.05 0.87 0.93]) % Токи [0.025 0.55 0.87 0.43]
set(a2,'position', [0.025 0.3 0.87 0.20])  % Напряжение
% set(a3,'position', [0.92 0.05 0.065 0.93]) % Смещение
% set(a4,'position', [0.025 0.05 0.87 0.20]) % Температура

% a1=axes(handles.axes1);
% a2=axes(handles.axes2);


set(handles.editsm,'String',num2str(s1)); 
set(handles.editins,'String',num2str(s2));

set(handles.text4,'String','sum 1');
set(handles.text5,'String','sum 2');

set(handles.bluee,'String','Закончил!');

% Остановка непрерывной передачи данных
function com23_Callback(hObject, eventdata, handles)

% --- Executes on selection change in listboxINF.
function listboxINF_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function listboxINF_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Частота дискретизации
function DISKRIZ_Callback(hObject, eventdata, handles)
global cm C con
contents = get(hObject,'Value');
switch contents
     case 1
    ds=0;
    dis=0;
     case 2
    ds=1;
    dis=2.5;
     case 3
    ds=2;
    dis=5;
     case 4
    ds=3;
    dis=10;
     case 5
    ds=4;
    dis=15;
     case 6
    ds=5;
    dis=25;
     case 7
    ds=6;
    dis=30;
     case 8
    ds=7;
    dis=50;
     case 9
    ds=8;
    dis=60;
     case 10
    ds=9;
    dis=100;
     case 11
    ds=10;
    dis=500;
     case 12
    ds=11;
    dis=1000;
     case 13
    ds=12;
    dis=2000;
     case 14
    ds=13;
    dis=3750;
     case 15
    ds=14;
    dis=7500;
end
C{con,3}=dis;
set(handles.uitable4, 'data', C);
com01(ds,cm)

% --- Executes during object creation, after setting all properties.
function DISKRIZ_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes during object creation, after setting all properties.
function editins_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function editsm_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function editsm_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function meantxt_Callback(hObject, eventdata, handles)

function meantxt_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Blue click me
function blue_Callback(hObject, eventdata, handles)
axes(handles.axes4);
smil=imread('hello.png');
imshow(smil)

set(handles.bluee,'String','Привет! Меня зовут Blue. Чтобы начать работу,         нажми (1 | 0), установи соединения с приборами. Если ты не знаешь для чего нужна кнопка. Напиши в чат и я подскажу тебе.');

% Диалог с Blue
function blue1_Callback(hObject, eventdata, handles)

% Диалог с Blue
function blue1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Написать Blue
function calblue_Callback(hObject, eventdata, handles)

men=get(handles.blue1,'string');

% [bl]=blue(men);
switch men
   case 'расскажи анекдот'    
   an=randint(1,1,[0,3]);
   
   if an==0
   axes(handles.axes4);
   smil=imread('joke.png');
   imshow(smil)
   s1='Колобок повесился.';
   bl = sprintf (s1);
   end
   
   if an==1
   axes(handles.axes4);
   smil=imread('sadness.png');
   imshow(smil)
   s1='Курю только после секса. Поэтому у меня здоровые лёгкие и печальные глаза.';
   bl = sprintf (s1);
   end
   
   if an==2
   axes(handles.axes4);
   smil=imread('finale.png');
   imshow(smil)
   s1='Хочу — слушаю жену, не хочу — лежу в травматологии.';
   bl = sprintf (s1);
   end
   
   if an==3
   axes(handles.axes4);
   smil=imread('orange.png');
   imshow(smil)
   s1='Близорукий пожарный три часа тушил рыжую женщину.';
   bl = sprintf (s1);
   end
   
   case 'кто тебя создал'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='Артем Пак.';
   bl = sprintf (s1);
   
   case 'Amplification range'   
   axes(handles.axes4);
   smil=imread('science.png');
   imshow(smil)
   
   s1='Диапазон усиления.';
   bl = sprintf (s1);
   
   case 'Data fragment'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='Отправляет фрагмент данных.';
   bl = sprintf (s1);
   
   case 'Mean'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='Вычисляет среднию величину шума.';
   bl = sprintf (s1);
   
   case 'U(B)'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='Меняет напряжение.';
   bl = sprintf (s1);
   
   case 'Sampling'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='Частота дискретизации АЦП.';
   bl = sprintf (s1);
   
   case 'Settings'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='Настройки прибора.';
   bl = sprintf (s1);
     
   case 'Camera 1'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='График для первой камеры.';
   bl = sprintf (s1);
   
   case 'Camera 2'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='График для второй камеры.';
   bl = sprintf (s1);
   
   case 'Camera 3'   
   axes(handles.axes4);
   smil=imread('pak.png');
   imshow(smil)
   
   s1='График для третьей камеры.';
   bl = sprintf (s1);
   
   otherwise 
   axes(handles.axes4);
   smil=imread('not.png');
   imshow(smil)
   
   s1='Я такое не знаю. Напиши что-нибудь другое.';
   bl = sprintf (s1);
end

set(handles.bluee,'String',bl);

% Диапазон усиления
function popupmenu5_Callback(hObject, eventdata, handles)
global cm con C
contents = get(hObject,'Value');
switch contents
     case 1
    o=0;
%     C(con,4)={'                       1 V/mA'};
    set(handles.uitable4, 'data', C);
     case 2
    o=1;  
%     C(con,4)={'                       1 V/nA'};
    set(handles.uitable4, 'data', C);
end
com22(cm,o)

% Диапазон усиления
function popupmenu5_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Cинхронизация
function pushbutton26_Callback(hObject, eventdata, handles)
global cm
str=char([16,0]);
fwrite(cm,str); 

% Выбор Камеры
function camera_Callback(hObject, eventdata, handles)
global cm tbl tbk tbg con 
con = get(hObject,'Value');
switch con
     case 1
    cm=tbk;
     case 2
    cm=tbl;
     case 3
    cm=tbg;     
end

% --- Executes during object creation, after setting all properties.
function camera_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Ввод ip
function editIP_Callback(hObject, eventdata, handles)

% Ввод ip
function editIP_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% IP
function ipcall_Callback(hObject, eventdata, handles)
global cm
pop=get(handles.editIP,'string');
pop=str2double(pop);
ip(cm,pop)

% % Открывает и закрывакет соединение с прибором 1
function togglebutton17_Callback(hObject, eventdata, handles)
global tbk 
a=get(hObject,'Value');
if a==1
[tbk]=bondbk();
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Установлено соединение с прибором 1.');    
set(handles.togglebutton17,'BackgroundColor',[0 1 0]); 
fwrite(tbk,255);
else
fclose(tbk);
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Разъединение с прибором 1.');
set(handles.togglebutton17,'BackgroundColor',[1 0 0]);
end

% % Открывает и закрывакет соединение с прибором 2
function togglebutton18_Callback(hObject, eventdata, handles)
global tbl 
a=get(hObject,'Value');
if a==1
[tbl]=bondbl();
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Установлено соединение с прибором 2.');    
set(handles.togglebutton18,'BackgroundColor',[0 1 0]); 
fwrite(tbl,255);
else
fclose(tbl);
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Разъединение с прибором 2.');
set(handles.togglebutton18,'BackgroundColor',[1 0 0]);
end

% % Открывает и закрывакет соединение с прибором 3
function togglebutton19_Callback(hObject, eventdata, handles)
global tbg
a=get(hObject,'Value');
if a==1
[tbg]=bondbg();
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Установлено соединение с прибором 3.');    
set(handles.togglebutton19,'BackgroundColor',[0 1 0]); 
fwrite(tbg,255);
else
fclose(tbg);
axes(handles.axes4);
smil=imread('happy.png');
imshow(smil)
set(handles.bluee,'String','Разъединение с прибором 3.');
set(handles.togglebutton19,'BackgroundColor',[1 0 0]);
end

% % Строим график 1 камеры 
function togglebutton20_Callback(hObject, eventdata, handles)
global ch1
a=get(hObject,'Value');
if a==1
ch1=1;
set(handles.togglebutton20,'BackgroundColor',[0 1 0]); 
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 1 прибора включен.');
else
ch1=-1;
set(handles.togglebutton20,'BackgroundColor',[1 0 0]);
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 1 прибора отключен.');
end

% % Строим график 2 камеры 
function togglebutton21_Callback(hObject, eventdata, handles)
global ch2 
a=get(hObject,'Value');
if a==1
ch2=1;
set(handles.togglebutton21,'BackgroundColor',[0 1 0]); 
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 2 прибора включен.');
else
ch2=-1;
set(handles.togglebutton21,'BackgroundColor',[1 0 0]);
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 2 прибора отключен.');
end

% % Строим график 3 камеры 
function togglebutton22_Callback(hObject, eventdata, handles)
global ch3
a=get(hObject,'Value');
if a==1
ch3=1;
set(handles.togglebutton22,'BackgroundColor',[0 1 0]); 
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 3 прибора включен.');
else
ch3=-1;
set(handles.togglebutton22,'BackgroundColor',[1 0 0]);
axes(handles.axes4);
smil=imread('science.png');
imshow(smil)
set(handles.bluee,'String','График 3 прибора отключен.');
end

% Разность токов
function togglebutton28_Callback(hObject, eventdata, handles)
global ch4
a=get(hObject,'Value');
if a==1
ch4=1;
set(handles.togglebutton28,'BackgroundColor',[0 1 0]); 
else
ch4=-1;
set(handles.togglebutton28,'BackgroundColor',[1 0 0]);
end

% % Сharacteristics
function pushbutton40_Callback(hObject, eventdata, handles)
global C
C={0,true,50, '                       1 V/mA';0,true,50, '                       1 V/mA';0,true,50, '                       1 V/mA'};
set(handles.uitable4, 'data', C);

% % Включение/отключение АЦП3, АЦП4
function popupmenu7_Callback(hObject, eventdata, handles)
global cm C con
a=get(hObject,'Value');
if a==1
   o=1;
   C(con,2)={true};
   set(handles.uitable4, 'data', C);
else
   o=0;
   C(con,2)={false};
   set(handles.uitable4, 'data', C);
end
com05(cm,o)

% % Включение/отключение АЦП3, АЦП4
function popupmenu7_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Тактовая частота 
function popupmenu8_Callback(hObject, eventdata, handles)
global cm C con
a=get(hObject,'Value');
if a==1
   o=1;
   C(con,5)={1.572864};
   set(handles.uitable4, 'data', C);
else
   o=0;
   C(con,5)={12.582912};
   set(handles.uitable4, 'data', C);
end
com25(cm,o)

% Тактовая частота 
function popupmenu8_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Питание узла синхронизация
function popupmenu9_Callback(hObject, eventdata, handles)
global cm C con
a=get(hObject,'Value');
if a==1
   o=1;
   C(con,6)={true};
   set(handles.uitable4, 'data', C);
else
   o=0;
   C(con,6)={false};
   set(handles.uitable4, 'data', C);
end
str=char([15,o]);
fwrite(cm,str); 

% Питание узла синхронизация
function popupmenu9_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% Время ожидания
function pushbutton41_Callback(hObject, eventdata, handles)
global cm
com13(cm)

% Синхронизация
function togglebutton24_Callback(hObject, eventdata, handles)
global tbk tbl
a=get(hObject,'Value');
if a==1
set(handles.togglebutton24,'BackgroundColor',[1 0 0]); 
str=char([16,1]);
fwrite(tbk,str); 
else
set(handles.togglebutton24,'BackgroundColor',[0 1 0]);
str=char([16,0]);
fwrite(tbl,str); 
end

% Запись в файл 1 
function togglebutton25_Callback(hObject, eventdata, handles)
global en1
a=get(hObject,'Value');
if a==1
en1=1;
set(handles.togglebutton25,'BackgroundColor',[0 1 0]); 
else
en1=-1;
set(handles.togglebutton25,'BackgroundColor',[1 0 0]);
end

% Запись в файл 2
function togglebutton26_Callback(hObject, eventdata, handles)
global en2
a=get(hObject,'Value');
if a==1
en2=1;
set(handles.togglebutton26,'BackgroundColor',[0 1 0]); 
else
en2=-1;
set(handles.togglebutton26,'BackgroundColor',[1 0 0]);
end

% Запись в файл 3 
function togglebutton27_Callback(hObject, eventdata, handles)
global en3
a=get(hObject,'Value');
if a==1
en3=1;
set(handles.togglebutton27,'BackgroundColor',[0 1 0]); 
else
en3=-1;
set(handles.togglebutton27,'BackgroundColor',[1 0 0]);
end



function edit8_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in pushbutton44.
function pushbutton44_Callback(hObject, eventdata, handles)
global n
n=get(handles.edit8,'string');
n=str2double(n);


% --- Executes on button press in togglebutton30.
function togglebutton30_Callback(hObject, eventdata, handles)
global ch4
a=get(hObject,'Value');
if a==1
ch4=1;
set(handles.togglebutton30,'BackgroundColor',[0 1 0]); 
else
ch4=-1;
set(handles.togglebutton30,'BackgroundColor',[1 0 0]);
end
