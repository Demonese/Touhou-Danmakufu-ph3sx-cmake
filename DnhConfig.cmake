# source files of DnhConfig

set(GcLib_source_DnhConfig
    # GcLib
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
    origin/source/TouhouDanmakufu/Common/DnhConfiguration.hpp
    origin/source/TouhouDanmakufu/Common/DnhConfiguration.cpp
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
