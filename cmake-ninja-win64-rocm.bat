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

rem ROCm-Runtime-DLLs neben die gebauten Exes kopieren (sonst Exit 0xC0000135 / DLL not found).
rem Die Exes liegen bei "Ninja Multi-Config" unter build\bin\Release\.
set EXE_OUT=build\bin\Release
set ROCM_DLLS=amdhip64_6.dll hipblas.dll amd_comgr_2.dll rocblas.dll hipblaslt.dll
for %%D in (%ROCM_DLLS%) do (
  if exist "%ROCM_BIN%\%%D" (
    copy /Y "%ROCM_BIN%\%%D" "%EXE_OUT%\%%D" >nul
    echo Kopiert: %%D
  ) else (
    echo WARNUNG: %%D nicht gefunden in %ROCM_BIN%
  )
)

echo Fertig. Exes liegen in %EXE_OUT%\. 
pause
endlocal
