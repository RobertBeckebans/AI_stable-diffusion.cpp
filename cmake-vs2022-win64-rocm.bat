@echo off
rmdir /s /q build
mkdir build

cmake -B build ^
  -G "Visual Studio 17 2022" -A x64 ^
  -DSD_VULKAN=ON ^
  -DSD_HIPBLAS=ON ^
  -DAMDGPU_TARGETS=gfx1201 ^
  -DCMAKE_PREFIX_PATH="C:/Program Files/AMD/ROCm/6.4" ^
  .

pause
