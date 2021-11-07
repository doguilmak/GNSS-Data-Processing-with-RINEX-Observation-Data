function [dxi, v, vtpv, qx, m0, cx] = Ex5_n_float_solut_doguilmak
clc
 
wavelenght_L1 = 0.1902937;
 
[nrsat, xsatref, ysatref, zsatref, pref, L1ref, L2ref, xsatrov, ysatrov, zsatrov, prov, L1rov, L2rov] = textread('sat3.txt', '%d%f%f%f%f%f%f%f%f%f%f%f%f', 'headerlines',6);
 
 
xyzref = [4075535.184, 931821.775, 4801609.099];
xyzapp = [4075599.632, 931875.237, 4801587.744];
 
nsat = 7;
nepoch = 5;
iref = 4;
DD_L = [];
k = 1;
 
for i=1:nepoch
L1refi = L1ref(k:k+nsat-1);
L1rovi = L1rov(k:k+nsat-1);
L1refref = L1refi(iref);
L1rovref = L1rovi(iref);
L1refi(iref) = [];
L1rovi(iref) = [];
 
DD_Lk = (L1rovi - L1refi) - (L1rovref - L1refref);
DD_L = [DD_L;DD_Lk];
k = k+nsat;

end
 
format long g
 
 
DD_ro = [];
c = 1;
 
 
M = zeros(6,7);
M(1:3,1:3) = eye(3);
M(:,4) = -ones(6,1);
M(4:6,5:7) = eye(3);
 
DD_G = [];
DD_I = [];

for n=1:nepoch
 
x_sat_refi = xsatref(c:c+nsat-1);
y_sat_refi = ysatref(c:c+nsat-1);
z_sat_refi = zsatref(c:c+nsat-1);
pseudo_refi = ((xyzref(1)-x_sat_refi).^2+(xyzref(2)-y_sat_refi).^2+(xyzref(3)-z_sat_refi).^2).^(0.5);
 
x_sat_rovi = xsatrov(c:c+nsat-1);
y_sat_rovi = ysatrov(c:c+nsat-1);
z_sat_rovi = zsatrov(c:c+nsat-1);
dx = x_sat_rovi-xyzapp(1);
dy = y_sat_rovi-xyzapp(2);
dz = z_sat_rovi-xyzapp(3);
pseudo_rovi = ((x_sat_rovi-xyzapp(1)).^2+(y_sat_rovi-xyzapp(2)).^2+(z_sat_rovi-xyzapp(3)).^2).^(0.5);
 
S_D_distance = pseudo_rovi - pseudo_refi;
DD = M*S_D_distance; 
DD_I = [DD_I;DD];
 
G = M*[dx./pseudo_rovi,dy./pseudo_rovi,dz./pseudo_rovi];
DD_G = [DD_G;G];
c = c+nsat;

end
 
DD_G = -DD_G/wavelenght_L1;
 
 
 
N = [];
N0 = round(DD_L(1:6)-((1/wavelenght_L1)*DD_I(1:6)));
for i=1:nepoch
N = [N;N0];
end
 
L = DD_L - ((1/wavelenght_L1)*DD_I) - N
 
 
D = [];
 
for i = 1:nepoch
D = [D;eye(nsat-1)];
end
 
A = [DD_G,D]
 
 
sigma_0_kwadr = 0.01^2;
nau =(nsat-1)*nepoch;
C_DD =  sigma_0_kwadr*(2 * (eye(nau)+ones(nau,nau)));
P_DD = inv(C_DD);
 
 
X = inv(A'*P_DD*A)*(A'*P_DD*L);
V = A*X-L
 
new = (nsat-1) * nepoch
nop = 3 + nsat-1;

mo_2 = (V'*P_DD*V)/(new-nop);
Cx = mo_2*inv((A'*P_DD*A))
mo = sqrt(mo_2);
f = diag(Cx);
mx = f(1)
my = f(2)
mz = f(3)
xyz = X(1:3);

save workspace_float_dogu.mat