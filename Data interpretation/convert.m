set(0,'DefaultFigureColor','w',...
      'DefaultAxesColor','w',...
      'DefaultAxesXColor','k',...
      'DefaultAxesYColor','k',...
      'DefaultAxesZColor','k',...
      'DefaultTextColor','k',...
      'DefaultLineColor','k')

for percent = 3:3
f1 = load(['Data Free/Data1_', num2str(percent), '.mat']); f1m = load(['Data Median/Data1_', num2str(percent), '.mat']);
f2 = load(['Data Free/Data2_', num2str(percent), '.mat']); f2m = load(['Data Median/Data2_', num2str(percent), '.mat']);
f3 = load(['Data Free/Data3_', num2str(percent), '.mat']); f3m = load(['Data Median/Data3_', num2str(percent), '.mat']);

Locs1 = f1.Locs; Pks1 = f1.Pks; locs1 = f1.f; pks1 = f1.pxx; m1 = f1.middle_line; S1 = f1.S; 
Locs2 = f2.Locs; Pks2 = f2.Pks; locs2 = f2.f; pks2 = f2.pxx; m2 = f2.middle_line; S2 = f2.S; 
Locs3 = f3.Locs; Pks3 = f3.Pks; locs3 = f3.f; pks3 = f3.pxx; m3 = f3.middle_line; S3 = f3.S; 

xm11 = f1m.x1; xm12 = f1m.x2; xm13 = f1m.x3;
xm21 = f2m.x1; xm22 = f2m.x2; xm23 = f2m.x3;
xm31 = f3m.x1; xm32 = f3m.x2; xm33 = f3m.x3;

x11 = f1.x1; X11 = f1.X1; x12 = f1.x2; X12 = f1.X2; x13 = f1.x3; X13 = f1.X3; x14 = f1.x4; X14 = f1.X4; x15 = f1.x5; X15 = f1.X5; 
x21 = f2.x1; X21 = f2.X1; x22 = f2.x2; X22 = f2.X2; x23 = f2.x3; X23 = f2.X3; x24 = f2.x4; X24 = f2.X4; x25 = f2.x5; X25 = f2.X5;
x31 = f3.x1; X31 = f3.X1; x32 = f3.x2; X32 = f3.X2; x33 = f3.x3; X33 = f3.X3; x34 = f3.x4; X34 = f3.X4; x35 = f3.x5; X35 = f3.X5;

Znak11 = sign(X11(:,1)); Znak12 = sign(X12(:,1:2)); Znak13 = sign(X13(:,1:3)); Znak14 = sign(X14(:,1:4)); Znak15 = sign(X15(:,1:5));
Znak21 = sign(X21(:,1)); Znak22 = sign(X22(:,1:2)); Znak23 = sign(X23(:,1:3)); Znak24 = sign(X24(:,1:4)); Znak25 = sign(X25(:,1:5));
Znak31 = sign(X31(:,1)); Znak32 = sign(X32(:,1:2)); Znak33 = sign(X33(:,1:3)); Znak34 = sign(X34(:,1:4)); Znak35 = sign(X35(:,1:5));

znak11 = sign(x11(:,1)); znak12 = sign(x12(:,1:2)); znak13 = sign(x13(:,1:3)); znak14 = sign(x14(:,1:4)); znak15 = sign(x15(:,1:5));
znak21 = sign(x21(:,1)); znak22 = sign(x22(:,1:2)); znak23 = sign(x23(:,1:3)); znak24 = sign(x24(:,1:4)); znak25 = sign(x25(:,1:5));
znak31 = sign(x31(:,1)); znak32 = sign(x32(:,1:2)); znak33 = sign(x33(:,1:3)); znak34 = sign(x34(:,1:4)); znak35 = sign(x35(:,1:5));

pi11 = zeros(1,1); pi12 = zeros(1,2); pi13 = zeros(1,3); pi14 = zeros(1,4); pi15 = zeros(1,5);
pi21 = zeros(1,1); pi22 = zeros(1,2); pi23 = zeros(1,3); pi24 = zeros(1,4); pi25 = zeros(1,5);
pi31 = zeros(1,1); pi32 = zeros(1,2); pi33 = zeros(1,3); pi34 = zeros(1,4); pi35 = zeros(1,5);

pos11 = zeros(1,1); pos12 = zeros(1,2); pos13 = zeros(1,3); pos14 = zeros(1,4); pos15 = zeros(1,5);
pos21 = zeros(1,1); pos22 = zeros(1,2); pos23 = zeros(1,3); pos24 = zeros(1,4); pos25 = zeros(1,5);
pos31 = zeros(1,1); pos32 = zeros(1,2); pos33 = zeros(1,3); pos34 = zeros(1,4); pos35 = zeros(1,5);

pi11(x11(:,2) < 0) = pi; pi12(x12(:,3:4) < 0) = pi; pi13(x13(:,4:6) < 0) = pi; pi14(x14(:,5:8) < 0) = pi; pi15(x15(:,6:10) < 0) = pi;
pi21(x21(:,2) < 0) = pi; pi22(x22(:,3:4) < 0) = pi; pi23(x23(:,4:6) < 0) = pi; pi24(x24(:,5:8) < 0) = pi; pi25(x25(:,6:10) < 0) = pi;
pi31(x31(:,2) < 0) = pi; pi32(x32(:,3:4) < 0) = pi; pi33(x33(:,4:6) < 0) = pi; pi34(x34(:,5:8) < 0) = pi; pi35(x35(:,6:10) < 0) = pi;

znakm11 = sign(xm11(:,1)); znakm12 = sign(xm12(:,1:2)); znakm13 = sign(xm13(:,1:3)); %znakm14 = sign(xm14(:,1:4));
znakm21 = sign(xm21(:,1)); znakm22 = sign(xm22(:,1:2)); znakm23 = sign(xm23(:,1:3)); %znakm24 = sign(xm24(:,1:4));
znakm31 = sign(xm31(:,1)); znakm32 = sign(xm32(:,1:2)); znakm33 = sign(xm33(:,1:3)); %znakm34 = sign(xm34(:,1:4));

pim11 = zeros(1,1); pim12 = zeros(1,2); pim13 = zeros(1,3); posm11 = zeros(1,1); posm12 = zeros(1,2); posm13 = zeros(1,3);
pim21 = zeros(1,1); pim22 = zeros(1,2); pim23 = zeros(1,3); posm21 = zeros(1,1); posm22 = zeros(1,2); posm23 = zeros(1,3);
pim31 = zeros(1,1); pim32 = zeros(1,2); pim33 = zeros(1,3); posm31 = zeros(1,1); posm32 = zeros(1,2); posm33 = zeros(1,3);

pim11(xm11(:,2) < 0) = pi; pim12(xm12(:,3:4) < 0) = pi; pim13(xm13(:,4:6) < 0) = pi;
pim21(xm21(:,2) < 0) = pi; pim22(xm22(:,3:4) < 0) = pi; pim23(xm23(:,4:6) < 0) = pi;
pim31(xm31(:,2) < 0) = pi; pim32(xm32(:,3:4) < 0) = pi; pim33(xm33(:,4:6) < 0) = pi;

x11(:,2) = abs(x11(:,2)); x12(:,3:4) = abs(x12(:,3:4)); x13(:,4:6) = abs(x13(:,4:6)); x14(:,5:8) = abs(x14(:,5:8)); x15(:,6:10) = abs(x15(:,6:10));
x21(:,2) = abs(x21(:,2)); x22(:,3:4) = abs(x22(:,3:4)); x23(:,4:6) = abs(x23(:,4:6)); x24(:,5:8) = abs(x24(:,5:8)); x25(:,6:10) = abs(x25(:,6:10));
x31(:,2) = abs(x31(:,2)); x32(:,3:4) = abs(x32(:,3:4)); x33(:,4:6) = abs(x33(:,4:6)); x34(:,5:8) = abs(x34(:,5:8)); x35(:,6:10) = abs(x35(:,6:10));

xm11(:,2) = abs(xm11(:,2)); xm12(:,3:4) = abs(xm12(:,3:4)); xm13(:,4:6) = abs(xm13(:,4:6));
xm21(:,2) = abs(xm21(:,2)); xm22(:,3:4) = abs(xm22(:,3:4)); xm23(:,4:6) = abs(xm23(:,4:6));
xm31(:,2) = abs(xm31(:,2)); xm32(:,3:4) = abs(xm32(:,3:4)); xm33(:,4:6) = abs(xm33(:,4:6));


