# Function to build a CMake project for Apple Silicon
silicon_build() {

    RED='\e[38;2;255;100;100m'
    NC='\e[0m'

    if [ ! -f CMakeLists.txt ]; then
        echo -e "${RED}There are no CMakeLists.txt in this catalogue. Go to root dir of the project, ensure you have a CMakeLists.txt and retry.${NC}"
        return 1
    fi

    ORIGIN_DIR=$(pwd)

    rm -rf build
    mkdir build
    cd build

    SDK_PATH=$(xcrun --sdk macosx --show-sdk-path)

    cmake .. \
        -DCMAKE_C_COMPILER=/opt/homebrew/opt/llvm/bin/clang \
        -DCMAKE_C_COMPILER_LAUNCHER="" \
        -DCMAKE_CXX_COMPILER=/opt/homebrew/opt/llvm/bin/clang++ \
        -DCMAKE_CXX_COMPILER_LAUNCHER="" \
        -DCMAKE_C_FLAGS="-Xclang -fopenmp -I/opt/homebrew/include -isysroot $SDK_PATH" \
        -DCMAKE_EXE_LINKER_FLAGS="-L/opt/homebrew/opt/libomp/lib -lomp" \
        -DCMAKE_OSX_SYSROOT=$SDK_PATH \
        -DCMAKE_SYSTEM_NAME=Darwin

    if [ $? -ne 0 ]; then
        echo -e "${RED}CMake failed. Check error messages above.${NC}"
        cd "$ORIGIN_DIR"
        return 1
    fi

    echo -e "${GREEN}CMake configure succeeded. Building...${NC}"
    make

    if [ $? -eq 0 ]; then
        echo -e "${GREEN}Build succeeded!${NC}"
    else
        echo -e "${RED}Build failed!${NC}"
    fi

    make

    cd "$ORIGIN_DIR"
}




# Function to create a universal CMakeLists.txt file
silicon_init() {
    local cmake_file="CMakeLists.txt"

    if [[ -f "$cmake_file" ]]; then
        rm "$cmake_file"
    fi

    cat < ~/.silicon/silicon-cmake-template > "$cmake_file"
}



# Command tool for building CMake projects
# Usage: silicon [init|build|run|clean|info]
silicon() {
    CYAN='\e[38;2;71;248;222m'
    YELLOW='\e[38;2;248;222;71m'
    GREEN='\e[38;2;100;255;100m'
    BLUE='\e[38;2;100;200;255m'
    RED='\e[38;2;255;100;100m'
    NC='\e[0m'

    BUILD_DIR="./build"
    if [[ "$1" == "init" ]]; then
        silicon_init
    elif [[ "$1" == "build" ]]; then
        silicon_build
    elif [[ "$1" == "run" ]]; then

        if [ ! -d "$BUILD_DIR" ]; then
            echo "Building..."
            silicon build
        fi

        CMAKE_TARGET=$(awk -F: '/^[a-zA-Z0-9_-]+:/{if ($1 != "default_target" && $1 != "all" && $1 != "clean" && $1 != "cmake_force" && $1 != "edit_cache" && $1 != "rebuild_cache" && $1 != "depend" && $1 != "preinstall") {print $1; exit}}' "$BUILD_DIR/Makefile")

        if [ ! -f "$BUILD_DIR/$CMAKE_TARGET" ]; then
            echo "Executable '$BUILD_DIR/$CMAKE_TARGET' not found. Building..."
            silicon build
        fi

        CMAKE_TARGET=$(awk -F: '/^[a-zA-Z0-9_-]+:/{if ($1 != "default_target" && $1 != "all" && $1 != "clean" && $1 != "cmake_force" && $1 != "edit_cache" && $1 != "rebuild_cache" && $1 != "depend" && $1 != "preinstall") {print $1; exit}}' "$BUILD_DIR/Makefile")

        if [ -z "$CMAKE_TARGET" ]; then
            echo "Error: Could not find CMake target."
            return 1
        fi

        ./"$BUILD_DIR/$CMAKE_TARGET"
    elif [[ "$1" == "clean" ]]; then
        if [ -d "$BUILD_DIR" ]; then
            rm -rf "$BUILD_DIR"
        fi
    elif [[ "$1" == "info" ]]; then
        echo -e " "
        echo -e "${CYAN}Silicon${NC} is a command line tool for building CMake projects on Apple Silicon."
        echo -e " "
        echo -e "It provides a simple interface to create, build, run, and clean CMake projects."
        echo -e "Silicon was created by ${YELLOW}Jørgen Finsveen${NC}."
        echo -e " "
        echo -e "Usage: silicon [${RED}init${NC}|${BLUE}build${NC}|${GREEN}run${NC}|${YELLOW}clean${NC}|info]"
        echo -e "-------------------------------------------------------------------"
        echo -e "  ${RED}init${NC}:  Create a universal CMakeLists.txt file"
        echo -e "  ${BLUE}build${NC}: Build the project using CMake"
        echo -e "  ${GREEN}run${NC}  : Build and run the project"
        echo -e "  ${YELLOW}clean${NC}: Remove the build directory"
        echo -e "  info : Show available commands"
    
    elif [[ "$1" == "" ]]; then
        echo -e " "
        echo -e "No command provided. Use 'silicon info' to see available commands."
        echo -e " "
        echo -e "Command format: silicon [command]"
    else
        echo -e " "
        echo -e "Invalid command: silicon ${RED}$1${NC}"
        echo -e " "
        echo -e "To see available commands, run: silicon info"
    fi
}
