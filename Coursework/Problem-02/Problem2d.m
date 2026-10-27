clear

%Problem 2d produces an expoenential distribution p(x)=e^(-ax) of random 
% variates x using inverse PDF.

%initalizing variables
N=1000;
a=3; %users choose but a cannot equal 0 in this case

%inverse of p(x)=e^(-ax)
x=rand(N,1);
pInv=-log(x)/a;

%plot of the function above
histogram(pInv);
hold on
limits = xlim();
ylimits = ylim();
x1=linspace(limits(1),limits(2),1000);
p=ylimits(2)*exp(-a*x1);
plot(x1,p)
hold off