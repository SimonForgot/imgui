$INSTALL_DIR="D:\app\imgui"

if (!$args) 
{
    if (Test-Path build) {
    Remove-Item build -Force -Recurse
    }
    cmake -Bbuild -G "Visual Studio 17 2022" -A x64 `
     -DCMAKE_BUILD_TYPE=Release `
     -DCMAKE_VERBOSE_MAKEFILE=OFF `
     -Dglfw3_DIR="D:\app\glfw3\lib\cmake\glfw3" `
     -DCMAKE_INSTALL_PREFIX="$INSTALL_DIR"
}
elseif ($args[0] -eq "c")
{
    cmake --build build -j36 --config Release --clean-first
}
elseif ($args[0] -eq "i")
{
    if (Test-Path "$INSTALL_DIR") {
    Remove-Item "$INSTALL_DIR" -Force -Recurse
    }
    cmake --install build
}
elseif ($args[0] -eq "r")
{
    cmake --build build --target run --config Release
}

#build & install command
#cmake --build build -j36 --target install --config Release

#-G "MinGW Makefiles" ^
#-DCMAKE_MAKE_PROGRAM="D:\Qt\Tools\mingw1120_64\bin\mingw32-make.exe" ^