# Touhou Danmakufu ph3sx cmake

## What's this

This is a CMake build system project (unofficial) of [Touhou Danmakufu ph3sx](https://github.com/Natashi/Touhou-Danmakufu-ph3sx-2).

## How to build

1. clone repository
```batch
git clone --recursive https://github.com/Demonese/Touhou-Danmakufu-ph3sx-cmake.git
```
2. using CMake to generate project files (VS2022)
```batch
cd Touhou-Danmakufu-ph3sx-cmake
mkdir build
cd build
cmake .. -G "Visual Studio 17 2022" -A Win32
cd ..
```
2. or using CMake to generate project files (VS2019)
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
