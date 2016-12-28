	REM Set this variable to the absolute or relative path to your SDK's bin directory. The SDK has to support at least Flash 10.1
SET MXMLC_PATH="c:/Programs/Air SDK/flex_sdk_4.6.0_a_3.6/bin/"

REM In order to build only a single version of the game copy the MXML_PATH variable declaration and the whole call of the version
REM you want to build into a separate *.cmd file and run it

REM First are all the release versions then the debug versions

REM Regular Release
%MXMLC_PATH%\mxmlc ^
	-default-size=528,448 ^
	-optimize ^
	-default-background-color=0 ^
	-frame=ContentFrame,game.global.Main ^
	-source-path=".\src" ^
	-source-path+=".\src.framework" ^
	-source-path+=".\src.utils" ^
	-define=CF::isRegular,true ^
	-define+=CF::isHard,false ^
	-output=bin/Kulkis_Regular.swf ^
	-static-link-runtime-shared-libraries=true ^
	src\game\global\preloader\Preloader.as

REM Hard Release
%MXMLC_PATH%\mxmlc ^
	-default-size=528,448 ^
	-optimize ^
	-default-background-color=0 ^
	-frame=ContentFrame,game.global.Main ^
	-source-path=".\src" ^
	-source-path+=".\src.framework" ^
	-source-path+=".\src.utils" ^
	-define=CF::isRegular,false ^
	-define+=CF::isHard,true ^
	-output=bin/Kulkis_Hard.swf ^
	-static-link-runtime-shared-libraries=true ^
	src\game\global\preloader\Preloader.as


	
REM Debug versions


REM Regular Release
%MXMLC_PATH%\mxmlc ^
	-default-size=528,448 ^
	-optimize ^
	-default-background-color=0 ^
	-frame=ContentFrame,game.global.Main ^
	-source-path=".\src" ^
	-source-path+=".\src.framework" ^
	-source-path+=".\src.utils" ^
	-define=CF::isRegular,true ^
	-define+=CF::isHard,false ^
	-output=bin/Kulkis_Regular_DEBUG.swf ^
	-static-link-runtime-shared-libraries=true ^
	-debug=true ^
	src\game\global\preloader\Preloader.as

REM Hard Release
%MXMLC_PATH%\mxmlc ^
	-default-size=528,448 ^
	-optimize ^
	-default-background-color=0 ^
	-frame=ContentFrame,game.global.Main ^
	-source-path=".\src" ^
	-source-path+=".\src.framework" ^
	-source-path+=".\src.utils" ^
	-define=CF::isRegular,false ^
	-define+=CF::isHard,true ^
	-output=bin/Kulkis_Hard_DEBUG.swf ^
	-static-link-runtime-shared-libraries=true ^
	-debug=true ^
	src\game\global\preloader\Preloader.as