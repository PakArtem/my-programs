function [tbl]=bondbl()
tbl=tcpip('192.168.161.240',5000,'InputBufferSize',2048); %Активация соединения с портом
fopen(tbl);%соединие TCP объекта с сервером
end

