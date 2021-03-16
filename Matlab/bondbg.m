function [tbg]=bondbg()
tbg=tcpip('192.168.161.229',5000,'InputBufferSize',2048); %Активация соединения с портом
fopen(tbg);%соединие TCP объекта с сервером
end