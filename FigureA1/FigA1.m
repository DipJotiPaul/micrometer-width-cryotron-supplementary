clc;        clear;      close all;         

%% FigA1a - 2um wire 
load('Isw_curve 2023-09-07 09-36-32 wTron-sample2_2um-width-wire_IV-meas-F3.mat');
figure(1);  scatter(V_device,I_device*1e3,"filled",'Color',[0 0.4470 0.7410],'linewidth',1.3);    
load('ltspice_2um_wire.mat');
hold on;    plot(Vch,Ich*1e3,'Color',[0.8500, 0.3250, 0.0980],'linewidth',1.8);  
xlim([-6 6]);  xticks(-6:2:6);  ylim([-0.8 0.8]);   yticks(-0.8:0.4:0.8);
set(gca,'LineWidth',1.1,'fontsize',20); 
xlabel('V_{ch} (V)','FontSize',22);          ylabel('I_{ch} (mA)','FontSize',22); 
legend({'exp','simulation'},'fontsize',20,'Location','northwest');      legend Boxoff 
% print('FigA1a','-dsvg');

%% FigA1b - 8um wire 
load('Isw_curve 2023-09-17 11-49-27 wTron-sample2_wTron-2um(meas)-8um_IV-meas-F6-F7.mat');
figure(2);  scatter(V_device,I_device*1e3,"filled",'Color',[0 0.4470 0.7410],'linewidth',1.3);    
load('ltspice_8um_wire.mat');
hold on;    plot(Vch,Ich*1e3,'Color',[0.8500, 0.3250, 0.0980],'linewidth',1.8);  
xlim([-3 3]);  xticks(-3:1:3);  ylim([-2.8 2.8]);   yticks(-2.8:1.4:2.8);
set(gca,'LineWidth',1.1,'fontsize',20); 
xlabel('V_{ch} (V)','FontSize',22);          ylabel('I_{ch} (mA)','FontSize',22); 
legend({'exp','simulation'},'fontsize',20,'Location','northwest');      legend Boxoff 
% print('FigA1b','-dsvg');
