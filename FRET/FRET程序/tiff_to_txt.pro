pro tiff_to_txt

;需要用到wv_denoise函数
;需要将程序修改为不再从子文件夹读取tiff 而直接从母文件夹读取

;dir= "J:\Data\G4\film\"
;dir= "M:\程序调试\"
dir= "F:\程序调试\"
;dir= "H:\程序调试\"
run = "asdf"
print, "name of directories to analyze"
read, run

path = dir + run
print, path
; find all the sub-directories in that directory

;foo_dirs = findfile(path + '\*');找到路径下的子文件
;nfoo_dirs = size(foo_dirs);子文件的数目
path = path + '\'
;nsub_dirs = 0                ; figure number of sub-directories 找到子文件中文件夹的数目（子文件夹的名字末尾是斜杠）
;for i = 2, nfoo_dirs(1) - 1 do begin
 ;   if rstrpos(foo_dirs(i),'\') eq (strlen(foo_dirs(i)) - 1) then begin
  ;     nsub_dirs = nsub_dirs + 1
   ; endif
;endfor

; print, "found : ", nsub_dirs, " sub-directories, which are :"
;sub_dirs = strarr(nsub_dirs)
;j = 0
;for i = 2, nfoo_dirs(1) - 1 do begin    ; get sub-directory names
 ;   if rstrpos(foo_dirs(i),'\') eq (strlen(foo_dirs(i)) - 1) then begin
  ;     sub_dirs(j) = foo_dirs(i)
   ;    j = j + 1
   ; endif
;endfor

; for i = 0, nsub_dirs - 1 do begin     ; print sub_directory names
;   print, sub_dirs(i)
; endfor

; now go through sub-directories finding the files to be analyzed and
; analyzing them if necessary.

;for i = 2, nfoo_dirs(1) - 1 do begin



    ; find all the *.pma files in the sub-directory
    ; analyze them if there is no currently existing .pks file

    f_to_a = findfile(path + '*.tif')
    print,f_to_a
    nf_to_a = size(f_to_a)
    for j = 0, nf_to_a(1) - 1 do begin
       f_to_a(j) = strmid(f_to_a(j), 0, strlen(f_to_a(j)) - 4)
       bb=findfile(f_to_a(j))
       err=1
       if strlen(bb) ne 0 then err=0 ;确保有对应文件夹的tiff是不用处理的
       close, 1

       if strmid(f_to_a(j), strlen(f_to_a(j))-3, strlen(f_to_a(j))-1) eq "ave" or strmid(f_to_a(j), strlen(f_to_a(j))-3, strlen(f_to_a(j))-1) eq "und" or strmid(f_to_a(j), strlen(f_to_a(j))-3, strlen(f_to_a(j))-1) eq 'ted'then begin ;自动跳过
        err=0;
       endif

       if err ne 0 then begin
         ; print, "Working on : ", f_to_a(j), err
         print, "Working on : ", f_to_a(j)
         p_nxgn1_ffpwn, f_to_a(j)
         p_nxgn1_apwn, f_to_a(j)
       endif
    endfor
;endfor

print, "Done."

end

pro p_nxgn1_ffpwn, run
loadct, 5

COMMON colors, R_ORIG, G_ORIG, B_ORIG, R_CURR, G_CURR, B_CURR

circle = bytarr(11,11)

circle(*,0) = [	0,0,0,0,0,0,0,0,0,0,0]
circle(*,1) = [ 0,0,0,0,1,1,1,0,0,0,0]
circle(*,2) = [ 0,0,0,1,0,0,0,1,0,0,0]
circle(*,3) = [ 0,0,1,0,0,0,0,0,1,0,0]
circle(*,4) = [ 0,1,0,0,0,0,0,0,0,1,0]
circle(*,5) = [ 0,1,0,0,0,0,0,0,0,1,0]
circle(*,6) = [ 0,1,0,0,0,0,0,0,0,1,0]
circle(*,7) = [ 0,0,1,0,0,0,0,0,1,0,0]
circle(*,8) = [ 0,0,0,1,0,0,0,1,0,0,0]
circle(*,9) = [ 0,0,0,0,1,1,1,0,0,0,0]
circle(*,10)= [ 0,0,0,0,0,0,0,0,0,0,0]

; get file to open

;give the fixed location change
;2013-1-5
;x_change=255
;y_change=4
;2014
;x_change=261
;y_change=5


;2016-
x_change=257
y_change=2


film_x = fix(1)
film_y = fix(1)

;;; input film

ok=query_tiff(run+".tif",s)
 film_x = s.dimensions(0,0)
 film_y = s.dimensions(1,0)
film_l = s.num_images

print, "film x,y,l : ", film_x,film_y,film_l

frame   = fltarr(film_x,film_y)
ave_arr = fltarr(film_x,film_y)


openr, 2, run + "_ave.tif", ERROR = err
if err eq 0 then begin
    close, 2

    close, 1
    frame = read_tiff(run + "_ave.tif")
endif else begin
    close, 2
    pic_of_avg=film_l   ; pic_of_avg=s.num_images

    frame=read_tiff(run+".tif",image_index=j)
    ave_arr =frame

    for j = 0,  pic_of_avg-1 do begin                       ;尝试给出多种平均帧数
       frame=read_tiff(run+".tif",image_index=j)
       ave_arr =(ave_arr + frame)/2                         ;这样叠加不会溢出
    endfor
    close, 1
    ;ave_arr = ave_arr/float(pic_of_avg)
    frame = fix(ave_arr)

endelse

; subtracts background

temp1 = frame
temp1 = smooth(temp1,2,/EDGE_TRUNCATE)
aves = fltarr(film_x/16,film_y/16)

for i = 8, film_x, 16 do begin
    for j = 8, film_y, 16 do begin
       aves((i-8)/16,(j-8)/16) = min(temp1(i-8:i+7,j-8:j+7))
    endfor
endfor

aves = rebin(aves,film_x,film_y)
pic=string(pic_of_avg)
    ;run=run+pic
WRITE_TIFF, run + "_background.tif", aves, 1, /SHORT
;aves = smooth(aves,30,/EDGE_TRUNCATE)
for i = 0, film_x - 1 do begin
    for j = 0, film_y - 1 do begin
      if temp1(i,j) le aves(i,j)  then temp1(i,j)=0
      if temp1(i,j) gt aves(i,j)  then temp1(i,j)=temp1(i,j)-aves(i,j)
    endfor
endfor
;WRITE_TIFF, run + "_ave1.tif", temp1, 1, /SHORT

temp2=temp1
; window, 1, xsize=84, ysize=84, xpos = 720, ypos = 580
window,1
tv, temp2
WRITE_TIFF, run + "_ave.tif", temp2, 1, /SHORT
; find the peaks

temp3 = temp2
;temp4 = temp3


good = intarr(2,10000)
back = intarr(2,10000)
foob = intarr(5,5)
;blow = bytarr(84,84)

no_good = 0
no_bogo = 0
leftmean=mean(temp2(50:230,100:400))
rightmean=mean(temp2(270:400,100:400))
;WRITE_TIFF, run + "_temp2.tif", temp2, 1,/SHORT
for i = 10, film_x - 11 do begin
	if i eq 246 then i = 266	; skip region where channels overlap
	for j = 10, film_y - 11 do begin
		if temp2(i,j) gt 0 then begin

			; find the nearest maxima

			foob = temp2(i-2:i+2,j-2:j+2)
			z = max(foob,foo)
			y = foo / 5 - 2
			x = foo mod 5 - 2
       		quality = 0
         if x eq 0 then begin
          if y eq 0 then begin
              y = y + j
              x = x + i

        ;if median(temp2(x-3:x+3,y-3:y+3)) lt 0.5*median(temp2(x-l:x+l,y-l:y+l)) then begin
         ;  if x lt 256 then begin
          ;    if  float(z) gt 0.5*leftmean then  quality=1
           ;endif
           ;if x gt 255 then begin
            ;  if  float(z) gt 0.5*rightmean then  quality=1
          ; endif
        ;endif

		if median(temp2(x-3:x+3,y-3:y+3)) lt 0.8*median(temp2(x-1:x+1,y-1:y+1)) then quality=1


					if quality eq 1 then begin

						; draw where peak was found on screen

						for k = -5, 5 do begin
							for l = -5, 5 do begin
								if circle(k+5,l+5) gt 0 then begin
									temp3(x+k,y+l) = 500
								endif
							endfor
						endfor

			if x lt 256	then begin		;分两种情况分别对应
 				 xf = x_change+x
                 yf = y_change+y

                for k = -5, 5 do begin
					for l = -5, 5 do begin
						if circle(k+5,l+5) gt 0 then begin
							temp3(xf+k,yf+l) = 500
						endif
					endfor
				endfor


                 good(0,no_good) = x
                 good(1,no_good) = y
                 back(no_good) = aves(x,y)
                 no_good = no_good + 1
                 good(0,no_good) = xf
                 good(1,no_good) = yf
                 back(no_good) = aves(xf,yf)
                 no_good = no_good + 1
			endif
			if x gt 256	then begin
 				 xf = -x_change+x
                 yf = -y_change+y
                 for k = -5, 5 do begin
					for l = -5, 5 do begin
						if circle(k+5,l+5) gt 0 then begin
							temp3(xf+k,yf+l) = 500
						endif
					endfor
				endfor

                 good(0,no_good) = xf
                 good(1,no_good) = yf
                 back(no_good) = aves(xf,yf)
                 no_good = no_good + 1
                 good(0,no_good) = x
                 good(1,no_good) = y
                 back(no_good) = aves(x,y)
                 no_good = no_good + 1
			endif
					endif
			endif
		endif



		endif

	endfor
endfor


WRITE_TIFF, run + "_selected.tif", temp3, 1,/short

print, "there were ", no_good, "good peaks"


openw, 1, run + ".pks"
for i = 0, no_good - 1 do begin
    printf, 1, i+1, good(0,i),good(1,i),back(i)
endfor

close, 1
openw, 1, run + ".txt"
for i = 0, no_good - 1 do begin
    printf, 1, i+1, good(0,i),good(1,i),back(i)
endfor

close, 1



end

pro p_nxgn1_apwn, run

loadct, 5

; generate gaussian peaks

;g_peaks = fltarr(3,3,7,7)

;for k = 0, 2 do begin
 ;   for l = 0, 2 do begin
  ;     offx = 0.5*float(k-1)
   ;    offy = 0.5*float(l-1)
    ;   for i = 0, 6 do begin
     ;    for j = 0, 6 do begin
      ;    dist = 0.4 * ((float(i)-3.0+offx)^2 + (float(j)-3.0+offy)^2)
       ;   g_peaks(k,l,i,j) = exp(-dist)
        ; endfor
      ; endfor
   ; endfor
;endfor
g_peaks = fltarr(3,3,3,3)
for k = 0, 2 do begin
    for l = 0, 2 do begin
       offx = 0.5*float(k-1)
       offy = 0.5*float(l-1)
       for i = 0, 2 do begin
         for j = 0, 2 do begin
          dist = 0.4 * ((float(i)-1.0+offx)^2 + (float(j)-1.0+offy)^2)
          g_peaks(k,l,i,j) = exp(-dist)
         endfor
       endfor
    endfor
endfor

all  = fltarr(11,11)
apeak  = fltarr(1)	; temp storage for analysis
apeak1  = fltarr(3,3)
reformedpoint = fltarr(25)
;newback1 = fltarr(1)
;newback2 = fltarr(1)
;newback3 = fltarr(1)
;newback4 = fltarr(1)
;newback = fltarr(1,1)


; initialize variables

film_x = fix(1)
film_y = fix(1)
fr_no  = fix(1)

close, 1				; make sure unit 1 is closed
close, 2

info1 = file_info( run + ".tif" )
info2 = file_info( run + ".pks" )

if ( info1.READ ne 1 ) then begin
	print, "Can't read .tif file!"
	return
endif
if ( info2.READ ne 1 ) then begin
	print, "Can't read .pks file!"
	return
endif

openr, 1, run + ".tif"
openr, 2, run + ".pks"

; figure out size + allocate appropriately
ok=query_tiff(run+".tif",s)
 film_x = s.dimensions(0,0)
 film_y = s.dimensions(1,0)
film_l = s.num_images
;film_l = 9000;
;film_l = long64(long64(result.SIZE-4)/(long64(film_x)*long64(film_y)))

print, "film l : ",film_l

frame = intarr(film_x,film_y)

; load the locations of the peaks

foo = fix(0)
x = float(0)
y = float(0)
b=float(0)
r=float(0)
;b = fltarr(film_l)
no_good = 0
good = fltarr(2,10000)
;back = fltarr(10000,film_l)
back = fltarr(10000)

while EOF(2) ne 1 do begin
	readf, 2, foo, x, y, b
	good(0,no_good) = x
	good(1,no_good) = y
	back(no_good) = b
	no_good = no_good + 1
endwhile

flgd = intarr(2,10000)
flgd(0,*) = floor(good(0,*))
flgd(1,*) = floor(good(1,*))

print, no_good, " peaks were found in file"


time_tr = intarr(no_good,film_l)
choosen_time_tr_1= intarr(no_good/2,film_l)
choosen_time_tr_2= intarr(no_good/2,film_l)
choosen_j=intarr(no_good/2)
choosen_x=intarr(no_good)
choosen_y=intarr(no_good)
;denoised_time_tr=intarr(no_good,film_l)
denoised_time_tr_1=intarr(film_l)
denoised_time_tr_2=intarr(film_l)
before_time_tr_1=intarr(film_l)
before_time_tr_2=intarr(film_l)
noise_tr = fltarr(no_good,film_l)
whc_gpk = intarr(no_good,2)
maxpixel = intarr(1)
maxpixel = 0
; calculate which peak to use for each time trace based on
; peak position

for i = 1, no_good - 1 do begin
	whc_gpk(i,0) = round(2.0 * (good(0,i) - flgd(0,i)))
	whc_gpk(i,1) = round(2.0 * (good(1,i) - flgd(1,i)))
endfor

; load the average image

ave_frame = read_tiff(run + "_ave.tif")

; now read values at peak locations into time_tr array

for i = 0, film_l - 1 do begin
	if (i mod 10) eq 0 then print, "working on : ", i, film_l
	frame=read_tiff(run+".tif",image_index=i)
	for j = 0, no_good - 1 do begin

	    ;all = float(frame(flgd(0,j)-5:flgd(0,j)+5,flgd(1,j)-5:flgd(1,j)+5))
	    ;apeak1 = float(frame(flgd(0,j)-2:flgd(0,j)+2,flgd(1,j)-2:flgd(1,j)+2))
	    ;newback = (total(all) - total(apeak1))/96  ; 121-25=96
	    ;newback1 = MEDIAN(frame(flgd(0,j)-5:flgd(0,j)-3,flgd(1,j)-5:flgd(1,j)+2), /EVEN)
	    ;newback2 = MEDIAN(frame(flgd(0,j)-2:flgd(0,j)+5,flgd(1,j)-5:flgd(1,j)-3), /EVEN)
	    ;newback3 = MEDIAN(frame(flgd(0,j)+3:flgd(0,j)+5,flgd(1,j)-2:flgd(1,j)+5), /EVEN)
	    ;newback4 = MEDIAN(frame(flgd(0,j)-5:flgd(0,j)+2,flgd(1,j)+3:flgd(1,j)+5), /EVEN)
        ;newback1 = min(frame(flgd(0,j)-5:flgd(0,j)-3,flgd(1,j)-5:flgd(1,j)+2))
	    ; newback2 = min(frame(flgd(0,j)-2:flgd(0,j)+5,flgd(1,j)-5:flgd(1,j)-3))
	    ; newback3 = min(frame(flgd(0,j)+3:flgd(0,j)+5,flgd(1,j)-2:flgd(1,j)+5))
	    ; newback4 = min(frame(flgd(0,j)-5:flgd(0,j)+2,flgd(1,j)+3:flgd(1,j)+5))
	    ;newback = float(newback1+newback2+newback3+newback4)/4
	   	;newback = rebin(newback,7,7)
	    ;frame(flgd(0,j)-4:flgd(0,j)+4,flgd(1,j)-4:flgd(1,j)+4)=frame(flgd(0,j)-4:flgd(0,j)+4,flgd(1,j)-4:flgd(1,j)+4)-newback
	   	;apeak = total(float(frame(flgd(0,j)-2:flgd(0,j)+2,flgd(1,j)-2:flgd(1,j)+2)-median(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3))))
;apeak = g_peaks(whc_gpk(j,0),whc_gpk(j,1),*,*) * float(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3)-min(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3)))
	    ;range=2;
	    ;maxpixel=0;
	    ;range_square=(2*range+1)*(2*range+1);
        ;reformedpoint=reform(frame(flgd(0,j)-range:flgd(0,j)+range,flgd(1,j)-range:flgd(1,j)+range),range_square)
        ;for m=1,3 do begin
        ;maxpixel=max(reformedpoint,maxnum)
        ;x=flgd(0,j)+maxnum mod (2*range+1)-range
        ;y=flgd(1,j)+maxnum/(2*range+1)-range
       ; y = foo / 7 - 3
        ; x = foo mod 7 - 3
        ;x=flgd(0,j)+(maxnum mod 5)
       ; y=flgd(1,j)+(maxnum/5)
        ;reformedpoint(maxnum)=0;
	    ;endfor
	    ;maxpixel= maxpixel/3
	    ;print,maxnum
	    ;apeak = maxpixel-min(frame(flgd(0,j)-range:flgd(0,j)+range,flgd(1,j)-range:flgd(1,j)+range))
	    ;apeak = min(frame((flgd(0,j)-range):(flgd(0,j)+range),(flgd(1,j)-range):(flgd(1,j)+range)));-newback
        ;apeak = g_peaks(whc_gpk(j,0),whc_gpk(j,1),*,*) * float(x-3:x+3,y-3:y-3)
	    ;apeak = max(frame(flgd(0,j)-2:flgd(0,j)+2,flgd(1,j)-2:flgd(1,j)+2));-min(frame(flgd(0,j)-2:flgd(0,j)+2,flgd(1,j)-2:flgd(1,j)+2));-min(frame(flgd(0,j)-1:flgd(0,j)+1,flgd(1,j)-1:flgd(1,j)+1));-newback
	    ;frame(x-1:x+1,y-1:y+1)= frame(x-1:x+1,y-1:y+1)+make_array(3,3,/float,value=200)
	    ;frame(x-2:x+2,y-2:y+2)=frame(x-2:x+2,y-2:y+2)+make_array(5,5,/float,value=200)
	    ;noise_tr(j,i) = newback

	   ;newback =  make_array(7,7,/float,value=min(float(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3))) )

	   ; apeak = total(g_peaks(whc_gpk(j,0),whc_gpk(j,1),*,*) * float(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3)-back(j)))

     	;apeak = total(float(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3)-newback))/49

     	;2016
        ;apeak = g_peaks(whc_gpk(j,0),whc_gpk(j,1),*,*) * float(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3)-median(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3)) )
        ;new test
        apeak = g_peaks(whc_gpk(j,0),whc_gpk(j,1),*,*) *(frame(flgd(0,j)-1:flgd(0,j)+1,flgd(1,j)-1:flgd(1,j)+1)-median(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3)) )

        ;apeak = g_peaks(whc_gpk(j,0),whc_gpk(j,1),*,*) * float(frame(flgd(0,j)-2:flgd(0,j)+2,flgd(1,j)-2:flgd(1,j)+2)-median(frame(flgd(0,j)-2:flgd(0,j)+2,flgd(1,j)-2:flgd(1,j)+2)) )
        ; apeak = g_peaks(1,1,*,*) * float(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3))

		;apeak = g_peaks(whc_gpk(j,0),whc_gpk(j,1),*,*) * float(frame(flgd(0,j)-3:flgd(0,j)+3,flgd(1,j)-3:flgd(1,j)+3) )
      ;apeak = mean(frame(flgd(0,j)-2:flgd(0,j)+2,flgd(1,j)-2:flgd(1,j)+2))
		time_tr(j,i) = round(total(apeak))
	    ;time_tr(j,i) = round(apeak)

	endfor
