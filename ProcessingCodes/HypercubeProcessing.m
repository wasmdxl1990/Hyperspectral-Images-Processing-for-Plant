function HypercubeProcessing(InputPath,OutputPath,threshold)
% loading dark reference
    loaddark
    
% loop through each image
for i=1:size(InputPath,1)
  path=InputPath{i,1}; 
  file=InputPath{i,2}; 
  % read image and segment
    [img,wavelength,bands] = reshapeImage_modified(path,file); 
    rgb=img2rgb(img,wavelength);
    [mask,t]=red_edge_segmentation(img,wavelength,threshold); 
    mask=bwareaopen(mask,50);  
 
%     % load white reference
%      if i==1
%          % load white image for first time
%          [white]=reshapeImage_modified(ReferencePath{i,1},ReferencePath{i,2});
%      else
%         % do not load existing white image
%         if isequal(fullfile(ReferencePath{i-1,1},ReferencePath{i-1,2}),fullfile(ReferencePath{i,1},ReferencePath{i,2}))
%             % do nothing
%         else
%             [white]=reshapeImage_modified(ReferencePath{i,1},ReferencePath{i,2});
%         end
%      end
%  
    % match image size
    
    whtStrip = mean(img(:,(end-25):(end-5),:),2);
    white = repmat(whtStrip,[1 782 1]);
    
    [m,n,o]=size(img);
    [a,b,c]=size(white);
    if isequal([a,b,c],[m,n,o])==0
        whiteimg=padimage(white,m,n,o);
    else 
        whiteimg=white;
    end
    % calculate reflectance
   % res=reshape(dark_value,1,1,length(dark_value));
   % dark=repmat(res,m,n);
%     ref=(img-dark)./(whiteimg-dark); 
    ref=img./whiteimg; 
    calirgb=img2calirgb(ref,wavelength);
	NDVIimg=img2ndvi(ref,wavelength,mask);
    NDVIimgRGB=img2ndviRGB(ref,wavelength,mask);
	ARIimg=img2ari(ref,wavelength,mask);    
 	PhRIimg=img2phri(ref,wavelength,mask);   
	NPCIimg=img2npci(ref,wavelength,mask);    
 	NBNDVIimg=img2nbndvi(ref,wavelength,mask);
 	PRIimg=img2pri(ref,wavelength,mask);
	NRIimg=img2nri(ref,wavelength,mask);    
 	TCARIimg=img2tcari(ref,wavelength,mask);   
	SIPIimg=img2sipi(ref,wavelength,mask);    
 	PSRIimg=img2psri(ref,wavelength,mask);   
	NDVI640img=img2nir640(ref,wavelength,mask);    
 	NDVI800img=img2nir800(ref,wavelength,mask);    
    SPADimg=img2spad(ref,wavelength,mask);
    
    [X,~] = imstack2vectors(ref,mask);   
    % get table
    
    
    
    
    
    
    
    [DataCell]=gettable(file,path,X,mask,wavelength,threshold);
    
    
    
    k = find(MASK==1);
    X_spectral=double(X(:,end-435:end-50));
    pred=pls(X_spectral,PLSModel_RWCTOP,options);
    Pred_RWC=double(cell2mat(pred.pred(2)));
    MASK = double(MASK);
    L1=-100;
    L2=63;
    Pred_RWC_L=Pred_RWC;
    Pred_RWC_L(Pred_RWC_L<L2 & Pred_RWC_L>L1 )=999;
    MASK(k)=Pred_RWC_L./150;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    % create date folder
    [~,datefolder,~]=fileparts(path);
