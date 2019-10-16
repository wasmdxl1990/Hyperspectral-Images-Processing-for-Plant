function PSRIimg=img2psri(img,wavelength,mask)

Band1=500;
Band2=678;
Band3=750;



[~,Band1index]=min(abs(wavelength-Band1));
[~,Band2index]=min(abs(wavelength-Band2));
[~,Band3index]=min(abs(wavelength-Band3));



Band1mask=img(:,:,Band1index);
Band2mask=img(:,:,Band2index);
Band3mask=img(:,:,Band3index);


NDVImask=(Band2mask-Band1mask)./(Band3mask)+0.5;


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
PSRIimg=NDVImask.*Nmask;
