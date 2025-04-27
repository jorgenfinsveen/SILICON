echo -e "\e[38;2;71;248;222m"
echo -e '    (    (    (     (             )      )   '
echo -e '    )\ ) )\ ) )\ )  )\ )   (   ( /(   ( /(   '
echo -e '    (()/((()/((()/( (()/(   )\  )\())  )\()) '
echo -e '    /(_))/(_))/(_)) /(_))(((_)((_)\  ((_)\   '
echo -e '    (_)) (_)) (_))  (_))  )\___  ((_)  _((_) '
echo -e '    / __||_ _|| |   |_ _|((/ __|/ _ \ | \| | '
echo -e '    \__ \ | | | |__  | |  | (__| (_) || .` | '
echo -e '    |___/|___||____||___|  \___|\___/ |_|\_| '           
echo -e " "
echo -e "By Jørgen Finsveen, 2025"
echo -e "\e[0m"     
echo " "
echo -e "❤️  Thank you for downloading \e[38;2;71;248;222mSilicon\e[0m\!"
echo -e "🔬 We will start setting up things for you."

# 1. Go to home-directory
cd ~/

# 2. Clone GitHub-repo to ~/.silicon
if [ -d ".silicon" ]; then
  echo -e "⚡ You already have Silicon! I'm flattered 🥹"
else
  echo -e "📥 Cloning GitHub-repo to ~/.silicon ..."
  git clone https://github.com/jorgenfinsveen/silicon.git ~/.silicon || { echo "Cloning failed!"; exit 1; }
fi

# 3. Check if .zshrc exist in home directory
if [ -f ".zshrc" ]; then
  echo -e "✅ You already have a .zshrc file."
else
  echo -e "📄 You don't have a .zshrc file already. We will take care of that for you\!"
  touch .zshrc
fi

# 4. Ensures that silicon.sh is sourced if not done already
if grep -Fxq "source ~/.silicon/silicon.sh" .zshrc; then
  echo -e "🔗 'source ~/.silicon/silicon.sh' is already in .zshrc."
else
  echo -e "🔗 Adding 'source ~/.silicon/silicon.sh' in .zshrc ..."
  echo "source ~/.silicon/silicon.sh" >> .zshrc
fi
source ~/.zshrc
echo -e " "
echo -e "🎉 We're done! You can now start using Silicon by running \e[38;2;71;248;222msilicon help\e[0m in your terminal\!"