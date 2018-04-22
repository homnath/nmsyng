clear all;clf;

nrec=181;

temp=load(['X1.Y5.LHZ.nmsyn']);
t=temp(:,1);
nstep=length(t); dt=t(2)-t(1);
s=zeros(nstep,nrec);
v=zeros(nstep,nrec);

for l=1:nrec
    temp=load(['X' int2str(l) '.Y5.LHZ.nmsyn']);
    s(:,l)=temp(:,2);
    v(1,l)=(s(2,l)-s(1,l))/dt;
    v(nstep,l)=(s(nstep,l)-s(nstep-1,l))/dt;
    v(2:nstep-1,l)=(s(3:nstep,l)-s(1:nstep-2,l))/2*dt;
end

fac_s=7;
fac_v=1;
subplot(1,2,1);hold on;
for l=1:nrec
    plot(t,fac_s*s(:,l)+(91-l));
end
xlim([0 max(t)]);ylim([-90 90]);
subplot(1,2,2);hold on;
for l=1:nrec
    plot(t,fac_v*v(:,l)+(91-l));
end
xlim([0 max(t)]);ylim([-90 90]);
saveas(gcf,'nmsyn.pdf','pdf');