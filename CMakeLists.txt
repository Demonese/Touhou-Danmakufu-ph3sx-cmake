cmake_minimum_required(VERSION 3.20)
project("Touhou-Danmakufu-ph3sx")

set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>$<$<CONFIG:Debug>:DLL>")

include(external/external.cmake)

function(dnh_common_project_config target)
    set_target_properties(${target} PROPERTIES
        C_STANDARD 11
        C_STANDARD_REQUIRED ON
        CXX_STANDARD 17
        CXX_STANDARD_REQUIRED ON
    )
    target_compile_options(${target} PUBLIC
        "/MP"
        "/utf-8"
    )
    if(CMAKE_SIZEOF_VOID_P EQUAL 4)
        target_compile_options(${target} PUBLIC
            "/arch:SSE2"
        )
    endif()
endfunction()
function(dnh_common_copy_output_file target dir_name file_name)
    add_custom_command(TARGET ${target} POST_BUILD
        COMMAND cmake -E make_directory ${CMAKE_SOURCE_DIR}/${dir_name}
        COMMAND cmake -E rm -f ${CMAKE_SOURCE_DIR}/${dir_name}/${file_name}
        COMMAND cmake -E copy $<TARGET_FILE:${target}> ${CMAKE_SOURCE_DIR}/${dir_name}/${file_name}
    )
endfunction()

# DnhConfig

include(DnhConfig.cmake)

add_executable(DnhConfig WIN32)
dnh_common_project_config(DnhConfig)
target_compile_definitions(DnhConfig PUBLIC
    DNH_PROJ_CONFIG
)
target_precompile_headers(DnhConfig PUBLIC
    origin/source/GcLib/pch.h
)
target_include_directories(DnhConfig PUBLIC
    origin
    origin/source/GcLib
)
target_sources(DnhConfig PRIVATE
    ${GcLib_source_DnhConfig}
    ${TouhouDanmakufu_source_DnhConfig}
    ${DnhConfig_source}
    origin/gstd.natvis
)
target_link_libraries(DnhConfig PUBLIC
    external_helper
    ogg
    vorbis
    vorbisfile
    dxerr
    legacy_stdio_definitions.lib
    d3dxof
    d3dx9
    d3dcompiler_43
)

dnh_common_copy_output_file(DnhConfig bin_th_dnh config_ph3sx.exe)

# DnhExecutor

include(DnhExecutor.cmake)

add_executable(DnhExecutor WIN32)
dnh_common_project_config(DnhExecutor)
target_compile_definitions(DnhExecutor PUBLIC
    DNH_PROJ_EXECUTOR
)
target_precompile_headers(DnhExecutor PUBLIC
    origin/source/GcLib/pch.h
)
target_include_directories(DnhExecutor PUBLIC
    origin
    origin/source/GcLib
)
target_sources(DnhExecutor PRIVATE
    ${GcLib_source}
    ${TouhouDanmakufu_source}
    ${DnhExecutor_source}
    origin/gstd.natvis
)
target_link_libraries(DnhExecutor PUBLIC
    external_helper
    ogg
    vorbis
    vorbisfile
    kissfft
    dxerr
    legacy_stdio_definitions.lib
    d3dxof
    d3dx9
    d3dcompiler_43
)

dnh_common_copy_output_file(DnhExecutor bin_th_dnh th_dnh_ph3sx.exe)

add_custom_command(TARGET DnhExecutor POST_BUILD
    COMMAND cmake -E make_directory ${CMAKE_SOURCE_DIR}/bin_th_dnh
    COMMAND cmake -E copy ${CMAKE_SOURCE_DIR}/origin/bin_th_dnh/license.txt ${CMAKE_SOURCE_DIR}/bin_th_dnh
    COMMAND cmake -E copy ${CMAKE_SOURCE_DIR}/origin/bin_th_dnh/readme.txt ${CMAKE_SOURCE_DIR}/bin_th_dnh
)

# FileArchiver

include(FileArchiver.cmake)

add_executable(FileArchiver WIN32)
dnh_common_project_config(FileArchiver)
target_compile_definitions(FileArchiver PUBLIC
    DNH_PROJ_FILEARCHIVER
)
target_precompile_headers(FileArchiver PUBLIC
    origin/source/GcLib/pch.h
)
target_include_directories(FileArchiver PUBLIC
    origin
    origin/source/GcLib
)
target_sources(FileArchiver PRIVATE
    ${GcLib_source_FileArchiver}
    ${FileArchiver_source}
    origin/gstd.natvis
)
target_link_libraries(FileArchiver PUBLIC
    external_helper
    ogg
    vorbis
    vorbisfile
    dxerr
    legacy_stdio_definitions.lib
    d3dxof
    d3dx9
    d3dcompiler_43
)

dnh_common_copy_output_file(FileArchiver bin_ext FileArchiver.exe)

add_custom_command(TARGET FileArchiver POST_BUILD
    COMMAND cmake -E make_directory ${CMAKE_SOURCE_DIR}/bin_ext
    COMMAND cmake -E copy ${CMAKE_SOURCE_DIR}/origin/bin_ext/FileArchiver_readme.txt ${CMAKE_SOURCE_DIR}/bin_ext
)
