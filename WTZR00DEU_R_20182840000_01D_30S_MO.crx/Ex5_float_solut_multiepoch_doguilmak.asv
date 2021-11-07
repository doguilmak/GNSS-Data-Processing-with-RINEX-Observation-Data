function[dxi, v, vtpv, qx, m0, cx] = Ex5_float_solut_multiepoch_doguilmak
clc

wavelenght_L1 = 0.1902937;

[nrsat, xsatref, ysatref, zsatref, pref, L1ref, L2ref, xsatrov, ysatrov, zsatrov, prov, L1rov, L2rov] = textread('sat3.txt', '%d%f%f%f%f%f%f%f%f%f%f%f%f', 'headerlines',6);

xyz_app = [4075599.632, 931875.237, 4801587.744];
xyz_ref = [4075535.184, 931821.775, 4801609.099];
nsat = 7;
nepoch = 5;
iref = 4;

DD_L = [];

k=1;
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


DD_Livec = [];
k=1;
k1=1;

M = zeros(6,7);
M(1:3,1:3) = eye(3);
M(:,4) = -ones(6,1);
M(4:6,5:7) = eye(3);
M

for i=1:nepoch
     
    xsatrefi = xsatref(k:k+nsat-1);
    ysatrefi = ysatref(k:k+nsat-1);
    zsatrefi = zsatref(k:k+nsat-1);
    
    xsatrovi = xsatrov(k:k+nsat-1);
    ysatrovi = ysatrov(k:k+nsat-1);
    zsatrovi = zsatrov(k:k+nsat-1);
    
    
    rosatref = sqrt((xsatrefi-xyz_ref(1)).^2 + (ysatrefi-xyz_ref(2)).^2 + (zsatrefi-xyz_ref(3)).^2);
   
    rosatrov = sqrt((xsatrovi-xyz_app(1)).^2 + (ysatrovi-xyz_app(2)).^2 + (zsatrovi-xyz_app(3)).^2);
    
    SD = rosatrov - rosatref;
    
    DD = M * SD;
    
    DD_Livec = [DD_Livec ; DD];
    
    k = k+nsat;
        
end
format long g

DD_Livec