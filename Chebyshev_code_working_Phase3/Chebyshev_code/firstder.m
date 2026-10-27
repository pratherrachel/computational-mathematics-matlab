% firstder - compute first derivative using a Chebyshev
%            differentiation matrix
%
% input:
% f - column vector of function to be differentiated, defined on
%     uniform N-point grid excluding right boundary point
% D1 - first Chebyshev derivative matrix
%
% output:
% fp - column vector of approximate first derivative values
function fp=firstder(f,D1)

% matrix-vector produc
fp=D1*f;

