function [err1,err2]=getreferrs(P1,P2,N,sigexp)
refname=[ 'dlwe1wpREF_N=' num2str(N) '_psigma=' num2str(sigexp) '.mat' ];
if exist(refname,'file')
    load(refname,'Pref1','Pref2');
else
    [Pref1,Pref2]=DLWE1wpsolve_ref(N,sigexp);
end
err1=norm(P1-Pref1)/norm(Pref1);
err2=norm(P2-Pref2)/norm(Pref2);
