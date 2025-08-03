@echo off
chcp 65001 >nul
setlocal

echo Zurücksetzen des Hauptrepositories...
git reset --hard

echo.
echo Rekursives Zurücksetzen aller Submodule...
git submodule foreach --recursive "git reset --hard && git clean -fd && echo Zurückgesetzt: $name"

echo.
echo Alle Änderungen wurden rückgängig gemacht.
pause
