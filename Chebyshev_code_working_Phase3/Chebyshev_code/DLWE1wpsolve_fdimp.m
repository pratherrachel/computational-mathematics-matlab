% DLWE1wpsolve_opt - optimized (to a point) KSS solver of 1-way
%     damped Lighthill-Westervelt equation with periodic BCs
%
% Linear Case
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
function [P1,P2,err1,err2,solntime,CFL]=DLWE1wpsolve_fdimp(N,sigexp,CFLmult)

%CFLmult=64;

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

tic

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
x = cos(pi*(0:Npad)'/Npad); % Chebyshev-Gauss-Lobatto points
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


T=0;

% initial data (k is parameter to be defined above)
Ppad=sin(k*Zpad);
P = Ppad(2:end-1);

doplot=false;
if doplot
    % plot initial data
    figure(1)
    color='b';
    plot(Zpad,Ppad,color)
    th=title([ '\sigma = 1.0 \times 10^{-' num2str(sigexp) '}' ]);
    set(th,'FontName','TimesNewRoman');
    set(th,'FontAngle','italic');
    xh=xlabel('Z');
    set(xh,'FontName','TimesNewRoman');
    set(xh,'FontAngle','italic');
    ph=ylabel('P');
    set(ph,'FontName','TimesNewRoman');
    set(ph,'FontAngle','italic');
    axis([ 0 1 -1.1 1.1 ]) %Updated to reflect new domain
    hold on
end
% pause

% ending time, see Dr Jordan's document for further discussion
Tend=T_bs;

% set time step, can set dT equal to multiple of dZ to see 
%     how large a time step we can get away with
dZ = (N+1)^2;
dT=CFLmult/dZ;
nsteps=floor(Tend/dT);
dT=Tend/nsteps;

CFL=max([ sigma*dT/dZ^2 max(abs(Ppad))*epsilon*betah*dT/dZ ])


% PDE coefficients on the interior grid
a2 = (0.5*sigma)*ones(N,1);
a1 = zeros(N,1); %since epsilon = 0
a0 = (0.5*delta_D)*ones(N,1);

% solve P_T + LP = 0
% LP = -a2 P_XX + a1 P_X + a0 P (note minus!!!)
%L = -diag(a2)*D2+diag(a1)*D1+diag(a0);
%I=eye(N);
%Crank-Nicolson Setup
%A_CN = I + 0.5*dT*L;
%B_CN = I - 0.5*dT*L;
%[Lcn,Ucn,Pcn] = lu(A_CN);



%Setting KSS Parameters
ord = 1;

for i=1:nsteps
    
    % Done % TODO: define 1st-order coefficient a1pad
    %a1pad=epsilon*betah*Ppad;
    %J=J0+spdiags(a1pad(2:end-1),0,N,N)*D1;

    % change to unpadded grid
    %
    P=Ppad(2:end-1);
    % TODO: see KSSstep for other things to change
    P=KSSstep(P,dT,a0,a1,a2,D1,D2,ord);
    %Forward Euler
    %P = (I-dT*L)*P;

    %Backward Euler
    %Pold = P;
    %Pnew = P;
    %for it = 1:2
    %    Ppad_it = [0;Pnew;0];
    %    a1_it=epsilon*betah*Ppad_it(2:end-1);
    %    L_it=-diag(a2)*D2 + diag(a1_it)*D1 + diag(a0);
    %    Pnew = (I+dT*L_it)\Pold;
    %end
    %P=Pnew;

    %Crank-Nicolson
    %rhs = B_CN*P;
    %P = Ucn\(Lcn\(Pcn*rhs));
   
    % change back to padded grid
    Ppad=[ 0; P; 0 ];
    %norm(Ppad)
    %pause

    T=T+dT;
    if abs(T-0.5*T_bs)<dT
        P1=P;
    end
                
    % plot solution at times of interest, and final time
    if doplot && ((T>=0.5*T_bs && (T-0.5*T_bs)<dT) || i==nsteps)
        figure(1)

        if (T>=0.5*T_bs && (T-0.5*T_bs)<dT)
            color='g';
        elseif i==nsteps
            color='#FF8800';
        else
            color='b';
        end

        plot(Zpad,Ppad,'Color',color)
        th=title([ '\sigma = 1.0 \times 10^{' num2str(-sigexp) '}' ]);
        set(th,'FontName','TimesNewRoman');
        set(th,'FontAngle','italic');
        xh=xlabel('Z');
        set(xh,'FontName','TimesNewRoman');
        set(xh,'FontAngle','italic');
        ph=ylabel('P');
        set(ph,'FontName','TimesNewRoman');
        set(ph,'FontAngle','italic');
        axis([ 0 1 -1.1 1.1 ])
        if (T>=0.5*T_bs && (T-0.5*T_bs)<dT)
            %pause
        elseif i==nsteps
            %pause
        else
        end


%         pause(0.1)
    end
    
end

solntime=toc;

P2=P;
[err1,err2]=getreferrs(P1,P2,N,sigexp);

%tstop=0.5*T_bs;

if doplot
    % save plot of solutions
    cfl_str=strrep(num2str(CFLmult), '.', ',');
    fname=[ 'dlwe1wpFDKSSOrderOne_N=' num2str(N) '_psigma=' num2str(sigexp) '_CFLmult=' cfl_str ];
    saveas(gcf,fname,'fig')
    saveas(gcf,fname,'png')
    hold off
end

