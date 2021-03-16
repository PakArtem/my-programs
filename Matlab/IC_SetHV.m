function str=IC_SetHV(t,V)
%Регулировка высокого напряжения 
%t=bond();
u=V/1030*65535;
u1=floor(u/256);
u2=mod(u,256);
str=char([8, u1, u2]);
fwrite(t,str);
end

