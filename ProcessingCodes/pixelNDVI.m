function ndvi=pixelNDVI(X,wavelength)

% NDVI = [R(800)-R(640)]  /  [R(800)+R(640)]

[err1,i800]=min(abs(wavelength-800));
[err2,i640]=min(abs(wavelength-640));
 
     if err1<2 & err2<2
           ndvi=mean((X(:,i800)-X(:,i640))./(X(:,i800)+X(:,i640)));
     else
         ndvi=NaN;
     end

     
 
  