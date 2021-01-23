% S is the directory path of the results file. It is assumed that it is
% placed in the folder C:\Abaqus_Temp\
S='C:\Abaqus_Temp';
% AbaqusInputFile.inp is the name of the Abaqus input file
fileID = fopen('AbaqusInputFile.inp','wt');
% Write Abaqus options in the file
fprintf(fileID,' *HEADING\n');
fprintf(fileID,' ...<options in Abaqus input file>...\n');
fprintf(fileID,' *STEP\n');
fprintf(fileID,' ...<options to define the preloading history for the model>...\n');
fprintf(fileID,' *END STEP\n');
fprintf(fileID,' *STEP\n');
fprintf(fileID,' *MATRIX GENERATE, STIFFNESS, MASS, VISCOUS DAMPING,\n');
fprintf(fileID,' STRUCTURAL DAMPING\n');
fprintf(fileID,' *MATRIX OUTPUT, STIFFNESS, MASS, VISCOUS DAMPING,\n');
fprintf(fileID,' STRUCTURAL DAMPING, FORMAT=MATRIX INPUT\n');
fprintf(fileID,' *BOUNDARY\n');
fprintf(fileID,' ...<Options to define the boundary conditions for the matrix generation step>...\n');
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
% Obtain the matrix output contained in the various mtx files
format='full'; % other options also possible
Stiffness=getMatrix('AbaqusInputFile_STIF1.mtx',format,S);
Mass=getMatrix('AbaqusInputFile_MASS1.mtx',format,S);
ViscousDamping=getMatrix('AbaqusInputFile_DMPV1.mtx',format,S);
StructuralDamping=getMatrix('AbaqusInputFile_DMPS1.mtx',format,S);