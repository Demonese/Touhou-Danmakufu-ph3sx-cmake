cmake_minimum_required(VERSION 3.20)
project("Touhou-Danmakufu-ph3sx")

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

set(GcLib_source_DnhConfig
    origin/source/GcLib/pch.cpp
    origin/source/GcLib/pch.h
    origin/source/GcLib/GcLib.hpp
    # gstd
    origin/source/GcLib/gstd/Application.cpp
    origin/source/GcLib/gstd/Application.hpp
    origin/source/GcLib/gstd/File.cpp
    origin/source/GcLib/gstd/File.hpp
    origin/source/GcLib/gstd/GstdLib.hpp
    origin/source/GcLib/gstd/GstdUtility.cpp
    origin/source/GcLib/gstd/GstdUtility.hpp
    origin/source/GcLib/gstd/Logger.cpp
    origin/source/GcLib/gstd/Logger.hpp
    origin/source/GcLib/gstd/SmartPointer.hpp
    origin/source/GcLib/gstd/Thread.cpp
    origin/source/GcLib/gstd/Thread.hpp
    origin/source/GcLib/gstd/Window.cpp
    origin/source/GcLib/gstd/Window.hpp
    # DirectX
    origin/source/GcLib/directx/DirectGraphics.cpp
    origin/source/GcLib/directx/DirectGraphics.hpp
    origin/source/GcLib/directx/DirectInput.cpp
    origin/source/GcLib/directx/DirectInput.hpp
    origin/source/GcLib/directx/DxConstant.hpp
    origin/source/GcLib/directx/DxLib.hpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${GcLib_source_DnhConfig})

set(TouhouDanmakufu_source_DnhConfig
    origin/source/TouhouDanmakufu/Common/DnhCommon.cpp
    origin/source/TouhouDanmakufu/Common/DnhCommon.hpp
    origin/source/TouhouDanmakufu/Common/DnhConstant.hpp
    origin/source/TouhouDanmakufu/Common/DnhGcLibImpl.cpp
    origin/source/TouhouDanmakufu/Common/DnhGcLibImpl.hpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${TouhouDanmakufu_source_DnhConfig})

set(DnhConfig_source
    origin/source/TouhouDanmakufu/DnhConfig/Common.cpp
    origin/source/TouhouDanmakufu/DnhConfig/Common.hpp
    origin/source/TouhouDanmakufu/DnhConfig/Constant.hpp
    origin/source/TouhouDanmakufu/DnhConfig/DnhConfig.rc
    origin/source/TouhouDanmakufu/DnhConfig/GcLibImpl.cpp
    origin/source/TouhouDanmakufu/DnhConfig/GcLibImpl.hpp
    origin/source/TouhouDanmakufu/DnhConfig/MainWindow.cpp
    origin/source/TouhouDanmakufu/DnhConfig/MainWindow.hpp
    origin/source/TouhouDanmakufu/DnhConfig/resource.h
    origin/source/TouhouDanmakufu/DnhConfig/WinMain.cpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${DnhConfig_source})

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
)

dnh_common_copy_output_file(DnhConfig bin_th_dnh config_ph3sx.exe)

# DnhExecutor

