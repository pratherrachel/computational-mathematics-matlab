function [t,u]=Question7b(n)
tic
h=1/n;
[A,b]=Question7a(h);
u=multigrid2D(A,b);
t=toc;
end

% To run this code I set n=2^-5