[x15(6:10),ind] = sort(x15(6:10), 'descend'); x15(1:5) = x15(ind); x15(11:15) = x15(10+ind); znak15(1:5) = znak15(ind); pi15(1:5) = pi15(ind);
[x25(6:10),ind] = sort(x25(6:10), 'descend'); x25(1:5) = x25(ind); x25(11:15) = x25(10+ind); znak25(1:5) = znak25(ind); pi25(1:5) = pi25(ind);
[x35(6:10),ind] = sort(x35(6:10), 'descend'); x35(1:5) = x35(ind); x35(11:15) = x35(10+ind); znak35(1:5) = znak35(ind); pi35(1:5) = pi35(ind);

[x14(5:8),ind] = sort(x14(5:8), 'descend'); x14(1:4) = x14(ind); x14(9:12) = x14(8+ind); znak14(1:4) = znak14(ind); pi14(1:4) = pi14(ind);
[x24(5:8),ind] = sort(x24(5:8), 'descend'); x24(1:4) = x24(ind); x24(9:12) = x24(8+ind); znak24(1:4) = znak24(ind); pi24(1:4) = pi24(ind);
[x34(5:8),ind] = sort(x34(5:8), 'descend'); x34(1:4) = x34(ind); x34(9:12) = x34(8+ind); znak34(1:4) = znak34(ind); pi34(1:4) = pi34(ind);

[x13(4:6),ind] = sort(x13(4:6), 'descend'); x13(1:3) = x13(ind); x13(7:9) = x13(6+ind); znak13(1:3) = znak13(ind); pi13(1:3) = pi13(ind);
[x23(4:6),ind] = sort(x23(4:6), 'descend'); x23(1:3) = x23(ind); x23(7:9) = x23(6+ind); znak23(1:3) = znak23(ind); pi23(1:3) = pi23(ind);
[x33(4:6),ind] = sort(x33(4:6), 'descend'); x33(1:3) = x33(ind); x33(7:9) = x33(6+ind); znak33(1:3) = znak33(ind); pi33(1:3) = pi33(ind);

[x12(3:4),ind] = sort(x12(3:4), 'descend'); x12(1:2) = x12(ind); x12(5:6) = x12(4+ind); znak12(1:2) = znak12(ind); pi12(1:2) = pi12(ind);
[x22(3:4),ind] = sort(x22(3:4), 'descend'); x22(1:2) = x22(ind); x22(5:6) = x22(4+ind); znak22(1:2) = znak22(ind); pi22(1:2) = pi22(ind);
[x32(3:4),ind] = sort(x32(3:4), 'descend'); x32(1:2) = x32(ind); x32(5:6) = x32(4+ind); znak32(1:2) = znak32(ind); pi32(1:2) = pi32(ind);

[xm13(4:6),ind] = sort(xm13(4:6), 'descend'); xm13(1:3) = xm13(ind); xm13(7:9) = xm13(6+ind); znakm13(1:3) = znakm13(ind); pim13(1:3) = pim13(ind);
[xm23(4:6),ind] = sort(xm23(4:6), 'descend'); xm23(1:3) = xm23(ind); xm23(7:9) = xm23(6+ind); znakm23(1:3) = znakm23(ind); pim23(1:3) = pim23(ind);
[xm33(4:6),ind] = sort(xm33(4:6), 'descend'); xm33(1:3) = xm33(ind); xm33(7:9) = xm33(6+ind); znakm33(1:3) = znakm33(ind); pim33(1:3) = pim33(ind);

[xm12(3:4),ind] = sort(xm12(3:4), 'descend'); xm12(1:2) = xm12(ind); xm12(5:6) = xm12(4+ind); znakm12(1:2) = znakm12(ind); pim12(1:2) = pim12(ind);
[xm22(3:4),ind] = sort(xm22(3:4), 'descend'); xm22(1:2) = xm22(ind); xm22(5:6) = xm22(4+ind); znakm22(1:2) = znakm22(ind); pim22(1:2) = pim22(ind);
[xm32(3:4),ind] = sort(xm32(3:4), 'descend'); xm32(1:2) = xm32(ind); xm32(5:6) = xm32(4+ind); znakm32(1:2) = znakm32(ind); pim32(1:2) = pim32(ind);

Pi11 = zeros(20,1); Pi12 = zeros(20,2); Pi13 = zeros(20,3); Pi14 = zeros(20,4); Pi15 = zeros(20,5); 
Pi21 = zeros(24,1); Pi22 = zeros(24,2); Pi23 = zeros(24,3); Pi24 = zeros(24,4); Pi25 = zeros(24,5);
Pi31 = zeros(20,1); Pi32 = zeros(20,2); Pi33 = zeros(20,3); Pi34 = zeros(20,4); Pi35 = zeros(20,5);

Pos11 = zeros(20,1); Pos12 = zeros(20,2); Pos13 = zeros(20,3); Pos14 = zeros(20,4); Pos15 = zeros(20,5);
Pos21 = zeros(24,1); Pos22 = zeros(24,2); Pos23 = zeros(24,3); Pos24 = zeros(24,4); Pos25 = zeros(24,5);
Pos31 = zeros(20,1); Pos32 = zeros(20,2); Pos33 = zeros(20,3); Pos34 = zeros(20,4); Pos35 = zeros(20,5);
 
Pi11(X11(:,2) < 0) = pi; Pi12(X12(:,3:4) < 0) = pi; Pi13(X13(:,4:6) < 0) = pi; Pi14(X14(:,5:8) < 0) = pi; Pi15(X15(:,6:10) < 0) = pi;
Pi21(X21(:,2) < 0) = pi; Pi22(X22(:,3:4) < 0) = pi; Pi23(X23(:,4:6) < 0) = pi; Pi24(X24(:,5:8) < 0) = pi; Pi25(X25(:,6:10) < 0) = pi;
Pi31(X31(:,2) < 0) = pi; Pi32(X32(:,3:4) < 0) = pi; Pi33(X33(:,4:6) < 0) = pi; Pi34(X34(:,5:8) < 0) = pi; Pi35(X35(:,6:10) < 0) = pi;

X11(:,2) = abs(X11(:,2)); X21(:,2) = abs(X21(:,2)); X31(:,2) = abs(X31(:,2));

for i = 1:20
    [~,ind] = sort(abs(X15(i,6:10)), 'descend');
    X15(i,1:5) = X15(i,ind); X15(i,6:10) = X15(i,5+ind); X15(i,11:15) = X15(i,10+ind);
    Znak15(i,1:5) = Znak15(i,ind); Pi15(i,1:5) = Pi15(i,ind);
end

for i = 1:24
    [~,ind] = sort(abs(X25(i,6:10)), 'descend');
    X25(i,1:5) = X25(i,ind); X25(i,6:10) = X25(i,5+ind); X25(i,11:15) = X25(i,10+ind);
    Znak25(i,1:5) = Znak25(i,ind); Pi25(i,1:5) = Pi25(i,ind);
end

for i = 1:20
    [~,ind] = sort(abs(X35(i,6:10)), 'descend');
    X35(i,1:5) = X35(i,ind); X35(i,6:10) = X35(i,5+ind); X35(i,11:15) = X35(i,10+ind);
    Znak35(i,1:5) = Znak35(i,ind); Pi35(i,1:5) = Pi35(i,ind);
end


for i = 1:20
    [~,ind] = sort(abs(X14(i,5:8)), 'descend');
    X14(i,1:4) = X14(i,ind); X14(i,5:8) = X14(i,4+ind); X14(i,9:12) = X14(i,8+ind);
    Znak14(i,1:4) = Znak14(i,ind); Pi14(i,1:4) = Pi14(i,ind);
end

for i = 1:24
    [~,ind] = sort(abs(X24(i,5:8)), 'descend');
    X24(i,1:4) = X24(i,ind); X24(i,5:8) = X24(i,4+ind); X24(i,9:12) = X24(i,8+ind);
    Znak24(i,1:4) = Znak24(i,ind); Pi24(i,1:4) = Pi24(i,ind);
end

for i = 1:20
    [~,ind] = sort(abs(X34(i,5:8)), 'descend');
    X34(i,1:4) = X34(i,ind); X34(i,5:8) = X34(i,4+ind); X34(i,9:12) = X34(i,8+ind);
    Znak34(i,1:4) = Znak34(i,ind); Pi34(i,1:4) = Pi34(i,ind);
end

for i = 1:20
    [~,ind] = sort(abs(X13(i,4:6)), 'descend');
    X13(i,1:3) = X13(i,ind); X13(i,4:6) = X13(i,3+ind); X13(i,7:9) = X13(i,6+ind);
    Znak13(i,1:3) = Znak13(i,ind); Pi13(i,1:3) = Pi13(i,ind);
end

for i = 1:24
    [~,ind] = sort(abs(X23(i,4:6)), 'descend');
    X23(i,1:3) = X23(i,ind); X23(i,4:6) = X23(i,3+ind); X23(i,7:9) = X23(i,6+ind);
    Znak23(i,1:3) = Znak23(i,ind); Pi23(i,1:3) = Pi23(i,ind);
