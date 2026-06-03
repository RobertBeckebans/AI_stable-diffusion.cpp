set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set PATH=%ROCM_ROOT%\bin;%PATH%
for /f %%i in ('wmic os get LocalDateTime ^| find "."') do set DT=%%i
set TODAY=%DT:~0,8%
set OUTDIR=output/%TODAY%
cd ..
.\bin\sd-cli.exe ^
  --diffusion-model models\diffusion_models\z-image-Q8_0.gguf ^
  --vae models\vae\flux-vae.safetensors ^
  --llm models\text_encoders\Qwen3-4B-Instruct-2507-IQ4_XS.gguf ^
  -p "Latina female with thick wavy hair, harbor boats and pastel houses behind. Breezy seaside light, warm tones, cinematic close-up." ^
  --cfg-scale 5.0 ^
  --steps 40 ^
  --seed 618168558929314 ^
  -v ^
  --offload-to-cpu --diffusion-fa ^
  --vae-tiling --vae-tile-size 64 --vae-tile-overlap 0.5 ^
  -H 1536 -W 1536 ^
  -o %OUTDIR%/zimage_base_latina_harbor.png

pause
