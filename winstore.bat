:: Copyright (c) 2016 WangBin. License: MIT

@echo off
set VCDIR=%VS140COMNTOOLS%
if /i %1 == win81 set VCDIR=%VS120COMNTOOLS%
set ARCH=%2
set ARCH2=%ARCH%
set ARG=x86_%ARCH%
if "%ARCH%" == "x86" (
  set ARCH2=
  set ARG=x86
)
if "%ARCH%" == "x64" (
  set ARCH2=amd64
  set ARG=x86_amd64
)
set WIN_VER=8.1
set WIN_PHONE=%3

if /i %1 == win10 (
  set WIN_VER=10
  set ARG=%ARG% store
)
call "%VCDIR%\..\..\VC\vcvarsall.bat" %ARG%

@if "%WIN_VER%" == "8.1" goto SetEnv81
@if "%WIN_VER%" == "10" goto SetEnv10

:SetEnv81
if "%WIN_PHONE%" == "phone" goto SetEnvPhone81
SET LIB=%VSINSTALLDIR%VC\lib\store\%ARCH2%;%WindowsSdkDir%lib\winv6.3\um\%ARCH%;;
SET LIBPATH=%WindowsSdkDir%References\CommonConfiguration\Neutral;%VSINSTALLDIR%VC\lib\%ARCH2%;
SET INCLUDE=%VSINSTALLDIR%VC\include;%WindowsSdkDir%Include\um;%WindowsSdkDir%Include\shared;%WindowsSdkDir%Include\winrt;
goto end

:SetEnvPhone81
SET WindowsPhoneKitDir=%WindowsSdkDir%..\..\Windows Phone Kits\8.1
SET LIB=%VSINSTALLDIR%VC\lib\store\%ARCH2%;%WindowsPhoneKitDir%\lib\%ARCH%;;
SET LIBPATH=%VSINSTALLDIR%VC\lib\%ARCH2%
SET INCLUDE=%VSINSTALLDIR%VC\INCLUDE;%WindowsPhoneKitDir%\Include;%WindowsPhoneKitDir%\Include\abi;%WindowsPhoneKitDir%\Include\mincore;%WindowsPhoneKitDir%\Include\minwin;%WindowsPhoneKitDir%\Include\wrl;
goto end

:SetEnv10
SET LIB=%VSINSTALLDIR%VC\lib\store\%ARCH2%;%UniversalCRTSdkDir%lib\%UCRTVersion%\ucrt\%ARCH%;;%UniversalCRTSdkDir%lib\%UCRTVersion%\um\%ARCH%
SET LIBPATH=%VSINSTALLDIR%VC\lib\%ARCH2%;
SET INCLUDE=%VSINSTALLDIR%VC\include;%UniversalCRTSdkDir%Include\%UCRTVersion%\ucrt;%UniversalCRTSdkDir%Include\%UCRTVersion%\um;%UniversalCRTSdkDir%Include\%UCRTVersion%\shared;%UniversalCRTSdkDir%Include\%UCRTVersion%\winrt
goto end

:end
@echo INCLUDE=%INCLUDE%
@echo LIB=%LIB%
@echo LIBPATH=%LIBPATH%
@echo You can write a user.bat to do additional configurations
@echo -------------------------------------------------------------------------------
@echo -----Build environment is ready: Windows Store %WIN_VER% %WIN_PHONE% %ARCH2%-----

if exist user.bat call user.bat
