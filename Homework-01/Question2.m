function [h,e]=Question2(i)
n=2^(i);
h=1/(n+1);
x=linspace(h,n*h,n);
phi=9*pi*(x.^2);
phix=18*pi*x;
phixx=18*pi;
f=transpose(sin(phi).*(phix.^2)-cos(phi)*phixx);
e=ones(n,1);
A=spdiags([-e 2*e -e],-1:1,n,n)/h^2;
u=A\f;
u0=transpose(sin(phi));
e=norm(u-u0)/norm(u0);
end

%The coding I used on my function was:
%[h1,e1]=Question2(10)
%[h2,e2]=Question2(11)
%[h3,e3]=Question2(12)
%which gave me three different values I could plot.
%Then to create my plot I used 
%loglog([h1,h2,h3],[h1^2,h2^2,h3^2],'--')
%hold on
%loglog([h1,h2,h3],[e1,e2,e3],'-')
%hold off
%xlabel('h')
%ylabel({'error','h^2'})
%This verified that I had 2nd order accuracy. 