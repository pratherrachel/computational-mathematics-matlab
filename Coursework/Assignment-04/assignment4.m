clear
load HW4.txt;
x=HW4(:,1);  y=HW4(:,2);
n=length(x);
t1=linspace(0,2*pi,n+1); t1(end)=[]; t1=t1';
nOnes = ones(n,1);
nZeros = zeros(n,1);
A=[nOnes nZeros (cos(t1).^3) nZeros ;
   nZeros nOnes nZeros (sin(t1).^3)];
c=A\[x;y];
t2=linspace(0,2*pi,200);
Xt=c(1)+c(3)*cos(t2).^3;
Yt=c(2)+c(4)*sin(t2).^3;
figure(1)
plot(x,y,'*r')
hold on
plot(Xt,Yt,'-b','LineWidth',2)
title('Plot of the Inputs from HW4.txt with Curve')
xlabel('X'); ylabel('Y');
axis equal
hold off

clear
load HW4a.txt;
x=HW4a(:,1);  y=HW4a(:,2);
n=length(x);
nOnes = ones(n,1);
A=[nOnes x (x.^2) (x.^3) (x.^4)];
c=A\y;
X=linspace(0,10,600);
Y=c(1)+c(2)*X+c(3)*X.^2+c(4)*X.^3+c(5)*X.^4;
figure(2)
plot(x,y,'or')
hold on
plot(X,Y,'-b','LineWidth',2)
title('Plot of the Inputs from HW4a.txt with Curve')
xlabel('X'); ylabel('Y');
xlim([0 10])
ylim([-1.5 1.5])
hold off