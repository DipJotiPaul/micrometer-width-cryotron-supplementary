clc;        clear;      close all;     

%% circuit design procedure
% Material parameters
d = 10e-9;
Rsheet = 250;
Tc = 9;
Tsub = 4;
hc = 50e3;
k = 2.44e-8*Tc/(Rsheet*d);
Lk = 1.38e-12*Rsheet/Tc;
c = 4400;
v0 = sqrt(hc*k/d)/c;
pho = Rsheet*d;
Jsw = 46e9;

% Give parameters
Vbias = 4;
Igate = 0.5e-3;
C = 500e-15;
sq_ch = 50;
Tduration = 9.5e-9;   

% design parameters
Rbias = linspace(1e3,10e3,3000);
w = linspace(1e-6,5e-6,3000);
% Rbias = 5e3;
% w = 2e-6;

% dependent parameters
min_limit=1.75*Vbias./(Jsw*d);
t = linspace(0,1e-6,5e4);
RHS = zeros(length(w),length(Rbias));
VCH = zeros(length(w),length(Rbias));

for k1=1:length(w)
    for k2=1:length(Rbias)
        Isw = Jsw*d*w(k1);
        psi = pho*Isw.^2./(hc*d*w(k1).^2*(Tc-Tsub));
        x = (2*Rsheet*v0/w(k1))*sqrt(psi)*Tduration/Isw;
        y = x*Vbias + x*Igate*Rbias(k2);
        z = Rbias(k2) - x*Igate;
        % To exclude the bias-induced switching of wTron, only includes switching when Igate is present 
        % Lw = Lk*sq_ch;      s1 = (-Lw+sqrt(Lw^2-4*Lw*C*Rbias(k2)^2))/(2*Lw*C*Rbias(k2));       IL = (Vbias/Rbias(k2))*(1-exp(s1*t));
        IL = Vbias/Rbias(k2);        % R1 = 0.5*(-z+sqrt(z.^2+4*y));     Rpar = (R1*Rbias(k2))/(R1+Rbias(k2));    RC_const = Rpar*C;
        % if(max(real(IL))<Isw && RC_const<1.5e-9)
        if(max(real(IL))<Isw) 
            RHS(k1,k2) = 0.5*(-z+sqrt(z.^2+4*y));
            VCH(k1,k2) = Vbias*(RHS(k1,k2)/(RHS(k1,k2)+Rbias(k2)))+0.5*Igate*(RHS(k1,k2)*Rbias(k2)/(RHS(k1,k2)+Rbias(k2)));
            % VCH(k1,k2) = Vbias*(1+0.5*Igate*Rbias(k2)/Vbias)/(1+(Rbias(k2)/RHS(k1,k2)));     --> diverges for Vbias = 0 
        end
    end
end

[X,Y]=meshgrid(Rbias,w);            VCH(VCH== 0)=NaN;          RHS(RHS== 0)=NaN;
% figure(1);      subplot(1,3,[2 3]);   
% [C,h]=contourf(X*1e-3,Y*1e6,VCH,7,':',"ShowText",true,"LabelFormat","%0.1f","FaceAlpha",0.75);     hold on;            
% clabel(C,h,'FontSize',16);      clabel(C,h,'LabelSpacing',150);         set(gca,'LineWidth',1.1,'fontsize',18);            
% xlabel('R_{bias} (K\Omega)','FontSize',20);          xlim([1 10]);      xticks(1:3:10);
% ylabel('channel width (\mum)','FontSize',20);     ylim([1 5]);
% hold on;    scatter(5,2,75,"filled",'MarkerFaceColor','red','Marker','o');
% % pos = get(gca, 'Position');     set(gca, 'Position', [pos(1)+0.01 pos(2)+0.1 pos(3)-0.02 pos(4)-0.12]);
% % ax = gca;   exportgraphics(ax,'Fig3c.pdf','ContentType','vector');          

