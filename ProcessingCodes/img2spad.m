function SPADimg=img2spad(img,wavelength,mask)

NIRband=942;
redband=650;

[~,NRIindex]=min(abs(wavelength-NIRband));
[~,rindex]=min(abs(wavelength-redband));

NIR=img(:,:,NRIindex);
r=img(:,:,rindex);

NDVImask=(NIR)./(r)/12;


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
SPADimg=NDVImask.*Nmask;
