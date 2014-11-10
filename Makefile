all: basicpackages latestgit nodejs go docker devpackages removepackages

removepackages:
	apt-get remove -y puppet chef

basicpackages:
	apt-get install -y python-software-properties make software-properties-common curl python g++

devpackages:
	apt-get install -y phantomjs
	npm install browserify -g

# updates to the latest git so we can use password caching
latestgit:
	add-apt-repository ppa:voronov84/andreyv -y
	apt-get update
	apt-get install -y git

# configures git with our details
gitconfig: gitshortcuts
	git config --global user.name "${GIT_NAME}"
	git config --global user.email "${GIT_EMAIL}"
	git config --global credential.helper 'cache --timeout=3600'

gitshortcuts:
	git config --global alias.ac '!git add -A && git commit'

nodejs:
	apt-get install -y python-software-properties make python
	wget -qO /usr/local/bin/nave https://raw.github.com/isaacs/nave/master/nave.sh
	chmod a+x /usr/local/bin/nave
	nave usemain 0.10.29

godeps:
	apt-get install -y mercurial subversion bzr

go: godeps
	curl https://go.googlecode.com/files/go1.2.1.linux-amd64.tar.gz | tar -C /usr/local -zx
	echo "GOROOT=/usr/local/go" >> /etc/environment
	echo "GOPATH=/srv/projects/gocode" >> /etc/environment
	echo "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/local/go/bin:/srv/projects/gocode/bin" >> /etc/environment

virtualbox:
	sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list'
	wget http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install -y virtualbox-4.3

vagrant:
	cd ~/Downloads && wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb
	cd ~/Downloads && sudo dpkg -i vagrant_1.6.5_x86_64.deb

docker:
	curl -sSL https://get.docker.io/ubuntu/ | sudo sh
	sudo usermod -a -G docker vagrant

builddevbox:
	docker build -t devbox .

    

devbox:
	sh ./startdevbox.sh