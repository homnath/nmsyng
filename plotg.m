clear all;

xrange=[0 4500];

temp0=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.HN.MXZD.sem.ascii');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.LV.MXZD.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/PRNC.GY.MXZD.sem.ascii');

figure
plot(temp0(:,1),temp0(:,2),'r-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Ligo Hanford');
print('-dpdf','-r600','LIGO_Hanford_disp.pdf');

figure
plot(temp1(:,1),temp1(:,2),'r-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Ligo Livingston');
print('-dpdf','-r600','LIGO_Livingston_disp.pdf');

figure
plot(temp2(:,1),temp2(:,2),'r-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Princeton Guyot');
print('-dpdf','-r600','Princeton_Guyot_disp.pdf');

temp0=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.HN.MXG.sem.ascii');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.LV.MXG.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/PRNC.GY.MXG.sem.ascii');

figure
plot(temp0(:,1),temp0(:,2),'r-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Perturbed gravity potential (m^2/m^2)');
title('Ligo Hanford');
print('-dpdf','-r600','LIGO_Hanford_grav_comp.pdf');

figure
plot(temp1(:,1),temp1(:,2),'r-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Perturbed gravity potential (m^2/m^2)');
title('Ligo Livingston');
print('-dpdf','-r600','LIGO_Livingston_grav.pdf');

figure
plot(temp2(:,1),temp2(:,2),'r-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Perturbed gravity potential (m^2/m^2)');
title('Princeton Guyot');
print('-dpdf','-r600','Princeton_Guyot_grav.pdf');

temp0=load('/home/hgharti/research/modes/nmsyng/SYNT/LIGO.HN.LHZ.nmsyn');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES/LIGO.HN.MXZD.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.HN.MXZD.sem.ascii');

figure
hold on
plot(temp0(:,1),temp0(:,2)+0.0068,'r-');
plot(temp1(:,1),temp1(:,2),'b-');
plot(temp2(:,1),temp2(:,2),'g-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Ligo hanford');
legend('Normal mode','SEM NEX=128','SEM NEX=160');
legend('boxoff');
print('-dpdf','-r600','LIGO_Hanford_disp_comp.pdf');

temp0=load('/home/hgharti/research/modes/nmsyng/SYNT/LIGO.LV.LHZ.nmsyn');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES/LIGO.LV.MXZD.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.LV.MXZD.sem.ascii');

figure
hold on
plot(temp0(:,1),temp0(:,2)-0.007,'r-');
plot(temp1(:,1),temp1(:,2),'b-');
plot(temp2(:,1),temp2(:,2),'g-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Displacement (m)');
title('Ligo Livingston');
legend('Normal mode','SEM NEX=128','SEM NEX=160');
legend('boxoff');
print('-dpdf','-r600','LIGO_Livingston_disp_comp.pdf');


temp0=load('/home/hgharti/research/modes/nmsyng/SYNT/LIGO.HN.GRV.nmsyn');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX128/LIGO.HN.MXG.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.HN.MXG.sem.ascii');

% figure
% plot(temp(:,1),temp(:,2),'r-');
% xlim([-100 1600]);
% xlabel('Time (s)');
% ylabel('Perturbed gravity potential (m^2/s^2)');
% title('LIGO Hanford');
% saveas(gcf,'LIGO_Hanford.pdf','pdf');

figure
hold on
plot(temp0(:,1),temp0(:,2),'r-');
plot(temp1(:,1),temp1(:,2),'b-');
plot(temp2(:,1),temp2(:,2),'g-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Gravity potential (m^2/s^2)');
title('LIGO Hanford');
legend('Normal mode','SEM NEX=128','SEM NEX=160');
legend('boxoff');
print('-dpdf','-r600','LIGO_Hanford_grav_comp.pdf');

temp0=load('/home/hgharti/research/modes/nmsyng/SYNT/LIGO.LV.GRV.nmsyn');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX128/LIGO.LV.MXG.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/LIGO.LV.MXG.sem.ascii');
temp0(:,2)=temp0(:,2)+0.00005;


% figure
% plot(temp(:,1),temp(:,2),'r-');
% xlim([-100 1600]);
% xlabel('Time (s)');
% ylabel('Perturbed gravity potential (m^2/s^2)');
% title('LIGO Livingston');
% saveas(gcf,'LIGO_Livingston.pdf','pdf');

figure
hold on
plot(temp0(:,1),temp0(:,2),'r-');
plot(temp1(:,1),temp1(:,2),'b-');
plot(temp2(:,1),temp2(:,2),'g-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Perturbed gravity potential (m^2/s^2)');
title('LIGO Livingston');
legend('Normal mode','SEM NEX=128','SEM NEX=160');
legend('boxoff');
print('-dpdf','-r600','LIGO_Livingston_grav_comp.pdf');

temp0=load('/home/hgharti/research/modes/nmsyng/SYNT/PRNC.GY.GRV.nmsyn');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX128/PRNC.GY.MXG.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/PRNC.GY.MXG.sem.ascii');

% figure
% plot(temp(:,1),temp(:,2),'r-');
% xlim([-100 1600]);
% xlabel('Time (s)');
% ylabel('Perturbed gravity potential (m^2/s^2)');
% title('Pinceton Guyot');
% saveas(gcf,'Princeton_Guyot.pdf','pdf');

figure
hold on
plot(temp0(:,1),temp0(:,2),'r-');
plot(temp1(:,1),temp1(:,2),'b-');
plot(temp2(:,1),temp2(:,2),'g-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Perturbed gravity potential (m^2/s^2)');
title('Princeton Guyot');
legend('Normal mode','SEM NEX=128','SEM NEX=160');
legend('boxoff');
print('-dpdf','-r600','Princeton_Guyot_grav_comp.pdf');

temp0=load('/home/hgharti/research/modes/nmsyng/SYNT/X121.Y5.GRV.nmsyn');
temp1=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX128/X121.Y5.MXG.sem.ascii');
temp2=load('/home/hgharti/tigress/gitwork/SEMGPETSC/OUTPUT_FILES_NEX160/X121.Y5.MXG.sem.ascii');

% figure
% plot(temp(:,1),temp(:,2),'r-');
% xlim([-100 1600]);
% xlabel('Time (s)');
% ylabel('Perturbed gravity potential (m^2/s^2)');
% title('Pinceton Guyot');
% saveas(gcf,'Princeton_Guyot.pdf','pdf');

figure
hold on
plot(temp0(:,1),temp0(:,2),'r-');
plot(temp1(:,1),temp1(:,2),'b-');
plot(temp2(:,1),temp2(:,2),'g-');
xlim(xrange);
xlabel('Time (s)');
ylabel('Perturbed gravity potential (m^2/s^2)');
title('X141 Y5');
legend('Normal mode','SEM NEX=128','SEM NEX=160');
legend('boxoff');
print('-dpdf','-r600','X141_Y5_grav_comp.pdf');