set(GcLib_source
    origin/source/GcLib/pch.cpp
    origin/source/GcLib/pch.h
    origin/source/GcLib/GcLib.hpp
    # gstd
    origin/source/GcLib/gstd/Application.cpp
    origin/source/GcLib/gstd/Application.hpp
    origin/source/GcLib/gstd/ArchiveEncryption.hpp
    origin/source/GcLib/gstd/ArchiveFile.cpp
    origin/source/GcLib/gstd/ArchiveFile.hpp
    origin/source/GcLib/gstd/File.cpp
    origin/source/GcLib/gstd/File.hpp
    origin/source/GcLib/gstd/FpsController.cpp
    origin/source/GcLib/gstd/FpsController.hpp
    origin/source/GcLib/gstd/GstdLib.hpp
    origin/source/GcLib/gstd/GstdUtility.cpp
    origin/source/GcLib/gstd/GstdUtility.hpp
    origin/source/GcLib/gstd/Logger.cpp
    origin/source/GcLib/gstd/Logger.hpp
    origin/source/GcLib/gstd/RandProvider.cpp
    origin/source/GcLib/gstd/RandProvider.hpp
    origin/source/GcLib/gstd/ScriptClient.cpp
    origin/source/GcLib/gstd/ScriptClient.hpp
    origin/source/GcLib/gstd/SmartPointer.hpp
    origin/source/GcLib/gstd/Task.cpp
    origin/source/GcLib/gstd/Task.hpp
    origin/source/GcLib/gstd/Thread.cpp
    origin/source/GcLib/gstd/Thread.hpp
    origin/source/GcLib/gstd/VectorExtension.hpp
    origin/source/GcLib/gstd/Window.cpp
    origin/source/GcLib/gstd/Window.hpp
    # gstd - script
    origin/source/GcLib/gstd/Script/Parser.cpp
    origin/source/GcLib/gstd/Script/Parser.hpp
    origin/source/GcLib/gstd/Script/Script.cpp
    origin/source/GcLib/gstd/Script/Script.hpp
    origin/source/GcLib/gstd/Script/ScriptFunction.cpp
    origin/source/GcLib/gstd/Script/ScriptFunction.hpp
    origin/source/GcLib/gstd/Script/ScriptLexer.cpp
    origin/source/GcLib/gstd/Script/ScriptLexer.hpp
    origin/source/GcLib/gstd/Script/Value.cpp
    origin/source/GcLib/gstd/Script/Value.hpp
    origin/source/GcLib/gstd/Script/ValueVector.cpp
    origin/source/GcLib/gstd/Script/ValueVector.hpp
    # DirectX
    origin/source/GcLib/directx/DirectGraphics.cpp
    origin/source/GcLib/directx/DirectGraphics.hpp
    origin/source/GcLib/directx/DirectInput.cpp
    origin/source/GcLib/directx/DirectInput.hpp
    origin/source/GcLib/directx/DirectSound.cpp
    origin/source/GcLib/directx/DirectSound.hpp
    origin/source/GcLib/directx/DxConstant.hpp
    origin/source/GcLib/directx/DxLib.hpp
    origin/source/GcLib/directx/DxObject.cpp
    origin/source/GcLib/directx/DxObject.hpp
    origin/source/GcLib/directx/DxScript.cpp
    origin/source/GcLib/directx/DxScript.hpp
    origin/source/GcLib/directx/DxText.cpp
    origin/source/GcLib/directx/DxText.hpp
    origin/source/GcLib/directx/DxTypes.hpp
    origin/source/GcLib/directx/DxUtility.cpp
    origin/source/GcLib/directx/DxUtility.hpp
    origin/source/GcLib/directx/DxUtilityIntersection.cpp
    origin/source/GcLib/directx/DxWindow.cpp
    origin/source/GcLib/directx/DxWindow.hpp
    origin/source/GcLib/directx/HLSL.cpp
    origin/source/GcLib/directx/HLSL.hpp
    origin/source/GcLib/directx/MetasequoiaMesh.cpp
    origin/source/GcLib/directx/MetasequoiaMesh.hpp
    origin/source/GcLib/directx/RenderObject.cpp
    origin/source/GcLib/directx/RenderObject.hpp
    origin/source/GcLib/directx/ScriptManager.cpp
    origin/source/GcLib/directx/ScriptManager.hpp
    origin/source/GcLib/directx/Shader.cpp
    origin/source/GcLib/directx/Shader.hpp
    origin/source/GcLib/directx/Texture.cpp
    origin/source/GcLib/directx/Texture.hpp
    origin/source/GcLib/directx/TransitionEffect.cpp
    origin/source/GcLib/directx/TransitionEffect.hpp
    origin/source/GcLib/directx/Vertex.hpp
    origin/source/GcLib/directx/VertexBuffer.cpp
    origin/source/GcLib/directx/VertexBuffer.hpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${GcLib_source})

