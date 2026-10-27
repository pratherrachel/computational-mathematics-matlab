function [P,iter]=Krylovstep(P,dT,a2pad,a1pad,a0pad)
% make Jacobian
N=length(P);
dZ=2/N;
a2mat=spdiags(a2pad(1:end-1),0,N,N);
a0mat=spdiags(a0pad(1:end-1),0,N,N);
a1mat=spdiags(a1pad(1:end-1),0,N,N);
e=ones(N,1);
D2=1/dZ^2*spdiags([ e -2*e e ],-1:1,N,N);
D2(1,N)=1/dZ^2;
D2(N,1)=1/dZ^2;
D1=1/(2*dZ)*spdiags([ -e e ],[ -1 1 ],N,N);
D1(1,N)=-1/(2*dZ);
D1(N,1)=1/(2*dZ);

J=-a2mat*D2+a1mat*D1+a0mat;

[P, stats] = AdaptiveKrylov_phipm(1,-dT*J,P,1e-4,0,1);
%disp('converged')
iter=stats(3);
%pause

