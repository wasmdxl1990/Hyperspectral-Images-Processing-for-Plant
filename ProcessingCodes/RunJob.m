function RunJob(InputFolder,OutputFolder,threshold)

[c name] = system('hostname');
fprintf('\n\nhostname:%s\n', name);

dt1=char(datetime);
fprintf('\n\nStart Date and Time:%s\n',dt1)

warning off


InputFolder=pathmodifier(InputFolder);
OutputFolder=pathmodifier(OutputFolder);
[InputPath]=definepath(InputFolder);

HypercubeProcessing(InputPath,OutputFolder,threshold);

dt2=char(datetime);
fprintf('\n\nEnd Date and Time:%s\n',dt2)

