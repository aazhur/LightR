function soln = fit_cos(func, arg, X0)
    ms = MultiStart;

    t = 0:(length(func)-1);
    xt = 0:0.1:(length(func)-1);
    func = interp1(t,func,xt,'spline');
    t = xt;
    mb = min(func); mxb = max(func) - min(func);
    y = smoothdata(func, 'gaussian',100);
    [~,c,~,a] = findpeaks(y); delta = median(c(2:end) - c(1:(end-1)))*0.1; 
    omega = 2*pi/delta; phase = 2*pi/(0.1*(c(1)-1)); A = median(a);
    %%{   
    if arg == 5
        fun = @(x)(x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16)) - func;
        lb = [2*pi*ones(1,5)/25,zeros(1,5),-pi*ones(1,5),mb];
        ub = [2*pi*ones(1,5)/5,ones(1,5),pi*ones(1,5),mxb];
        x0 = [X0(1:4),omega,X0(5:8),A,X0(9:12),phase,X0(13)];
    elseif arg == 4
        fun = @(x)(x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13)) - func;
        lb = [-pi*ones(1,4),-mxb*ones(1,4),-pi*ones(1,4),mb];
        ub = [pi*ones(1,4),mxb*ones(1,4),pi*ones(1,4),mxb];
        x0 = [X0(1:3),omega,X0(4:6),A,X0(7:9),phase,X0(10)];
    elseif arg == 3
        fun = @(x)(x(4)*cos(x(1)*t+x(7)) + x(5)*cos(x(2)*t+x(8)) + x(6)*cos(x(3)*t+x(9)) + x(10)) - func;
        lb = [-pi*ones(1,3),-mxb*ones(1,3),-pi*ones(1,3),mb];
        ub = [pi*ones(1,3),mxb*ones(1,3),pi*ones(1,3),mxb];
        x0 = [X0(1:2),omega,X0(3:4),A,X0(5:6),phase,X0(7)];
    elseif arg == 2
        fun = @(x)(x(3)*cos(x(1)*t+x(5)) + x(4)*cos(x(2)*t+x(6)) + x(7)) - func;
        lb = [-pi*ones(1,2),-mxb*ones(1,2),-pi*ones(1,2),mb];
        ub = [pi*ones(1,2),mxb*ones(1,2),pi*ones(1,2),mxb];
        x0 = [X0(1),omega,X0(2),A,X0(3),phase,X0(4)];
    elseif arg == 1
        fun = @(x)(x(2)*cos(x(1)*t+x(3)) + x(4)) - func;
        lb = [-pi,-mxb,-pi,mb];
        ub = [pi,mxb,pi,mxb];
        x0 = [omega,A,phase,mb + mxb/2];
    end  
    %x0 = x;
    problem2 = createOptimProblem('lsqnonlin','x0',x0,'objective',fun,'lb',lb,'ub',ub);
    [x,~] = run(ms,problem2,1000);
    soln = x;
    %{
    if arg == 5
        fun = @(x)(X0(5)*cos(X0(1)*t+X0(9))+X0(6)*cos(X0(2)*t+X0(10))+X0(7)*cos(X0(3)*t+X0(11))+X0(8)*cos(X0(4)*t+X0(12))+x(2)*cos(x(1)*t+x(3)) + x(4)) - func;
        lb = [-pi,-mxb,-pi,mb];
        ub = [pi,mxb,pi,mxb];
        x0 = [omega,A,phase,mb + mxb/2];
    elseif arg == 4
        fun = @(x)(X0(4)*cos(X0(1)*t+X0(7)) + X0(5)*cos(X0(2)*t+X0(8)) + X0(6)*cos(X0(3)*t+X0(9)) + x(2)*cos(x(1)*t+x(3)) + x(4)) - func;
        lb = [-pi,-mxb,-pi,mb];
        ub = [pi,mxb,pi,mxb];
        x0 = [omega,A,phase,mb + mxb/2];
    elseif arg == 3
        fun = @(x)(X0(3)*cos(X0(1)*t+X0(5)) + X0(4)*cos(X0(2)*t+X0(6)) + x(2)*cos(x(1)*t+x(3)) + x(4)) - func;
        lb = [-pi,-mxb,-pi,mb];
        ub = [pi,mxb,pi,mxb];
        x0 = [omega,A,phase,mb + mxb/2];
    elseif arg == 2
        fun = @(x)(X0(2)*cos(X0(1)*t+X0(3)) + x(2)*cos(x(1)*t+x(3)) + x(4)) - func;
        lb = [-pi,-mxb,-pi,mb];
        ub = [pi,mxb,pi,mxb];
        x0 = [omega,A,phase,mb + mxb/2];
    elseif arg == 1
        fun = @(x)(x(2)*cos(x(1)*t+x(3)) + x(4)) - func;
        lb = [-pi,-mxb,-pi,mb];
        ub = [pi,mxb,pi,mxb];
        x0 = [omega,A,phase,mb + mxb/2];
    end  
    
    %x0 = x;
    problem2 = createOptimProblem('lsqnonlin','x0',x0,'objective',fun,'lb',lb,'ub',ub);
    [x,~] = run(ms,problem2,1000);
    
    if arg == 1
        soln = x;
    elseif arg == 2
        soln = [X0(1),x(1),X0(2),x(2),X0(3),x(3),x(4)];
    elseif arg == 3
        soln = [X0(1),X0(2),x(1),X0(3),X0(4),x(2),X0(5),X0(6),x(3),x(4)];
    elseif arg == 4
        soln = [X0(1),X0(2),X0(3),x(1),X0(4),X0(5),X0(6),x(2),X0(7),X0(8),X0(9),x(3),x(4)];
    elseif arg == 5
        soln = [X0(1:4),x(1),X0(5:8),x(2),X0(9:12),x(3),x(4)];
    end 
    %}
end
