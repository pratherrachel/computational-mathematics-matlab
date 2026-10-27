% applyop - computes
% Ly = a0 y + a1 y' - a2 y'' 
% using Chebyshev differentiation matrices D1 and D2
function Ly=applyop(y,a0,a1,a2,D1,D2)

%Done % TODO: define firstder function like secondder, using Chebyshev 
%differentiation matrices D1 and D2
yX=firstder(y,D1);
yXX=secondder(y,D2);

% Done % TODO: change this to include a1 term, based on equation (66)
Ly=-a2.*yXX+a1.*yX+a0.*y; 

