clc;        clear all;      close all;          load('wTron_LED_drive.mat');

%% Plotting
figure(1);  tlo = tiledlayout(4,1,'TileSpacing','tight');
nexttile,   plot(time,Ch1,'Color',[0 0.4470 0.7410],'linewidth',1.3);     hold on;  set(gca,'LineWidth',1.1,'fontsize',15);     
set(tlo.Children,'XTick',[]);        xlim([0 60]);  ylim([0 10]);        yticks(0:5:10);  set(gca,'box','off');  
text(9,7.5,'V_{bias}','Color',[0 0.4470 0.7410],'FontSize',16);   

nexttile,   plot(time,Ch4,'Color',[0.8500, 0.3250, 0.0980],'linewidth',1.3);     hold on;   set(gca,'LineWidth',1.1,'fontsize',15); 
set(tlo.Children,'XTick',[]);        xlim([0 60]);  ylim([0 1]);      yticks(0:0.5:1);  set(gca,'box','off'); 
text(9,0.75,'V_{gate}','Color',[0.8500, 0.3250, 0.0980],'FontSize',16);

nexttile,   plot(time,Ch3,'Color',[0.4940, 0.1840, 0.5560],'linewidth',1.3);     hold on;   set(gca,'LineWidth',1.1,'fontsize',15);
set(tlo.Children,'XTick',[]);        xlim([0 60]);  ylim([0 3.1]);        yticks(0:1.5:3);    set(gca,'box','off');   
text(9,2.25,'V_{ch}','Color',[0.4940, 0.1840, 0.5560],'FontSize',16); 
h = ylabel('(volt)', 'FontSize', 18, 'HorizontalAlignment', 'left');    
set(h, 'Position', get(h, 'Position') + [-0.5, 0, 0]);  

nexttile,   plot(time,Ch2,'Color',[0 0 0],'linewidth',1.3);     hold on;   set(gca,'box','off');
xlim([0 60]);  xticks(0:10:60);         ylim([0 10]);        yticks(0:5:10);    set(gca,'LineWidth',1.1,'fontsize',15);
xlabel('time (ms)','FontSize',16);      text(9,7.5,'V_{pd}','Color',[0 0 0],'FontSize',16);    
% exportgraphics(tlo,'Fig2b.pdf','BackgroundColor','none');
