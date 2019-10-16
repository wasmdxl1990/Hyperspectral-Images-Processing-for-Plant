function NDVIimg=img2ndvi(img,wavelength,mask)

NIRband=800;
redband=650;

[~,NRIindex]=min(abs(wavelength-NIRband));
[~,rindex]=min(abs(wavelength-redband));

NIR=img(:,:,NRIindex);
r=img(:,:,rindex);

NDVImask=(NIR-r)./(NIR+r);


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
NDVIimg=NDVImask.*Nmask;
NDVIimg=ind2rgb(gray2ind(NDVImask,255),jet(255));






