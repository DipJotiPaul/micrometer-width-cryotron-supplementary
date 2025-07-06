clc;        clear;      close all;          
load('Fig5cd.mat');     load('python_wTron_no_coax.mat'); 

%% Hotspot voltage
figure(1);  tlo = tiledlayout(1,2,'TileSpacing','compact');
nexttile,   plot(Vin(2,:),Vout(2,:),'o','Color',[0 0 0],'linewidth',1.1,'MarkerSize',2);      hold on;
plot(Vbias(1,:),VL_wTron(2,:),'Color',[0 0.4470 0.7410],'linewidth',1.7);
set(gca,'LineWidth',1.1,'fontsize',20);     xlim([0 2.5]);
xlabel('V_{bias,max} (V)','FontSize',22);          ylabel('V_{ch,max} (V)','FontSize',22);
legend({'exp','simulation'},'fontsize',12,'Location','best');      legend Boxoff 
% print('Fig5c','-dsvg');

%% Hotspot RHS
figure(2);   tlo = tiledlayout(1,2,'TileSpacing','compact');        
nexttile,    plot(Vbias(1,:),RHS_wTron(2,:)*1e-3,'-o','Color',[0 0.4470 0.7410],'linewidth',1.1,'MarkerSize',2);
set(gca,'LineWidth',1.1,'fontsize',20);     xlim([0 2.5]);
xlabel('V_{bias,max} (V)','FontSize',22);          ylabel('R_{HS,max} (K\Omega)','FontSize',22);
pos = get(gca, 'Position');     set(gca, 'Position', [pos(1)+0.01 pos(2)+0.1 pos(3)-0.02 pos(4)-0.12]);
% ax = gca;   exportgraphics(ax,'Fig5d.pdf','ContentType','vector');