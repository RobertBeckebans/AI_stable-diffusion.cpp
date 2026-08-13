#!/usr/bin/env bash
# Make sd-cli.exe find the ROCm DLLs (hipblas.dll, hipblaslt.dll, ...) from
# Git Bash (MINGW64). Mirrors tests/test_z_image_turbo.bat's PATH setup.
#
# Two ways to use:
#
#   1. Source it to extend the PATH in the CURRENT shell:
#        source ./setup_rocm.sh
#        ./bin/sd-cli.exe --help
#
#   2. Execute it to drop into a NEW bash with the extended PATH:
#        ./setup_rocm.sh
#        ./bin/sd-cli.exe --help
#        exit            # leave the spawned shell

ROCM_ROOT="${ROCM_ROOT:-/c/Program Files/AMD/ROCm/6.4}"

# Prepend only once so re-sourcing stays clean.
case ":$PATH:" in
  *":$ROCM_ROOT/bin:"*) ;;
  *) export PATH="$ROCM_ROOT/bin:$PATH" ;;
esac

echo "ROCm on PATH: $ROCM_ROOT/bin"

# When executed directly (not sourced), spawn a sub-shell that inherits the
# extended PATH. A child process cannot modify the parent's PATH, so this is
# the only way `./setup_rocm.sh` (without `source`) can be useful.
if [ "${BASH_SOURCE[0]}" = "${0}" ]; then
  echo "Spawning a new bash with the extended PATH. Type 'exit' to leave."
  exec bash
fi