function com03( )
% Источник данных для кольцевого буфера
% Тестовый сигнал
t=bond();
str=char([3,2]);
fwrite(t,str);
fclose(t);
end

