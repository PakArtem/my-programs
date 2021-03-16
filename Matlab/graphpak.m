function [ ]= graphpak( )
%[time, prof, proferr, nmes] = IC_GetProf( t, num, dt, draw )

prof=zeros(40,4); %массив с нулевыми элементами
proferr=prof; 
nmes=prof;
for i=1:40
    d=com255( );
    prof(i,1)=mean(double(d.acp1)); %mean-арифметическое среднее 
    prof(i,2)=mean(double(d.acp2));
    prof(i,3)=mean(double(d.acp3));
    prof(i,4)=mean(double(d.acp4));
    proferr(i,1)=std(double(d.acp1)); %std-стандартное отклонение элеметов
    proferr(i,2)=std(double(d.acp2));
    proferr(i,3)=std(double(d.acp3));
    proferr(i,4)=std(double(d.acp4));
    nmes(i,1)=length(dat.acp1); %length-определяет на какое количество элементом в этом массиве возрасло
    nmes(i,2)=length(dat.acp2);
    nmes(i,3)=length(dat.acp3);
    nmes(i,4)=length(dat.acp4);
    if draw
        subplot(4,1,1); plot(time(1:i), prof(1:i,1));
        subplot(4,1,2); plot(time(1:i), prof(1:i,2));
        subplot(4,1,3); plot(time(1:i), prof(1:i,3));
        subplot(4,1,4); plot(time(1:i), prof(1:i,4));
        drawnow;
    end 
end
end

% h = animatedline;
% axis([0.4*pi -1 1])
% x = linspace(0.4*pi,2000);
% 
% for k = 1:length(x)
%     y = sin(x(k));
%     addpoints(h,x(k),y);
%     drawnow
% end