FROM shK3Bq4d/stdenv:py

RUN true \
	&& git config --global user.name "Jeff Malone" \
	&& git config --global user.email "jeff@stdenv.stdenv" \
	&& cd ~ \
	&& git clone https://github.com/shK3Bq4d/stdhome.git ~/stdhome \
	&& ~/stdhome/bin/stdhome-install.sh -a o \
	&& cd ~ \
	&& git clone --no-checkout https://github.com/shK3Bq4d/stdenv.git ~/stdenv \
	&& cd ~/stdenv \
	&& git config branch.autosetupmerge always \
	&& git config status.showuntrackedfiles no \
	&& git config core.worktree ~ \
	&& git checkout --force -b stdenv origin/stdenv \
	&& true

