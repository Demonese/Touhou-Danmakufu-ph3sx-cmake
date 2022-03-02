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

set(ZLIB_COMPAT ON)
set(ZLIB_ENABLE_TESTS OFF)
add_subdirectory(external/zlib)
set_target_properties(zlib PROPERTIES
    DEBUG_POSTFIX ""
)
set_target_properties(zlib PROPERTIES FOLDER external)

# DXSDK

add_library(d3dx9 STATIC IMPORTED GLOBAL)
target_include_directories(d3dx9 INTERFACE
    external/dxsdk/include
)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(d3dx9 PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk/lib/x64/d3dx9.lib
    )
else()
    set_target_properties(d3dx9 PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk/lib/d3dx9.lib
    )
endif()

add_library(d3dxof STATIC IMPORTED GLOBAL)
target_include_directories(d3dxof INTERFACE
    external/dxsdk/include
)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(d3dxof PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk/lib/x64/d3dxof.lib
    )
else()
    set_target_properties(d3dxof PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk/lib/d3dxof.lib
    )
endif()

add_library(dxerr STATIC IMPORTED GLOBAL)
target_include_directories(dxerr INTERFACE
    external/dxsdk/include
)
if(CMAKE_SIZEOF_VOID_P EQUAL 8)
    set_target_properties(dxerr PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk/lib/x64/DxErr.lib
    )
else()
    set_target_properties(dxerr PROPERTIES
        IMPORTED_LOCATION ${CMAKE_SOURCE_DIR}/external/dxsdk/lib/DxErr.lib
    )
endif()

# kissfft

option(KISSFFT_PKGCONFIG "Build pkg-config files" OFF)
option(KISSFFT_STATIC "Build kissfft as static (ON) or shared library (OFF)" ON)
option(KISSFFT_TEST "Build kissfft tests" OFF)
option(KISSFFT_TOOLS "Build kissfft command-line tools" OFF)
add_subdirectory(external/kissfft)
set_target_properties(kissfft PROPERTIES FOLDER external)

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