end

for i = 1:20
    [~,ind] = sort(abs(X33(i,4:6)), 'descend');
    X33(i,1:3) = X33(i,ind); X33(i,4:6) = X33(i,3+ind); X33(i,7:9) = X33(i,6+ind);
    Znak33(i,1:3) = Znak33(i,ind); Pi33(i,1:3) = Pi33(i,ind);
end

for i = 1:20
    [~,ind] = sort(abs(X12(i,3:4)), 'descend');
    X12(i,1:2) = X12(i,ind); X12(i,3:4) = X12(i,2+ind); X12(i,5:6) = X12(i,4+ind);
    Znak12(i,1:2) = Znak12(i,ind); Pi12(i,1:2) = Pi12(i,ind);
end

for i = 1:24
    [~,ind] = sort(abs(X22(i,3:4)), 'descend');
    X22(i,1:2) = X22(i,ind); X22(i,3:4) = X22(i,2+ind); X22(i,5:6) = X22(i,4+ind);
    Znak22(i,1:2) = Znak22(i,ind); Pi22(i,1:2) = Pi22(i,ind);
end

for i = 1:20
    [~,ind] = sort(abs(X32(i,3:4)), 'descend');
    X32(i,1:2) = X32(i,ind); X32(i,3:4) = X32(i,2+ind); X32(i,5:6) = X32(i,4+ind);
    Znak32(i,1:2) = Znak32(i,ind); Pi32(i,1:2) = Pi32(i,ind);
end

X11(:,3) = X11(:,3).*Znak11 + Pi11; X12(:,5:6) = X12(:,5:6).*Znak12 + Pi12; X13(:,7:9) = X13(:,7:9).*Znak13 + Pi13; X14(:,9:12) = X14(:,9:12).*Znak14 + Pi14; X15(:,11:15) = X15(:,11:15).*Znak15 + Pi15;
X21(:,3) = X21(:,3).*Znak21 + Pi21; X22(:,5:6) = X22(:,5:6).*Znak22 + Pi22; X23(:,7:9) = X23(:,7:9).*Znak23 + Pi23; X24(:,9:12) = X24(:,9:12).*Znak24 + Pi24; X25(:,11:15) = X25(:,11:15).*Znak25 + Pi25;
X31(:,3) = X31(:,3).*Znak31 + Pi31; X32(:,5:6) = X32(:,5:6).*Znak32 + Pi32; X33(:,7:9) = X33(:,7:9).*Znak33 + Pi33; X34(:,9:12) = X34(:,9:12).*Znak34 + Pi34; X35(:,11:15) = X35(:,11:15).*Znak35 + Pi35;

Pos11(X11(:,3) < 0) = 2*pi; Pos12(X12(:,5:6) < 0) = 2*pi; Pos13(X13(:,7:9) < 0) = 2*pi; Pos14(X14(:,9:12) < 0) = 2*pi; Pos15(X15(:,11:15) < 0) = 2*pi;
Pos21(X21(:,3) < 0) = 2*pi; Pos22(X22(:,5:6) < 0) = 2*pi; Pos23(X23(:,7:9) < 0) = 2*pi; Pos24(X24(:,9:12) < 0) = 2*pi; Pos25(X25(:,11:15) < 0) = 2*pi;
Pos31(X31(:,3) < 0) = 2*pi; Pos32(X32(:,5:6) < 0) = 2*pi; Pos33(X33(:,7:9) < 0) = 2*pi; Pos34(X34(:,9:12) < 0) = 2*pi; Pos35(X35(:,11:15) < 0) = 2*pi;

X11(:,3) = X11(:,3) + Pos11; X12(:,5:6) = X12(:,5:6) + Pos12; X13(:,7:9) = X13(:,7:9) + Pos13; X14(:,9:12) = X14(:,9:12) + Pos14; X15(:,11:15) = X15(:,11:15) + Pos15;
X21(:,3) = X21(:,3) + Pos21; X22(:,5:6) = X22(:,5:6) + Pos22; X23(:,7:9) = X23(:,7:9) + Pos23; X24(:,9:12) = X24(:,9:12) + Pos24; X25(:,11:15) = X25(:,11:15) + Pos25;
X31(:,3) = X31(:,3) + Pos31; X32(:,5:6) = X32(:,5:6) + Pos32; X33(:,7:9) = X33(:,7:9) + Pos33; X34(:,9:12) = X34(:,9:12) + Pos34; X35(:,11:15) = X35(:,11:15) + Pos35;

X11(:,1:3) = abs(X11(:,1:3)); X12(:,1:6) = abs(X12(:,1:6)); X13(:,1:9) = abs(X13(:,1:9)); X14(:,1:12) = abs(X14(:,1:12)); X15(:,1:15) = abs(X15(:,1:15));
X21(:,1:3) = abs(X21(:,1:3)); X22(:,1:6) = abs(X22(:,1:6)); X23(:,1:9) = abs(X23(:,1:9)); X24(:,1:12) = abs(X24(:,1:12)); X25(:,1:15) = abs(X25(:,1:15));
X31(:,1:3) = abs(X31(:,1:3)); X32(:,1:6) = abs(X32(:,1:6)); X33(:,1:9) = abs(X33(:,1:9)); X34(:,1:12) = abs(X34(:,1:12)); X35(:,1:15) = abs(X35(:,1:15));

x11(:,3) = x11(:,3).*znak11 + pi11; x12(:,5:6) = x12(:,5:6).*znak12 + pi12; x13(:,7:9) = x13(:,7:9).*znak13 + pi13; x14(:,9:12) = x14(:,9:12).*znak14 + pi14; x15(:,11:15) = x15(:,11:15).*znak15 + pi15;
x21(:,3) = x21(:,3).*znak21 + pi21; x22(:,5:6) = x22(:,5:6).*znak22 + pi22; x23(:,7:9) = x23(:,7:9).*znak23 + pi23; x24(:,9:12) = x24(:,9:12).*znak24 + pi24; x25(:,11:15) = x25(:,11:15).*znak25 + pi25;
x31(:,3) = x31(:,3).*znak31 + pi31; x32(:,5:6) = x32(:,5:6).*znak32 + pi32; x33(:,7:9) = x33(:,7:9).*znak33 + pi33; x34(:,9:12) = x34(:,9:12).*znak34 + pi34; x35(:,11:15) = x35(:,11:15).*znak35 + pi35;

pos11(x11(:,3) < 0) = 2*pi; pos12(x12(:,5:6) < 0) = 2*pi; pos13(x13(:,7:9) < 0) = 2*pi; pos14(x14(:,9:12) < 0) = 2*pi; pos15(x15(:,11:15) < 0) = 2*pi;
pos21(x21(:,3) < 0) = 2*pi; pos22(x22(:,5:6) < 0) = 2*pi; pos23(x23(:,7:9) < 0) = 2*pi; pos24(x24(:,9:12) < 0) = 2*pi; pos25(x25(:,11:15) < 0) = 2*pi;
pos31(x31(:,3) < 0) = 2*pi; pos32(x32(:,5:6) < 0) = 2*pi; pos33(x33(:,7:9) < 0) = 2*pi; pos34(x34(:,9:12) < 0) = 2*pi; pos35(x35(:,11:15) < 0) = 2*pi;

x11(:,3) = x11(:,3) + pos11; x12(:,5:6) = x12(:,5:6) + pos12; x13(:,7:9) = x13(:,7:9) + pos13; x14(:,9:12) = x14(:,9:12) + pos14; x15(:,11:15) = x15(:,11:15) + pos15;
x21(:,3) = x21(:,3) + pos21; x22(:,5:6) = x22(:,5:6) + pos22; x23(:,7:9) = x23(:,7:9) + pos23; x24(:,9:12) = x24(:,9:12) + pos24; x25(:,11:15) = x25(:,11:15) + pos25;
x31(:,3) = x31(:,3) + pos31; x32(:,5:6) = x32(:,5:6) + pos32; x33(:,7:9) = x33(:,7:9) + pos33; x34(:,9:12) = x34(:,9:12) + pos34; x35(:,11:15) = x35(:,11:15) + pos35;

x11(1:3) = abs(x11(1:3)); x12(1:6) = abs(x12(1:6)); x13(1:9) = abs(x13(1:9)); x14(1:12) = abs(x14(1:12)); x15(1:15) = abs(x15(1:15));
x21(1:3) = abs(x21(1:3)); x22(1:6) = abs(x22(1:6)); x23(1:9) = abs(x23(1:9)); x24(1:12) = abs(x24(1:12)); x25(1:15) = abs(x25(1:15));
x31(1:3) = abs(x31(1:3)); x32(1:6) = abs(x32(1:6)); x33(1:9) = abs(x33(1:9)); x34(1:12) = abs(x34(1:12)); x35(1:15) = abs(x35(1:15));