set(TouhouDanmakufu_source
    origin/source/TouhouDanmakufu/Common/DnhCommon.cpp
    origin/source/TouhouDanmakufu/Common/DnhCommon.hpp
    origin/source/TouhouDanmakufu/Common/DnhConstant.hpp
    origin/source/TouhouDanmakufu/Common/DnhGcLibImpl.cpp
    origin/source/TouhouDanmakufu/Common/DnhGcLibImpl.hpp
    origin/source/TouhouDanmakufu/Common/DnhReplay.cpp
    origin/source/TouhouDanmakufu/Common/DnhReplay.hpp
    origin/source/TouhouDanmakufu/Common/DnhScript.cpp
    origin/source/TouhouDanmakufu/Common/DnhScript.hpp
    origin/source/TouhouDanmakufu/Common/StgCommon.cpp
    origin/source/TouhouDanmakufu/Common/StgCommon.hpp
    origin/source/TouhouDanmakufu/Common/StgControlScript.cpp
    origin/source/TouhouDanmakufu/Common/StgControlScript.hpp
    origin/source/TouhouDanmakufu/Common/StgEnemy.cpp
    origin/source/TouhouDanmakufu/Common/StgEnemy.hpp
    origin/source/TouhouDanmakufu/Common/StgIntersection.cpp
    origin/source/TouhouDanmakufu/Common/StgIntersection.hpp
    origin/source/TouhouDanmakufu/Common/StgItem.cpp
    origin/source/TouhouDanmakufu/Common/StgItem.hpp
    origin/source/TouhouDanmakufu/Common/StgPackageController.cpp
    origin/source/TouhouDanmakufu/Common/StgPackageController.hpp
    origin/source/TouhouDanmakufu/Common/StgPackageScript.cpp
    origin/source/TouhouDanmakufu/Common/StgPackageScript.hpp
    origin/source/TouhouDanmakufu/Common/StgPlayer.cpp
    origin/source/TouhouDanmakufu/Common/StgPlayer.hpp
    origin/source/TouhouDanmakufu/Common/StgShot.cpp
    origin/source/TouhouDanmakufu/Common/StgShot.hpp
    origin/source/TouhouDanmakufu/Common/StgStageController.cpp
    origin/source/TouhouDanmakufu/Common/StgStageController.hpp
    origin/source/TouhouDanmakufu/Common/StgStageScript.cpp
    origin/source/TouhouDanmakufu/Common/StgStageScript.hpp
    origin/source/TouhouDanmakufu/Common/StgSystem.cpp
    origin/source/TouhouDanmakufu/Common/StgSystem.hpp
    origin/source/TouhouDanmakufu/Common/StgUserExtendScene.cpp
    origin/source/TouhouDanmakufu/Common/StgUserExtendScene.hpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${TouhouDanmakufu_source})

