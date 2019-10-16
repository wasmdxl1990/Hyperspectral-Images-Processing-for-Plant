function PRIimg=img2pri(img,wavelength,mask)

Band1=531;
Band2=570;

[~,Band1index]=min(abs(wavelength-Band1));
[~,Band2index]=min(abs(wavelength-Band2));

Band1mask=img(:,:,Band1index);
Band2mask=img(:,:,Band2index);

NDVImask=(Band2mask-Band1mask)./(Band2mask+Band1mask)+0.5;


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
PRIimg=NDVImask.*Nmask;
