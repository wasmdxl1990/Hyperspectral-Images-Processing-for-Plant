function SIPIimg=img2sipi(img,wavelength,mask)

Band1=445;
Band2=680;
Band3=800;



[~,Band1index]=min(abs(wavelength-Band1));
[~,Band2index]=min(abs(wavelength-Band2));
[~,Band3index]=min(abs(wavelength-Band3));



Band1mask=img(:,:,Band1index);
Band2mask=img(:,:,Band2index);
Band3mask=img(:,:,Band3index);


NDVImask=(Band3mask-Band1mask)./(Band3mask+Band2mask);


%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
SIPIimg=NDVImask.*Nmask;
