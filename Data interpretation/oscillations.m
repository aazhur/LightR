set(0,'DefaultFigureColor','k',...
      'DefaultAxesColor','k',...
      'DefaultAxesXColor','w',...
      'DefaultAxesYColor','w',...
      'DefaultAxesZColor','w',...
      'DefaultTextColor','w',...
      'DefaultLineColor','w')
  
N = 20;

kymos = cell(1,N);
sV = cell(1,N);
Vel = zeros(N,86);
t = linspace(1,86,86);
oscill = zeros(56,N);
fourier = zeros(56,N);
X5 = zeros(N,16);
X4 = zeros(N,13);
X3 = zeros(N,10);
X2 = zeros(N,7);
X1 = zeros(N,4);
lag = 5;

%percent = 0;
mode = 0;
total_sV = 0;

for percent = 3:3
    Pks = []; Locs = []; S = [];
    middle_line = 0;
    fig1 = figure;
    for i = 1:N
        if mode == 0 
            kymos{i} = load([pwd, '/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
        else
            kymos{i} = load([pwd, '/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;smoothed.mat']);
        end  
        sV{i} = kymos{i}.sV;       
        
        total_sV = total_sV + sV{i};
        [~,n] = size(sV{i}); k = n/2;
        delta = floor(n*percent/100);
        M = sV{i}(:,(k-delta):(k+delta));
        Vel(i,:) = mean(M,2)';

        v = Vel(i,16:71);
        oscill(:,i) = v';
        [Y, ~,  pxx, f, ~, ~, I, p, l] = fourier_transform(v);
        t = 0:55; n = length(v); k = I(1);
        pow = 2*pi*1i*(k-1)*t/n;
        osc = (1/n)*Y(k)*(exp(pow));
        for j = 2:8
            k = I(j);
            pow = 2*pi*1i*(k-1)*t/n;
            osc = osc + (1/n)*Y(k)*(exp(pow));
        end
        fourier(:,i) = osc';
        middle_line = middle_line + pxx;
        disp(f);
        s = size(p,2);
        Pks = [Pks, p];
        Locs = [Locs, l];
        S = [S, s];
        
        subplot(4,5,i);
        hold on;
        plot(f,pxx);
        ax = gca;
        xlabel('Frequency');
        ylabel('Magnitude');
        
    end
    
    fig1.InvertHardcopy = 'off';
    saveas(fig1, ['/Users/azhurikhina/Dropbox/Mark Andrei/Group/MLCK Free/All_Fourier;Percent_' num2str(percent) ';Smoothed_Lag_5.png']);
    
    file = load(['/Users/azhurikhina/Dropbox/Mark Andrei/Group/Data/Data3_', num2str(percent),'.mat']);
    X3 = file.X3; X4 = file.X4; X2 = file.X2; X1 = file.X1; x3 = file.x3; x2 = file.x2; x1 = file.x1; x4 = file.x4;
    
    for arg = 5 %1:4
        fig1 = figure;
        for i = 1:N
            v = oscill(:,i)';
            subplot(4,5,i);
            hold on;
            plot(t,v);
            if arg == 5
                x = fit_cos(v,arg,X4(i,:));
                X5(i,:) = x;
                plot(t,x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16));
            elseif arg == 4
                x = fit_cos(v,arg,X3(i,:));
                X4(i,:) = x;
                plot(t, x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13));
            elseif arg == 3
                x = fit_cos(v,arg,X2(i,:));
                X3(i,:) = x;
                plot(t, x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9))+x(10));
            elseif arg == 2
                x = fit_cos(v,arg,X1(i,:));
                X2(i,:) = x;
                plot(t,x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6))+x(7));
            elseif arg == 1   
                x = fit_cos(v,arg,zeros(1,4));
                X1(i,:) = x;
                plot(t,x(2)*cos(x(1)*t+x(3))+x(4));
            end       
        end
        fig1.InvertHardcopy = 'off';
        saveas(fig1, ['/Users/azhurikhina/Dropbox/Mark Andrei/Group/MLCK Free/All_Func_', num2str(arg),'_Cosfit;Percent_' num2str(percent) ';Smoothed_Lag_5.png']);
    end

fig2 = figure;
axis equal;
axis off;
colormap jet;
for i = 1:N
    subplot(1,N,i);
    imagesc(oscill(:,i));
    set(gca,'YTick',[]);
    set(gca,'XTick',[]);
    title(num2str(i));
end

fig2.InvertHardcopy = 'off';
saveas(fig2, ['/Users/azhurikhina/Dropbox/Mark Andrei/Group/MLCK Free/All_Strips;Percent_' num2str(percent) ';Smoothed_Lag_5.png']);

middle_line = middle_line/N;

