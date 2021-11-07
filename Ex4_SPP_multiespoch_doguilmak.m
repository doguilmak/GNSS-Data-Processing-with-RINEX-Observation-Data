function[dxi, v, vtpv, qx, m0, cx] = Ex4_SPP_multiepoch_doguilmak
clc



[nrsat, xref, yref, zref, pref, L1ref, L2ref, xrov, yrov, zrov, prov, L1rov, L2rov] = textread('sat3.txt', '%d%f%f%f%f%f%f%f%f%f%f%f%f', 'headerlines',6);



numsat = 7;
nepoch = 5;
a = numsat * nepoch

xyz_app = [4075599.632, 931875.237, 4801587.744];
xyzsat_rov = [xrov,yrov,zrov];

k = 1;
rosat = zeros(numsat, 1);


for k = 1 : a
    
    
    rosat(k) = sqrt((xrov(k)-xyz_app(1))^2 + (yrov(k)-xyz_app(2))^2 + (zrov(k)-xyz_app(3))^2);

        
end



L = prov - rosat


m0 = 1/0.30^2;
m = m0*ones(a,1);
P = diag(m);


for k = 1:a
    
    Ax(k)=(xyz_app(1)-xrov(k))/rosat(k);
    Ay(k)=(xyz_app(2)-yrov(k))/rosat(k);
    Az(k)=(xyz_app(3)-zrov(k))/rosat(k);
    
end
    
    
A = [Ax;Ay;Az]';
D = [];

for i=1:nepoch
 
    D = blkdiag(D,ones(7,1));

end

A = [A,D]

X = inv(A'*P*A)*A'*P*L

V = A*X-L
[n, m] = size(A)

m02 = V'*P*V/(n-m)

mo = sqrt(m02)

Cx = m02*(inv(A'*P*A))

mx = sqrt(Cx(1,1))
my = sqrt(Cx(2,2))
mz = sqrt(Cx(3,3))



end

