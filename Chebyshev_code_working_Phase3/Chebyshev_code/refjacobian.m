function J=refjacobian(~,P,sigma,delta_D,epsilon,betah,D1,D2)

N=length(P);


a2=1/2*sigma;
a0=1/2*delta_D;

a1=epsilon*betah*P;


J=-a2*D2+spdiags(a1,0,N,N)*D1+a0*speye(N,N);
%J=-a2*D2+spdiags(a1,0,N,N)*D1+a0*eye(N);


