function [sm,ins]=pologenie(xx,yy)
% Коэффициенты, надо подумать над величиной
k1 = 1;
k2 = 1;
% Смещение и интенсивность 
sm = k1*(xx-yy)/(xx+yy);
ins = k2*(xx+yy);
% plot([-1 1], [sm sm], 'LineWidth',2, 'Color','g');
% axis([-1 1 -4 4])
% set(a2,'Position', [0.92 0.045 0.06 0.9])
% text(-0.999, sm+0.19, [' ' num2str(sm) ''],'HorizontalAlignment','left')
% text(-0.999, sm-0.19, [' ' num2str(ins) ''],'HorizontalAlignment','left')
end

