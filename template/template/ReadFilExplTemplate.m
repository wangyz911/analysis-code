% S is the directory path of the results file. It is assumed that it is
% placed in the folder C:\Abaqus_Temp\
S='C:\Abaqus_Temp';
% AbaqusInputFile.inp is the name of the Abaqus input file
fileID = fopen('AbaqusInputFile.inp','wt');
% Write Abaqus options in the file
fprintf(fileID,' *HEADING\n');
fprintf(fileID,' ...<options in Abaqus input file>...\n');
fprintf(fileID,' *STEP\n');
fprintf(fileID,' ...<options for analysis in Abaqus/Explicit>...\n');
fprintf(fileID,' *FILE OUTPUT\n');
% specify at least one of the following:
fprintf(fileID,' *EL FILE\n');
fprintf(fileID,'  ...<Element output variable IDs>...\n');
% or:
fprintf(fileID,' *NODE FILE\n');
fprintf(fileID,'  ...<Node output variable IDs>...\n');
% end the step definition
fprintf(fileID,' *END STEP\n');
fclose(fileID);
% Run the input file with Abaqus
!abaqus job=AbaqusInputFile
% Give Abaqus enough time to create the lck file
pause(2)
% While the lck file exists then halt Matlab execution
while exist('AbaqusInputFile.lck','file')==2
    pause(0.1)
end
% Convert fil file to fin (ASCII format)
!abaqus ascfil job=AbaqusInputFile
% Give Abaqus enough time for the file conversion
pause(2)
% Obtain results contained in AbaqusInputFile.fin
recordKey=myRecordKey;
out=readFil('AbaqusInputFile.fin',recordKey,S);