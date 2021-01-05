cmake_minimum_required(VERSION 3.14)

project(qfeh LANGUAGES CXX)

set(CMAKE_INCLUDE_CURRENT_DIR ON)

set(CMAKE_AUTOUIC ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

find_package(QT NAMES Qt6 COMPONENTS Core Quick REQUIRED)
find_package(Qt${QT_VERSION_MAJOR} COMPONENTS Core Quick QuickControls2 REQUIRED)

set(IMAGE_HISTOGRAM_MODEL
        src/imagehistogrammodel.cpp
        src/imagehistogrammodel.h
    )
set(PROJECT_SOURCES
        src/main.cpp
        src/localdiriterator.cpp
        src/localdiriterator.h
        ${IMAGE_HISTOGRAM_MODEL}
        qml.qrc
        assets.qrc
)

qt_add_executable(qfeh
    ${PROJECT_SOURCES}
)

target_compile_definitions(qfeh
  PRIVATE $<$<OR:$<CONFIG:Debug>,$<CONFIG:RelWithDebInfo>>:QT_QML_DEBUG>)
target_link_libraries(qfeh
  PRIVATE Qt${QT_VERSION_MAJOR}::Core Qt${QT_VERSION_MAJOR}::Quick)
