# Silicon

A CLI-tool for creating, building and running C/C++ projects on Apple Silicon.

__Author__: <a href="https://github.com/jorgenfinsveen">Jørgen Finsveen</a> <br/>
__Contact__: <a href="mailto:jorgen.finsveen@ntnu.no">jorgen.finsveen@ntnu.no</a>

## Installation

In order for this to work on your Mac, you should first have have a .zshrc in your home directory. But no worries! You may run this magic script in your terminal, which will set up everything for you. No need to clone the repo, we got you covered!

```sh
curl -fsSL https://raw.githubusercontent.com/jorgenfinsveen/silicon/main/install/install.sh | zsh
```

## Manual
Using Silicon is fairly easy! In order to start using it just do the following:
1. Open an empty folder where you plan to write some C/C++ code.
2. Start a terminal session in that directory.
3. Run ```silicon help``` to see your options!

## Note
I created this due to problems I had with C/C++ and OpenMP. In order to get the most out of Silicon, I would recommend you to do the following:

### Install Homebrew, Xcode CLI, vcpkg, and OpenMP

### Installing Homebrew:
```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zshrc
eval "$(/opt/homebrew/bin/brew shellenv)"
brew --version
clang --version
```

### Installing vcpkg
```sh
brew install vcpkg
vcpkg version
```

### Installing Xcode CLI
```sh
xcode-select --install
```

### Installing OpenMP
I added this here because the CMakeLists template you get from Silicon ads the OpenMP flag (I needed it when I first started this ridicoulous project). Just to ensure that you don't get any weird errors, spare you the trouble by downloading OpenMP as well.

#### Check if OpenMP is already installed
```sh
brew list | grep libomp
```

#### Installing OpenMP through Homebrew

```sh
brew install libomp
```

## Contact and Contribution
Have any suggestions or questions? Just send me an email at <a href="mailto:jorgen.finsveen@ntnu.no">jorgen.finsveen@ntnu.no</a>!

If you would like to contribute to the project, you may also contact me. You can also fork the repo, initiate a pull request, and add issues.
