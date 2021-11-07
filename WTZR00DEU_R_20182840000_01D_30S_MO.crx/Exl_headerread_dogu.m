function[Rnx_type,Sta_name,Rec_type,Ant_type,XYZ_RNX,Ant_dNEU,obs_num,obs_type,time_of_first_obs,time_system] = Exl_headerread_dogu
%{
This function has been created 
to read some information from a RINEX file.
This information's are: 
-Rinex Version (Rnx_type,string), 
-Station Name (Sta_name,string), 
-Reciver Type (Rec_type,string),
-Approximate position XYZ (XYZ_RNX,column vector 3x1)
-Antenna Type (Ant_type,string)
-North East Up eccentrity of antenna (Ant_dNEU,column vector 3x1)
-Number of observations GPS system (obs_num,intiger number)
-Observation Types (obs_type,cell of strings)
-Time of firts observation (time_of_first_obs,column vector 6x1)
-Time System (time_system,string)
%}

% Giving a long format to be readable for human 
format longG
% Selecting a RINEX file to open
filernx = fopen('WTZR00DEU_R_20182840000_01D_30S_MO.rnx');
%LOGIC
while ~feof(filernx)
% Searching for VERSION OF RINEX
    tline = fgetl(filernx);
    if strfind(tline,'RINEX VERSION / TYPE')
        Rnx_type = tline(1:9);
        Rnx_type = Rnx_type(find(~isspace(Rnx_type))); % this line deletes a blank places in string
        disp('RINEX version type:')
        disp(Rnx_type)
% Searching for NAME OF THE STATION
    elseif  strfind(tline,'MARKER NAME')
        Sta_name = tline(1:4);
        Sta_name = Sta_name(find(~isspace(Sta_name))); % this line deletes a blank places in string
        disp('Name of reference station:')
        disp(Sta_name)
% Searching for TYPE OF THE RECIVER    
    elseif strfind(tline,'REC # / TYPE / VERS')
        Rec_type = tline(21:40);
        Rec_type = Rec_type(find(~isspace(Rec_type))); % this line deletes a blank places in string
        %A = A(find(~isspace(A)))
        disp('Type of reciver:')
        disp(Rec_type)
% Searching for NAME OF ANTENNA TYPE   
    elseif strfind(tline,'ANT # / TYPE')
        Ant_type = tline(21:40);
        disp('Type of antenna:')
        disp(Ant_type)
% Searching for APROXIMATED RECIVER COORDINATES
    elseif strfind(tline,'APPROX POSITION XYZ')
        XYZ_RNX_str = tline(1:42);
        X_RNX = str2double(XYZ_RNX_str(1:14));
        Y_RNX = str2double(XYZ_RNX_str(15:28));
        Z_RNX = str2double(XYZ_RNX_str(29:42));
        disp('Approximted antenna position X:')
        disp(X_RNX)
        disp('Approximted antenna position Y:')
        disp(Y_RNX)
        disp('Approximted antenna position Z:')
        disp(Z_RNX)
        XYZ_RNX(1) = X_RNX;
        XYZ_RNX(2) = Y_RNX;
        XYZ_RNX(3) = Z_RNX;
        disp('Column vector of approximted antenna position X,Y,Z:')
        disp(XYZ_RNX)
% Searching for NorthEastUpeccentrity of antenna column vector 3x1
    elseif strfind(tline,'ANTENNA: DELTA H/E/N')
        Ant_dNEU_str = tline(1:42);
        Ant_dN = str2double(Ant_dNEU_str(1:14));
        Ant_dE = str2double(Ant_dNEU_str(15:28));
        Ant_dU = str2double(Ant_dNEU_str(29:42));
        disp('North eccetrity of anttena:')
        disp(Ant_dN)
        disp('East eccetrity of anttena:')
        disp(Ant_dE)
        disp('Up eccetrity of anttena:')
        disp(Ant_dU)
        Ant_dNEU(1) = Ant_dN; 
        Ant_dNEU(2) = Ant_dE;
        Ant_dNEU(3) = Ant_dU;
        disp('Column vector of anttena eccentities:')
        disp(Ant_dNEU)
% Searching for A NUMBER OF OBSERVATION TYPES,  NAD THEIR TYPE - GPS SYSTEM(INTIGER)
    elseif strfind(tline,'SYS / # / OBS TYPES')
        if tline(1) == 'G'
           obs_num = tline(3:6);
           disp('Number of GPS obsercations:')
           disp(obs_num)
           obs_type = tline(7:58);
           disp('Types of observations:')
           disp(obs_type)
        end
% Searching for A TIME OF FIRST OBSERVATION        
    elseif strfind(tline,'TIME OF FIRST OBS')
        %YEARS
        year_obs = str2num(tline(3:6));
        disp('Year of first observation:')
        disp(year_obs)
        %MONTHS
        month_obs = str2num(tline(7:12));
        disp('Month of first observation:')
        disp(month_obs)
        %DAY OF MONTH
        day_obs = str2num(tline(13:18));
        disp('Day of month of first observation:')
        disp(day_obs)
        %HOURS
        hour_obs = str2num(tline(19:24));
        disp('Hour of first observation:')
        disp(hour_obs)
        %MINUTES
        minute_obs = str2num(tline(25:30));
        disp('Minute of first observation:')
        disp(minute_obs)
        %SECONDS
        second_obs = str2num(tline(31:36));
        disp('Second of first observation:')
        disp(second_obs)
        %VECTOR
        time_of_first_obs(1)= year_obs; 
        time_of_first_obs(2)= month_obs;
        time_of_first_obs(3)= day_obs;
        time_of_first_obs(4)= hour_obs;
        time_of_first_obs(5)= minute_obs;
        time_of_first_obs(6)= second_obs;
        disp('Column vector of first observation:')
        disp(time_of_first_obs)
        % CHECKING TIME SYSTEM 
        time_system = tline(49:51);
        if time_system == 'GPS'
            disp ('Time system is Global Positioning System!')
        else 
            disp('It is some other time system than GPS !!!!')
        end
        
    end
end
