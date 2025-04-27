# Silicon

![Silicon](https://img.shields.io/badge/Silicon-Optimized%20for%20M--series-black?logo=apple&logoColor=white) [![GitHub release](https://img.shields.io/github/v/release/jorgenfinsveen/silicon?style=flat-square)](https://github.com/jorgenfinsveen/silicon/releases)
 ![Install](https://img.shields.io/badge/install-curl--script-brightgreen) ![Silicon](https://img.shields.io/badge/Silicon-Rocket%20Powered-red?logo=rocket&logoColor=white)

<picture>
  <source srcset="https://github.com/user-attachments/assets/bc5675a1-309a-4cf6-af52-a4c17127a968" media="(prefers-color-scheme: dark)">
  <source srcset="https://github.com/user-attachments/assets/c358df6b-69bb-4907-a805-e1f3c4728b68" media="(prefers-color-scheme: light)">
  <img src="https://github.com/user-attachments/assets/bc5675a1-309a-4cf6-af52-a4c17127a968" width="760" alt="Silicon Logo" />
</picture>


<br/>

**Silicon** is a lightweight and fast command-line tool for setting up, building, running, and cleaning C/C++ projects on macOS with Apple Silicon (ARM64).

It was created with simplicity and developer speed in mind, aiming to make project management easy and efficient.

---

## ✨ Features

- Quickly initialize a new CMake project with a universal `CMakeLists.txt` template
- Automatically configure and build projects optimized for Apple Silicon
- Run the compiled binary with a single command
- Clean build artifacts easily
- Colorful, user-friendly terminal output
- Designed specifically for macOS on Apple Silicon (M1, M2, M3 chips)

---

## ⚡ Installation

### Quick Install
In order for this to work on your Mac, you should first have a .zshrc in your home directory. But no worries! You may run this magic script in your terminal, which will set up everything for you. No need to clone the repo, we got you covered!

```sh
curl -fsSL https://raw.githubusercontent.com/jorgenfinsveen/silicon/main/install/install.sh | zsh
```

### Semi Manual
1. Clone this repo and store it in your user directory under the name .silicon:
```sh
git clone https://github.com/jorgenfinsveen/silicon.git ~/.silicon
```
2. Run the following command in your terminal:
```sh
sh ~/.silicon/install/install.sh # sudo may be required
```
3. Start making your life easier with Silicon!


### Old-School Installation
1. Clone this repo and store it in your user directory under the name .silicon:
```sh
git clone https://github.com/jorgenfinsveen/silicon.git ~/.silicon
```
2. Make sure you have a .zshrc, .bashrc (or similar). If not, create one depending on wether you use zsh or bash (zsh is default on MacOS).
3. Write the following at the bottom of the above file:
```sh
source ~/.silicon/silicon.sh
```
4. Finally, run this command in the terminal to apply Silicon to your CLI:
```sh
source ~/[shell-profile-file] # Alternatives: .zshrc, .bashrc, etc.
```




## Manual

### 🛠 Basic usage
```sh
silicon [command]
```

Available commands:

| Command       | Description                                         |
|---------------|-----------------------------------------------------|
| ```init```    | Create a new ```CMakeLists.txt``` from template     |
| ```build```   | Configure and build the project                     |
| ```run```     | Run the compiled binary (auto-detects target)       |
| ```clean```   | Remove the build directory                          |
| ```info```    | Display information about Silicon                   |


### TL;DR
Using Silicon is fairly easy! In order to start using it just do the following:
1. Open an empty folder where you plan to write some C/C++ code.
2. Start a terminal session in that directory.
3. Run ```silicon help``` to see your options!



## ✅ Recommendations
I created this due to problems I had with C/C++ and OpenMP. In order to get the most out of Silicon, I would recommend you to do the following:

### Install Homebrew, Xcode CLI, vcpkg, and OpenMP

#### Installing Homebrew:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
brew --version
clang --version
```

#### Installing vcpkg
```sh
brew install vcpkg
vcpkg version
```

#### Installing Xcode CLI
```sh
xcode-select --install
```

#### Installing OpenMP
I added this here because the CMakeLists template you get from Silicon ads the OpenMP flag (I needed it when I first started this ridicoulous project). Just to ensure that you don't get any weird errors, spare you the trouble by downloading OpenMP as well.

__Check if OpenMP is already installed__
```sh
brew list | grep libomp
```

__Installing OpenMP through Homebrew__

```sh
brew install libomp
```

### If you are using Visual Studio Code
The Microsoft C/C++ language support extension has some errors when it comes to e.g., OpenMP, which makes it impossible for vscode to understand that you are using OpenMP correctly, leaving red squiggly lines all over the place! I would therefore recommend that you use [clangd](https://marketplace.visualstudio.com/items/?itemName=llvm-vs-code-extensions.vscode-clangd) instead. Also, it could be a good idea to download [Cmake Tools](https://marketplace.visualstudio.com/items/?itemName=ms-vscode.cmake-tools) as well!

I will also recommend that you select the right configurations. Here is how my ```.vscode``` setup looks like:

#### settings.json
```json
{
    "clangd.path": "/opt/homebrew/opt/llvm/bin/clangd",
    "cmake.sourceDirectory": "${workspaceFolder}",
    "cmake.buildDirectory": "${workspaceFolder}/build",
    "cmake.generator": "Unix Makefiles",
    "cmake.configureOnOpen": true
}
```

#### c_cpp_properties.json
```json
{
    "configurations": [
      {
        "name": "Mac",
        "includePath": [
          "${workspaceFolder}/**"
        ],
        "defines": [],
        "macFrameworkPath": [
          "/System/Library/Frameworks",
          "/Library/Frameworks"
        ],
        "compilerPath": "/opt/homebrew/opt/llvm/bin/clang",
        "cStandard": "c11",
        "cppStandard": "c++17",
        "intelliSenseMode": "macos-clang-arm64",
        "compileCommands": "${workspaceFolder}/build/compile_commands.json"
      }
    ],
    "version": 4
}
```

## 🛤 Roadmap

- [x] v1.0.0: First official release
- [x] Colorful ASCII logo and CLI output
- [x] Quick install via `curl`
- [ ] Allow specifying target manually (e.g., `silicon run myprogram`)
- [x] Add caching of target name for faster runs
- [ ] Add support for building multiple binaries
- [ ] Add `silicon update` command for future self-updating
- [ ] Write full documentation with examples and troubleshooting
- [ ] Add parameter to init function to specify the language of the project

---

### ✨ Planned Features
- Interactive CLI prompts (e.g., when initializing a project)
- Auto-detect common project structures
- Support for cross-platform (Linux ARM64)
- Support for automatic CMake inclusion of parallelism libraries (MPI, Metal, OpenCL, CUDA)
- Support for specifying compiler flags

---

If you have ideas or suggestions, feel free to open an [issue](https://github.com/jorgenfinsveen/silicon/issues)!


## 📸 Screenshots
<img width="753" alt="Terminal screenshot of Silicon in action" src="https://github.com/user-attachments/assets/e8ecefc3-d273-4508-9888-a1299be1ed05" />



## 📄 License
This project is licensed under the MIT License.
See the [LICENSE](LICENSE) for details.

## 🧠 About
Silicon was created by [Jørgen Finsveen](https://github.com/jorgenfinsveen) as a personal tool to streamline C/C++ development workflows on Apple Silicon machines.
Feel free to contribute by submitting an [issue](https://github.com/jorgenfinsveen/silicon/issues) or a pull request!

