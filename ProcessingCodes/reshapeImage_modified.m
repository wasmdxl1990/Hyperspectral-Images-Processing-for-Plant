function [imageMatrix,ignore,spectral] = reshapeImage(path, FileName)

% function reshapeImage
% needs function parseHdrInfo

[ ignore, spatial, frames, spectral ] = parseHdrInfo(path, strrep(FileName,'.raw', '.hdr'));  
pointsPerFile = spatial*spectral*frames;
fidr = fopen(fullfile(path, FileName),'r');
V = fread(fidr,pointsPerFile,'uint16=>uint16');
imageMatrix = single(reshape(V,spatial,spectral,frames));
imageMatrix = permute(imageMatrix,[3,1,2]);
fclose('all');

