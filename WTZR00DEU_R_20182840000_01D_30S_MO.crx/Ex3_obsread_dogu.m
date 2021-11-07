function G_obs = Ex3_obsread_dogu

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

tline = fgetl(fid);


epoch = 0;

while ~feof(fid)      

       
       kline = fgetl(fid);
       
       if strfind(kline,'>')
           
           epoch = epoch + 1;
           year = str2double(kline(3:6))
           month = str2double(kline(8:9))
           day = str2double(kline(11:12))
           hour = str2double(kline(14:15))
           minute = str2double(kline(17:18))
           second = str2double(kline(20:21))
           data = [year, month, day, hour, minute, second]
           G_obs{1,epoch}=data;
           
           
           %d = zeros(6,1);
           %d(1) = tline;
           
       
       end
       tline = fgetl(fid);
end
fclose(fid)