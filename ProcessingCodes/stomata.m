folder = 'X:\jin\Libo\microscope_hyperspectral\corn leaf transmittance test';
[wavelengths, spatial, frames, spectral] = parseHdrInfo(folder, 'test_69.hdr');
SIZE = [frames, spatial, spectral];
plant =  multibandread(fullfile(folder,'test_69.raw'), SIZE, 'uint16', 0, 'bil','ieee-le');
%%
fileName = 'test_69.raw';
pointsPerFile = spatial*spectral*frames;
fidr = fopen(fullfile(folder, fileName),'r');
V = fread(fidr,pointsPerFile,'uint16=>uint16');
imageMatrix = single(reshape(V,frames,spatial,spectral));
% imageMatrix_err = permute(imageMatrix,[3,1,2]);
fclose('all');
%%
% get RGB wavelengths
[~,i640]=min(abs(wavelengths-639.8713)); % red band
[~,i550]=min(abs(wavelengths-549.7619)); % green band
[~,i470]=min(abs(wavelengths-469.9277)); % blue band
im = squeeze(plant(:,:,[i640,i550,i470]));
%%
r=plant(:,:,i640);
g=plant(:,:,i550);
b=plant(:,:,i470);
r=(r-min(min(r)))/(max(max(r))-min(min(r)));
g=(g-min(min(g)))/(max(max(g))-min(min(g)));
b=(b-min(min(b)))/(max(max(b))-min(min(b)));

r1=imadjust(r,[],[],0.5);
g1=imadjust(g,[],[],0.5);
b1=imadjust(b,[],[],0.5);
rgb=cat(3,r1,g1,b1);
figure, imshow(rgb);
%%
figure, imshow(im/65535*64);
[x_bright_margin,y_bright_margin] = ginput(30);
figure, imshow(im/65535*64);
[x_bright_center,y_bright_center] = ginput(30);
figure, imshow(im/65535*64);
[x_bright_out,y_bright_out] = ginput(30);
%%
figure, imshow(im/65535*64);
[x_dark_margin,y_dark_margin] = ginput(30);
figure, imshow(im/65535*64);
[x_dark_center,y_dark_center] = ginput(30);
figure, imshow(im/65535*64);
[x_dark_out,y_dark_out] = ginput(30);
%%
figure,imagesc(im/65535*64);
hold on
plot(x_bright_margin,y_bright_margin,'r.');
%%
for i = 1:30
    bright_margin(i,:) = squeeze(plant(round(y_bright_margin(i)),round(x_bright_margin(i)),:));
    bright_center(i,:) = squeeze(plant(round(y_bright_center(i)),round(x_bright_center(i)),:));
    bright_out(i,:) = squeeze(plant(round(y_bright_out(i)),round(x_bright_out(i)),:));
    
    dark_margin(i,:) = squeeze(plant(round(y_dark_margin(i)),round(x_dark_margin(i)),:));
    dark_center(i,:) = squeeze(plant(round(y_dark_center(i)),round(x_dark_center(i)),:));
    dark_out(i,:) = squeeze(plant(round(y_dark_out(i)),round(x_dark_out(i)),:));   
    
end
%%
stomata = [bright_center;dark_center;bright_margin;dark_margin;bright_out;dark_out];

xlswrite(fullfile(folder,'stomata_table.xlsx'),[wavelengths;stomata]);
%%
NDVI = pixelNDVI(stomata,wavelengths);
ARI = pixelARI(stomata,wavelengths);
NBNDVI = pixelNBNDVI(stomata,wavelengths);
NPCI = pixelNPCI(stomata,wavelengths);
NRI = pixelNRI(stomata,wavelengths);
PhRI = pixelPhRI(stomata,wavelengths);
PRI = pixelPRI(stomata,wavelengths);
PSRI = pixelPSRI(stomata,wavelengths);
SIPI = pixelSIPI(stomata,wavelengths);
TCARI = pixelTCARI(stomata,wavelengths);
%%
AAA = [NDVI,NBNDVI,ARI,NPCI,NRI,PhRI,PRI,PSRI,SIPI,TCARI,normr(stomata)];
new_wave = [1,1,1,1,1,1,1,1,1,1,wavelengths];
%%
xlswrite(fullfile(folder,'stomata_table.xlsx'),[new_wave;AAA]);
%% 
figure, mesh(stomata);
%%
figure
hold on
plot(dark_center', 'r');
plot(dark_margin', 'g');
plot(dark_out', 'b');
legend('center','margin','outside')
hold off

figure,
hold on
plot((normr(dark_center))', 'r');
plot((normr(dark_margin))', 'g');
plot((normr(dark_out))', 'b');
legend('center','margin','outside')
hold off