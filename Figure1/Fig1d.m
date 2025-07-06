clc;        clear;      close all;      root=cd;
%%
load('Isw_micron_wires.mat');
figure(1);             
tlo = tiledlayout(2,1,'TileSpacing','tight');      nexttile,       
c = polyfit(wid,Isw_med,1);     y_est = polyval(c,[0 1 wid]);     plot([0 1 wid],y_est,'--','Color','k','LineWidth',1.1);       hold on;
scatter(wid,Isw_med,50,'o','MarkerFaceColor',[0 0.4470 0.7410],'MarkerEdgeColor',[0 0.4470 0.7410]); 
set(gca,'LineWidth',1.1,'fontsize',15);     set(tlo.Children,'Xticklabel',[]);        xlim([0 5.25]);  
ylim([0 2.1]);        yticks(0:0.5:2.1);          set(gca,'box','on');     set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 18);
ylabel('$\tilde{I}_{\mathrm{sw}}$ (mA)', 'Interpreter', 'latex', 'FontSize', 18);
legend({'linear fit'},'Location','southeast', 'Interpreter', 'latex','FontSize',18); legend boxoff

nexttile,   boxplot(dist,width,'Widths',0.2, 'positions', [2 3 4 5]);         ylim([-110 50]);    yticks(-100:50:50);   
yticklabels({'$\tilde{I}_{\mathrm{sw}} -100\mu\mathrm{A}$', ...
             '$\tilde{I}_{\mathrm{sw}} -50\mu\mathrm{A}$', ...
             '$\tilde{I}_{\mathrm{sw}}$', ...
             '$\tilde{I}_{\mathrm{sw}}+50\mu\mathrm{A}$'});
set(gca, 'TickLabelInterpreter', 'latex', 'FontSize', 18);      set(findobj(gca,'type','line'),'linew',1);
xlim([0 5.25]);             xticks(0:1:5);              xticklabels({'0', '1', '2', '3', '4', '5'});
set(gca,'LineWidth',1.1,'fontsize',16);     xlabel('nominal wire width (\mum)','FontSize',15);        
% ax = gcf;   exportgraphics(ax,'Fig1d.pdf','BackgroundColor','none');
