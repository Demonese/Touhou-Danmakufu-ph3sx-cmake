# all external lib
# zlib, ogg, vorbis, vorbisfile, DXSDK

set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# zlib

add_subdirectory(external/zlib)
set_target_properties(zlibstatic PROPERTIES
    DEBUG_POSTFIX ""
)
set_target_properties(example PROPERTIES FOLDER external/zlib)
set_target_properties(minigzip PROPERTIES FOLDER external/zlib)
set_target_properties(zlib PROPERTIES FOLDER external/zlib)
set_target_properties(zlibstatic PROPERTIES FOLDER external/zlib)

# xiph group

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
set_target_properties(test_bitwise PROPERTIES FOLDER external/libogg)
set_target_properties(test_framing PROPERTIES FOLDER external/libogg)
set_target_properties(ogg PROPERTIES FOLDER external/libogg)
set_target_properties(vorbis PROPERTIES FOLDER external/libvorbis)
set_target_properties(vorbisenc PROPERTIES FOLDER external/libvorbis)
set_target_properties(vorbisfile PROPERTIES FOLDER external/libvorbis)
set_target_properties(vorbis_test PROPERTIES FOLDER external/libvorbis)

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

# helper

add_library(external_helper STATIC
    external/cmake_empty_helper.h
    external/cmake_empty_helper.cpp
)
target_include_directories(external_helper PUBLIC
    external
    ${CMAKE_BINARY_DIR}/external
)

set_target_properties(external_helper PROPERTIES FOLDER external)
