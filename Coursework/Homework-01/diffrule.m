% compute coefficients of differentation rule that uses values of
% f at equally spaced points to approximate a derivative of f of
% a given order.
%
% inds specifies which points are to be used.  it is a row vector
% of integers i1,i2,...,in corresponding to the points x0+i1*h,
% x0+i2*h, etc. at which f is to be evaluated to approximate the
% specified derivative of f at any point x0
%
% approximation has the form
% f^(order)(x0) = sum(j=1 to length(inds)) f(x0+inds(j)*h)*coefs(j) / h^order
%
function coefs=diffrule(inds,order)
if nargin<2
    order=1;
end
n=length(inds);
% I is the n-by-n identity matrix 
I=eye(n);
coefs=zeros(n,1);
for i=1:n
    % compute ith Lagrange polynomial that is equal 
    % to 1 at xi, and 0 at all other points
    pi=polyfit(inds,I(i,:),n-1);
    % differentiate it
    for j=1:order
        pi=polyder(pi);
    end
    % evaluate at 0 to obtain coefficient for f(x_i)
    coefs(i)=polyval(pi,0);
end
