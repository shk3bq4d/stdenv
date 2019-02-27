FROM shk3bq4d/stdenv:py

RUN true \
	&& sh -c "$(curl -kfsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" \
	&& touch ~/.z \
	&& git config --global user.name "Jeff Malone" \
	&& git config --global user.email "jeff@stdenv.stdenv" \
	&& cd ~ \
	&& mkdir -p ~/.ssh/c \
	&& git clone https://github.com/shK3Bq4d/stdhome.git ~/stdhome \
    && ~/stdhome/bin/stdhome-install.sh -a o \
	&& cd ~ \
	&& git clone --no-checkout https://github.com/shK3Bq4d/stdenv.git ~/stdenv \
	&& cd ~/stdenv \
	&& git config branch.autosetupmerge always \
	&& git config status.showuntrackedfiles no \
	&& git config core.worktree ~ \
	&& cd ~/stdenv \
	&& git checkout --force stdenv \
	&& true
	#&& git checkout --force -b stdenv origin/stdenv \

	#RUN sed -r -i -e '/stdhome-install-onefile/s/...dev.tty/echo "" |/' ~/stdhome/bin/stdhome-install.sh
