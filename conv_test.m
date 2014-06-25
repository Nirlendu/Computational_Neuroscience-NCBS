% sdt2an.m
% Convert a file from Stimulate to Analyze format.
% (Copy .sdt to .img, add a header.)
% Written by Nirlendu Saha
% Mail at nirlendu##at##gmail##dot##com


 %-----------------
 % Prompt for input
 %-----------------
   xdim    = input('x dimension');
   ydim    = input('y dimension');
   zdim    = input('slice thickness');
   fov     = input('fov');

   %name1   = 'stimulate.sdt';
   name1 = 'ab_18.4.01.ax.sdt';
   name2   = input('Experiment name (ex: "pos1"):  ','s');

   nslices = input('How many slices per volume?  (usually 25)');
   nvols   = input('How many volumes per expt/run (usually 63)?  ');
   numruns = input('How many expts/runs?  ');

   path1   = input('SDT file location? (Ex: /export/data/reconstruction/gmr3/r1/:  ' ,'s');
   path2   = input('Output directory? (Ex: /home/students/jgrinband/data/):  ' ,'s');



 %------------------
 % Loop through runs
 %------------------
   for run_num  = 1 : numruns,

     s=sprintf('Run number %d of %d', run_num,numruns); disp(s);

   %----------------------------
   % Copy .sdt file to .img file
   %----------------------------
     img_copy = 1;
     if img_copy ==1
       stim_file = [path1,name2,'/r',int2str(run_num),'/',name1];
       ana_file  = [path2,name2,'r',int2str(run_num),'.img'];
       display(stim_file);
       display(ana_file);
       %copyfile(stim_file,ana_file);
       %s=sprintf('unix(''cp %s %s'');',stim_file,ana_file); eval(s);
     end
   %---------------------
   % Write Analyze header
   %---------------------
     hdr_write = 1;
     if hdr_write ==1
       %stim_file = [path1,name2,'/r',int2str(run_num),'/',name1];
       stim_file = [path1,name2,int2str(run_num),'\',name1];
       ana_file  = [path2,name2,'r', int2str(run_num)];
       %s=sprintf('unix(''cp %s %s'');',stim_file,ana_file); eval(s);
       copyfile (stim_file,ana_file);
       DIM  = [xdim ydim nslices nvols];
       VOX  = [fov/xdim fov/ydim zdim nvols];
       TYPE = 4; % 4 for 2 bytes per pixel
       spm_hwrite(ana_file,DIM,VOX,1,TYPE,0,[0 0 0],'');
       s=sprintf('unix(''rm %s'');',ana_file); eval(s);

     end

 end

disp('Voila!')
