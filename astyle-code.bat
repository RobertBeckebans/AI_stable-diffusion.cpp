astyle.exe -v -Q -R --options=astyle-options.ini --exclude="ggml/src/ggml-impl.h" *.h
astyle.exe -v -Q -R --options=astyle-options.ini --exclude="ggml/src/ggml-cpu/ggml-cpu.c" *.c
astyle.exe -v -Q -R --options=astyle-options.ini *.cpp
astyle.exe -v -Q -R --options=astyle-options.ini *.glsl
astyle.exe -v -Q -R --options=astyle-options.ini *.vert
astyle.exe -v -Q -R --options=astyle-options.ini *.frag
astyle.exe -v -Q -R --options=astyle-options.ini *.tesc
astyle.exe -v -Q -R --options=astyle-options.ini *.tese
astyle.exe -v -Q -R --options=astyle-options.ini *.comp
astyle.exe -v -Q -R --options=astyle-options.ini *.hlsl
astyle.exe -v -Q -R --options=astyle-options.ini *.hlsli

pause