cmake_minimum_required(VERSION 3.11 FATAL_ERROR)
project(PTAM-SP)

INCLUDE(GNUInstallDirs)
INCLUDE(FetchContent)
INCLUDE(ExternalProject)

set(CMAKE_CXX_STANDARD 17)
 
find_package( OpenCV 4 REQUIRED )
find_package( OpenGL REQUIRED )
find_package(Threads REQUIRED)
find_package (Eigen3 3.3 REQUIRED NO_MODULE)
find_package(LAPACK REQUIRED)

# CVD dependencies
find_package(X11)
find_package(OpenGL REQUIRED COMPONENTS OpenGL GLX)

# Old dependencies
INCLUDE(cmake/toon.cmake)
INCLUDE(cmake/cvd.cmake)
INCLUDE(cmake/gvars3.cmake)

INCLUDE(cmake/nanoflann.cmake)
INCLUDE(cmake/dbow2.cmake)
INCLUDE(cmake/cereal.cmake)

include_directories(
        src
        include 
        ${nanoflann_INCLUDE_DIRS}
        ${cereal_INCLUDE_DIRS}
        ${dbow2_INCLUDE_DIRS}
        ${cvd_INCLUDE_DIRS}
        ${toon_INCLUDE_DIRS}
        ${gvars3_INCLUDE_DIRS}
        ${OpenCV_INCLUDE_DIRS}
        ${EIGEN3_INCLUDE_DIR}
)

set(PTAM_SP_LIB_SRC
        ${CMAKE_SOURCE_DIR}/src/lib/ATANCamera.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/Bundle.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/KeyFrame.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/Map.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/MapMaker.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/MapPoint.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/PatchFinder.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/ShiTomasi.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/SmallBlurryImage.cpp
        ${CMAKE_SOURCE_DIR}/src/lib/Tracker.cpp)

SET(CMAKE_CXX_FLAGS ${CMAKE_CXX_FLAGS} "-Wno-enum-compare -march=core2 -msse3")
add_definitions(-DCVD_HAVE_XMMINTRIN=1)

set(SHARED_LIBS ${cvd_LIBS} ${dbow2_LIBS} gvars3 ${OpenCV_LIBS}  Threads::Threads ${LAPACK_LIBRARIES})

add_library(ptamsp STATIC ${PTAM_SP_LIB_SRC})
target_link_libraries(ptamsp ${SHARED_LIBS} Eigen3::Eigen)
add_dependencies(ptamsp nanoflann cereal)


add_executable(ptam_headless src/headless/headless.cpp src/headless/HeadlessSystem.cpp src/VideoSource.cpp)
target_link_libraries(ptam_headless ptamsp ${SHARED_LIBS})

add_executable(ptam_model src/model/model_installer.cpp src/VideoSource.cpp)
target_link_libraries(ptam_model ptamsp ${SHARED_LIBS})

add_executable(ptam_gui src/gui/main.cpp src/gui/MapViewer.cpp src/gui/System.cpp src/VideoSource.cpp src/GLWindowMenu.cpp src/GLWindow2.cpp src/keysym.h)
target_link_libraries(ptam_gui ptamsp ${SHARED_LIBS} OpenGL::GL OpenGL::GLX OpenGL::OpenGL ${X11_LIBRARIES})

add_executable(ptam_calibrate_camera src/calibration/CameraCalibrator.cpp src/calibration/CalibImage.cpp src/calibration/CalibCornerPatch.cpp src/VideoSource.cpp src/GLWindowMenu.cpp src/GLWindow2.cpp)
target_link_libraries(ptam_calibrate_camera ptamsp ${SHARED_LIBS}  OpenGL::GL OpenGL::GLX OpenGL::OpenGL  ${X11_LIBRARIES})

add_executable(ptam_calibrate_video src/calibration/VideoCameraCalibrator.cpp src/calibration/CalibImage.cpp src/calibration/CalibCornerPatch.cpp src/VideoSource.cpp src/GLWindowMenu.cpp src/GLWindow2.cpp)
target_link_libraries(ptam_calibrate_video ptamsp ${SHARED_LIBS}  OpenGL::GL OpenGL::GLX OpenGL::OpenGL  ${X11_LIBRARIES})