%{
total_sV = zeros(size(sV{1}));
for i = 1:size(sV{1},1)
    for j = 1:size(sV{1},2)
        vel_array = zeros(1,N);
        for k = 1:N
            vel_array(k) = sV{k}(i,j); 
        end    
        total_sV(i,j) = median(vel_array);
    end    
end
%}
total_sV = total_sV/N;
[~,n] = size(total_sV); k = n/2;
delta = floor(n*percent/100);
V = mean(total_sV(:,k-delta:k+delta),2)'; 
func = V(16:71); 
n = length(func);
[Y, P1, pxx, f, PXX, F, I, pks, locs] = fourier_transform(func);
%pxx = normalize(pxx,'range');
%pks = normalize(pks,'range');

fig3 = figure;
subplot(1,2,2);
plot(2*pi*f,pxx);
num = 1:length(locs);
%text(locs,pks+0.05,num2str(num'));
%ylim([0,1.1]);

subplot(1,2,1);
axis equal;
axis off;
colormap(jet);
imagesc(total_sV);
P = 700;

hold on;
%{
for i = 1:4
    T = 21 - lag;
    while T < (70 - lag)
        line([1 P],[T T],'Color','k','LineStyle','--','LineWidth',0.1);
        T = T + 1/locs(i);
    end  
end    
%}

line([P/2 P/2],[0 90],'Color','r','LineStyle','--','LineWidth',0.8);
line([k-delta k-delta],[0 90],'Color','k','LineStyle','--','LineWidth',0.8);
line([k+delta k+delta],[0 90],'Color','k','LineStyle','--','LineWidth',0.8);

line([1 P],[16 16],'Color','r','LineStyle','--','LineWidth',1.5);
line([1 P],[66 66],'Color','r','LineStyle','--','LineWidth',1.5);

fig3.InvertHardcopy = 'off';
saveas(fig3, ['/Users/azhurikhina/Dropbox/Mark Andrei/Group/MLCK Free/Median_of_Kymos_Fourier;Percent_' num2str(percent) ';Smoothed_Lag_5.png']);

t = 0:55;
osc = cell(1,numel(Y));
k = I(1); pow = 2*pi*1i*(k-1)*t/n;
osc{1} = (1/n)*Y(k)*(exp(pow));
for j = 2:numel(Y)
    k = I(j);
    pow = 2*pi*1i*(k-1)*t/n;
    osc{j} = osc{j-1} + (1/n)*Y(k)*(exp(pow));
    %osc{j} = (1/n)*Y(k)*(exp(pow));
end

fig4 = figure;
clf;
hold on;
axis tight;
plot(V,'.-', 'Linewidth', 1);
for j = 8:8
    plot(t+16, osc{j}, '-', 'Linewidth', 1.5);    
    text(t(1)+15,osc{j}(1),num2str(j));
end    

fig4.InvertHardcopy = 'off';
saveas(fig4, ['/Users/azhurikhina/Dropbox/Mark Andrei/Group/MLCK Free/Fit_of_Median;Percent_' num2str(percent) ';Smoothed_Lag_5.png']);

fig5 = figure;
FFT_image = fft2(total_sV);
colormap(jet);
imagesc(abs(fftshift(FFT_image)));

fig5.InvertHardcopy = 'off';
saveas(fig5, ['/Users/azhurikhina/Dropbox/Mark Andrei/Group/MLCK Free/Median_Fourier2D;Percent_' num2str(percent) ';Smoothed_Lag_5.png']);

%%find the right oscillations
for arg = 5 %1:4
    fig6 = figure;
    hold on;
    plot(t, func);
    if arg == 5
        x5 = fit_cos(func, arg, x4);
        x = x5;
        plot(t,x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16));
    elseif arg == 4
        x4 = fit_cos(func, arg, x3);
        x = x4;
        plot(t,x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13));
    elseif arg == 3
        x3 = fit_cos(func, arg, x2);
        x = x3;
        plot(t, x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9))+x(10));
    elseif arg == 2
        x2 = fit_cos(func, arg, x1);
        x = x2;
        plot(t,x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6))+x(7));
    elseif arg == 1  
        x1 = fit_cos(func, arg, zeros(1,4));
        x = x1;
        plot(t,x(2)*cos(x(1)*t+x(3))+x(4));
    end

    fig6.InvertHardcopy = 'off';
    saveas(fig6, ['/Users/azhurikhina/Dropbox/Mark Andrei/Group/MLCK Free/Func_',num2str(arg),'_CosFit;Percent_' num2str(percent) ';Smoothed_Lag_5.png']);
end
%save(['/Users/azhurikhina/Dropbox/Mark Andrei/Group/Data/Data3_', num2str(percent),'.mat'],'Pks','Locs', 'S','pxx','f','middle_line','x1','x2','x3','x4','X1','X2','X3','X4');
save(['/Users/azhurikhina/Dropbox/Mark Andrei/Group/Data Free/Data3_', num2str(percent),'.mat'],'X5','x5','-append') 
close all;
end