xm11(:,3) = xm11(:,3).*znakm11 + pim11; xm12(:,5:6) = xm12(:,5:6).*znakm12 + pim12; xm13(:,7:9) = xm13(:,7:9).*znakm13 + pim13;
xm21(:,3) = xm21(:,3).*znakm21 + pim21; xm22(:,5:6) = xm22(:,5:6).*znakm22 + pim22; xm23(:,7:9) = xm23(:,7:9).*znakm23 + pim23;
xm31(:,3) = xm31(:,3).*znakm31 + pim31; xm32(:,5:6) = xm32(:,5:6).*znakm32 + pim32; xm33(:,7:9) = xm33(:,7:9).*znakm33 + pim33;

posm11(xm11(:,3) < 0) = 2*pi; posm12(xm12(:,5:6) < 0) = 2*pi; posm13(xm13(:,7:9) < 0) = 2*pi;
posm21(xm21(:,3) < 0) = 2*pi; posm22(xm22(:,5:6) < 0) = 2*pi; posm23(xm23(:,7:9) < 0) = 2*pi;
posm31(xm31(:,3) < 0) = 2*pi; posm32(xm32(:,5:6) < 0) = 2*pi; posm33(xm33(:,7:9) < 0) = 2*pi;

xm11(:,3) = xm11(:,3) + posm11; xm12(:,5:6) = xm12(:,5:6) + posm12; xm13(:,7:9) = xm13(:,7:9) + posm13;
xm21(:,3) = xm21(:,3) + posm21; xm22(:,5:6) = xm22(:,5:6) + posm22; xm23(:,7:9) = xm23(:,7:9) + posm23;
xm31(:,3) = xm31(:,3) + posm31; xm32(:,5:6) = xm32(:,5:6) + posm32; xm33(:,7:9) = xm33(:,7:9) + posm33;

xm11(1:3) = abs(xm11(1:3)); xm12(1:6) = abs(xm12(1:6)); xm13(1:9) = abs(xm13(1:9));
xm21(1:3) = abs(xm21(1:3)); xm22(1:6) = abs(xm22(1:6)); xm23(1:9) = abs(xm23(1:9));
xm31(1:3) = abs(xm31(1:3)); xm32(1:6) = abs(xm32(1:6)); xm33(1:9) = abs(xm33(1:9));

%{
figure;
for i = 1:20
    subplot(4,5,i);
    hold on;
    t = 0:55;
    x = X31(i,:);
    plot(t, x(2)*cos(x(1)*t+x(3)) + x(4));
    x = f3.X1; x = x(i,:);
    plot(t, x(2)*cos(x(1)*t+x(3)) + x(4));
end    

figure;
for i = 1:20
    subplot(4,5,i);
    hold on;
    t = 0:55;
    x = X32(i,:);
    plot(t, x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7));
    x = f3.X2; x = x(i,:);
    plot(t, x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7));
end    

figure;
for i = 1:20
    subplot(4,5,i);
    hold on;
    t = 0:55;
    x = X33(i,:);
    plot(t, x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10));
    x = f3.X3; x = x(i,:);
    plot(t, x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10));
end    

figure;
for i = 1:20
    subplot(4,5,i);
    hold on;
    t = 0:55;
    x = X34(i,:);
    plot(t,x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13));
    x = f3.X4; x = x(i,:);
    plot(t,x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13));
end    
%}

save([pwd, '/Data Free/Data1', num2str(percent),'.mat'],'Pks1','Locs1','S1','pks1','locs1','m1','x11','x12','x13','xm11','xm12','xm13','X11','X12','X13');
save([pwd, '/Data Free/Data2', num2str(percent),'.mat'],'Pks2','Locs2','S2','pks2','locs2','m2','x21','x22','x23','xm21','xm22','xm23','X21','X22','X23');
save([pwd, '/Data Free/Data3', num2str(percent),'.mat'],'Pks3','Locs3','S3','pks3','locs3','m3','x31','x32','x33','xm31','xm32','xm33','X31','X32','X33');

%err = zeros(3,5);
T1 = zeros(20,3);
figure;
subplot(2,3,1);
hold on;
t = 0:55;
x = x11; est = x(2)*cos(x(1)*t+x(3)) + x(4);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X11(i,:); est = x(2)*cos(x(1)*t+x(3)) + x(4);
    n = ceil(length(l)/2);
    [~,L] = findpeaks(est); T1(i,1) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--m');
    total = total + est;
end 
total11 = total/20;
x = x11; est = x(2)*cos(x(1)*t+x(3)) + x(4);
plot(t, est, '-m', 'Linewidth', 2);
plot(t, total11, '-w', 'Linewidth', 2);
%err(1,1) = goodnessOfFit(est,total11,'MSE');
axis tight;
title('1 Cos');

subplot(2,3,2);
hold on;
t = 0:55;
x = x12; est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X12(i,:); est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
    n = ceil(length(l)/2);
    [~,L] = findpeaks(est); T1(i,2) = min(abs(L-l(n)))*0.1;
    plot(t, est,'--m');
    total = total + est;
end 
total12 = total/20;
x = x12; est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
plot(t, est,'-m', 'Linewidth', 2);
plot(t, total12, '-w', 'Linewidth', 2);
%err(1,2) = goodnessOfFit(est,total12,'MSE');
axis tight;
title('2 Cos');

subplot(2,3,3);
hold on;
t = 0:55;
x = x13; est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X13(i,:); est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
    n = ceil(length(l)/2);
    [~,L] = findpeaks(est); T1(i,3) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--m');
    total = total + est;
end 
total13 = total/20;
x = x13; est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
plot(t, est, '-m', 'Linewidth', 2);
plot(t, total13, '-w', 'Linewidth', 2);
%err(1,3) = goodnessOfFit(est,total13,'MSE');
axis tight;
title('3 Cos');

subplot(2,3,4);
hold on;
t = 0:55;
x = x14; est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X14(i,:); est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T1(i,3) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--m');
    total = total + est;
end 
total14 = total/20;
x = x14; est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
plot(t, est, '-m', 'Linewidth', 2);
plot(t, total14, '-w', 'Linewidth', 2);
%err(1,4) = goodnessOfFit(est,total14,'MSE');
axis tight;
title('4 Cos');

subplot(2,3,5);
hold on;
t = 0:0.1:55;
x = x15; est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
[~,L] = findpeaks(est);
total = 0;
MM1 = zeros(20,2);
for i = 1:20
    x = X15(i,:); est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    prom = (max(est)-min(est))/4;
    tf = islocalmin(est,'MinProminence',prom); l = islocalmax(est,'MinProminence',prom); 
    [MM1(i,1), I] = max(est(l));
    [~,ind] = min(abs(I-tf));
    MM1(i,2) = min(est(tf(ind)));
    plot(t, est, '--m');
    total = total + est;
end 
total15 = total/20;
x = x15; est15 = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
plot(t, est15, '-m', 'Linewidth', 2);
plot(t, total15, '-w', 'Linewidth', 2);
%err(1,5) = goodnessOfFit(est15,total15,'MSE');
axis tight;
title('5 Cos');

subplot(2,3,6);
hold on;
total = 0;
%err1 = zeros(20,5);
vhist1 = [];
Control = zeros(20,56);
for i = 1:20
    t = 0:55;
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/Local stimulation FF 20.50.20/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    [~,n] = size(sV); k = n/2; delta = ceil(n*percent/100);
    M = sV(:,(k-delta):(k+delta)); Vel = mean(M,2)';
    v = Vel(16:71);
    Control(i,:) = v;
    vhist1 = [vhist1, v];
    
    x = X11(i,:); est1 = x(2)*cos(x(1)*t+x(3))+x(4);
    x = X12(i,:); est2 = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6))+x(7);
    x = X13(i,:); est3 = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9))+x(10);
    x = X14(i,:); est4 = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
    x = X15(i,:); est5 = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    cost_func = 'MSE';
    %err1(i,1) = goodnessOfFit(est1,v,cost_func);
    %err1(i,2) = goodnessOfFit(est2,v,cost_func);
    %err1(i,3) = goodnessOfFit(est3,v,cost_func);
    %err1(i,4) = goodnessOfFit(est4,v,cost_func);
    %err1(i,5) = goodnessOfFit(est5,v,cost_func);
    total = total + sV;
    plot(t,v,'--m');
end    
total = total/20;
[~,n] = size(total); k = n/2;
delta = ceil(n*percent/100);
V = mean(total(:,k-delta:k+delta),2)'; 
func = V(16:71); 
plot(t, func, '-m', 'Linewidth', 2);
%err(1,1) = goodnessOfFit(func,total11,'MSE');
%err(1,2) = goodnessOfFit(func,total12,'MSE');
%err(1,3) = goodnessOfFit(func,total13,'MSE');
%err(1,4) = goodnessOfFit(func,total14,'MSE');
%err(1,5) = goodnessOfFit(func,total15,'MSE');
axis tight;
title('Mean');


