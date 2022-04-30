
file(GLOB gvars3_SRC ${CMAKE_SOURCE_DIR}/3rdparty/gvars3/src/*.cc)

add_library(gvars3 STATIC ${gvars3_SRC})

SET(gvars3_INCLUDE_DIRS "${CMAKE_SOURCE_DIR}/3rdparty/gvars3/")

