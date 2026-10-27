function [h,e]=Question2b(i)
n=2^(i);
h=1/(n+1);
x=linspace(h,n*h,n);
phi=9*pi*(x.^2);
phix=18*pi*x;
phixx=18*pi;
f=transpose(sin(phi).*(phix.^2)-cos(phi)*phixx);
e=ones(n,1);
c=diffrule([-2,-1,0,1,2],2);
A=-spdiags([c(1)*e, c(2)*e, c(3)*e, c(4)*e, c(5)*e],-2:2,n,n)/h^2;
c1=diffrule([-1,0,1,2,3,4,],2);
A(1,1:5)=[-c1(2)/h^2, -c1(3)/h^2, -c1(4)/h^2, -c1(5)/h^2, -c1(6)/h^2];
A(n,n-4:n)=[-c1(6)/h^2, -c1(5)/h^2, -c1(4)/h^2, -c1(3)/h^2, -c1(2)/h^2];
u=A\f;
u0=transpose(sin(phi));
e=norm(u-u0, 'inf')/norm(u0, 'inf');
end

%The coding I used on my function was:
%[h1,e1]=Question2b(10)
%[h2,e2]=Question2b(11)
%[h3,e3]=Question2b(12)
%which gave me three different values I could plot.
%Then to create my plot I used 
%loglog([h1,h2,h3],[e1,e2,e3])
%xlabel('h')
%ylabel({'error','h^2'})