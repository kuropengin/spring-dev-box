FROM redhat/ubi9

USER root
RUN dnf update -y
RUN dnf install -y wget git maven
ENV DISTRIBUTION_NAME rhel
RUN cat <<EOF > /etc/yum.repos.d/adoptium.repo
[Adoptium]
name=Adoptium
baseurl=https://packages.adoptium.net/artifactory/rpm/${DISTRIBUTION_NAME:-$(. /etc/os-release; echo $ID)}/\$releasever/\$basearch
enabled=1
gpgcheck=1
gpgkey=https://packages.adoptium.net/artifactory/api/gpg/key/public
EOF
RUN dnf update
RUN dnf install temurin-21-jdk -y

RUN curl -fsSL https://code-server.dev/install.sh | sh

RUN adduser coder
USER coder

ENV VSCODE_USER /home/coder/.local/share/code-server/User
RUN code-server --install-extension MS-CEINTL.vscode-language-pack-ja
# 個別に取得
# RUN code-server --install-extension vscjava.vscode-java-pack
RUN code-server --install-extension redhat.java
RUN code-server --install-extension vscjava.vscode-java-debug
RUN code-server --install-extension vscjava.vscode-java-dependency
RUN code-server --install-extension vscjava.vscode-java-test
RUN code-server --install-extension vscjava.vscode-maven

RUN code-server --install-extension redhat.vscode-yaml
RUN code-server --install-extension vscjava.vscode-gradle

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
RUN code-server --install-extension GabrielBB.vscode-lombok

RUN code-server --install-extension akamud.vscode-theme-onedark
RUN code-server --install-extension streetsidesoftware.code-spell-checker
RUN code-server --install-extension mikestead.dotenv
RUN code-server --install-extension usernamehw.commands
RUN code-server --install-extension yzane.markdown-pdf
RUN code-server --install-extension zaaack.markdown-editor
RUN code-server --install-extension hbenl.vscode-test-explorer
RUN code-server --install-extension ms-playwright.playwright
RUN code-server --install-extension eamodio.gitlens
RUN code-server --install-extension xabikos.JavaScriptSnippets
RUN code-server --install-extension dsznajder.es7-react-js-snippets
RUN code-server --install-extension dbaeumer.vscode-eslint
RUN code-server --install-extension formulahendry.code-runner
RUN code-server --install-extension cweijan.vscode-mysql-client2
RUN code-server --install-extension christian-kohler.path-intellisense

ENV JAVA_HOME /usr/lib/jvm/temurin-21-jdk

WORKDIR /home/coder
ENTRYPOINT ["code-server", "--bind-addr", "0.0.0.0:8080", "."]

