%% Anaylisis function of Cell protrusive activity

% gamma specifies how many cell stacks there are in the folder for analysis
for gamma = 1:20
    
        % start and ending are the numbers of time frames at which laser
        % was initialized and turned off
        start = 21;
        ending = 70;
        close all;

        set(0,'DefaultFigureColor','k',...
              'DefaultAxesColor','k',...
              'DefaultAxesXColor','w',...
              'DefaultAxesYColor','w',...
              'DefaultAxesZColor','w',...
              'DefaultTextColor','w',...
              'DefaultLineColor','w')

        %% Load the Cell Mask File for Analysis
        % path is the name of file with Cell masks
        path = ['Y:\tsygankov-lab\Nastya Zhurikhina\Mark Andrei\FF Src with MLCK inh\Cell ',int2str(gamma),'\'];
        % frames loads the Cell Mask to analyze at the current step
        frames = load([path 'MaskedImages.mat']);

        %% Load Image File with light beam position and get its coordinates
        I = imread([path, 'laser.tif']);
        BW = (I>0);
        %BW = medfilt2(BW);
        %BW = imfill(BW,'holes');

        s = regionprops(BW,'centroid');
        c = cat(1, s.Centroid);  
        xc = mean(c(:,1)); yc = mean(c(:,2)); 
        
    %% Get the velocity of Cell Border using Masks
    % imagelag specifies the time difference in frames, which is used for
    % calculation of the border velocity {v = (position_frame_x -
    % position_frame_(x-lag))/lag}
    
    % mode specifies whether the border used in velocity analysis is taken
    % in smoothed out by CellGeo or original state
    
    for imagelag = [1,5]
        for mode = [0,1]

            if mode == 1     
                boundaries = frames.sXbYb; %smoothed border
            else   
                boundaries = frames.boundaries; %original border
            end
            
            framenumber = size(boundaries,2); %number of frames in cell mask file
            mFRM = framenumber-imagelag; %number of frames with calculated velocity
            XN=cell(1,framenumber); % X coordinates for each frame
            YN=cell(1,framenumber); % Y coordinates for each frame
            
            
            for i = 1:framenumber
                XS = boundaries{i}(:,2)';
                YS = boundaries{i}(:,1)';

                DS=sqrt((XS(2:end)-XS(1:(end-1))).^2+(YS(2:end)-YS(1:(end-1))).^2);
                CS=[0 cumsum(DS)];
                Len=sum(DS); N=round(Len); % N sets a number of points on current cell border for which velocity will be calculated
                r=Len/N;

                XN{i}=zeros(1,N); YN{i}=zeros(1,N); % set up of X and Y coordinates of current frame
                RD=0; XN{i}(1)=XS(1); YN{i}(1)=YS(1);
                
                % current frame X and Y coordinates calculation
                for j=1:(N-1)    
                    RD=RD+r;
                    [vi, mi]=max(CS(CS<=RD));
                    w=RD-vi;
                    XN{i}(j+1)=XS(mi)+(XS(mi+1)-XS(mi))*w/DS(mi);
                    YN{i}(j+1)=YS(mi)+(YS(mi+1)-YS(mi))*w/DS(mi);    
                end

                XN{i}=fliplr(XN{i}); YN{i}=fliplr(YN{i});      

            end

         L=zeros(1,mFRM);
         LocVel=cell(1,mFRM);
         
         %Velocity calculation for each point of current frame
         %relative to cell mask at time point (current frame + lag)
         for i=1:mFRM

            cNUM=length(XN{i});        
            db=zeros(1,cNUM);
            di=zeros(1,cNUM);
            LocVel{i}=zeros(1,cNUM);
            L(i)=cNUM;

            for n=1:cNUM
                di(n)=inpolygon(XN{i}(n),YN{i}(n),XN{i+imagelag},YN{i+imagelag});
                [db(n),~,~]=DistToBoundU(XN{i}(n),YN{i}(n),XN{i+imagelag},YN{i+imagelag});       
                LocVel{i}(n)=db(n)*sign(di(n)-0.5);       
            end

         end

         %% Unifying step at which we use extrapolation to make sure that each border consists of the same number of points N
         
            N = 700; % Number of border points for each Cell Mask
            n = 1:N;

            nX=zeros(mFRM,N);   
            nY=zeros(mFRM,N);

            nV=zeros(mFRM,N);
            sV=zeros(mFRM,N);

            wait=waitbar(1,'Processing in progress... ','WindowStyle','modal');
            
            % Coordinate and Velocity extrapolation
            for fr = 1:mFRM
                waitbar(fr/mFRM);

                x = XN{fr};   
                y = YN{fr};
                v = LocVel{fr};


                X=zeros(1,N);       
                Y=zeros(1,N);    
                V=zeros(1,N);

                t=(L(fr)-1)*(n-1)/(N-1);
                s=1+floor(t);     
                e=1+ceil(t);     
                t=t+1;
                ii=(e-s)==0;     
                jj=(e-s)~=0;

                X(ii)=x(s(ii)); Y(ii)=y(s(ii));
                X(jj)=x(s(jj))+(t(jj)-s(jj)).*(x(e(jj))-x(s(jj)))./(e(jj)-s(jj));
                Y(jj)=y(s(jj))+(t(jj)-s(jj)).*(y(e(jj))-y(s(jj)))./(e(jj)-s(jj));

                V(ii)=v(s(ii));
                V(jj)=v(s(jj))+(t(jj)-s(jj)).*(v(e(jj))-v(s(jj)))./(e(jj)-s(jj));
                
                nX(fr,:)=X;      
                nY(fr,:)=Y;
                nV(fr,:)=V;
                sV(fr,:)=(V-mean(V))/std(V);
                
                % This step ensures that the 'first point' of each border
                % is (a) in a region with least pertrubation, and that (b)
                % all 'first points' of every border are chosen by the least
                % distance from the 'first point' of the previous one
                if fr == 1
                    [~,I] = min(sqrt((xc-X).^2+(yc-Y).^2));
                    nX(fr,:)=circshift(nX(fr,:),floor(N/2)-I); 
                    nY(fr,:)=circshift(nY(fr,:),floor(N/2)-I);            
                    nV(fr,:)=circshift(nV(fr,:),floor(N/2)-I);  
                    sV(fr,:)=circshift(sV(fr,:),floor(N/2)-I);
                else
                    [~,I] = min(sqrt((nX(1,N/2)-X).^2+(nY(1,N/2)-Y).^2));
                    nX(fr,:)=circshift(nX(fr,:),floor(N/2)-I); 
                    nY(fr,:)=circshift(nY(fr,:),floor(N/2)-I);            
                    nV(fr,:)=circshift(nV(fr,:),floor(N/2)-I);  
                    sV(fr,:)=circshift(sV(fr,:),floor(N/2)-I);
                end    
            end  
            close(wait); 
            
            %% By applying GF filter define local maxima in the vicinity of the center
            
            % Find the point with maximum positive protrusive activity within the time frame of
            %laser activation close to the coordinates of the laser
            
            % Find points closest to laser at the start of laser activation
            Dc = round(sqrt((nX(start,:)-xc).^2 + (nY(start,:)-yc).^2));
            [d,ind] = sort(Dc);
            [C,~,~] = unique(d, 'stable'); C = C(1:ceil(0.10*numel(C)));
            k = find(ismember(d,C)); ind = ind(k); 
            ind = (min(ind):1:max(ind));
            %disp(ind);
            
            s_I = zeros(1,N); s_I(ind) = 1;
            
            %Apply Gaussian Filter to smooth out the borders between which
            %the protrusive activity is defined to avoid artifacts
            smooth_X = GFilterA(nX(start,:),50);
            smooth_Y = GFilterA(nY(start,:),50);
            dy = gradient(smooth_Y); dy = dy.*s_I;
            dx = gradient(smooth_X); dx = dx.*s_I;
            end_ind = [];
            max_frame = zeros(1,N);
            
            %Calculate protrusions length and direction between start and
            %end of laser
            wait=waitbar(1,'Detecting biggest protrusive activity... ','WindowStyle','modal');
            count = 0;
            f = zeros(1,N);
            for i = 1:numel(ind)
                waitbar(count/(numel(ind)*(ending-start)));
                xbi = smooth_X(ind(i)) - 100*dy(ind(i)); ybi = smooth_Y(ind(i)) + 100*dx(ind(i));
                c = polyfit([xbi, smooth_X(ind(i))],[ybi, smooth_Y(ind(i))], 1);
                for frame = (start+1):ending
                    end_X = GFilterA(nX(frame,:),20);
                    end_Y = GFilterA(nY(frame,:),20);
                    [D, j] = min_to_line([end_X;end_Y],c(1),c(2),smooth_X(ind(i)),smooth_Y(ind(i)),xbi,ybi); 
                    if D > 0
                        f_l = sqrt((smooth_X(ind(i))-end_X(j))^2 + (smooth_Y(ind(i))-end_Y(j))^2); 
                        if f_l > f(ind(i))
                            f(ind(i)) = f_l;
                            end_ind = [end_ind,j];
                            max_frame(ind(i)) = frame;
                        end    
                    end  
                    count = count + 1;
                end
            end 
            close(wait);
            end_ind = (min(end_ind):1:max(end_ind));
            
            %Detect the point with biggest protrusive activity
            F = f;
            [pks,locs] = findpeaks(F);
            [~,I] = max(pks); I = locs(I);
            max_frame = max_frame(I);
            %disp(M);
            %disp(pks);
            %disp(I);
            
            %Shift the serial number order of points for each frame in a
            %fashion that ensures that the serial number of the point along
            %the line of biggest cell border protrsive activity detected at
            %previous step is exactly N/2 (the center)
            nX(start,:)=circshift(nX(start,:),floor(N/2)-I); 
            nY(start,:)=circshift(nY(start,:),floor(N/2)-I);            
            nV(start,:)=circshift(nV(start,:),floor(N/2)-I);  
            sV(start,:)=circshift(sV(start,:),floor(N/2)-I);
            
            smooth_X=circshift(smooth_X,floor(N/2)-I);
            smooth_Y=circshift(smooth_Y,floor(N/2)-I);
            dx=circshift(dx,floor(N/2)-I); 
            dy=circshift(dy,floor(N/2)-I);
            ind = sort(find(dy));
            end_X = GFilterA(nX(max_frame,:),20);
            end_Y = GFilterA(nY(max_frame,:),20);
            
            F=circshift(F,floor(N/2)-I); 
            
            xb = smooth_X(N/2) - 100*dy(N/2); yb = smooth_Y(N/2) + 100*dx(N/2);
            xb0 = smooth_X(N/2) + 20*dy(N/2); yb0 = smooth_Y(N/2) - 20*dx(N/2);
            coeffs = polyfit([xb, xb0],[yb, yb0],1);
            
            for i = 1:mFRM  
                [~,j] = min_to_line([nX(i,:);nY(i,:)],coeffs(1),coeffs(2),xb0,yb0,xb,yb);
                nX(i,:)=circshift(nX(i,:),floor(N/2)-j);       
                nY(i,:)=circshift(nY(i,:),floor(N/2)-j); 
                nV(i,:)=circshift(nV(i,:),floor(N/2)-j);  
                sV(i,:)=circshift(sV(i,:),floor(N/2)-j);  
                if i == max_frame
                    [~,j] = min_to_line([end_X;end_Y],coeffs(1),coeffs(2),xb0,yb0,xb,yb);
                    end_X=circshift(end_X,floor(N/2)-j);
                    end_Y=circshift(end_Y,floor(N/2)-j);
                    end_ind = mod(end_ind+(floor(N/2)-j),N);
                    end_ind(end_ind == 0) = N;
                end    
            end    
            
            % Calculate distances from each laser beam to points 
            Dist = zeros(mFRM,N);

            for i = 1:mFRM  
                if i >= start && i <= ending
                   Dist(i,:) = sqrt((nX(i,:)-xc).^2 + (nY(i,:)-yc).^2);
                   D = max(Dist(i,:));
                   Dist(i,:) = D - Dist(i,:);
                end   
            end    
            
            % Estimate the length of cell region under most laser activity influence
            from_to_x = (diag(nX(1,:))*ones(N,N) - ones(N,N)*diag(nX(1,:))).^2;
            from_to_y = (diag(nY(1,:))*ones(N,N) - ones(N,N)*diag(nY(1,:))).^2;
            from_to_d = sqrt(from_to_x+from_to_y);
            [r,c] = find(from_to_d.*(15 < from_to_d & from_to_d < 17));
            disp(median(abs(r-c)));    

            %% Display the analysis results
           
            fig = figure; %('Position',[1,1,1500,300]);
            axis equal;
            axis off;
            colormap(jet);
            %fig.Color = 'black';
            
            % Resulting velocity kymographs
            subplot(2,2,1)
            cla;
            if scale == 0
                imagesc(sV);    
            else
                imagesc(nV);    
            end
            colorbar;

            xlabel('perimeter (counterclockwise)','FontName','Helvetica','FontUnits','pixels','FontSize',12);
            ylabel('<==  time','FontName','Helvetica','FontUnits','pixels','FontSize',12);
            title('Velocity kymograph');

            subplot(2,2,2)
            %Kympograph of each border point position relative to laser
            imagesc(Dist); 
            colorbar;
            xlabel('perimeter (counterclockwise)','FontName','Helvetica','FontUnits','pixels','FontSize',12);
            ylabel('<==  time','FontName','Helvetica','FontUnits','pixels','FontSize',12);
            title('Light Beam distance to edge kymograph');

            subplot(2,2,4)
            %Display border for each time frame
            hold on;
            axis ij;
            axis equal;
            axis off;
            patch(nX(1,:),nY(1,:),'c','EdgeColor','c','FaceColor','none','LineStyle','--','LineWidth',0.5);
            patch(nX(mFRM,:),nY(mFRM,:),'b','EdgeColor','b','FaceColor','none','LineStyle','--','LineWidth',0.5);

            patch(nX(start,:),nY(start,:),'m','EdgeColor','m','FaceColor','none','LineStyle','-','LineWidth',1);
            patch(nX(ending,:),nY(ending,:),'r','EdgeColor','g','FaceColor','none','LineStyle','-','LineWidth',1);
            for i = 1:mFRM 
                x_bord = nX(i,:); y_bord = nY(i,:);
                plot(x_bord(1),y_bord(1),'ko','MarkerFaceColor', 'c'); 
                plot(x_bord(N/2),y_bord(N/2),'ko','MarkerFaceColor', 'w');
            end  
            
            x1 = nX(start,N/2); x2 = nX(ending,N/2);
            y1 = polyval(coeffs,x1); y2 = polyval(coeffs,x2);           
            
            plot(xc,yc,'ko','MarkerFaceColor', 'w','MarkerSize',10);
            plot(nX(start,N/2),nY(start,N/2),'ko','MarkerFaceColor', 'r','MarkerSize',5);
            plot(nX(ending,N/2),nY(ending,N/2),'ko','MarkerFaceColor', 'r','MarkerSize',5);
            line([x2, x1],[y2, y1],'Color','w','LineStyle','--');
            %line([nX(start,N/2), nX(ending,N/2)],[nY(start,N/2), nY(ending,N/2)],'Color','w','LineStyle','--');
            
            h = zeros(4, 1);
            h(1) = plot(NaN,NaN,'--c', 'LineWidth', 2);
            h(2) = plot(NaN,NaN,'--b', 'LineWidth', 2);
            h(3) = plot(NaN,NaN,'-m', 'LineWidth', 2);
            h(4) = plot(NaN,NaN,'-g', 'LineWidth', 2);
            lgd = legend(h,'First border','Last Border','Start of laser','End of laser');
            lgd.FontSize = 4;
            
            subplot(2,2,3)
            %Display the direction of biggest protrusive activity closest
            %to laser and parts of cell borders used for its detection
            %{
            hold on;
            [pks,locs] = findpeaks(F);
            [~,I] = max(pks); I = locs(I);
            time = linspace(1,N,N);
            plot(F);
            scatter(time(locs),F(locs),'r*');
            plot(time(I),F(I),'yo');
            %}
            hold on;
            axis ij;
            axis equal;
            axis off;
            col = parula(mFRM);
            
            plot(smooth_X(ind), smooth_Y(ind),'y');
            plot(end_X(end_ind),end_Y(end_ind),'g');
            
            quiver(smooth_X(ind), smooth_Y(ind), -dy(ind), dx(ind), 'LineWidth', 0.1);
            
            l = sqrt(dy(N/2)^2+dx(N/2)^2); 
            L = 0.9*sqrt((smooth_X(N/2)-end_X(N/2))^2+((smooth_Y(N/2)-end_Y(N/2))^2));
            C = L/l;
            quiver(smooth_X(N/2), smooth_Y(N/2), -C*dy(N/2), C*dx(N/2), 'Color', 'w', 'LineWidth', 0.5);
            
            plot(xc,yc,'ko','MarkerFaceColor', 'w','MarkerSize',10);
            plot(smooth_X(N/2),smooth_Y(N/2),'ko','MarkerFaceColor', 'r','MarkerSize',5);
            plot(end_X(N/2),end_Y(N/2),'ko','MarkerFaceColor', 'r','MarkerSize',5);
            
            %Save all analysis results as figures and mat files in
            %designated folders
            if (imagelag == 1 || imagelag == 5)
                if mode == 0
                    save(['Y:/tsygankov-lab/Nastya Zhurikhina/Mark Andrei/FF Src with MLCK inh/kymos/Mat files (Data)/Velocity Kymograph for Cell ' int2str(gamma) '; Lag = ' num2str(imagelag) ';smoothed.mat'],'sV')
                else
                    save(['Y:/tsygankov-lab/Nastya Zhurikhina/Mark Andrei//FF Src with MLCK inh/kymos/Mat files (Data)/Velocity Kymograph for Cell ' int2str(gamma) '; Lag = ' num2str(imagelag) ';original.mat'],'sV')
                end    
            end
        
      
            fig.InvertHardcopy = 'off';
            if mode == 1
                pic_name = [path 'Original Cell ' int2str(gamma) '; Lag = ',num2str(imagelag),'.png'];
            else
                pic_name = [path 'Small Thresh Cell ' int2str(gamma) '; Lag = ',num2str(imagelag),'.png'];
            end   
            print(pic_name,'-dpng','-r1200');
            close(gcf);
            
        
        end
    end        
end

%% Additional Functions
%Detect the serial number and distance of point closest to the direction of
%maximum protrsive activity
function [D,ind] = min_to_line(pts, v1, v2, xc, yc, xb, yb)
      V = [xc-xb;yc-yb]; L = norm(V); V = V/L; V = repmat(V,1,size(pts,2));
      v = [xc-pts(1,:);yc-pts(2,:)];
      v = repmat(dot(v,V),2,1).*V;  
      cond1 = dot(v,V); cond2 = L - vecnorm(v);
      condition = (cond1 > 0).*(cond2 > 0);  
      distances = abs(v1*pts(1,:)-pts(2,:)+v2)/sqrt(v1^2+1);    
      distances(condition == 0) = max(distances);
      [D,ind] = min(distances);
      if D > 0.5
          D = 0;
      end    
end

%Calculation of Local Velocity
function [db,dx,dy] = DistToBoundU(xo,yo,XB,YB)

    LB=length(XB);
    e=zeros(1,LB); xe=zeros(1,LB); ye=zeros(1,LB);
    for k=1:(LB-1)
        
       x1=XB(k); x2=XB(k+1);
       y1=YB(k); y2=YB(k+1);

       u=((xo-x1)*(x2-x1)+(yo-y1)*(y2-y1))/((x2-x1)^2+(y2-y1)^2);

       if u<=0
           e(k)=(xo-x1)^2+(yo-y1)^2;
           xe(k)=x1; ye(k)=y1;
       elseif u>=1
           e(k)=(xo-x2)^2+(yo-y2)^2;
           xe(k)=x2; ye(k)=y2;
       else
           e(k)=(xo-x1-u*(x2-x1))^2+(yo-y1-u*(y2-y1))^2;
           xe(k)=x1+u*(x2-x1); ye(k)=y1+u*(y2-y1);
       end
       
    end

    x1=XB(LB); x2=XB(1);
    y1=YB(LB); y2=YB(1);
    
    u=((xo-x1)*(x2-x1)+(yo-y1)*(y2-y1))/((x2-x1)^2+(y2-y1)^2);

    if u<=0
        e(LB)=(xo-x1)^2+(yo-y1)^2;
        xe(LB)=x1; ye(LB)=y1;
    elseif u>=1
        e(LB)=(xo-x2)^2+(yo-y2)^2;
        xe(LB)=x2; ye(LB)=y2;
    else
        e(LB)=(xo-x1-u*(x2-x1))^2+(yo-y1-u*(y2-y1))^2;
        xe(LB)=x1+u*(x2-x1); ye(LB)=y1+u*(y2-y1);
    end
      
    [mv,mi]=min(e);
    db = sqrt(mv);
    dx = xe(mi);
    dy = ye(mi);
    if db<1e-12
       db=0;
    end	
end 

%Gaussian Filter
function Y=GFilterA(y,n)
  
    if length(y)<n || n<=1
        Y=y;
        return;
    end
 
    if mod(n,2)==0
        n=n+1;
    end
    ots=floor(n/2);
     
    gs=(n-1)/6;
    gx = linspace(-3*gs,3*gs,n);
    gf = exp( -(gx.^2)/(2*gs^2) );
    gf = gf / sum(gf);
     
    yi=(y(1)+y(2))/2;
    yf=(y(end-1)+y(end))/2;
     
    Y=y; 
    if size(y,1)==1
        yy=[yi*ones(1,ots) y yf*ones(1,ots)];
    elseif size(y,2)==1
        yy=[yi*ones(1,ots) y' yf*ones(1,ots)];
    else
        Y=[];
        return;
    end
             
    for j=1:length(y)
        Y(j)=sum(yy(j:(j+n-1)).*gf);
    end
end  