;	WRITE_TIFF, run + "_after.tif", frame,/APPEND,/short
endfor

close, 1
close, 2




no_good = no_good
openw, 1, run + ".traces"
writeu, 1, film_l
writeu, 1, no_good
writeu, 1, time_tr
close, 1

;we can add the proces of drawing pics from here
	choosen_num=0
	for j = 0, (no_good-1)/2 do begin
		before_time_tr_1=TRANSPOSE(time_tr(2*j,0:film_l - 1))
		before_time_tr_2=TRANSPOSE(time_tr(2*j+1,0:film_l - 1))
		;denoised_time_tr(2*j,0:film_l - 1)=wv_denoise(time_tr(2*j,0:film_l - 1), 'Daubechies', 2, COEFF=100,DENOISE_STATE=denoise_state)
		;denoised_time_tr(2*j+1,0:film_l - 1)=wv_denoise(time_tr(2*j+1,0:film_l - 1), 'Daubechies', 2, COEFF=100,DENOISE_STATE=denoise_state)
		;这里就不用小波降噪了 直接smooth
		;denoised_time_tr_2=wv_denoise(before_time_tr_2, 'Daubechies',2,COEFF=100,THRESHOLD=1)
		;denoised_time_tr_1=wv_denoise(before_time_tr_1, 'Daubechies',2,COEFF=100,THRESHOLD=1)
		denoised_time_tr_1=smooth(before_time_tr_1,5)
		denoised_time_tr_2=smooth(before_time_tr_2,5)
		;r=correlate(denoised_time_tr(2*j,0:film_l - 1),denoised_time_tr(2*j+1,0:film_l - 1))
		denoised_time_tr_1=TRANSPOSE(denoised_time_tr_1)
		denoised_time_tr_2=TRANSPOSE(denoised_time_tr_2)
			r=correlate(denoised_time_tr_1,denoised_time_tr_2)
			if r lt -0.4 then begin
			;if r lt -0.4 then begin
		;加入去重复的功能 把选中的点的坐标和j存下来 去重之后再保存txt
			choosen_j(choosen_num)=j
			choosen_time_tr_1(choosen_num)= denoised_time_tr_1
			choosen_time_tr_2(choosen_num)= denoised_time_tr_2
			choosen_num=choosen_num+1
			endif
	endfor
	print, "there are : ",choosen_num ,' dots'
			;choosen_num=choosen_num-1;	不明原因地多了1 所以减一下
			;if choosen_num NE 0 then begin
