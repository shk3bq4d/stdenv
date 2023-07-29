node file.js # cheap syntax checker
docker run -it readytalk/nodejs node
sudo docker run -it -v $PWD:/js --rm node:lts-alpine /js/bip.js
