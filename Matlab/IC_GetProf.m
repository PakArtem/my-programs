function [time, prof, proferr, nmes] = IC_GetProf( t, num, dt, draw )

prof=zeros(num,4); %массив с нулевыми элементами
proferr=prof; 
nmes=prof;
if nargin < 4, draw=0; end

tic;
for i=1:num
    time(i)=toc;
    d=IC_ReadBuff(t);
    prof(i,1)=mean(double(d.acp1)); %mean-арифметическое среднее 
    prof(i,2)=mean(double(d.acp2));
    prof(i,3)=mean(double(d.acp3));
    prof(i,4)=mean(double(d.acp4));
    proferr(i,1)=std(double(d.acp1)); %std-стандартное отклонение элеметов
    proferr(i,2)=std(double(d.acp2));
    proferr(i,3)=std(double(d.acp3));
    proferr(i,4)=std(double(d.acp4));
    nmes(i,1)=length(d.acp1); %length-определяет на какое количество элементом в этом массиве возрасло
    nmes(i,2)=length(d.acp2);
    nmes(i,3)=length(d.acp3);
    nmes(i,4)=length(d.acp4);
    if draw
        subplot(4,1,1); plot(time(1:i), prof(1:i,1));
        subplot(4,1,2); plot(time(1:i), prof(1:i,2));
        subplot(4,1,3); plot(time(1:i), prof(1:i,3));
        subplot(4,1,4); plot(time(1:i), prof(1:i,4));
        drawnow;
    end
    pause(dt);
    
end
end
 
