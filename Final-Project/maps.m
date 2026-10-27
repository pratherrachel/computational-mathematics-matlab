clear

%This creates a map of the various discovered

%This is the route without Madrid with any starting city
Route1=readmatrix('LatLong.xlsx','Range','B6:C16');
lat1=Route1(:,1);   lon1=Route1(:,2);

%This is the route without Madrid that starts in London
Route2=readmatrix('LatLong.xlsx','Range','E6:F16');
lat2=Route2(:,1);   lon2=Route2(:,2);

%This is the route with Madrid with any starting city
Route3=readmatrix('LatLong.xlsx','Range','H6:I17');
lat3=Route3(:,1);   lon3=Route3(:,2);

%This is the route with Mardid that starts in London
Route4=readmatrix('LatLong.xlsx','Range','K6:L17');
lat4=Route4(:,1);   lon4=Route4(:,2);

figure(1)
geoplot(lat1,lon1,'-*', ...
    [lat1(end) lat1(1)],[lon1(end) lon1(1)],'m:','LineWidth',1)
geolimits([min(lat1)-1,max(lat1)+1],[min(lon1)-1,max(lon1)+1])
geobasemap streets

figure(2)
geoplot(lat2,lon2,'-*', ...
    [lat2(end) lat2(1)],[lon2(end) lon2(1)],'m:','LineWidth',1)
geolimits([min(lat2)-1,max(lat2)+1],[min(lon2)-1,max(lon2)+1])
geobasemap streets

figure(3)
geoplot(lat3,lon3,'-*', ...
    [lat3(end) lat3(1)],[lon3(end) lon3(1)],'m:','LineWidth',1)
geolimits([min(lat3)-1,max(lat3)+1],[min(lon3)-1,max(lon3)+1])
geobasemap streets

figure(4)
geoplot(lat4,lon4,'-*', ...
    [lat4(end) lat4(1)],[lon4(end) lon4(1)],'m:','LineWidth',1)
geolimits([min(lat4)-1,max(lat4)+1],[min(lon4)-1,max(lon4)+1])
geobasemap streets
