function  IC_GetProf_n( t, num, dt, draw )

global PROF
PROF.time=zeros(num,1);
PROF.prof=zeros(num,4);
PROF.proferr=zeros(num,4);
PROF.nmeas=zeros(num,4);
if nargin < 4, draw=0; end

tic;
for i=1:num
    PROF.time(i)=toc;
    d=IC_ReadBuff(t);
    PROF.prof(i,1)=mean(double(d.acp1));
    PROF.prof(i,2)=mean(double(d.acp2));
    PROF.prof(i,3)=mean(double(d.acp3));
    PROF.prof(i,4)=mean(double(d.acp4));
    PROF.proferr(i,1)=std(double(d.acp1));
    PROF.proferr(i,2)=std(double(d.acp2));
    PROF.proferr(i,3)=std(double(d.acp3));
    PROF.proferr(i,4)=std(double(d.acp4));
    PROF.nmeas(i,1)=length(d.acp1);
    PROF.nmeas(i,2)=length(d.acp2);
    PROF.nmeas(i,3)=length(d.acp3);
    PROF.nmeas(i,4)=length(d.acp4);
    if draw
        subplot(4,1,1); plot(PROF.time(1:i), PROF.prof(1:i,1));
        subplot(4,1,2); plot(PROF.time(1:i), PROF.prof(1:i,2));
        subplot(4,1,3); plot(PROF.time(1:i), PROF.prof(1:i,3));
        subplot(4,1,4); plot(PROF.time(1:i), PROF.prof(1:i,4));
        PROF.last=i;
        drawnow;
    end
    pause(dt);
    
end
end
 
