%%
folder = 'Z:\data\Libo Zhang\3D White Reference\slope_flat_02_27_17(2)';
filePattern = fullfile(folder, '*.raw');
srcFiles = dir(filePattern);
numImages = size(srcFiles, 1);
%%
leaf = zeros(20,582);
for i = 1:numImages;
    if ismember(i,1:10)
        hdrName = strrep(srcFiles(i).name, '.raw', '.hdr');
        [wavelengths, spatial, frame, spectral] = parseHdrInfo(folder, hdrName);
        SIZE = [frame, spatial, spectral];
        img =  multibandread(fullfile(folder,srcFiles(i).name), ...
            SIZE, 'uint16', 0, 'bil','ieee-le');
        hdrNameW = strrep(srcFiles(i+20).name, '.raw', '.hdr');
        [~, spatialW, frameW, spectralW] = parseHdrInfo(folder, hdrNameW);
        SIZEW = [frameW, spatialW, spectralW];
        white = multibandread(fullfile(folder,srcFiles(i+20).name), ...
            SIZEW, 'uint16', 0, 'bil','ieee-le');
        threshold = 8;
        [mask,~]=red_edge_segmentation(img,wavelengths,threshold);
        mask = bwareaopen(mask,150);
        [r,c] = find(mask == 1);
        maskImg = bsxfun(@times,img,cast(mask,'like',img));
        % match image size
        [m,n,o]=size(mask);
        [a,b,c]=size(white);
        if isequal([a,b,c],[m,n,o])==0
            whiteimg=padimage(white,m,n,o);
        else 
            whiteimg=white;
        end
        maskWhite = bsxfun(@times,whiteimg,cast(mask,'like',whiteimg));
        rgb = img2rgb(maskImg, wavelengths);
        figure; imshow(rgb, 'InitialMagnification', 'fit');         
        for j = 1:size(maskImg,3)
            leaf(i,j) = sum(sum(maskImg(:,:,j)))/length(r);
            Ref(i,j) = sum(sum(maskWhite(:,:,j)))/length(r);
        end
        
    end

end;
%%
for i = 1:10
    normLeaf1(i,:) = leaf(i,:)/sqrt(sum(leaf(i,:).^2));
end
figure;
oldorder = get(gcf,'DefaultAxesColorOrder');
set(gcf,'DefaultAxesColorOrder',jet(10));
angle = [0;10;20;30;40;50;60;70;80;90];
[C,I] =  sort(angle);
plot3(repmat(wavelengths,10,1)',repmat(angle(I),1,length(wavelengths))',normLeaf1(I,:));
view([0 0])
set(gcf,'DefaultAxesColorOrder',oldorder);
title('Normalized Leaf 1','FontSize',15);
xlabel('Wavelength','FontSize',15); ylabel('Angles','FontSize',15);zlabel('Normalized Reflectance','FontSize',15);
% zlim([0 1.1]);
legend({'Degree 0','Degree 10','Degree 20','Degree 30','Degree 40',...
        'Degree 50','Degree 60','Degree 70','Degree 80','Degree 90'},...
        'FontSize',15,'Location','EastOutside');