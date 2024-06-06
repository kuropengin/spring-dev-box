FROM codercom/code-server:4.89.1-debian

USER root
RUN apt update
RUN apt install -y wget software-properties-common gnupg git
RUN apt install -y wget apt-transport-https
RUN wget -O - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo apt-key add -
RUN echo "deb https://packages.adoptium.net/artifactory/deb $(awk -F= '/^VERSION_CODENAME/{print$2}' /etc/os-release) main" | sudo tee /etc/apt/sources.list.d/adoptium.list
RUN apt update
RUN apt install temurin-21-jdk -y
RUN apt install -y maven

USER coder

ENV VSCODE_USER /home/coder/.local/share/code-server/User
RUN code-server --install-extension MS-CEINTL.vscode-language-pack-ja
RUN code-server --install-extension vscjava.vscode-java-pack
RUN code-server --install-extension redhat.vscode-yaml
RUN code-server --install-extension vscjava.vscode-gradle@3.13.2024011802

RUN code-server --install-extension vscode-icons-team.vscode-icons
RUN code-server --install-extension esbenp.prettier-vscode
RUN code-server --install-extension redhat.vscode-community-server-connector
RUN code-server --install-extension redhat.vscode-rsp-ui
RUN code-server --install-extension oderwat.indent-rainbow
RUN code-server --install-extension ecmel.vscode-html-css
RUN code-server --install-extension formulahendry.auto-rename-tag
RUN code-server --install-extension donjayamanne.githistory
RUN code-server --install-extension mhutchie.git-graph

RUN code-server --install-extension vmware.vscode-spring-boot
RUN code-server --install-extension vscjava.vscode-spring-initializr
RUN code-server --install-extension vscjava.vscode-spring-boot-dashboard

