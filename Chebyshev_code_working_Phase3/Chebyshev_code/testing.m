
%DLWE1wpsolve_opt(N,sigexp,CFLmult,pgibbs)

%N: 4^k, k=6,7,8,9
%CFLmult: 2^p, p=0,1,...,8
%sigma: 10^-k, k=5,6,...15
%pgibbs: 4^p, p=0,1,....(whatever gives a correct soln)

%Goal: for each value of N, try to maximize CFLmult, while minimizing
%sigma and pgibbs, and still obtain a correct solution
%The code should plot three smooth curves, on the same set of axes, 
% that should not have any kinks. In some cases, failure is indicated by only
%showing one curve (the initial data), since the other ones turned out to be NaN.

%for i=6:8 %N loop 
for i=6
%     for k=5:15 %sigma loop
    for k=13
%         for p=0:8 %CFLmult loop
        for p=6 %CFLmult loop
            for j=2
                N=4^i
                sigexp=k
                CFLmult=2^p
                pgibbs=j
                DLWE1wpsolve_opt(N,sigexp,CFLmult,pgibbs)
            end
        end
    end
end
