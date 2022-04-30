

SET(_PROJECT_NAME dbow2)

FetchContent_Declare(${_PROJECT_NAME}
GIT_REPOSITORY    https://github.com/dorian3d/DBoW2
GIT_TAG           3924753db6145f12618e7de09b7e6b258db93c6e
)

FetchContent_MakeAvailable(${_PROJECT_NAME})

set(${_PROJECT_NAME}_SRC
    ${${_PROJECT_NAME}_SOURCE_DIR}/src/BowVector.cpp     
    ${${_PROJECT_NAME}_SOURCE_DIR}/src/FBrief.cpp        
    ${${_PROJECT_NAME}_SOURCE_DIR}/src/FORB.cpp
    ${${_PROJECT_NAME}_SOURCE_DIR}/src/FeatureVector.cpp 
    ${${_PROJECT_NAME}_SOURCE_DIR}/src/QueryResults.cpp  
    ${${_PROJECT_NAME}_SOURCE_DIR}/src/ScoringObject.cpp
)

add_library(${_PROJECT_NAME}_lib STATIC ${${_PROJECT_NAME}_SRC})
target_include_directories(${_PROJECT_NAME}_lib PRIVATE "${${_PROJECT_NAME}_SOURCE_DIR}/include/DBoW2")
target_link_libraries(${_PROJECT_NAME}_lib ${OpenCV_LIBS})

SET(${_PROJECT_NAME}_LIBS "${_PROJECT_NAME}_lib")
SET(${_PROJECT_NAME}_INCLUDE_DIRS "${${_PROJECT_NAME}_SOURCE_DIR}/include")