;				for i=0,choosen_num-1 do begin
;					j1=choosen_j(i)
;					print,'i=',i
;					print, 'j1= ',j1
;				endfor
			for i=0,choosen_num-2 do begin
					j1=choosen_j(i)
					;print,'i=',i
					;print, 'j1= ',j1
						sign=0
					;print, 'choosen_num',choosen_num
					if good(0,2*j1) ne 0 and good(1,2*j1) ne 0 then begin
					for k=i+1,choosen_num-1 do begin

								j2=choosen_j(k)
								;print,'k=',k
								;print, 'j2= ',j2
								if good(0,2*j2) ne 0 and good(1,2*j2) ne 0 then begin
											;print,'on',good(0,2*j1),'-',good(1,2*j1),'and',good(0,2*j2),'-',good(1,2*j2)
												if good(0,2*j1) ge good(0,2*j2)-1 and good(0,2*j1) le good(0,2*j2)+1 and good(1,2*j1) ge good(1,2*j2)-1 and good(1,2*j1) le good(1,2*j2)+1  then begin
														;	print,'match',good(0,2*j1),'-',good(1,2*j1),'and',good(0,2*j2),'-',good(1,2*j2)
															sign=1
															if VARIANCE(choosen_time_tr_1(i,0:film_l - 1))	ge 	VARIANCE(choosen_time_tr_1(k,0:film_l - 1)) then j3=j1 	else j3=j2

															if VARIANCE(choosen_time_tr_2(i,0:film_l - 1))	ge 	VARIANCE(choosen_time_tr_2(k,0:film_l - 1)) then j4=j1 	else j4=j2

															str=strcompress('d='+string(good(0,2*j3))+'-'+string(good(1,2*j3))+'a='+string(good(0,2*j4+1))+'-'+string(good(1,2*j4+1)),/remove)
															dotname=run+'\'+  str
															FILE_MKDIR,run

															openw, 1, dotname + ".txt"
																for i_o = 0, film_l - 1 do begin
																   ; printf, 1, i+1, time_tr(2*j,i),time_tr(2*j+1,i),denoised_time_tr(2*j,i),denoised_time_tr(2*j+1,i)
																    printf, 1, i_o+1, time_tr(2*j3,i_o),time_tr(2*j4+1,i_o);,denoised_time_tr_1(i),denoised_time_tr_2(i)
																endfor

															close, 1

															good(0,2*j2)=0
															good(1,2*j2)=0;这里将比对过的点归零 避免重复筛选
												endif
								endif
					endfor
					if sign EQ 0 then begin

											;print,'printing',good(0,2*j1),good(1,2*j1),good(0,2*j1+1),good(1,2*j1+1)
											str=strcompress('d='+string(good(0,2*j1))+'-'+string(good(1,2*j1))+'a='+string(good(0,2*j1+1))+'-'+string(good(1,2*j1+1)),/remove)
											dotname=run+'\'+  str
											FILE_MKDIR,run

											openw, 1, dotname + ".txt"
												for i_o = 0, film_l - 1 do begin
												   ; printf, 1, i+1, time_tr(2*j,i),time_tr(2*j+1,i),denoised_time_tr(2*j,i),denoised_time_tr(2*j+1,i)
												    printf, 1, i_o+1, time_tr(2*j1,i_o),time_tr(2*j1+1,i_o);,denoised_time_tr_1(i),denoised_time_tr_2(i)
												endfor
											close, 1


					endif
					endif
  			endfor
			;endif




end



