 %将IDL筛选出的点的txt读取出来并画出图
 clear all
 leakage=0.15;
%  gama=1.15;
% 	pth='C:\user\tir data\data\pic\';
% pth='D:\DATA\G4\';
% pth='J:\Data\G4\film\';
pth='F:\程序调试\';
% H:\程序调试
file_folder=input('Please input the file folder： ','s');
pth=[pth,file_folder,'\'];
    DIRS=dir(pth);
    n=length(DIRS);
     
  
    
for x=3:n,
    subpth=[pth,DIRS(x).name];
    if isempty(strfind(subpth,'.'))==1
    cd(subpth);
    
    A=dir;
    nf1= numel(A); 
    done=0;
    for l=1:nf1,
        if  isempty(strfind(A(l,1).name,'.bmp'))~=1
            done=1;
            break
        end
    end
    
    if nf1 ~= 2 && done~=1,
        num_of_path=1;
        for l=1:nf1,
        if  isempty(strfind(A(l,1).name,'.txt'))~=1 
            s=A(l,1).name;
            a=textread([subpth,'\',s]);
            n=1;
            donor=a(:,2);
            acceptor=a(:,3);
            
            size=length(donor);
            timeunit=0.25;
            time=(0:(size-1))*timeunit;

                                %%画图
                                methods = 'sym4';
                                level = 2;
                                soft_or_hard = 's';   
                                NaN=2;
                                r_strd=-0.5;
                                
%%

     [C,L] = wavedec(acceptor',3,'db6');
         sigma = wnoisest(C,L,1);
         alpha=2;
         thr=wbmpen(C,L,sigma,alpha);
         keepapp=1;
         acceptor_denoised=wdencmp('gbl',C,L,'db6',3,thr,'s',keepapp);
         ok=0;
            

      [C,L] = wavedec(donor',3,'db6');
         sigma = wnoisest(C,L,1);
         alpha=2;
         thr=wbmpen(C,L,sigma,alpha);
         keepapp=1;
         donor_denoised=wdencmp('gbl',C,L,'db6',3,thr,'s',keepapp);
       
        r=corrcoef(donor_denoised,acceptor_denoised);
        r(1,2)=vpa(r(1,2),3);
        
%      if r(1,2)<r_strd,%r_strd为标准     
            
         var_rate=var(donor_denoised)/var(acceptor_denoised);
         avg_rate=mean(donor_denoised)/mean(acceptor_denoised);
     hdl3=gcf;
         figure(hdl3);
         title([s(1:end-4)]);
      subplot(2,2,1);
         plot(time,donor_denoised,'g',time,acceptor_denoised-leakage*donor_denoised,'r');
%          plot(time,donor_denoised,'g',time,acceptor_denoised*donor_denoised,'r');
         grid on;
      subplot(2,2,2);
%       plot(time,donor(kmin,:)+acceptor(j,:),'k')
        plot(time,donor_denoised+acceptor_denoised,'k')
        total_denoised=donor_denoised+acceptor_denoised;
%         std=sqrt(var(total_denoised));
        avg=mean(total_denoised);
%         title(['  Total intensity ' 'avg' num2str(avg) 'std' num2str(std)]);
        temp=axis;
        grid on;
        axis(temp);
        zoom on;
        fretE=(acceptor_denoised-leakage*donor_denoised)./(acceptor_denoised+donor_denoised);

  

      subplot(2,2,3);
        plot(time,fretE(:),'c');
        temp=axis;
        temp(3)=-0.2;
        temp(4)=1.2;
        axis(temp);
        set(gca,'ytick',[-0.2:0.2:1.2])
        grid on;
        zoom on;
        %title(['  FRET E']);
        %just to ensure cmddenoise function can work on all fretE
        for z=1:length(fretE)
            if fretE(z)>1.3
               fretE(z)=1.3;
            end
            if fretE(z)<-0.3
               fretE(z)=-0.3;
            end
        end
     
          
          fname1=[s(1:end-4),'r=',num2str(r(1,2))];
          
        
        saveas(hdl3,[subpth '\' fname1 '.fig' ],'fig');
        saveas(hdl3,[subpth '\' fname1 '.bmp' ],'bmp');
        fname3=[subpth '\' fname1 '.txt'];
        output = [time' donor_denoised'  (acceptor_denoised-leakage*donor_denoised)' fretE' (donor_denoised+acceptor_denoised)'];%给出 nor_donor来判断一下有没有对齐path
        save(fname3,'output','-ascii');
        %这里最后加上一句删除原来的txt
        clear acceptor
        clear squared_Cy5
        clear donor
        clear squared_Cy3
        clear fretE
        close(gcf)
        delete( [subpth,'\',s])
%      end
                                %%
                                 
                             end
                             end
    end
    end
                    end
                            
               
            
%          system('shutdown -s');    
   