@echo off

echo Delete all obj files
cd obj
del /Q *.obj
cd ..

echo Add BCC101 to path
setlocal
set PATH=e:\Borland\BCC101\Bin;%PATH%

:echo Compiling with O2 = optimized for speed [O1 = optimized for size]
: a8 align on 8 bytes, default for bcc 55 is 4 but nowadays 8 is standard
: -u- no underscores
: -RT- no runtime type info
: delphizlib uses also flags (probably for newer BCC) -Ve -X -pr -b -d -k -vi -tWM
: Check to see if we should add some of those...

:BCC 101 clang version doesn't use -6 -u -OS

:zlib
echo Compiling zlib...
cd zlib
:del zlib_errors.txt
bcc32c -a8 -RT- -d- -O2 -c -n..\obj\ *.c >..\zlib_errors.txt 2>&1
:echo Errorlevel = %errorlevel%
if errorlevel 1 goto zliberror
cd ..

:libjpeg
echo Compiling LibJpeg...
:del libjpeg_errors.txt
cd libjpeg
bcc32c -a8 -RT- -d- -O2 -c -n..\obj\ jutils.c jcapimin.c jcapistd.c jccoefct.c jccolor.c jcdctmgr.c jchuff.c jcinit.c jcmainct.c jcmarker.c jcmaster.c jcomapi.c jcparam.c jcphuff.c jcprepct.c jcsample.c jctrans.c jdapimin.c jdapistd.c jdatadst.c jdatasrc.c jdcoefct.c jdcolor.c jddctmgr.c jdhuff.c jdinput.c jdmainct.c jdmarker.c jdmaster.c jdmerge.c jdphuff.c jdpostct.c jdsample.c jdtrans.c jerror.c jfdctflt.c jfdctfst.c jfdctint.c jidctflt.c jidctfst.c jidctint.c jidctred.c jmemmgr.c jmemnobs.c jquant1.c jquant2.c >..\libjpeg_errors.txt 2>&1
:echo Errorlevel = %errorlevel%
if errorlevel 1 goto libjpegerror
cd ..

:libtiff
echo Compiling LibTiff 4...
:del libtiff_errors.txt
cd libtiff4
bcc32c -a8 -RT- -d- -O2 -c -I..\zlib;..\libjpeg -n..\obj\libtiff4 tif_aux.c tif_close.c tif_codec.c tif_color.c tif_compress.c tif_dir.c tif_dirinfo.c tif_dirread.c tif_dirwrite.c tif_dumpmode.c tif_error.c tif_extension.c tif_fax3.c tif_fax3sm.c tif_flush.c tif_getimage.c tif_jpeg.c tif_luv.c tif_lzw.c tif_next.c tif_ojpeg.c tif_open.c tif_packbits.c tif_pixarlog.c tif_predict.c tif_print.c tif_read.c tif_strip.c tif_swab.c tif_thunder.c tif_tile.c tif_version.c tif_warning.c tif_write.c tif_zip.c >..\libtiff_errors.txt 2>&1
:echo Errorlevel = %errorlevel%
if errorlevel 1 goto libtifferror
cd ..

:no errors: then copy obj files to destination
:echo Copying obj files...

: Auto copying of the obj files disabled since we don't want to overwrite
: in case we didn't have our patches applied!

:copy obj\libtiff4\*.obj ..\obj\libtiff4
:copy obj\*.obj ..\obj

echo Done.
pause
del /Q *_errors.txt
goto end2

:zliberror
cd ..
echo There was an error compiling zlib

goto end

:libjpegerror
cd ..
echo There was an error compiling LibJpeg

goto end

:libtifferror
cd ..
echo There was an error compiling LibTiff

goto end

:end
pause

:end2
