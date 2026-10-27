% DLWE1wpsolve_opt - optimized (to a point) KSS solver of 1-way
%     damped Lighthill-Westervelt equation with periodic BCs
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
function [P1,P2,err1,err2,solntime,avgiter]=DLWE1wpsolve_krylov(N,sigexp,CFLmult)

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
epsilon=0.25;
delta_D=0.15;
gamma=1.4;
beta=1.2;
%alphas=(gamma*delta_D)/(2*epsilon*beta);
T_bs=0.764211;
betah=beta/gamma;

sigma=10^-sigexp;


% define uniform grid on (-1,1) for periodic BCs
% note: any variables with a "pad" suffix are defined on a
%     "padded" grid that includes both boundary points,
%     which is sometimes needed for things like interpolation
%     to a different grid, but not necessarily needed here
dZ=2/N;
Zpad=-1+dZ*(0:N)';

T=0;

% initial data (k is parameter to be defined above)
Ppad=cos(k*Zpad);

doplot=false;

% plot initial data
if doplot
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
    axis([ -1 1 -1.1 1.1 ])
    hold on
end
% pause

% ending time, see Dr Jordan's document for further discussion
Tend=T_bs;

% set time step, can set dT equal to multiple of dZ to see 
%     how large a time step we can get away with
dT=CFLmult*dZ;
tspan=0:dT:Tend;
nsteps=length(tspan)-1;
dT=Tend/nsteps;

CFL=max([ sigma*dT/dZ^2 max(abs(Ppad))*epsilon*betah*dT/dZ ])

% vector of frequencies
ws=[ 0:N/2 -N/2+1:-1 ]'*pi;

% solve P_T + LP = 0
% LP = -a2 P_XX + a1 P_X + a0 P (note minus!!!)

% coefficients of differential operator L, from eq (52):
% a2 = 1/2 sigma
% a1 = epsilon betah P
% a0 = 1/2 delta_D

% Done TODO: define 2nd-order and 0th-order coefficients a2pad, a1pad
% as vectors of function values, for a vector of same size as Zpad
a2pad=1/2*sigma*ones(N+1,1);
a0pad=1/2*delta_D*ones(N+1,1);

%N=length(ws);
eta=ws/(N/2+1);
sf=abs(sin(pi*eta)./(pi*eta));
sf(1)=1;

ws2=ws.^2;

%ws2=(2-2*cos(ws*dZ))/dZ^2;

totiter=0;
for i=1:nsteps

    %dT=min([dT (T_bs-T)]);

    % Done % TODO: define 1st-order coefficient a1pad
    a1pad=epsilon*betah*Ppad;

    % change to unpadded grid
    P=Ppad(1:end-1);
    % TODO: see KSSstep for other things to change
    %P=KSSstep(P,dT,a2pad,a1pad,a0pad,ws,ws2,pgibbs,sf);
    [P,iter]=Krylovstep(P,dT,a2pad,a1pad,a0pad);
    totiter=totiter+iter;
    % change back to padded grid
    Ppad=[ P; P(1) ];
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
        axis([ -1 1 -1.1 1.1 ])
        if (T>=0.5*T_bs && (T-0.5*T_bs)<dT)
            pause
        elseif i==nsteps
            pause
        else
        end


%         pause(0.1)
    end
    
end

solntime=toc;

P2=P;
[err1,err2]=getreferrs(P1,P2,N,sigexp);

avgiter=totiter/nsteps;
%tstop=0.5*T_bs

if doplot
    % save plot of solutions
    fname=[ 'dlwe1wpKrylov_N=' num2str(N) '_psigma=' num2str(sigexp) '_CFLmult=' num2str(CFLmult) ];
    saveas(gcf,fname,'fig')
    saveas(gcf,fname,'png')
    hold off
end