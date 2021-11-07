function G_obs = Ex2_obsread_dogu

clc
obs_num = 16;
fid = fopen('WTZR00DEU_R_20182840000_01D_30S_MO.rnx');

while ~feof(fid)
    
    tline = fgetl(fid);
    
    if strfind(tline,'END OF HEADER')
        disp(tline)       

    break
    end            

end


fclose(fid)