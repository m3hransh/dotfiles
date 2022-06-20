### Install
Install fish using package manager

### Post-installation
1. install [Omf](https://github.com/oh-my-fish/oh-my-fish)
2. install [Fisher](https://github.com/jorgebucaran/fisher)
3. make fish as a default shell
  ```bash
   echo /usr/local/bin/fish | sudo tee -a /etc/shells
   chsh -s $(wich fish)
  ```
4. install bass
```bash
fisher install edc/bass
```
