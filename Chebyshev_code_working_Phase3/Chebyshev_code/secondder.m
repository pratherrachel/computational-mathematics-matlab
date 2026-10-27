% secondder - compute second derivative using a Chebyshev
%             differentiation matrix
% input:
% f - column vector of function to be differentiated, defined on
%     uniform N-point grid excluding right boundary point
% D2 - second Chebyshev derivative matrix
%
% output:
% fpp - column vector of approximate second derivative values
function fpp=secondder(f,D2)

% matrix-vector product
fpp=D2*f;
