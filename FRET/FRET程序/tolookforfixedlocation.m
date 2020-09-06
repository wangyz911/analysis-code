%找出对应关系
close all;
fclose('all');
cd('E:\程序调试\traces\');
fileFolder=fullfile('E:\程序调试\traces\');
dirOutput=dir(fullfile(fileFolder,'*.traces'));
fileNames={dirOutput.name}';
M=size(fileNames,1);
for o=1:M,
fname=fileNames(o);
fname=fname{1};
fname=['E:\程序调试\traces\',fname];
disp('working on tiff ')
disp(fname)
[path,name,EXT] = fileparts(fname) ;
fname=name;
disp('fname length is');
length(fname)
% if isempty(fname)
%     fname=1;
% end
% fname=num2str(fname);

%['' fname '.traces']
fname_for_match=[fname,'_for_match'];
mkdir('E:\程序调试\traces\pic\',fname_for_match)
% define time unit
timeunit=0.25;

% timeunit=input('Time Unit [default=0.25 sec]  ');
% if isempty(timeunit)
%     timeunit=0.25;
% end

%leakage=0.20;
leakage=0;
% leakage=input('Donor leakage correction [default=0]  ');
% if isempty(leakage)
%     leakage=0.20;
%     leakage=0;
% end


%fid=fopen(['hel' fname '.traces'],'r');
fid=fopen(['' fname '.traces'],'r');
disp(fid);


len=fread(fid,1,'int32');
disp('The len of the time traces is: ')
disp(len);
Ntraces=fread(fid,1,'int16')
disp('The number of traces is:')
disp(Ntraces);
time=(0:(len-1))*timeunit;

raw=fread(fid,Ntraces*len,'int16');
disp('Done reading pma data.');
fclose(fid);

a=textread(['' fname '.txt']);
%fed=fopen(['' fname '.pks'],'r');
%a=fread(fed,[Ntraces,4]);
x=a(:,2);
y=a(:,3);
i=0;
while x(i+1) <256
    i=i+1;
end

disp('The number of the donor traces is: ')
disp(i)


% convert into donor and acceptor traces
index=(1:Ntraces*len);
Data=zeros(Ntraces,len);
donor=zeros(i,len);
donor_denoised=zeros(i,len);
acceptor=zeros(Ntraces-i,len);
acceptor_denoised=zeros(Ntraces-i,len);
Data(index)=raw(index);
methods = 'sym4';
level = 2;
soft_or_hard = 's';   
NaN=2;
%thrSettings = 75.241758965267010;

for j=1:i,
    donor(j,:)=Data(j,:);
    %donor_denoised(j,:)=Data(j,:);
    donorx(j)=x(j);
    donory(j)=y(j);
end
for j=1:(Ntraces-i)
    acceptor(j,:)=Data(i+j,:);
    %acceptor_denoised(j,:)=Data(i+j,:);
    acceptorx(j)=x(i+j);
    acceptory(j)=y(i+j);
end
disp('done reading a & c ')
j=1;
figure;
hdl3=gcf;
acceptor_no=Ntraces-i;
donor_no=i;

search_r=20;
R=zeros(2*search_r+1,2*search_r+1);%用于累加map中的r
%%
while j<acceptor_no+1 ,
     [C,L] = wavedec(acceptor(j,:),3,'db6');
         sigma = wnoisest(C,L,1);
         alpha=2;
         thr=wbmpen(C,L,sigma,alpha);
         keepapp=1;
        acceptor_denoised(j,:)=wdencmp('gbl',C,L,'db6',3,thr,'s',keepapp);
         
%      acceptor_denoised(j,:)=acceptor(j,:);
     
    ok=0;
%     rmin=-0.49;
    disp('working on acceptor ')
    disp(j)
    for k=1:donor_no,
     if (acceptorx(j)-256-search_r)<donorx(k)&&donorx(k)<(acceptorx(j)-256+search_r) && (acceptory(j)-search_r)<donory(k)&&donory(k)<(acceptory(j)+search_r),%5变成10了
         [C,L] = wavedec(donor(k,:),3,'db6');
         sigma = wnoisest(C,L,1);
         alpha=2;
         thr=wbmpen(C,L,sigma,alpha);
         keepapp=1;
         donor_denoised(k,:)=wdencmp('gbl',C,L,'db6',3,thr,'s',keepapp);
%                 donor_denoised(k,:)=donor(k,:);
        r=corrcoef(donor_denoised(k,:),acceptor_denoised(j,:));
%         r=corrcoef(donor(k,:),acceptor(j,:));
        r(1,2)=vpa(r(1,2),3);
     if abs(r(1,2))>0.7,%包括透过的杂质以及FRET点
%          if r(1,2)<-0.5,%包括透过的杂质以及FRET点
%               if r(1,2)>0.7,%包括透过的杂质以及FRET点
         clear donor_denoised(k,:)
          R(acceptorx(j)-donorx(k)-256+20,acceptory(j)-donory(k)+20)= R(acceptorx(j)-donorx(k)-256+20,acceptory(j)-donory(k)+20)+abs(r(1,2));
%        if r(1,2)<=-0.9
%            surf (acceptorx(j)-donorx(k),acceptory(j)-donory(k),R)%,'rd')
%            grid on
%            hold on
%        end
%        if r(1,2)<=-0.8&&r(1,2)>-0.9
%            surf (acceptorx(j)-donorx(k),acceptory(j)-donory(k),R)%,'rd')
%            grid on
%            hold on
%        end
%        if r(1,2)<=-0.7&&r(1,2)>-0.8
%             surf (acceptorx(j)-donorx(k),acceptory(j)-donory(k),R)%,'rd')
%            grid on
%            hold on
%        end
%        if r(1,2)<=0.8&&r(1,2)>0.7
%             surf (acceptorx(j)-donorx(k),acceptory(j)-donory(k),R)%,'gd')
%            grid on
%            hold on
%        end
%        
%        if r(1,2)<=0.9&&r(1,2)>0.8
%             surf (acceptorx(j)-donorx(k),acceptory(j)-donory(k),R)%,'gd')
%            grid on
%            hold on
%        end
%        
%        if r(1,2)>0.9
%             surf (acceptorx(j)-donorx(k),acceptory(j)-donory(k),R)%,'gd')
%            grid on
%            hold on
%        end
        
     end 
      
      
%      end
     end
    end
    %clear acceptor_denoised(j,:)
   j=j+1;
   
end
 surf(-20:20,-20:20,R)
 max_R=max(R(:));
 [max_R,index]=max(R(:));
 R_y=fix(index/(2*search_r+1))+1-search_r;
 R_x=mod(index,(2*search_r+1))-search_r+256;
  fname1=['location_guide_map_x=' num2str(R_x) 'y=' num2str(R_y)];
          fname2=fname;
        if fname2(end)==' '
            fname2=fname2(1:end-1);
        end
        saveas(hdl3,['E:\程序调试\pic\' fname_for_match '\' fname1 '.fig' ],'fig');
        saveas(hdl3,['E:\程序调试\pic\' fname_for_match '\' fname1 '.bmp' ],'bmp');
clear donor_denoised
    clear acceptor_denoised
% delete(['' fname '.traces'])
% delete(['' fname '.txt'])
end



close all;
fclose('all');
%  system('shutdown -s');