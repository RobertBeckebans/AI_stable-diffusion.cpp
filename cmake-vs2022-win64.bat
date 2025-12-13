@echo off
rmdir /s /q build
mkdir build

cmake -B build ^
	-G "Visual Studio 17 2022" -A x64 ^
	-DSD_VULKAN=ON ^
	-SD_HIPBLAS=ON ^
	.

pause