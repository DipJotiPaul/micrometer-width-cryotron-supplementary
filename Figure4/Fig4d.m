clc;        clear;      close all;          

%%
load('LL_wTron_II.mat');
figure(1);      % subplot(3,1,[1,2]);
plot(Ib_gate*1e3,Isw_ch*1e3,'--o','Color',[0 0.4470 0.7410],'linewidth',1.6,'MarkerSize',2);
set(gca,'LineWidth',1.3,'fontsize',22,'FontName','times');    
xlabel('I_{gate} (mA)','FontSize',22);              xlim([0 1.15]);       xticks(0:0.25:1);      
ylabel('I_{sw,ch} (mA)','FontSize',22);      % yticks(0:0.5:3);
% ax = gcf;   exportgraphics(ax,'Fig4d.pdf','BackgroundColor','none');   