figure(2);      subplot(1,3,[2 3]);   
[C,h]=contourf(X*1e-3,Y*1e6,RHS*1e-3,[0 1 2 3 5 7 9 11],':',"ShowText",true,"LabelFormat","%0.1f","FaceAlpha",0.75);     colormap('parula')            
clabel(C,h,'FontSize',16);      clabel(C,h,'LabelSpacing',150);   set(gca,'LineWidth',1.1,'fontsize',18);            
xlabel('R_{bias} (K\Omega)','FontSize',20);          xlim([1 10]);      xticks(1:3:10);
ylabel('channel width (\mum)','FontSize',20);     ylim([1 5]);   
hold on;    scatter(5,2,75,"filled",'MarkerFaceColor','red','Marker','o');
pos = get(gca, 'Position');     set(gca, 'Position', [pos(1)+0.01 pos(2)+0.1 pos(3)-0.02 pos(4)-0.12]);
% ax = gca;   exportgraphics(ax,'Fig3d.pdf','ContentType','vector');

%% circuit design procedure -- LTspice cross check
% load('Fig3_LTspice_cross_check.mat');
% [X,Y]=meshgrid(Rb,wc);          VCH(VCH== 0)=NaN;          RHS(RHS== 0)=NaN;
% figure(3);      subplot(1,3,[2 3]);   
% [C,h]=contourf(X*1e-3,Y*1e6,VCH,[0 0.5 0.8 1.1 1.3 1.6 1.9],':',"ShowText",true,"LabelFormat","%0.1f","FaceAlpha",0.75);     hold on;              
% clabel(C,h,'FontSize',16);      clabel(C,h,'LabelSpacing',150);         set(gca,'LineWidth',1.1,'fontsize',18);            
% % xlabel('R_{bias} (K\Omega)','FontSize',20);          xlim([1 10]);      xticks(1:3:10);
% % ylabel('channel width (\mum)','FontSize',20);     ylim([1 5]);
% hold on;    scatter(5,2,75,"filled",'MarkerFaceColor','red','Marker','o');
% % pos = get(gca, 'Position');     set(gca, 'Position', [pos(1)+0.01 pos(2)+0.1 pos(3)-0.02 pos(4)-0.12]);
% % ax = gca;   exportgraphics(ax,'Fig4c.pdf','ContentType','vector');         
% 
% figure(4);      subplot(1,3,[2 3]);   
% [C,h]=contourf(X*1e-3,Y*1e6,RHS*1e-3,[0 1.6 2.9 4.2 5.4],':',"ShowText",true,"LabelFormat","%0.1f","FaceAlpha",0.75);     colormap('parula')            
% clabel(C,h,'FontSize',16);      clabel(C,h,'LabelSpacing',150);   set(gca,'LineWidth',1.1,'fontsize',18);            
% % xlabel('R_{bias} (K\Omega)','FontSize',20);          xlim([1 10]);      xticks(1:3:10);
% % ylabel('channel width (\mum)','FontSize',20);     ylim([1 5]);   
% hold on;    scatter(5,2,75,"filled",'MarkerFaceColor','red','Marker','o');
% % pos = get(gca, 'Position');     set(gca, 'Position', [pos(1)+0.01 pos(2)+0.1 pos(3)-0.02 pos(4)-0.12]);
% % ax = gca;   exportgraphics(ax,'Fig4d.pdf','ContentType','vector');

%% minimum number of squares in channel
% VOff = 50e-3;
% Rbias = 2e3;
% w = 9.5e-6;
% 
% Lk = 1.38e-12*Rsheet/Tc;
% x = (2*Rsheet*v0/w)*sqrt(psi)*Tduration/Isw;
% y = x*Vbias + x*Igate*Rbias;
% z = Rbias - x*Igate;
% RHS = 0.5*(-z+sqrt(z.^2+4*y));

% sq_min = RHS/Rsheet;    disp(sq_min);
% sq_max = (VOff/Vbias)*Rbias*sqrt(C/Lk);     disp(sq_max);

% L = 38.3e-9;     C = 500e-15;       Rb = 5e3;
% Is = 4/Rb;        t = linspace(0,2e-9,10000);
% s1 = (-L+sqrt(L^2-4*L*C*Rb^2))/(2*L*C*Rb);       IL = Is*(1-exp(s1*t));
% figure(3);  plot(t*1e12,real(IL)*1e3);          disp(max(real(IL*1e3)));
