@echo off
setlocal

rem --- Pfade anpassen falls nötig ---
set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set ROCM_BIN=%ROCM_ROOT%\bin

rem ROCm-Bin ins PATH
set PATH=%ROCM_BIN%;%PATH%

rem Sauberer Build-Ordner
rmdir /s /q build 2>nul

rem CMake-Konfiguration mit Ninja + Clang + HIP
cmake -B build ^
  -G "Ninja Multi-Config" ^
  -DCMAKE_C_COMPILER="%ROCM_BIN%\clang.exe" ^
  -DCMAKE_CXX_COMPILER="%ROCM_BIN%\clang++.exe" ^
  -DSD_VULKAN=OFF ^
  -DSD_HIPBLAS=ON ^
  -DAMDGPU_TARGETS=gfx1201 ^
  -Dhipblas_DIR="%ROCM_ROOT%\lib\cmake\hipblas" ^
  .

if errorlevel 1 (
  echo CMake-Konfiguration fehlgeschlagen.
  pause
  exit /b 1
)

rem Build im Release-Mode
cmake --build build --config Release

if errorlevel 1 (
  echo Build fehlgeschlagen.
  pause
  exit /b 1
)

echo Fertig. Exes liegen in build\bin\Release\.
echo Hinweis: Zum Ausfuehren ROCm-Bin ins PATH setzen, z.B.:
echo   set "PATH=C:\Program Files\AMD\ROCm\6.4\bin;%%PATH%%"
echo (rocBLAS/hipBLASLt brauchen ihre Data-Verzeichnisse neben der DLL,
echo  daher DLLs nicht einfach zur Exe kopieren.)
pause
endlocal
