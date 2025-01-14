REM cd ..
del /s /q build
mkdir build
cd build
cmake -G "Visual Studio 16 2019" -A x64 -DSD_VULKAN=ON ..
pause