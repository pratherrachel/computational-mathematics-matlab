% DLWE1wpsolve_opt - optimized (to a point) KSS solver of 1-way
%     damped Lighthill-Westervelt equation with periodic BCs
% Linear Case
%
% input:
% N - number of grid points (must be even, suggest power of 2)
% sigexp - used to set parameter sigma = 10^(-sigexp)
% CFLmult - multiplier for time step: dT = dZ*CFLmult
% pgibbs - regularizing factor is raised to pgibbs power
%
% goals: maximize CFLmult and sigexp, minimize N and pgibbs
%        while obtaining a smooth curve for a solution that
%        is essentially vertical at final time T_b*
%
function [Pref1,Pref2]=DLWE1wpsolve_ref(N,sigexp)

%CFLmult=1;

% Done % TODO: define parameters from PDE, see equations (2), (3), (4), (5)
% in document dLWE_periodicBC_v2.pdf
%
% parameters needed: k, epsilon, delta_D, gamma, beta,
% alphas (for alpha*), T_bs (for T_B*), betah ("beta-hat")

% % set(0,'defaultLineLineWidth',1)
% % set(0,'defaultAxesFontSize',15)
% % set(0,'defaultAxesFontWeight','bold')
% % set(0,'defaultAxesFontAngle','normal')
% % set(0,'defaultAxesFontName','Helvetica')
% % set(0,'defaulttextFontSize',15)
% % set(0,'defaulttextFontWeight','bold')
% % set(0,'defaulttextFontAngle','italic')
% % set(0,'defaulttextFontName','TimesNewRoman')

k=2*pi;
epsilon=0;
delta_D=0.15;
gamma=1.4;
beta=1.2;
alphas=(gamma*delta_D)/(2*epsilon*beta);
T_bs=0.764211;
betah=beta/gamma;

sigma=10^-sigexp;


% define Chebyshev matrices on domain (0,1) for Dirchlet BCs
% note: any variables with a "pad" suffix are defined on a
%     "padded" grid that includes both boundary points,
%     which is sometimes needed for things like interpolation
%     to a different grid, but not necessarily needed here
Npad = N+1;
x = cos(pi*(0:Npad)'/Npad);
c = [2; ones(N,1); 2].*(-1).^(0:Npad)';
X = repmat(x,1,Npad+1);
dX = X-X';
D = (c*(1./c)')./(dX+(eye(Npad+1))); % off-diagonal entries
D = D - diag(sum(D'));               % diagonal entries

Zpad = (1/2)*(1-x);
Z = Zpad(2:end-1);


D1 = -2*D(2:Npad,2:Npad);    % First derivative matrix
D2 = 4*(D^2);
D2 = D2(2:Npad,2:Npad);   % Second derivative matrix


% initial data (k is parameter to be defined above)
Ppad=sin(k*Zpad);

% plot initial data
P=Ppad(2:end-1);
% ending time, see Dr Jordan's document for further discussion

% set time step, can set dT equal to multiple of dZ to see
%     how large a time step we can get away with


odeopts = odeset('AbsTol',1e-14,'RelTol',1e-14,'Jacobian', @(t,P) refjacobian(t,P,sigma,delta_D,epsilon,betah,D1,D2));
%odeopts = odeset('AbsTol', 1e-13, 'RelTol', 1e-13);
%[Ts,~]=ode15s(@(t,P)timederiv(t,P,sigma,delta_D,epsilon,betah),[ 0 T_bs ],Ppad(1:N),odeopts);
%dtavg=T_bs/(length(Ts)-1)
%dtmin=min(diff(Ts))
%dtmax=max(diff(Ts))
[~,Ps] = ode15s(@(t,P) timederiv(t,P,sigma,delta_D,epsilon,betah,D1,D2),[0 0.5*T_bs T_bs], P, odeopts);

fname = [ 'dlwe1wpREF_N=' num2str(N) '_psigma=' num2str(sigexp) '.mat' ];

Pref1 = Ps(2,:).';
Pref2 = Ps(end,:).';

% Save the interior grid too (needed for interpolation)
save(fname,'Pref1','Pref2','Z');

