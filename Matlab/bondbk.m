function [tbk]=bondbk()
tbk=tcpip('192.168.161.250',5000,'InputBufferSize',2048); %Активация соединения с портом
fopen(tbk);%соединие TCP объекта с сервером
end

