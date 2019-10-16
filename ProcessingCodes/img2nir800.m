function NDVIimg_800=img2nir800(img,wavelength,mask)

NIRband=800;
%redband=650;

[~,NRIindex]=min(abs(wavelength-NIRband));
%[~,rindex]=min(abs(wavelength-redband));

NIR=img(:,:,NRIindex);
%r=img(:,:,rindex);

%NDVImask=(NIR-r)./(NIR+r);
NDVImask=NIR;

%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
NDVIimg_800=NDVImask.*Nmask;

