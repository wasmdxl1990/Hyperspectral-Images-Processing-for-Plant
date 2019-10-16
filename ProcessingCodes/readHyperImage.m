addpath('E:\Libo Documents\Matlab codes\readHyperImages')
path = 'Z:\jin\Libo\Multispec Device\images with new Pi camera v2';
[wavelengths, spatial, frames1, spectral] = parseHdrInfo(path, 'corn_leaf1.hdr');
SIZE1 = [frames1, spatial, spectral];
plant =  multibandread(fullfile(path,'corn_leaf1.raw'), SIZE1, 'uint16', 0, 'bil','ieee-le');
%%
% RGB = img2rgb(plant,wavelengths);
% figure, imshow(RGB);
% [x,y] = ginput(2);
%%
threshold = 7;
[mask,t]=red_edge_segmentation(plant,wavelengths,threshold);
mask = bwareaopen(mask,200);
figure; imshow(mask);
%%
[~, ~, frames2, ~] = parseHdrInfo(path, 'reference-YYYY-MM-DD_hh.mm.ss.hdr');
SIZE2 = [frames2, spatial, spectral];
white =  multibandread(fullfile(path,'reference-YYYY-MM-DD_hh.mm.ss.raw'), SIZE2, 'uint16', 0, 'bil','ieee-le');

% match image size
[m,n,o]=size(plant);
[a,b,c]=size(white);
if isequal([a,b,c],[m,n,o])==0
    whiteimg=padimage(white,m,n,o);
else 
    whiteimg=white;
end

ref = plant./whiteimg;
maskRef = bsxfun(@times,ref,cast(mask,'like',ref));
%%
NDVI = pixelNDVI(maskRef,wavelengths);
figure;
mesh(NDVI);
%%
figure,imagesc(NDVI,'AlphaData',~isnan(NDVI))
c = colorbar;
caxis([0.1,0.8])
colormap(jet(256))