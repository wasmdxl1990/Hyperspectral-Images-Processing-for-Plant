function NDVIimg_640=img2nir640(img,wavelength,mask)

%NIRband=800;
redband=640;

%[~,NRIindex]=min(abs(wavelength-NIRband));
[~,rindex]=min(abs(wavelength-redband));

%NIR=img(:,:,NRIindex);
r=img(:,:,rindex);

%NDVImask=(NIR-r)./(NIR+r);
NDVImask=r;

%NDVIimg = ind2rgb(gray2ind(NDVImask,255),jet(255));

Nmask=mask;
NDVIimg_640=NDVImask.*Nmask;


