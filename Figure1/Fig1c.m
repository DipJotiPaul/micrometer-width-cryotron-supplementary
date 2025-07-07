clc;        clear;      close all;      root=cd;  

%% 
cd('wTron24_II');
load('Isw_curve 2023-09-15 17-24-24 wTron-sample2_wTron-2um-4um_IV-meas-F4-F2.mat');    Ib_gate1=Ib_gate;       Isw_ch1=Isw_ch;
figure(1);   plot(Ib_gate1*1e3,Isw_ch1*1e3,'--o','Color',[0.8500, 0.3250, 0.0980],'linewidth',1.3,'MarkerSize',2);        hold on;
cd(root);       cd('wTron28_II');
load('Isw_curve 2023-09-17 16-14-51 wTron-sample2_wTron-2um-8um_IV-meas-F6-F7.mat');    Ib_gate2=Ib_gate;       Isw_ch2=Isw_ch;
figure(1);   plot(Ib_gate2*1e3,Isw_ch2*1e3,'--o','Color',[0 0.4470 0.7410],'linewidth',1.3,'MarkerSize',2);        hold on;
xlim([0 1]);    xlabel('I_{gate} (mA)','FontSize',22);          ylabel('I_{sw,ch} (mA)','FontSize',22);     yticks(0:0.5:3);     xticks(0:0.25:1);	set(gca,'LineWidth',1.3,'fontsize',22,'FontName','times');     cd(root);       

%% curve-fitting: linear-exponential
% linear-1: 2um-0.77, 4um-1.59; 2um-0.73, 8um-2.66
x1=0;     y1=1.59;     x2=0.73;       y2=0.6;       x3=0.77;       y3=0;            m1=(y1-y2)/(x1-x2);
x11=0;   y11=2.68;  x12=0.69;     y12=1.74;    x13=0.74;     y13=0;       m11=(y11-y12)/(x11-x12);
alpha=-0.5*(m1+m11);        Isw_ch=y11-alpha*x12;           %Eq1: current crowding factor --> 1.36    
% exponential
% % q = a*exp(b*p);       --> a = y2, b = 64.445 (hotspot suppression factor)
p1=x2-Ib_gate1(74:78)*1e3;      q1=Isw_ch1(74:78)*1e3;
p2=x12-Ib_gate2(70:75)*1e3;    q2=Isw_ch2(70:75)*1e3;
f1=fit(p1',q1','exp1');     %disp(f1);
f2=fit(p2',q2','exp1');     %disp(f2);

figure(1);  
% graph-1
alpha=1.3592;               beta=6.5e4;  
Isw_ch1_fitted1=Isw_ch1(1)-alpha*Ib_gate1(1:73);
Isw_ch1_fitted2=Isw_ch1(74)*exp(beta*(Ib_gate1(74)-Ib_gate1(74:end)));
Isw_ch1_fitted=[Isw_ch1_fitted1 Isw_ch1_fitted2];
plot(Ib_gate1*1e3,Isw_ch1_fitted*1e3,'--','Color','k','linewidth',0.9);       hold on;
% graph-2
Isw_ch2_fitted1=Isw_ch2(1)-alpha*Ib_gate2(1:69);
Isw_ch2_fitted2=Isw_ch2(70)*exp(beta*(Ib_gate2(70)-Ib_gate2(70:end)));
Isw_ch2_fitted=[Isw_ch2_fitted1 Isw_ch2_fitted2];
plot(Ib_gate2*1e3,Isw_ch2_fitted*1e3,'--','Color','k','linewidth',0.75);
legend({'ck 2\mum, ch 4\mum','ck 2\mum, ch 7\mum','fitted'},'Location','northeast','FontSize',18); legend boxoff
% ax = gca;   exportgraphics(ax,'Fig1c.pdf','BackgroundColor','none');
