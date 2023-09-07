cmake_minimum_required(VERSION 3.26)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

get_filename_component(ProjectId ${CMAKE_CURRENT_SOURCE_DIR} NAME)
string(REPLACE " " "_" ProjectId ${ProjectId})
project(${ProjectId} LANGUAGES CXX)

find_package(glfw3 REQUIRED)
find_package(OpenGL)

set(imgui_lib_src  
    "${PROJECT_SOURCE_DIR}/imgui.cpp"
    "${PROJECT_SOURCE_DIR}/imgui_demo.cpp"
    "${PROJECT_SOURCE_DIR}/imgui_draw.cpp"
    "${PROJECT_SOURCE_DIR}/imgui_tables.cpp"
    "${PROJECT_SOURCE_DIR}/imgui_widgets.cpp"
    "${PROJECT_SOURCE_DIR}/backends/imgui_impl_glfw.cpp"
    "${PROJECT_SOURCE_DIR}/backends/imgui_impl_opengl3.cpp")
# 

add_library(imgui ${imgui_lib_src})
target_include_directories(imgui PUBLIC ./ ./backends)
target_link_libraries(imgui PUBLIC glfw)

add_executable(sample examples/example_glfw_opengl3/main.cpp)
target_include_directories(sample PRIVATE ${OPENGL_INCLUDE_DIRS})
target_link_libraries(sample PRIVATE imgui ${CMAKE_DL_LIBS} ${OPENGL_LIBRARIES})
add_custom_target(run COMMAND $<TARGET_FILE:sample>)

file(GLOB headers "*.h" "backends/*.h")
set_target_properties(imgui PROPERTIES
  PUBLIC_HEADER "${headers}")
  
install(TARGETS imgui)
