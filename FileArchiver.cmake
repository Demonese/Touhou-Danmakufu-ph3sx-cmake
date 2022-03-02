# source files of FileArchiver

set(GcLib_source_FileArchiver
    # GcLib
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