T2 = zeros(24,3);
figure;
subplot(2,3,1);
hold on;
t = 0:55;
x = x21; est = x(2)*cos(x(1)*t+x(3)) + x(4);
[~,l] = findpeaks(est);
total = 0;
for i = 1:24
    x = X21(i,:); est = x(2)*cos(x(1)*t+x(3)) + x(4);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T2(i,1) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--c');
    total = total + est;
end 
total21 = total/24;
x = x21; est = x(2)*cos(x(1)*t+x(3)) + x(4);
plot(t, est, '-c', 'Linewidth', 2);
plot(t, total21, '-w', 'Linewidth', 2);
%err(2,1) = goodnessOfFit(est,total21,'MSE');
axis tight;
title('1 Cos');

subplot(2,3,2);
hold on;
t = 0:55;
x = x22; est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
[~,l] = findpeaks(est);
total = 0;
for i = 1:24
    x = X22(i,:); est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T2(i,2) = min(abs(L-l(n)))*0.1;
    plot(t, est,'--c');
    total = total + est;
end 
total22 = total/24;
x = x22; est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
plot(t, est,'-c', 'Linewidth', 2);
plot(t, total22, '-w', 'Linewidth', 2);
%err(2,2) = goodnessOfFit(est,total22,'MSE');
axis tight;
title('2 Cos');

subplot(2,3,3);
hold on;
t = 0:55;
x = x23; est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
[~,l] = findpeaks(est);
total = 0;
for i = 1:24
    x = X23(i,:); est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T2(i,3) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--c');
    total = total + est;
end 
total23 = total/24;
x = x23; est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
plot(t, est, '-c', 'Linewidth', 2);
plot(t, total23, '-w', 'Linewidth', 2);
%err(2,3) = goodnessOfFit(est,total23,'MSE');
axis tight;
title('3 Cos');


subplot(2,3,4);
hold on;
t = 0:55;
x = x24; est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
[~,l] = findpeaks(est);
total = 0;
for i = 1:24
    x = X24(i,:); est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T1(i,3) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--c');
    total = total + est;
end 
total24 = total/24;
x = x24; est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
plot(t, est, '-c', 'Linewidth', 2);
plot(t, total24, '-w', 'Linewidth', 2);
%err(2,4) = goodnessOfFit(est,total24,'MSE');
axis tight;
title('4 Cos');

subplot(2,3,5);
hold on;
t = 0:0.1:55;
x = x25; est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
[~,L] = findpeaks(est);
total = 0;
MM2 = zeros(24,2);
for i = 1:24
    x = X25(i,:); est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    prom = (max(est)-min(est))/4;
    tf = islocalmin(est,'MinProminence',prom); l = islocalmax(est,'MinProminence',prom); 
    [MM2(i,1), I] = max(est(l));
    [~,ind] = min(abs(I-tf));
    MM2(i,2) = min(est(tf(ind)));
    plot(t, est, '--c');
    total = total + est;
end 
total25 = total/24;
x = x25; est25 = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
plot(t, est25, '-c', 'Linewidth', 2);
plot(t, total25, '-w', 'Linewidth', 2);
%err(2,5) = goodnessOfFit(est25,total25,'MSE');
axis tight;
title('5 Cos');

subplot(2,3,6);
hold on;
total = 0;
%err2 = zeros(24,5);
ROCK = zeros(24,56);
vhist2 = [];
for i = 1:24
    t = 0:55;
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/FF Src with Y-27632 Local stimulation/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    [~,n] = size(sV); k = n/2; delta = ceil(n*percent/100);
    M = sV(:,(k-delta):(k+delta)); Vel = mean(M,2)';
    v = Vel(16:71);
    ROCK(i,:) = v;
    vhist2 = [vhist2, v];
        
    x = X21(i,:); est1 = x(2)*cos(x(1)*t+x(3))+x(4);
    x = X22(i,:); est2 = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6))+x(7);
    x = X23(i,:); est3 = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9))+x(10);
    x = X24(i,:); est4 = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
    x = X25(i,:); est5 = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    cost_func = 'MSE';
    %err2(i,1) = goodnessOfFit(est1,v,cost_func);
    %err2(i,2) = goodnessOfFit(est2,v,cost_func);
    %err2(i,3) = goodnessOfFit(est3,v,cost_func);
    %err2(i,4) = goodnessOfFit(est4,v,cost_func);
    %err2(i,5) = goodnessOfFit(est5,v,cost_func);
    
    total = total + sV;
    plot(t,v,'--c');
end    
total = total/24;
[~,n] = size(total); k = n/2;
delta = ceil(n*percent/100);
V = mean(total(:,k-delta:k+delta),2)'; 
func = V(16:71); 
plot(t, func, '-c', 'Linewidth', 2);
axis tight;
%err(2,1) = goodnessOfFit(func,total21,'MSE');
%err(2,2) = goodnessOfFit(func,total22,'MSE');
%err(2,3) = goodnessOfFit(func,total23,'MSE');
%err(2,4) = goodnessOfFit(func,total24,'MSE');
%err(2,5) = goodnessOfFit(func,total25,'MSE');
title('Mean');


T3 = zeros(20,3);
figure;
subplot(2,3,1);
hold on;
t = 0:55;
x = x31; est = x(2)*cos(x(1)*t+x(3)) + x(4);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X31(i,:); est = x(2)*cos(x(1)*t+x(3)) + x(4);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T3(i,1) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--g');
    total = total + est;
end 
total31 = total/20;
x = x31; est = x(2)*cos(x(1)*t+x(3)) + x(4);
plot(t, est, '-g', 'Linewidth', 2);
plot(t, total31, '-w', 'Linewidth', 2);
%err(3,1) = goodnessOfFit(est,total31,'MSE');
axis tight;
title('1 Cos');

subplot(2,3,2);
hold on;
t = 0:55;
x = x32; est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X32(i,:); est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T3(i,2) = min(abs(L-l(n)))*0.1;
    plot(t, est,'--g');
    total = total + est;
end 
total32 = total/20;
x = x32; est = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6)) + x(7);
plot(t, est,'-g', 'Linewidth', 2);
plot(t, total32, '-w', 'Linewidth', 2);
%err(3,2) = goodnessOfFit(est,total32,'MSE');
axis tight;
title('2 Cos');

subplot(2,3,3);
hold on;
t = 0:55;
x = x33; est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X33(i,:); est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T3(i,3) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--g');
    total = total + est;
end 
total33 = total/20;
x = x33; est = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9)) + x(10);
plot(t, est, '-g', 'Linewidth', 2);
plot(t, total33, '-w', 'Linewidth', 2);
%err(3,3) = goodnessOfFit(est,total33,'MSE');
axis tight;
title('3 Cos');


subplot(2,3,4);
hold on;
t = 0:55;
x = x34; est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
[~,l] = findpeaks(est);
total = 0;
for i = 1:20
    x = X34(i,:); est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
    n = ceil(length(l)/2);
    [p,L] = findpeaks(est); T1(i,3) = min(abs(L-l(n)))*0.1;
    plot(t, est, '--g');
    total = total + est;
end 
total34 = total/20;
x = x34; est = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
plot(t, est, '-g', 'Linewidth', 2);
plot(t, total34, '-w', 'Linewidth', 2);
%err(3,4) = goodnessOfFit(est,total34,'MSE');
axis tight;
title('4 Cos');

subplot(2,3,5);
hold on;
t = 0:0.1:55;
x = x35; est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
[~,l] = findpeaks(est);
total = 0;
MM3 = zeros(20,2);
for i = 1:20
    x = X35(i,:); est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    prom = (max(est)-min(est))/4;
    tf = islocalmin(est,'MinProminence',prom); l = islocalmax(est,'MinProminence',prom); 
    [MM3(i,1), I] = max(est(l));
    [~,ind] = min(abs(I-tf));
    MM3(i,2) = min(est(tf(ind)));
    plot(t, est, '--g');
    total = total + est;
end 
total35 = total/20;
x = x35; est35 = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
plot(t, est35, '-g', 'Linewidth', 2);
plot(t, total35, '-w', 'Linewidth', 2);
%err(3,5) = goodnessOfFit(est35,total35,'MSE');
axis tight;
title('5 Cos');

