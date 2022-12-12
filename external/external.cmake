# all external lib
# zlib, ogg, vorbis, vorbisfile, DXSDK

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# xiph group

option(BUILD_TESTING "close your eyes" OFF)
add_subdirectory(external/libogg)
add_subdirectory(external/libvorbis)
set_target_properties(ogg PROPERTIES
    OUTPUT_NAME "ogg_static"
)
set_target_properties(vorbis PROPERTIES
    OUTPUT_NAME "vorbis_static"
)
set_target_properties(vorbisfile PROPERTIES
    OUTPUT_NAME "vorbisfile_static"
)
set_target_properties(ogg PROPERTIES FOLDER external)
set_target_properties(vorbis PROPERTIES FOLDER external)
set_target_properties(vorbisenc PROPERTIES FOLDER external)
set_target_properties(vorbisfile PROPERTIES FOLDER external)

# zlib
# warning: please keep zlib-ng next to libogg & libvorbis
#          there is a bug here, the behavior of BUILD_SHARED_LIBS is inconsistent

option(ZLIB_COMPAT "Compile with zlib compatible API" ON)
option(ZLIB_ENABLE_TESTS "Build test binaries" OFF)
option(WITH_AVX2 "Build with AVX2" OFF)
option(WITH_AVX512 "Build with AVX512" OFF)
option(WITH_AVX512VNNI "Build with AVX512 VNNI extensions" OFF)
option(WITH_SSSE3 "Build with SSSE3" OFF)
option(WITH_SSE41 "Build with SSE41" OFF)
option(WITH_SSE42 "Build with SSE42" OFF)
option(WITH_PCLMULQDQ "Build with PCLMULQDQ" OFF)
option(WITH_VPCLMULQDQ "Build with VPCLMULQDQ" OFF)
add_subdirectory(external/zlib)
set_target_properties(zlib PROPERTIES
    DEBUG_POSTFIX ""
)
set_target_properties(zlib PROPERTIES FOLDER external)

# d3dx9

add_library(d3dx9 SHARED IMPORTED GLOBAL)
target_include_directories(d3dx9 INTERFACE
    external/dxsdk.d3dx/include
)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(d3dx9 PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/bin/x64/D3DX9_43.dll
        IMPORTED_IMPLIB   ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/lib/x64/d3dx9.lib
    )
else()
    set_target_properties(d3dx9 PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/bin/D3DX9_43.dll
        IMPORTED_IMPLIB   ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/lib/d3dx9.lib
    )
endif()

# d3dcompiler_43

add_library(d3dcompiler_43 SHARED IMPORTED GLOBAL)
target_include_directories(d3dcompiler_43 INTERFACE
    external/dxsdk.d3dx/include
)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(d3dcompiler_43 PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/bin/x64/D3DCompiler_43.dll
        IMPORTED_IMPLIB   ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/lib/x64/d3dx9.lib
    )
else()
    set_target_properties(d3dcompiler_43 PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/bin/D3DCompiler_43.dll
        IMPORTED_IMPLIB   ${CMAKE_SOURCE_DIR}/external/dxsdk.d3dx/lib/d3dx9.lib
    )
endif()

# d3dxof - TODO: should delete it

add_library(d3dxof STATIC IMPORTED GLOBAL)
target_include_directories(d3dxof INTERFACE
    external/dxsdk.d3dx/include
)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(d3dxof PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.legacy/lib/x64/d3dxof.lib
    )
else()
    set_target_properties(d3dxof PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.legacy/lib/d3dxof.lib
    )
endif()

# dxerr - TODO: we should find a replacement

add_library(dxerr STATIC IMPORTED GLOBAL)
target_include_directories(dxerr INTERFACE
    external/dxsdk.legacy/include
)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(dxerr PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.legacy/lib/x64/DxErr.lib
    )
else()
    set_target_properties(dxerr PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk.legacy/lib/DxErr.lib
    )
endif()

# kissfft

option(KISSFFT_PKGCONFIG "Build pkg-config files" OFF)
option(KISSFFT_STATIC "Build kissfft as static (ON) or shared library (OFF)" ON)
option(KISSFFT_TEST "Build kissfft tests" OFF)
option(KISSFFT_TOOLS "Build kissfft command-line tools" OFF)
add_subdirectory(external/kissfft)
set_target_properties(kissfft PROPERTIES FOLDER external)

# imgui

set(imgui_sources
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imstb_rectpack.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imstb_textedit.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imstb_truetype.h
    
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imconfig.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_internal.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_draw.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_tables.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_widgets.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/imgui_demo.cpp

    ${CMAKE_CURRENT_LIST_DIR}/imgui/misc/cpp/imgui_stdlib.cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/misc/cpp/imgui_stdlib.h

    #${CMAKE_CURRENT_LIST_DIR}/imgui/misc/freetype/imgui_freetype.cpp
    #${CMAKE_CURRENT_LIST_DIR}/imgui/misc/freetype/imgui_freetype.h

    ${CMAKE_CURRENT_LIST_DIR}/imgui/misc/single_file/imgui_single_file.h
    
    ${CMAKE_CURRENT_LIST_DIR}/imgui/backends/imgui_impl_win32.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/backends/imgui_impl_win32.cpp

    ${CMAKE_CURRENT_LIST_DIR}/imgui/backends/imgui_impl_dx9.h
    ${CMAKE_CURRENT_LIST_DIR}/imgui/backends/imgui_impl_dx9.cpp
)
source_group(TREE ${CMAKE_CURRENT_LIST_DIR} FILES ${imgui_sources})

add_library(imgui STATIC)
target_compile_definitions(imgui PRIVATE
    _UNICODE
    UNICODE
)
target_compile_definitions(imgui PUBLIC
    IMGUI_DISABLE_OBSOLETE_FUNCTIONS
    IMGUI_DISABLE_OBSOLETE_KEYIO
    IMGUI_USE_BGRA_PACKED_COLOR # Direct3D 9 only support B8G8R8A8 (0xAARRGGBB)
    IMGUI_USE_WCHAR32
)
target_include_directories(imgui PUBLIC
    ${CMAKE_CURRENT_LIST_DIR}/imgui
    ${CMAKE_CURRENT_LIST_DIR}/imgui/misc/cpp
    ${CMAKE_CURRENT_LIST_DIR}/imgui/misc/freetype
    ${CMAKE_CURRENT_LIST_DIR}/imgui/misc/single_file
    ${CMAKE_CURRENT_LIST_DIR}/imgui/backends
)
target_sources(imgui PRIVATE
    ${imgui_sources}
)

# helper

add_library(external_helper STATIC
    external/cmake_empty_helper.h
    external/cmake_empty_helper.cpp
)
target_include_directories(external_helper PUBLIC
    ${CMAKE_BINARY_DIR}/external/
    ${CMAKE_BINARY_DIR}/external/zlib
    external
    external/zlib
)
target_link_libraries(external_helper PUBLIC
    zlib
)

set_target_properties(external_helper PROPERTIES FOLDER external)
