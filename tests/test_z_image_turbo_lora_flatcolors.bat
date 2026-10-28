set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set PATH=%ROCM_ROOT%\bin;%PATH%
for /f %%i in ('wmic os get LocalDateTime ^| find "."') do set DT=%%i
set TODAY=%DT:~0,8%
set OUTDIR=output/%TODAY%
cd ..
.\bin\sd-cli.exe ^
  --diffusion-model models\diffusion_models\z_image_turbo-Q4_K.gguf ^
  --vae models\vae\flux-vae.safetensors ^
  --llm models\text_encoders\Qwen3-4B-Instruct-2507-IQ4_XS.gguf ^
  --lora-model-dir models\loras ^
  -p "1girl, blue eyes, star-shaped pupils, blue hair, side ponytail, long hair, white earrings, upper body, abstract background, water dress, starry sky, from side, leaning forward, closed mouth, light smile, looking up, text 'z image turbo' in the top corner in calligraphy, text 'Flat color - Style' in the bottom corner, absurdres, masterpiece, very aesthetic. It is flat color style <lora:zimage_turbo_flat_color_v2.1:0.2>, no lineart" ^
  --cfg-scale 1.0 ^
  --steps 9 ^
  --seed 618168558929314 ^
  -v ^
  --offload-to-cpu --diffusion-fa ^
  -H 1024 -W 1024 ^
  -o %OUTDIR%/zimage_turbo_1girl_flatcolor.png

pause
