

SET(_PROJECT_NAME toon)

FetchContent_Declare(toon
GIT_REPOSITORY https://github.com/edrosten/TooN.git
GIT_TAG        df34d640e6079a3936849e95172a5f68e5f53947
)

FetchContent_MakeAvailable(toon)

SET(${_PROJECT_NAME}_INCLUDE_DIRS "${toon_SOURCE_DIR}")

