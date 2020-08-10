close all;
N = 20; % Number of Cell Velocity files
P = 700; % Number of points on each border with detected coordinates and velocity
folder = pwd;

% lag specifies the time difference in frames, which is used for calculation of the border velocity {v = (position_frame_x - position_frame_(x-lag))/lag}
    
% mode specifies whether the border used in velocity analysis is taken in smoothed out by CellGeo or original state
for lag = [1,5]
    for mode = [1,0]
set(0,'DefaultFigureColor','k',...
      'DefaultAxesColor','k',...
      'DefaultAxesXColor','w',...
      'DefaultAxesYColor','w',...
      'DefaultAxesZColor','w',...
      'DefaultTextColor','w',...
      'DefaultLineColor','w')

kymos = cell(1,N);
sV = cell(1,N);
width = 24;
%mode = 0;
%lag = 5;

total_sV = 0;
%Load amt files with border velocity information

for i = 1:N  
    if mode == 0
        kymos{i} = load([pwd, '/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = ' num2str(lag) ';original.mat']);
    else
        kymos{i} = load([pwd, '/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = ' num2str(lag) ';smoothed.mat']);
    end    
    sV{i} = kymos{i}.sV;   
    total_sV = total_sV + sV{i};
end    

%Mean velocity kymograph calculation
total_sV = total_sV/N;

%Median velocity kymograph calculation
median_sV = zeros(size(total_sV)); 

for i = 1:size(total_sV,1)
    for j = 1:size(total_sV,2)
        vel_array = zeros(1,N);
        for k = 1:N
            vel_array(k) = sV{k}(i,j); 
        end    
        median_sV(i,j) = median(vel_array);
    end    
end    

%Show and Save Figures displaying individual and mean, median kymographs
fig1 = figure;
axis equal;
axis off;
colormap(jet);
for i = 1:N
    subplot(4,5,i);
    axis tight;
    box off;
    axis ij;
    hold on;
    imagesc(sV{i},[-7,6.5]);
    line([P/2, P/2],[1 91-lag],'Color','k','LineStyle','--','LineWidth', 0.5);
    title(['#' num2str(i)]);
end    

fig1.InvertHardcopy = 'off';
if mode == 0
    saveas(fig1, [pwd, '/Kymographs/All Kymos Lag ' num2str(lag) '; Original.png']);
else
    saveas(fig1, [pwd, '/Kymographs/All Kymos Lag ' num2str(lag) '; Smoothed.png']);
end

fig2 = figure;
axis equal;
axis off;
colormap(jet);
imagesc(total_sV,[-1,2]);
hold on;
line([(P-width)/2 (P-width)/2],[1 91],'Color','k','LineStyle','--','LineWidth',2)
line([(P+width)/2 (P+width)/2],[1 91],'Color','k','LineStyle','--','LineWidth',2)
line([1 P],[21-lag 21-lag],'Color','r','LineStyle','--','LineWidth',1)
line([1 P],[70-lag 70-lag],'Color','r','LineStyle','--','LineWidth',1)
title('Velocity Average Kymograph');
colorbar;

fig2.InvertHardcopy = 'off';
if mode == 0
    saveas(fig2, [pwd, '/Kymographs/Average Kymo Lag ' num2str(lag) '; Original.png']);
    saveas(fig2, [pwd, '/Kymographs/Average Kymo Lag ' num2str(lag) '; Original.fig']);
else
    saveas(fig2, [pwd, '/Kymographs/Average Kymo Lag ' num2str(lag) '; Smoothed.png']);
    saveas(fig2, [pwd, '/Kymographs/Average Kymo Lag ' num2str(lag) '; Smoothed.fig']);
end

fig3 = figure;
axis equal;
axis off;
colormap(jet);
imagesc(median_sV,[-1,2]);
colorbar;
hold on;
line([(P-width)/2 (P-width)/2],[1 91],'Color','k','LineStyle','--','LineWidth',2)
line([(P+width)/2 (P+width)/2],[1 91],'Color','k','LineStyle','--','LineWidth',2)
line([1 P],[21-lag 21-lag],'Color','r','LineStyle','--','LineWidth',1)
line([1 P],[70-lag 70-lag],'Color','r','LineStyle','--','LineWidth',1)
title('Velocity Median Kymograph');
colorbar;

fig3.InvertHardcopy = 'off';
if mode == 0
    saveas(fig3, [pwd, '/Kymographs/Median Kymo Lag ' num2str(lag) '; Original.png']);
    saveas(fig3, [pwd, '/Kymographs/Median Kymo Lag ' num2str(lag) '; Original.fig']);
else
    saveas(fig3, [pwd, '/Kymographs/Median Kymo Lag ' num2str(lag) '; Smoothed.png']);
    saveas(fig3, [pwd, '/Kymographs/Median Kymo Lag ' num2str(lag) '; Smoothed.fig']);
end

    end
end

close all;
%{
corr = corr_im(total_sV,total_sV);
fig4 = figure;
axis equal;
axis off;
colormap(jet);
imagesc(corr);
title('Correlation');

fig4.InvertHardcopy = 'off';
saveas(fig4, 'Correlation Average Kymo Lag 1 new.png');

corr = corr_im(median_sV,median_sV);
fig5 = figure;
axis equal;
axis off;
colormap(jet);
imagesc(corr);
title('Correlation');

fig5.InvertHardcopy = 'off';
saveas(fig5, 'Correlation Median Kymo Lag 1 new.png');
%}