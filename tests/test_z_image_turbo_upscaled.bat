set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set PATH=%ROCM_ROOT%\bin;%PATH%
cd ..
.\bin\sd-cli.exe ^
  --diffusion-model models\diffusion_models\z_image_turbo-Q4_K.gguf ^
  --vae models\vae\flux-vae.safetensors ^
  --llm models\text_encoders\Qwen3-4B-Instruct-2507-IQ4_XS.gguf ^
  --upscale-model models\upscalers\RealESRGAN_x4plus_anime_6B.pth ^
  -p "Latina female with thick wavy hair, harbor boats and pastel houses behind. Breezy seaside light, warm tones, cinematic close-up." ^
  --cfg-scale 1.0 ^
  --steps 9 ^
  --seed 618168558929314 ^
  -v ^
  --offload-to-cpu --diffusion-fa ^
  -H 1024 -W 1024 ^
  --vae-tiling --vae-tile-size 32 --vae-tile-overlap 0.5 ^
  -o output/latina_harbor_upscaled.png
  
pause
