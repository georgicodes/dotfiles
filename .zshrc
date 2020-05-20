ZSH_THEME="muse"

# Aliases
alias src="cd ~/enterprise2;"
alias sshc="src; chroot-ssh.sh"
alias reset="src; chroot-stop.sh; chroot-reset.sh;"
alias build="src; reset; chroot-build.sh && chroot-start.sh && chroot-configure.sh"

# enterprise2
export PATH=~/enterprise2:$PATH
export DEV_MODE=1
export GHE_LXC_NAME=ghe-dev-$(id -un)
export ENABLE_HYDRO=1
export OVERLAY_VM_FILES=yes

src;