subplot(2,3,6);
hold on;
total = 0;
%err3 = zeros(20,5);
MLCK = zeros(20,56);
vhist3 = [];
for i = 1:20
    t = 0:55;
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/FF Src with MLCK inh/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    [~,n] = size(sV); k = n/2; delta = ceil(n*percent/100);
    M = sV(:,(k-delta):(k+delta)); Vel = mean(M,2)';
    v = Vel(16:71);
    MLCK(i,:) = v;
    vhist3 = [vhist3, v];
    
    x = X31(i,:); est1 = x(2)*cos(x(1)*t+x(3))+x(4);
    x = X32(i,:); est2 = x(3)*cos(x(1)*t+x(5))+x(4)*cos(x(2)*t+x(6))+x(7);
    x = X33(i,:); est3 = x(4)*cos(x(1)*t+x(7))+x(5)*cos(x(2)*t+x(8))+x(6)*cos(x(3)*t+x(9))+x(10);
    x = X34(i,:); est4 = x(5)*cos(x(1)*t+x(9))+x(6)*cos(x(2)*t+x(10))+x(7)*cos(x(3)*t+x(11))+x(8)*cos(x(4)*t+x(12))+x(13);
    x = X35(i,:); est5 = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    cost_func = 'MSE';
    %err3(i,1) = goodnessOfFit(est1,v,cost_func);
    %err3(i,2) = goodnessOfFit(est2,v,cost_func);
    %err3(i,3) = goodnessOfFit(est3,v,cost_func);
    %err3(i,4) = goodnessOfFit(est4,v,cost_func);
    %err3(i,5) = goodnessOfFit(est5,v,cost_func);
    
    total = total + sV;
    plot(t,v,'--g');
end    
total = total/20;
[~,n] = size(total); k = n/2;
delta = ceil(n*percent/100);
V = mean(total(:,k-delta:k+delta),2)'; 
func = V(16:71); 
plot(t, func, '-g', 'Linewidth', 2);
%err(3,1) = goodnessOfFit(func,total31,'MSE');
%err(3,2) = goodnessOfFit(func,total32,'MSE');
%err(3,3) = goodnessOfFit(func,total33,'MSE');
%err(3,4) = goodnessOfFit(func,total34,'MSE');
%err(3,5) = goodnessOfFit(func,total35,'MSE');
axis tight;
title('Mean');

save([pwd, '/Data/Data1', num2str(percent),'.mat'],'Pks1','Locs1','S1','pks1','locs1','m1','x11','x12','x13','x14','x15','xm11','xm12','xm13','X11','X12','X13','X14','X15','T1');
save([pwd, '/Data/Data2', num2str(percent),'.mat'],'Pks2','Locs2','S2','pks2','locs2','m2','x21','x22','x23','x24','x25','xm21','xm22','xm23','X21','X22','X23','X24','X25','T2');
save([pwd, '/Data/Data3', num2str(percent),'.mat'],'Pks3','Locs3','S3','pks3','locs3','m3','x31','x32','x33','x34','x35','xm31','xm32','xm33','X31','X32','X33','X34','X35','T3');

save([pwd,'Velocities.mat'], 'Control', 'ROCK', 'MLCK');

figure;
t = 0:0.1:55;
subplot(1,3,1); hold on; plot(t, est15, '-m', 'Linewidth', 2); plot(t, total15, '--w', 'Linewidth', 2); ylim([-0.05,1.35]);
subplot(1,3,2); hold on; plot(t, est25, '-c', 'Linewidth', 2); plot(t, total25, '--w', 'Linewidth', 2); ylim([-0.05,1.35]);
subplot(1,3,3); hold on; plot(t, est35, '-g', 'Linewidth', 2); plot(t, total35, '--w', 'Linewidth', 2); ylim([-0.05,1.35]);

figure;
subplot(1,3,1);
hold on;
total = 0;
for i = 1:20
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/Local stimulation FF 20.50.20/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    total = total + sV;
end    
total = total/20;
[~,n] = size(total); k = n/2;
delta = ceil(n*percent/100);
V = mean(total(:,k-delta:k+delta),2)'; 
func = V; 
t = 0:(length(func)-1);
plot(t, func, '-m', 'Linewidth', 2);

t = 0:55;
x = x15; est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
plot(t+15, est, '-w', 'Linewidth', 1);
ylim([-0.2,1.3]);

subplot(1,3,2);
hold on;
total = 0;
for i = 1:24
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/FF Src with Y-27632 Local stimulation/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    total = total + sV;
end    
total = total/24;
[~,n] = size(total); k = n/2;
delta = ceil(n*percent/100);
V = mean(total(:,k-delta:k+delta),2)'; 
func = V; 
t = 0:(length(func)-1);
plot(t, func, '-c', 'Linewidth', 2);

t = 0:55;
x = x25; est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
plot(t+15, est, 'w', 'Linewidth', 1);
ylim([-0.2,1.3]);

subplot(1,3,3);
hold on;
total = 0;
for i = 1:20
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/FF Src with MLCK inh/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    total = total + sV;
end    
total = total/20;
[~,n] = size(total); k = n/2;
delta = ceil(n*percent/100);
V = mean(total(:,k-delta:k+delta),2)'; 
func = V; 
t = 0:(length(func)-1);
plot(t, func, 'g', 'Linewidth', 2);

t = 0:55;
x = x35; est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
plot(t+15, est, '-w', 'Linewidth', 1);
ylim([-0.2,1.3]);

%{
figure;
x = 1:20;
subplot(3,5,1); scatter(x, %err1(:,1), 'fill'); subplot(3,5,2); scatter(x, %err1(:,2), 'fill'); subplot(3,5,3); scatter(x, %err1(:,3), 'fill'); 
subplot(3,5,4); scatter(x, %err1(:,4), 'fill'); subplot(3,5,5); scatter(x, %err1(:,5), 'fill');
x = 1:24;
subplot(3,5,6); scatter(x, %err2(:,1), 'fill'); subplot(3,5,7); scatter(x, %err2(:,2), 'fill'); subplot(3,5,8); scatter(x, %err2(:,3), 'fill'); 
subplot(3,5,9); scatter(x, %err2(:,4), 'fill'); subplot(3,5,10); scatter(x, %err2(:,5), 'fill');
x = 1:20;
subplot(3,5,11); scatter(x, %err3(:,1), 'fill'); subplot(3,5,12); scatter(x, %err3(:,2), 'fill'); subplot(3,5,13); scatter(x, %err3(:,3), 'fill'); 
subplot(3,5,14); scatter(x, %err3(:,4), 'fill'); subplot(3,5,15); scatter(x, %err3(:,5), 'fill');
%}
I1 = reshape(repmat(1:5,20,1),[100,1]); I2 = reshape(repmat(1:5,24,1),[120,1]); I3 = reshape(repmat(1:5,20,1),[100,1]);
%err1 = reshape(%err1,[100,1]); %err2 = reshape(%err2,[120,1]); %err3 = reshape(%err3,[100,1]);
%{
save(['/Users/azhurikhina/Dropbox/Mark Andrei/Group/Data/Data1', num2str(percent),'.mat'],'%err1','%err','I1','-append');
save(['/Users/azhurikhina/Dropbox/Mark Andrei/Group/Data/Data2', num2str(percent),'.mat'],'%err2','%err','I2','-append');
save(['/Users/azhurikhina/Dropbox/Mark Andrei/Group/Data/Data3', num2str(percent),'.mat'],'%err3','%err','I3','-append');
%}
%close all;
K1 = zeros(100,3);
K1(:,2) = reshape(2*pi./X15(:,1:5),[100,1]); K1(:,1) = reshape(X15(:,6:10),[100,1]); %K1(:,3) = reshape(X15(:,11:15),[100,1]);

K2 = zeros(120,3);
K2(:,2) = reshape(2*pi./X25(:,1:5),[120,1]); K2(:,1) = reshape(X25(:,6:10),[120,1]); %K2(:,3) = reshape(X25(:,11:15),[120,1]);

K3 = zeros(100,3);
K3(:,2) = reshape(2*pi./X35(:,1:5),[100,1]); K3(:,1) = reshape(X35(:,6:10),[100,1]); %K3(:,3) = reshape(X35(:,11:15),[100,1]);

K1(K1(:, 2) > 30, :) = []; K2(K2(:, 2) > 30, :) = []; K3(K3(:, 2) > 30, :) = [];
C1 = K1(K1(:, 2) < 5, :); C2 = K2(K2(:, 2) < 5, :); C3 = K3(K3(:, 2) < 5, :);
C1(:,3) = 4; C2(:,3) = 4; C3(:,3) = 4;
K1(K1(:, 2) < 5, :) = []; K2(K2(:, 2) < 5, :) = []; K3(K3(:, 2) < 5, :) = [];
adj1 = max(max(K1(:,2)))/max(max(K1(:,1))); K1(:,1) = adj1*K1(:,1);
adj2 = max(max(K2(:,2)))/max(max(K2(:,1))); K2(:,1) = adj2*K2(:,1);
adj3 = max(max(K3(:,2)))/max(max(K3(:,1))); K3(:,1) = adj3*K3(:,1);