%     mask1=flip(mask,2);
%     rgb1=flip(rgb,2);
%     calirgb1=flip(calirgb,2);
%     NDVIimg1=flip(NDVIimg,2);
%     ARIimg=flip(ARIimg,2);
%     PhRIimg=flip(PhRIimg,2);
%     NPCIimg=flip(NPCIimg,2);   
%     NBNDVIimg=flip(NBNDVIimg,2);    
%     PRIimg=flip(PRIimg,2);
%     NRIimg=flip(NRIimg,2);
%     TCARIimg=flip(TCARIimg,2);
%     SIPIimg=flip(SIPIimg,2);   
%     PSRIimg=flip(PSRIimg,2);    
%     NDVI640img=flip(NDVI640img,2);   
%     NDVI800img=flip(NDVI800img,2);    
%     SPADimg=flip(SPADimg,2); 
    mask1=mask;
    rgb1=rgb;
    calirgb1=calirgb;
    NDVIimg1=NDVIimg;
    
    
    
    
    
    
    
    
    [numrows,numcols]=size(mask1);
    ratio=1;
    mask2 = imresize(mask1,[round(numrows*ratio) numcols]);
    rgb2 = imresize(rgb1,[round(numrows*ratio) numcols]);
    calirgb2 = imresize(calirgb1,[round(numrows*ratio) numcols]);
    NDVIimg2 = imresize(NDVIimg1,[round(numrows*ratio) numcols]);
    NDVIimgRGB2=imresize(NDVIimgRGB,[round(numrows*ratio) numcols]);
    
    ARIimg = imresize(ARIimg,[round(numrows*ratio) numcols]);    
    PhRIimg = imresize(PhRIimg,[round(numrows*ratio) numcols]);
    NPCIimg = imresize(NPCIimg,[round(numrows*ratio) numcols]);       
    NBNDVIimg = imresize(NBNDVIimg,[round(numrows*ratio) numcols]);
    PRIimg = imresize(PRIimg,[round(numrows*ratio) numcols]);       
    NRIimg = imresize(NRIimg,[round(numrows*ratio) numcols]);
    TCARIimg = imresize(TCARIimg,[round(numrows*ratio) numcols]);       
    SIPIimg = imresize(SIPIimg,[round(numrows*ratio) numcols]);
    PSRIimg = imresize(PSRIimg,[round(numrows*ratio) numcols]);       
    NDVI640img = imresize(NDVI640img,[round(numrows*ratio) numcols]);
    NDVI800img = imresize(NDVI800img,[round(numrows*ratio) numcols]);       
    SPADimg = imresize(SPADimg,[round(numrows*ratio) numcols]); 
    
    mkdir(fullfile(OutputPath,datefolder));
    
    % create result folder
    foldername=fullfile(OutputPath,datefolder,file(1:end-4));
    mkdir(foldername);
    % save results
    savename=fullfile(foldername,'matfiles');
    imwrite(rgb2,fullfile(foldername,'RGB.png'),'png');
	imwrite(NDVIimg2,fullfile(foldername,'NDVIimg.png'),'png');
    imwrite(NDVIimgRGB2,fullfile(foldername,'NDVIimgRGB.png'),'png');
    imwrite(mask2,fullfile(foldername,'mask.png'),'png');
    imwrite(calirgb2,fullfile(foldername,'calirgb.png'),'png');    
    imwrite(ARIimg,fullfile(foldername,'ARIimg.png'),'png');
    imwrite(PhRIimg,fullfile(foldername,'PhRIimg.png'),'png');
    imwrite(NPCIimg,fullfile(foldername,'NPCIimg.png'),'png');
    imwrite(NBNDVIimg,fullfile(foldername,'NBNDVIimg.png'),'png');
    imwrite(PRIimg,fullfile(foldername,'PRIimg.png'),'png');
    imwrite(TCARIimg,fullfile(foldername,'TCARIimg.png'),'png');
    imwrite(SIPIimg,fullfile(foldername,'SIPIimg.png'),'png');
    imwrite(NRIimg,fullfile(foldername,'NRIimg.png'),'png');
    imwrite(PSRIimg,fullfile(foldername,'PSRIimg.png'),'png');
    imwrite(NDVI640img,fullfile(foldername,'NDVI640img.png'),'png');
    imwrite(NDVI800img,fullfile(foldername,'NDVI800img.png'),'png');
    imwrite(SPADimg,fullfile(foldername,'SPADimg.png'),'png');
    %save(savename);
    %save(savename,'X','mask','t','DataCell','wavelength','-v7.3');
    
    if i==1
        DataTable=DataCell;
    else
        DataTable=[DataTable;DataCell(2,:)];
    end

end

tablename=fullfile(OutputPath,strcat('Table_',datefolder));
save(tablename,'DataTable');
% xlswrite(fullfile(OutputPath,'DataTable.xlsx'),DataTable)
