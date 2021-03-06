function NRIimg=img2nri(img,wavelength,mask)

Band1=570;
Band2=670;

[~,Band1index]=min(abs(wavelength-Band1));
[~,Band2index]=min(abs(wavelength-Band2));

Band1mask=img(:,:,Band1index);
Band2mask=img(:,:,Band2index);

NDVImask=(Band1mask-Band2mask)./(Band1mask+Band2mask);


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
NRIimg=NDVImask.*Nmask;
