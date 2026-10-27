function [t,u]=Question7c(n)
tic
h=1/n;
[A,b]=Question7a(h);
u=A\b;
t=toc;
end

% To run this code I set n=2^-5
% Here we can see that we get the same results but the multigrid solver
% takes ten times as long to solve.