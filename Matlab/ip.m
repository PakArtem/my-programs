function ip(cm,pop)
ip4=192;
ip3=168;
ip2=161;
% ip1=240; %черный 250 синий 240
str=char([19, ip4, ip3, ip2, pop]);
fwrite(cm,str);   
end

