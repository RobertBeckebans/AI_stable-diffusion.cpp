set ROCM_ROOT=C:\Program Files\AMD\ROCm\6.4
set PATH=%ROCM_ROOT%\bin;%PATH%
cd ..
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
  -o output/flux_kontext.png
  
pause