clc;        clear;      close all;     

%%
Vbias = 4;
Igate = 0.5e-3;
C = 500e-15;
Rbias = 5e3;
f = 0.5;          % f = Igate*Rbias/Vbias;

RHS_b = logspace(-2,1,500);           Vth=RHS_b.*(1+0.5*f)./(1+RHS_b);          tau=RHS_b./(1+RHS_b); 
figure(1);      subplot(1,3,[2 3]);         
yyaxis left;   semilogx(RHS_b,Vth,'-','Color',[0 0.4470 0.7410],'linewidth',2); 
ylabel('$V_{CH}/V_{clk}$','FontSize',26,'Interpreter','latex');    xlabel('$R_{HS,ch}/R_{bias}$','FontSize',26,'Interpreter','latex');
set(gca,'LineWidth',1.4,'fontsize',22);     xticks([0.01 1 10]);   set(gca,'XTickLabel',get(gca,'xtick'));
hold on;    yyaxis right;    semilogx(RHS_b,tau,'-','Color',[0.8500, 0.3250, 0.0980],'linewidth',2);      
ylabel('$\tau/(R_{bias}C)$','FontSize',26,'Interpreter','latex');    %yticks(0:0.25:1);

% Add indicators for left y-axis
left_indicator_x = 5; 
left_indicator_y = 0.9;
rectangle('Position', [left_indicator_x, left_indicator_y, 2, 0.09], ...
                            'Curvature', [1, 1], 'EdgeColor', [0 0.4470 0.7410], 'LineWidth', 1.3);
annotation('arrow', [0.855, 0.785], [0.875, 0.875], 'Color', [0 0.4470 0.7410], 'LineWidth', 1.3);

% Add indicators for right y-axis
right_indicator_x = 3.75; 
right_indicator_y = 0.75; 
rectangle('Position', [right_indicator_x, right_indicator_y, 1.5, 0.09], ...
                    'Curvature', [1, 1], 'EdgeColor', [0.8500 0.3250 0.0980], 'LineWidth', 1.3);
annotation('arrow', [0.835, 0.89], [0.745, 0.745], 'Color', [0.8500 0.3250 0.0980], 'LineWidth', 1.3);

pos = get(gca, 'Position');     set(gca, 'Position', [pos(1)+0.01 pos(2)+0.1 pos(3)-0.02 pos(4)-0.12]);
% ax = gca;   exportgraphics(ax,'Fig3c.pdf','ContentType','vector');





