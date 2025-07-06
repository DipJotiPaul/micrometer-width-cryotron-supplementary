clc;        clear;      close all;     load('wTron_MOSFET_drive.mat');

%% Scope traces
figure(1);    
tlo = tiledlayout(3,1,'TileSpacing','tight');    
nexttile,   plot(time,Ch2,'Color',[0 0.4470 0.7410],'linewidth',1.3);     hold on;  set(gca,'box','off');
xlim([0 25]);  set(tlo.Children,'XTick',[]);        ylim([0 9]);        yticks(0:4.5:9);    set(gca,'LineWidth',0.9,'fontsize',16);
text(6.5,7,'V_{bias}','Color',[0 0.4470 0.7410],'FontSize',16);   

nexttile,   plot(time,Ch1,'Color',[0.8500, 0.3250, 0.0980],'linewidth',1.3);     hold on;   set(gca,'box','off');
xlim([0 25]);  set(tlo.Children,'XTick',[]);        ylim([0 1]);        yticks(0:0.5:1);    set(gca,'LineWidth',0.9,'fontsize',16);
text(6.5,0.8,'V_{gate}','Color',[0.8500, 0.3250, 0.0980],'FontSize',16); 
h = ylabel('(volt)', 'FontSize', 18, 'VerticalAlignment', 'bottom'); 
set(h, 'Position', get(h, 'Position') + [0, 0, 0]);  

nexttile,   plot(time,Ch3,'Color',[0.4940, 0.1840, 0.5560],'linewidth',1.3);     hold on;   set(gca,'box','off');
xlim([0 25]);  xticks(0:5:25);         ylim([0 2.5]);        yticks(0:1.25:2.5);    set(gca,'LineWidth',0.9,'fontsize',16);
xlabel('time (ms)','FontSize',17);          text(6.5,1.9,'V_{ch}','Color',[0.4940, 0.1840, 0.5560],'FontSize',16); 
% exportgraphics(tlo,'Fig2d.pdf','BackgroundColor','none');