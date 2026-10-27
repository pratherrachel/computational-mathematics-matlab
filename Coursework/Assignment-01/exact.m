tic
fun=@(t) (cos(3.*t)+sqrt(2-sin(3.*t).^2)).^(1/3);
area2=integral2(@(theta,r) r,0,2*pi,0,fun);
display(area2);
toc