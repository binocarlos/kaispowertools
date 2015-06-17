all: clean basicpackages latestgit nodejs go docker devpackages removepackages nodepackages python

clean:

# this creates an ssl tunnel so we can have port 443 directed to the vagrant machine
# not needed unless you need to test ssl sites
sslbridge:
	sudo ssh -p 2222 -gNfL 443:localhost:443 vagrant@localhost -i ~/.vagrant.d/insecure_private_key

removepackages:
	apt-get remove -y puppet chef

basicpackages:
	apt-get update	
	apt-get install -y python-software-properties make software-properties-common curl python g++

phantomjs:
	apt-get install bzip2
	cd /usr/local/share && wget https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
	cd /usr/local/share && tar xjf phantomjs-1.9.7-linux-x86_64.tar.bz2
	ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/share/phantomjs
	ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs
	ln -s /usr/local/share/phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/bin/phantomjs

devpackages: phantomjs
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

nodepackages:
	npm install -g browserify component@0.19.8

python:
	apt-get install -y python-pip python-dev python-pyasn1 libyaml-dev libffi-dev libssl-dev python-tox

go: latestgit
	git clone https://github.com/binocarlos/go-go-gadget.git /tmp/go-go-gadget
	cd /tmp/go-go-gadget && sudo bash ./install.sh

virtualbox:
	sudo sh -c 'echo "deb http://download.virtualbox.org/virtualbox/debian trusty contrib" >> /etc/apt/sources.list'
	wget http://download.virtualbox.org/virtualbox/debian/oracle_vbox.asc -O- | sudo apt-key add -
	sudo apt-get update
	sudo apt-get install -y virtualbox-4.3

vagrant:
	cd ~/Downloads && wget https://dl.bintray.com/mitchellh/vagrant/vagrant_1.6.5_x86_64.deb
	cd ~/Downloads && sudo dpkg -i vagrant_1.6.5_x86_64.deb

docker:
	bash installdocker.sh

builddevbox:
	docker build -t devbox .

    

devbox:
	sh ./startdevbox.sh