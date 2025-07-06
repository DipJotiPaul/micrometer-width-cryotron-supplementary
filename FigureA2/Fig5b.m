clc;        clear;      close all;          
load('Fig5b.mat');

figure(1);  tlo = tiledlayout(2,1,'TileSpacing','tight');
nexttile,   plot(t_axis(1,:),ch1(1,:),'Color',[0 0.4470 0.7410],'linewidth',1.6);    
hold on;    plot(t_axis(1,:),ch2(1,:),'Color',[0.8500, 0.3250, 0.0980],'linewidth',1.6);
set(gca,'LineWidth',1.1,'fontsize',17);     set(gca,'box','off');
xlim([0 300]);  xticks(0:50:300);     ylim([0 1]);  yticks(0:0.25:1);
legend({'V_{bias}','V_{ch}'},'Location','northeast','FontSize',18); legend boxoff

nexttile,   plot(t_axis(2,:),ch1(2,:),'Color',[0 0.4470 0.7410],'linewidth',1.6);    
hold on;    plot(t_axis(2,:),ch2(2,:),'Color',[0.8500, 0.3250, 0.0980],'linewidth',1.6);
set(gca,'LineWidth',1.1,'fontsize',17);     set(gca,'box','off');
xlim([0 300]);  xticks(0:50:300);     ylim([0 2]);  yticks(0:0.5:2);
xlabel(tlo,'time (\mus)','FontSize',20);  ylabel(tlo,'(volt)','FontSize',22,'HorizontalAlignment','center');
% exportgraphics(tlo,'Fig5b.pdf','ContentType','vector');