function [A,b]=Question7a(h)
n=1\h-1;
I=eye(n);
x=linspace(0,1,n);
y=transpose(linspace(0,1,n));
b=ones(n,n);
b(1,:)=b(1,:)+(-1/2)*x.^2;
b(n,:)=b(n,:)+(x.^3)-x-(1/2)*x.^2;
b(:,1)=b(:,1)+0;
b(:,n)=b(:,n)+y-y.^3-(1/2);
b=reshape(b,[],1);
e=ones(n,1);
A=spdiags([-e 2*e -e],-1:1,n,n)/(h^2);
A=kron(I,A)+kron(A,I);
end

% To run this code I set h=2^-5