c1 = [0.8 0.5 3; 10 25 15];
c2 = [0.8 0.5 2.5; 12 30 15];
c3 = [0.25 1 2.5; 15 25 10];

K1(:,3) = kmeans(K1(:,1:2), 3, 'Start', c1', 'MaXIter', 100000); %'Replicates', 10000); 
K2(:,3) = kmeans(K2(:,1:2), 3, 'Start', c2', 'MaXIter', 100000); %'Replicates', 10000); 
K3(:,3) = kmeans(K3(:,1:2), 3, 'Start', c3', 'MaXIter', 100000); %'Replicates', 10000);

K1(:,1) = K1(:,1)/adj1; K2(:,1) = K2(:,1)/adj2; K3(:,1) = K3(:,1)/adj3;
K1 = [K1; C1]; K2 = [K2; C2]; K3 = [K3; C3];

C = jet(7);
figure;
subplot(1,3,1);
ind = K1(:,3);
scatter(K1(:,1),K1(:,2),40,C(ind,:),'filled');
%scatter3(K1(:,1),K1(:,2),K1(:,3),40,C(ind,:),'filled');
%xlim([0, 3.5]); ylim([0,3]);
title('Control');
box on;
ylabel('Period');
xlabel('Amplitude');

subplot(1,3,2);
ind = K2(:,3);
scatter(K2(:,1),K2(:,2),40,C(ind,:),'filled');
%scatter3(K2(:,1),K2(:,2),K2(:,3),40,C(ind,:),'filled');
%xlim([0, 3.5]); ylim([0,3]);
title('ROCK');
box on;
ylabel('Period');
xlabel('Amplitude');

subplot(1,3,3);
ind = K3(:,3);
scatter(K3(:,1),K3(:,2),40,C(ind,:),'filled');
%scatter3(K3(:,1),K3(:,2),K3(:,3),40,C(ind,:),'filled');
%xlim([0, 3.5]); ylim([0,3]);
title('MLCK');
box on;
ylabel('Period');
xlabel('Amplitude');
%{
C = jet(12);
figure;
hold on;
ind = K1(:,3);
scatter(K1(:,1),K1(:,2),40,C(ind,:),'filled');
%scatter3(K1(:,1),K1(:,2),K1(:,3),40,C(ind,:),'filled');
ind = K2(:,3)+4;
scatter(K2(:,1),K2(:,2),40,C(ind,:),'filled');
%scatter3(K2(:,1),K2(:,2),K2(:,3),40,C(ind,:),'filled');
ind = K3(:,3)+8;
scatter(K3(:,1),K3(:,2),40,C(ind,:),'filled');
%scatter3(K3(:,1),K3(:,2),K3(:,3),40,C(ind,:),'filled');
legend('Control.1','Control.2','Control.3','Control.4','ROCK.1','ROCK.2','ROCK.3','ROCK.4','MLCK.1','MLCK.2','MLCK.3','MLCK.4');
xlim([0, 1.1]); ylim([0,1.1]);
box on;
xlabel('Amplitude');
ylabel('Period');
zlabel('Phase');
%}
save([pwd, '/Data/Data1', num2str(percent),'.mat'],'K1', 'MM1', 'vhist1', '-append');
save([pwd, '/Data/Data2', num2str(percent),'.mat'],'K2', 'MM2', 'vhist2', '-append');
save([pwd, '/Data/Data3', num2str(percent),'.mat'],'K3', 'MM3', 'vhist3', '-append');

factor = 6;
t = 0:0.1:55;
figure;
L1 = []; MaxA1 = [];
TF1 = []; MinA1 = [];
MaxC1 = []; MinC1 = [];
F1 = zeros(20, 10); T1 = zeros(20, 10);
Diff1 = [];
cut = 0;
for i = 1:20
    subplot(4,5,i);
    hold on;
    x = X15(i,:); 
    est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    n = ceil(length(l)/2);
    prom = (max(est)-min(est))/factor;
    tf = islocalmin(est,'MinProminence',prom); l = islocalmax(est,'MinProminence',prom); 
    TF1 = [TF1, t(tf)]; MinA1 = [MinA1, est(tf)]; L1 = [L1, t(l)]; MaxA1 = [MaxA1, est(l)];
   
    y = est(l); x = t(l); 
    ym = est(tf); xm = t(tf); 
    
    if x(1) > cut
        cut = x(1);
    end    
    
    [~,j1] = min(y);
    F1(i,3) = y(j1); T1(i,3) = x(j1);
    
    [~,j2] = min(ym);
    F1(i,4) = ym(j2); T1(i,4) = xm(j2);
    
    [~,k1] = max(y);
    F1(i,1) = y(k1); T1(i,1) = x(k1);
    
    [~,k2] = max(ym);
    F1(i,2) = ym(k2); T1(i,2) = xm(k2);

    F1(i,5) = y(1); T1(i,5) = x(1);
    F1(i,6) = ym(1); T1(i,6) = xm(1);
    
    F1(i,7) = median(y); T1(i,7) = median(x);
    F1(i,8) = median(ym); T1(i,8) = median(xm);
    
    F1(i,9) = mean(y); T1(i,9) = mean(x);
    F1(i,10) = mean(ym); T1(i,10) = mean(xm);
    
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/Local stimulation FF 20.50.20/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    [~,n] = size(sV); k = n/2; delta = ceil(n*percent/100);
    M = sV(:,(k-delta):(k+delta)); 
    Vel = mean(M,2)';
    
    T = 0:85;
    plot(T, Vel, 'k', 'LineWidth', 0.5);
    plot(t+15, est, 'Color', [0.8 0.3 0.3], 'LineWidth', 1.2);
    scatter(t(tf)+15, est(tf),'b*');
    scatter(t(l)+15, est(l), 'r*');
    ylim([-1.6,3]);
    ylim([-1.6,3]);
    
    maximum = est(l); minimum = est(tf);
    len_max = length(maximum); len_min = length(minimum);
    MaxC1 = [MaxC1, i*ones(1,len_max)]; MinC1 = [MinC1, i*ones(1,len_min)];
    if length(maximum) > length(minimum)
        diff = maximum - [minimum, minimum(len_min)*ones(1,len_max-len_min)];     
    else  
        diff = maximum - minimum(1:len_max);
    end    
    Diff1 = [Diff1, diff];
    %{
    scatter(x(j1), y(j1), 'bo', 'filled');
    scatter(xm(j2), ym(j2), 'bo', 'filled');
    scatter(x(k1), y(k1), 'yo', 'filled');
    scatter(xm(k2), ym(k2), 'yo', 'filled');
    scatter(x(1), y(1), 'mo', 'filled');
    scatter(xm(1), ym(1), 'mo', 'filled');
    %}
end 
sgtitle('Control');

figure(12);
subplot(3,1,1);
mean_line1 = 0;
cut = 0;
for i = 1:20
    t = 0:0.1:55;
    x = X15(i,:); 
    est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    
    n = ceil(length(l)/2);
    prom = (max(est)-min(est))/factor;
    l = islocalmax(est,'MinProminence',prom); 
    all = t(l); first = all(1);
    add = first-cut;
    t = add:0.1:(55+add);
    est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    mean_line1 = mean_line1 + est;
    
    t = 0:0.1:55;
    hold on;
    plot(t, est, '--k');
    xline(cut);
end    
mean_line1 = mean_line1/20;
plot(t, mean_line1, 'r', 'Linewidth', 2);
axis tight;
ylim([-0.5,1.7]);

figure;
t = 0:0.1:55;
L2 = []; MaxA2 = [];
TF2 = []; MinA2 = [];
MaxC2 = []; MinC2 = [];
F2 = zeros(24, 10); T2 = zeros(24, 10);
Diff2 = [];
cut = 0;
for i = 1:24
    subplot(4,6,i);
    hold on;
    x = X25(i,:); est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    n = ceil(length(l)/2);
    prom = (max(est)-min(est))/factor;
    tf = islocalmin(est,'MinProminence',prom); l = islocalmax(est,'MinProminence',prom); 
    TF2 = [TF2, t(tf)]; MinA2 = [MinA2, est(tf)]; L2 = [L2, t(l)]; MaxA2 = [MaxA2, est(l)];
    
    y = est(l); x = t(l); 
    ym = est(tf); xm = t(tf);
    
    if x(1) > cut
        cut = x(1);
    end 
    
    [~,j1] = min(y);
    F2(i,3) = y(j1); T2(i,3) = x(j1);
    
    [~,j2] = min(ym);
    F2(i,4) = ym(j2); T2(i,4) = xm(j2);
    
    [~,k1] = max(y);
    F2(i,1) = y(k1); T2(i,1) = x(k1);
    
    [~,k2] = max(ym);
    F2(i,2) = ym(k2); T2(i,2) = xm(k2);

    F2(i,5) = y(1); T2(i,5) = x(1);
    F2(i,6) = ym(1); T2(i,6) = xm(1);
    
    F2(i,7) = median(y); T2(i,7) = median(x);
    F2(i,8) = median(ym); T2(i,8) = median(xm);
    
    F2(i,9) = mean(y); T2(i,9) = mean(x);
    F2(i,10) = mean(ym); T2(i,10) = mean(xm);
        
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/FF Src with Y-27632 Local stimulation/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    [~,n] = size(sV); k = n/2; delta = ceil(n*percent/100);
    M = sV(:,(k-delta):(k+delta)); 
    Vel = mean(M,2)';
    
    T = 0:85;
    plot(T, Vel, 'k', 'LineWidth', 0.5);
    plot(t+15, est, 'Color', [0 0.8 0.5], 'LineWidth', 1.2);
    scatter(t(tf)+15, est(tf),'b*');
    scatter(t(l)+15, est(l), 'r*');
    ylim([-1.6,3]);
    
    maximum = est(l); minimum = est(tf);
    len_max = length(maximum); len_min = length(minimum);
    MaxC2 = [MaxC2, i*ones(1,len_max)]; MinC2 = [MinC2, i*ones(1,len_min)];
    if length(maximum) > length(minimum)
        diff = maximum - [minimum, minimum(len_min)*ones(1,len_max-len_min)];     
    else  
        diff = maximum - minimum(1:len_max);
    end  
    Diff2 = [Diff2, diff];
    %{
    scatter(x(j1), y(j1), 'bo', 'filled');
    scatter(xm(j2), ym(j2), 'bo', 'filled');
    scatter(x(k1), y(k1), 'yo', 'filled');
    scatter(xm(k2), ym(k2), 'yo', 'filled');
    scatter(x(1), y(1), 'co', 'filled');
    scatter(xm(1), ym(1), 'co', 'filled');
    %}
end 
sgtitle('ROCK');

figure(12);
subplot(3,1,2);
mean_line2 = 0;
cut = 0;
for i = 1:20
    t = 0:0.1:55;
    x = X25(i,:); 
    est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    
    n = ceil(length(l)/2);
    prom = (max(est)-min(est))/factor;
    l = islocalmax(est,'MinProminence',prom); 
    all = t(l); first = all(1);
    add = first-cut;
    t = add:0.1:(55+add);
    est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    mean_line2 = mean_line2 + est;
    
    t = 0:0.1:55;
    hold on;
    plot(t, est, '--k');
    xline(cut);
end    
mean_line2 = mean_line2/24;
plot(t, mean_line2, 'Color', [0 0.8 0.5], 'Linewidth', 2);
axis tight;
ylim([-0.5,1.7]);

figure;
L3 = []; MaxA3 = [];
TF3 = []; MinA3 = [];
MaxC3 = []; MinC3 = [];
F3 = zeros(20, 10); T3 = zeros(20, 10);
Diff3 = [];
cut = 0;
for i = 1:20
    subplot(4,5,i);
    hold on;
    x = X35(i,:); est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    n = ceil(length(l)/2);
    prom = (max(est)-min(est))/factor;
    tf = islocalmin(est,'MinProminence',prom); l = islocalmax(est,'MinProminence',prom); 
    TF3 = [TF3, t(tf)]; MinA3 = [MinA3, est(tf)]; L3 = [L3, t(l)]; MaxA3 = [MaxA3, est(l)];
    
    y = est(l); x = t(l); 
    ym = est(tf); xm = t(tf);
    
    if x(1) > cut
        cut = x(1);
    end 
    
    [~,j1] = min(y);
    F3(i,3) = y(j1); T3(i,3) = x(j1);
    
    [~,j2] = min(ym);
    F3(i,4) = ym(j2); T3(i,4) = xm(j2);
    
    [~,k1] = max(y);
    F3(i,1) = y(k1); T3(i,1) = x(k1);
    
    [~,k2] = max(ym);
    F3(i,2) = ym(k2); T3(i,2) = xm(k2);

    F3(i,5) = y(1); T3(i,5) = x(1);
    F3(i,6) = ym(1); T3(i,6) = xm(1);
    
    F3(i,7) = median(y); T3(i,7) = median(x);
    F3(i,8) = median(ym); T3(i,8) = median(xm);
    
    F3(i,9) = mean(y); T3(i,9) = mean(x);
    F3(i,10) = mean(ym); T3(i,10) = mean(xm);
        
    kymo = load(['/Users/azhurikhina/Dropbox/Mark Andrei/FF Src with MLCK inh/kymos/Mat files (Data)/Velocity Kymograph for Cell ' num2str(i) '; Lag = 5;original.mat']);
    sV = kymo.sV;       
    [~,n] = size(sV); k = n/2; delta = ceil(n*percent/100);
    M = sV(:,(k-delta):(k+delta)); 
    Vel = mean(M,2)';
    
    T = 0:85;
    plot(T, Vel, 'k', 'LineWidth', 0.5);
    plot(t+15, est, 'Color', [0 0.1 0.8], 'LineWidth', 1.2);
    scatter(t(tf)+15, est(tf),'b*');
    scatter(t(l)+15, est(l), 'r*');
    ylim([-1.6,3]);
    
    maximum = est(l); minimum = est(tf);
    len_max = length(maximum); len_min = length(minimum);
    MaxC3 = [MaxC3, i*ones(1,len_max)]; MinC3 = [MinC3, i*ones(1,len_min)];
    if length(maximum) > length(minimum)
        diff = maximum - [minimum, minimum(len_min)*ones(1,len_max-len_min)];     
    else  
        diff = maximum - minimum(1:len_max);
    end  
    Diff3 = [Diff3, diff];
    %{
    scatter(x(j1), y(j1), 'bo', 'filled');
    scatter(xm(j2), ym(j2), 'bo', 'filled');
    scatter(x(k1), y(k1), 'yo', 'filled');
    scatter(xm(k2), ym(k2), 'yo', 'filled');
    scatter(x(1), y(1), 'go', 'filled');
    scatter(xm(1), ym(1), 'go', 'filled');
    %}
end 
sgtitle('MLCK');

figure(12);
subplot(3,1,3);
mean_line3 = 0;
cut = 0;
for i = 1:20
    t = 0:0.1:55;
    x = X35(i,:); 
    est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    
    n = ceil(length(l)/2);
    prom = (max(est)-min(est))/factor;
    l = islocalmax(est,'MinProminence',prom); 
    all = t(l); first = all(1);
    add = first-cut;
    t = add:0.1:(55+add);
    est = x(6)*cos(x(1)*t+x(11))+x(7)*cos(x(2)*t+x(12))+x(8)*cos(x(3)*t+x(13))+x(9)*cos(x(4)*t+x(14))+x(10)*cos(x(5)*t+x(15))+x(16);
    mean_line3 = mean_line3 + est;
    
    t = 0:0.1:55;
    hold on;
    plot(t, est, '--k');
    xline(cut);
end    
mean_line3 = mean_line3/20;
plot(t, mean_line3, 'b', 'Linewidth', 2);
axis tight;
ylim([-0.5,1.7]);

figure;
hold on;
plot(t, mean_line1, 'r', 'Linewidth', 2);
plot(t, mean_line2, 'Color', [0 0.8 0.5], 'Linewidth', 2);
plot(t, mean_line3, 'b', 'Linewidth', 2);
axis tight;

save([pwd, '/Data/Data1', num2str(percent),'.mat'],'L1', 'TF1', 'MaxA1', 'MinA1', 'MaxC1', 'MinC1', 'F1', 'T1', 'Diff1', '-append');
save([pwd, '/Data/Data2', num2str(percent),'.mat'],'L2', 'TF2', 'MaxA2', 'MinA2', 'MaxC2', 'MinC2', 'F2', 'T2', 'Diff2', '-append');
save([pwd, '/Data/Data3', num2str(percent),'.mat'],'L3', 'TF3', 'MaxA3', 'MinA3', 'MaxC3', 'MinC3', 'F3', 'T3', 'Diff3', '-append');

figure;
subplot(1,4,1);
histogram(vhist1, 'FaceColor', 'm');
xlim([-2,3.2]); ylim([0,185]);

subplot(1,4,2);
histogram(vhist2, 'FaceColor', 'c');
xlim([-2,3.2]); ylim([0,185]);

subplot(1,4,3);
histogram(vhist3, 'FaceColor', 'g');
xlim([-2,3.2]); ylim([0,185]);

subplot(1,4,4);
hold on;
histogram(vhist2, 'FaceColor', 'c');
histogram(vhist3, 'FaceColor', 'g');
histogram(vhist1, 'FaceColor', 'm');
xlim([-2,3.2]); ylim([0,185]);

%close all;

end
