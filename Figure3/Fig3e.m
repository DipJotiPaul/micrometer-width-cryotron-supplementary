clc;        clear;      close all;          load('Fig3e_ltspice_wTron_cap_500pF.mat');

%% LTspice Traces
figure(1);    tlo = tiledlayout(4,1,'TileSpacing','Compact');     time=sim_time*1e9;
nexttile,   plot(time,Vd_bias,'Color',[0 0.4470 0.7410],'linewidth',1.6);     hold on;  set(gca,'LineWidth',1.1,'fontsize',15);     
set(tlo.Children,'xticklabel',[]);        ylim([0 4.01]);        yticks(0:4:4);  set(gca,'box','off');     xticks(1:10:61);      xlim([0 62]);  
ylabel('(volt)','FontSize',15);            text(12.5,2.75,'V_{clk}','Color',[0 0.4470 0.7410],'FontSize',15); 
nexttile,   plot(time,(I_gate1+I_gate2)*1e3,'Color',[0.8500, 0.3250, 0.0980],'linewidth',1.6);     hold on;   set(gca,'LineWidth',1.1,'fontsize',15);  
set(tlo.Children,'xticklabel',[]);        ylim([0 0.501]);      yticks(0:0.5:0.5);  set(gca,'box','off');         xticks(1:10:61);      xlim([0 62]);  
ylabel('(mA)','FontSize',15);             text(12.5,0.35,'I_{gate}','Color',[0.8500, 0.3250, 0.0980],'FontSize',15); 
nexttile,   plot(time,Rc_HS*1e-3,'Color',[0.4660 0.6740 0.1880],'linewidth',1.6);     hold on;   set(gca,'LineWidth',1.1,'fontsize',15);  
set(tlo.Children,'xticklabel',[]);        ylim([0 5.11]);      yticks(0:5.1:5.1);  set(gca,'box','off');            xticks(1:10:61);      xlim([0 62]);    
ylabel('(K\Omega)','FontSize',15);       text(16,3.7,'R_{hs,ch}','Color',[0.4660 0.6740 0.1880],'FontSize',15); 
nexttile,   plot(time,VC,'Color',[0.4940, 0.1840, 0.5560],'linewidth',1.6);     hold on;   set(gca,'LineWidth',1.1,'fontsize',15);  
ylim([0 2.41]);      yticks(0:2.4:2.4);  set(gca,'box','off');          text(16,1.7,'V_{ch}','Color',[0.4940, 0.1840, 0.5560],'FontSize',15); 
xlabel('time (ns)','FontSize',15);         ylabel('(volt)','FontSize',15);                 xticks(1:10:61);      xlim([0 62]);    
% exportgraphics(tlo,'Fig3e.pdf','ContentType','vector');        
