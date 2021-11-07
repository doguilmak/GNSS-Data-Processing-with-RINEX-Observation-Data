function [dxi, v, vtpv, qx, m0, cx] = Ex5_float_solut_doguilmak
clc

wavelenght_L1 = 0.1902937;

[nrsat, xsatref, ysatref, zsatref, pref, L1ref, L2ref, xsatrov, ysatrov, zsatrov, prov, L1rov, L2rov] = textread('sat3.txt','%d%f%f%f%f%f%f%f%f%f%f%f%f','headerlines',6);

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

DD_I = [];


for n=1:nepoch
    
    x_sat_refi = xsatref(c:c+nsat-1);
    y_sat_refi = ysatref(c:c+nsat-1);
    z_sat_refi = zsatref(c:c+nsat-1);
    pseudo_refi = ((xyzref(1)-x_sat_refi).^2+(xyzref(2)-y_sat_refi).^2+(xyzref(3)-z_sat_refi).^2).^(0.5);

    x_sat_rovi = xsatrov(c:c+nsat-1);
    y_sat_rovi = ysatrov(c:c+nsat-1);
    z_sat_rovi = zsatrov(c:c+nsat-1);
    pseudo_rovi = ((x_sat_rovi-xyzapp(1)).^2+(y_sat_rovi-xyzapp(2)).^2+(z_sat_rovi-xyzapp(3)).^2).^(0.5);

    S_D_distance = pseudo_rovi - pseudo_refi;
    DD = M*S_D_distance;
    DD_I = [DD_I;DD];
    c = c+nsat;

end

N = [];
N0 = round(DD_L(1:6)-((1/wavelenght_L1)*DD_I(1:6)));

for i=1:nepoch

    N = [N;N0];

end

L = DD_L - ((1/wavelenght_L1)*DD_I) - N

nall = (nsat-1) * nepoch

CDD = 0.0001 * 2 * (eye(nall)+ones(nall,nall));

PDD = inv(CDD);

save workspace_float_dogu.mat