function com24(t)
%«апуск непрерывной передачи данных.

str=char(24);
fwrite(t,str);
for y=1:20
pause(0.5)
bts=get(t, 'BytesAvailable')
 if bts ~=0
%  disp(bts)
 disp(y)
 c=uint32(fread(t, bts/4, 'uint32'));
 disp(c)
 end
% c=uint32(fread(t, bts/4, 'uint32'));
% disp(c)
end

% if bts ~=0
% c=uint32(fread(t, bts/4, 'uint32'));
% disp(c)
% end
% nacp=bitshift(c,-30);
% dat.acp1=bitand(c(nacp==0),hex2dec('ffffff'));
% dat.acp2=bitand(c(nacp==1),hex2dec('ffffff'));
% dat.acp3=bitand(c(nacp==2),hex2dec('ffffff'));
% dat.acp4=bitand(c(nacp==3),hex2dec('ffffff'));

end

