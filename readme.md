# Touhou Danmakufu ph3sx cmake

## What's this

This is a CMake build system project (unofficial) of [Touhou Danmakufu ph3sx](https://github.com/Natashi/Touhou-Danmakufu-ph3sx-2).

## How to build

1. clone repository
```batch
git clone --recursive https://github.com/Demonese/Touhou-Danmakufu-ph3sx-cmake.git
```
2. using CMake to generate project files 用CMake生成项目文件
```batch
cd Touhou-Danmakufu-ph3sx-cmake
mkdir build
cd build
cmake .. -G "Visual Studio 16 2019" -A Win32
cd ..
```
3. compile
```batch
cmake --build build --config Release
```
