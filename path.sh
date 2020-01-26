if [[ -z $TMUX ]]; then
    export PATH=$PATH:/opt/maven/bin:${HOME}/bin
    export PATH=$PATH:/usr/local/bin
    export PATH=$PATH:${HOME}/.anyenv/bin
    export GOPATH=$HOME/go
fi

# なんかおかしい
export PATH=$PATH:${GOPATH}/bin
export JAVA_HOME=`jenv javahome`

if [[ -z $TMUX ]]; then
  case "${OSTYPE}" in
   darwin*)
     export PATH=$PATH:${HOME}/Library/Android/sdk/platform-tools/
     export PATH=$PATH:${HOME}/Library/Android/sdk/tools/
   linux*)
      export PATH=$PATH:${HOME}/workspace/android-practice/Sdk/platform-tools
      export PATH=$PATH:${HOME}/workspace/android-practice/Sdk/tools
    ;;
  esac
fi

