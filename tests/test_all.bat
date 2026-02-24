set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set PATH=%ROCM_ROOT%\bin;%PATH%
for /f %%i in ('wmic os get LocalDateTime ^| find "."') do set DT=%%i
set TODAY=%DT:~0,8%
set OUTDIR=output/%TODAY%
cd ..

:: Z Image Turbo
.\bin\sd-cli.exe ^
  --diffusion-model models\diffusion_models\z_image_turbo-Q4_K.gguf ^
  --vae models\vae\flux-vae.safetensors ^
  --llm models\text_encoders\Qwen3-4B-Instruct-2507-IQ4_XS.gguf ^
  -p "Latina female with thick wavy hair, harbor boats and pastel houses behind. Breezy seaside light, warm tones, cinematic close-up." ^
  --cfg-scale 1.0 ^
  --steps 9 ^
  --seed 618168558929314 ^
  -v ^
  --offload-to-cpu --diffusion-fa ^
  -H 1024 -W 1024 ^
  --vae-tiling --vae-tile-size 32 --vae-tile-overlap 0.5 ^
  -o %OUTDIR%/zimage_turbo_latina_harbor.png

:: Z Image Turbo + Upscaled
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
  -o %OUTDIR%/zimage_turbo_latina_harbor_upscaled.png

:: Flux Kontext
.\bin\sd-cli.exe ^
  --diffusion-model models\diffusion_models\flux1-kontext-dev-Q4_K_M.gguf ^
  --clip_l models\text_encoders\flux-clip_l.safetensors ^
  --t5xxl models\text_encoders\flux-t5xxl_fp8_e4m3fn.safetensors ^
  --vae models\vae\flux-vae.safetensors ^
  -p "change 'flux.cpp' to 'kontext.cpp' and change the cat to a dog" ^
  --cfg-scale 1.0 ^
  -v ^
  --clip-on-cpu ^
  -r input/flux1-dev-q8_0.png ^
  -o %OUTDIR%/flux_kontext_edit.png

:: Flux 2
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
  -o %OUTDIR%/flux2_fashion_brutalist.png

:: Flux 2 - Quake 3 base_wall edit
.\bin\sd-cli.exe ^
  --diffusion-model models\diffusion_models\flux2-dev-Q4_K_S.gguf ^
  --vae models\vae\flux2-vae.safetensors ^
  --llm models\text_encoders\Mistral-Small-3.2-24B-Instruct-2506-IQ4_XS.gguf ^
  -p "Transform this existing wall texture into a seamless biomechanical gothic horror fusion in HR Giger style mixed with Quake 3 Arena 1999 aesthetic, keep the original structure and layout of pipes, vents, seams and panels, but fuse them with glossy black chitin resin, chrome rivets melting into organic sinew and tendrils, ribbed exoskeletal details embedded with alien veins, subtle bioluminescent sickly green and purple glows on edges, rusty iron trims with cracked stone and gothic carvings, low-saturation dark palette with hints of red bronze and deep shadows, flat 2D diffuse tiling texture, no lighting no perspective, highly detailed dark sci-fi horror game style" ^
  -n "people, text, signature, watermark, bright colors, cartoon, realistic photo, smooth plastic, clean metal, cute, blurry, visible seams" ^
  --cfg-scale 0.7 ^
  -v ^
  -H 512 -W 512 ^
  --offload-to-cpu --diffusion-fa --clip-on-cpu ^
  -r input/base_wall/archpipe2_ifin.png ^
  -o %OUTDIR%/flux2_edit_q3_base_wall_archpipe2_ifin.png


pause
