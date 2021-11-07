function [dxi, v, mO, cx] = Ex3_SPP_doguilmak
clc
[nrsat,xref,yref,zref,pref,L1ref,L2ref,xrov,yrov,zrov,prov,L1rov,L2rov] = textread('sat2.txt','%d%f%f%f%f%f%f%f%f%f%f%f%f')


xyz_app = [4075599.632,931875.237,4801587.744]


sat = size(xrov, 1);
rosat = zeros(sat, 1);


delta_x = zeros(sat,1);
delta_y = zeros(sat,1);
delta_z = zeros(sat,1);


for k = 1 :sat
   
    rosat(k) = sqrt((xrov(k)-xyz_app(1))^2+(yrov(k)-xyz_app(2))^2+(zrov(k)-xyz_app(3))^2);
    
    delta_x(k) = xrov(k)-xyz_app(1)
    delta_y(k) = yrov(k)-xyz_app(2)
    delta_z(k) = zrov(k)-xyz_app(3)


end

rosat

L = prov - rosat

A = [delta_x./rosat,delta_y./rosat,delta_z./rosat,ones(sat,1)]