set(DnhExecutor_source
    origin/source/TouhouDanmakufu/DnhExecutor/Common.cpp
    origin/source/TouhouDanmakufu/DnhExecutor/Common.hpp
    origin/source/TouhouDanmakufu/DnhExecutor/Constant.hpp
    origin/source/TouhouDanmakufu/DnhExecutor/DnhExecuter.rc
    origin/source/TouhouDanmakufu/DnhExecutor/GcLibImpl.cpp
    origin/source/TouhouDanmakufu/DnhExecutor/GcLibImpl.hpp
    origin/source/TouhouDanmakufu/DnhExecutor/resource.h
    origin/source/TouhouDanmakufu/DnhExecutor/ScriptSelectScene.cpp
    origin/source/TouhouDanmakufu/DnhExecutor/ScriptSelectScene.hpp
    origin/source/TouhouDanmakufu/DnhExecutor/StgScene.cpp
    origin/source/TouhouDanmakufu/DnhExecutor/StgScene.hpp
    origin/source/TouhouDanmakufu/DnhExecutor/System.cpp
    origin/source/TouhouDanmakufu/DnhExecutor/System.hpp
    origin/source/TouhouDanmakufu/DnhExecutor/th_dnh_sx.ico
    origin/source/TouhouDanmakufu/DnhExecutor/TitleScene.cpp
    origin/source/TouhouDanmakufu/DnhExecutor/TitleScene.hpp
    origin/source/TouhouDanmakufu/DnhExecutor/WinMain.cpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${DnhExecutor_source})

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
    dxerr
    legacy_stdio_definitions.lib
    d3dxof
    d3dx9
)

dnh_common_copy_output_file(DnhExecutor bin_th_dnh th_dnh_ph3sx.exe)

add_custom_command(TARGET DnhExecutor POST_BUILD
    COMMAND cmake -E make_directory ${CMAKE_SOURCE_DIR}/bin_th_dnh
    COMMAND cmake -E copy ${CMAKE_SOURCE_DIR}/origin/bin_th_dnh/license.txt ${CMAKE_SOURCE_DIR}/bin_th_dnh
    COMMAND cmake -E copy ${CMAKE_SOURCE_DIR}/origin/bin_th_dnh/readme.txt ${CMAKE_SOURCE_DIR}/bin_th_dnh
)

# FileArchiver

set(GcLib_source_FileArchiver
    origin/source/GcLib/pch.cpp
    origin/source/GcLib/pch.h
    origin/source/GcLib/GcLib.hpp
    # gstd
    origin/source/GcLib/gstd/Application.cpp
    origin/source/GcLib/gstd/Application.hpp
    origin/source/GcLib/gstd/ArchiveEncryption.hpp
    origin/source/GcLib/gstd/ArchiveFile.cpp
    origin/source/GcLib/gstd/ArchiveFile.hpp
    origin/source/GcLib/gstd/File.cpp
    origin/source/GcLib/gstd/File.hpp
    origin/source/GcLib/gstd/GstdLib.hpp
    origin/source/GcLib/gstd/GstdUtility.cpp
    origin/source/GcLib/gstd/GstdUtility.hpp
    origin/source/GcLib/gstd/Logger.cpp
    origin/source/GcLib/gstd/Logger.hpp
    origin/source/GcLib/gstd/SmartPointer.hpp
    origin/source/GcLib/gstd/Thread.cpp
    origin/source/GcLib/gstd/Thread.hpp
    origin/source/GcLib/gstd/Window.cpp
    origin/source/GcLib/gstd/Window.hpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${GcLib_source_FileArchiver})

set(FileArchiver_source
    origin/source/FileArchiver/Constant.hpp
    origin/source/FileArchiver/FileArchiver.rc
    origin/source/FileArchiver/LibImpl.cpp
    origin/source/FileArchiver/LibImpl.hpp
    origin/source/FileArchiver/MainWindow.cpp
    origin/source/FileArchiver/MainWindow.hpp
    origin/source/FileArchiver/resource.h
    origin/source/FileArchiver/WinMain.cpp
)
source_group(TREE ${CMAKE_SOURCE_DIR}/origin/source FILES ${FileArchiver_source})

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
)

dnh_common_copy_output_file(FileArchiver bin_ext FileArchiver.exe)

add_custom_command(TARGET FileArchiver POST_BUILD
    COMMAND cmake -E make_directory ${CMAKE_SOURCE_DIR}/bin_ext
    COMMAND cmake -E copy ${CMAKE_SOURCE_DIR}/origin/bin_ext/FileArchiver_readme.txt ${CMAKE_SOURCE_DIR}/bin_ext
)
