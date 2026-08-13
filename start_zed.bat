@echo off
REM Launch Zed with the ROCm DLLs on PATH so sd-cli.exe can be run directly
REM from Zed's integrated terminal (hipblas.dll, hipblaslt.dll, ...).
REM Mirrors tests/test_z_image_turbo.bat.

set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set PATH=%ROCM_ROOT%\bin;%PATH%

cd /d F:\AITools\GFX\AI_stable-diffusion.cpp
start "" "C:\Program Files\Zed\Zed.exe" .