% getslopes - Computes frequency-dependent coefficients for KSS.
% Linear Case
%
% This function returns a matrix of coefficients, where each column
% corresponds to the power-form coefficients for the polynomial
% approximant for a specific Chebyshev mode.
%
% The method involves three main steps:
%   1. Estimates the eigenvalues of the operator J for each mode.
%   2. For each mode, select representative nodes based on its
%      estimated eigenvalues (e.g. 0, half the eigenvalue, and the full 
%      eigenvalue).
%   3. Construct and solve a Vandermonde system for each mode to find the
%      the polynomial coefficients that interpolate exp(-x*dt) at those
%      nodes.
%
% input:
%   dt        - The time step size.
%   ord       - The desired order of accuracy.
%   a0        - The vector a0.
%   a2        - The vector a2.
%
% output:
%   coefs:    - A 3xN matrix containing the power-form coefficients
%               coefs(1,:) are the c0 coeffs, coefs(2,:) are the c1, etc.

function coefs=getslopes(dt,ord,a0,a2)
% Always make a 3×N array, since KSSstep expects 3 coefs per mode.
N     = length(a0);
coefs = zeros(3, N);

% Estimate each mode's eigenvalue based on the PDE coefficients.
k = (1:N)';
L = a2 .* (k*pi).^2 + a0;    % N×1 vector of estimated eigenvalues

if ord == 2
  % 2nd order: use {0, 0.99*L, L} for every mode j 
  for j = 1:N
    % Define the interpolation nodes for the current mode
    nodes = [0; (0.99)*L(j); L(j)];       % strictly increasing
    
    % evaluates the target function exp(-x*dt)
    fvals = exp(-nodes*dt);    

    % Builds and solves the Vandermonde system to find the coefficients
    V     = [ones(3,1), nodes, nodes.^2];
    coefs(:,j) = V \ fvals;          
  end

else  % ord == 1
  % 1st order: two‐point rule, pad with c2=0
  for j = 1:N
    % Define the two interpolation nodes for the current mode.
    nodes = [0; L(j)];

    % Evaluate the targent function at the nodes
    fvals = exp(-nodes*dt);

    % Build and solve the 2x2 Vandermonde system
    V     = [ones(2,1), nodes];
    tmp   = V \ fvals;       % Results is a 2x1 vector [c0; c1]

    %Store coefficients and pad the third (c2) with zero
    coefs(1:2, j) = tmp;     
    coefs(3,   j) = 0;       
  end
end
