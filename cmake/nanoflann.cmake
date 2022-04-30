

SET(_PROJECT_NAME nanoflann)

SET(${_PROJECT_NAME}_CMAKE_FLAGS
-DCMAKE_INSTALL_PREFIX=${CMAKE_BINARY_DIR}/${_PROJECT_NAME}/install
-DCMAKE_BUILD_TYPE=Release
)

ExternalProject_Add(${_PROJECT_NAME}
PREFIX ${_PROJECT_NAME}
GIT_REPOSITORY    https://github.com/jlblancoc/nanoflann
GIT_TAG           b3e81831b847a77473e0da2ad7ee266b4f4e0d9a
CMAKE_ARGS        ${${_PROJECT_NAME}_CMAKE_FLAGS}
TEST_COMMAND      ""
)

SET(${_PROJECT_NAME}_INCLUDE_DIRS "${CMAKE_BINARY_DIR}/${_PROJECT_NAME}/install/include/")
