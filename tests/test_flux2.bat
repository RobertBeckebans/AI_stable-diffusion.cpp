set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set PATH=%ROCM_ROOT%\bin;%PATH%
for /f %%i in ('wmic os get LocalDateTime ^| find "."') do set DT=%%i
set TODAY=%DT:~0,8%
set OUTDIR=output/%TODAY%
cd ..
.\bin\sd-cli.exe ^
  --diffusion-model models\diffusion_models\flux2-dev-Q4_K_S.gguf ^
  --vae models\vae\flux2-vae.safetensors ^
  --llm models\text_encoders\Mistral-Small-3.2-24B-Instruct-2506-IQ4_XS.gguf ^
  -p "high fashion, vintage couture, street photography, luxury fashion shoot, neo brutalist architecture, pastel paints" ^
  --cfg-scale 1.0 ^
  --steps 20 ^
  --seed 368376176406613 ^
  -v ^
  --offload-to-cpu --diffusion-fa --clip-on-cpu ^
  -H 1024 -W 1024 ^
  --vae-tiling --vae-tile-size 32 --vae-tile-overlap 0.5 ^
  -o %OUTDIR%/fashion_brutalist_flux2.png

pause
