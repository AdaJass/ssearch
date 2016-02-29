Ssearch is a chatable search website, written in coffescript. After compiling, you can get .js file in dist directory. 

# Installation
If you want to run this web server on your cp. you need to preinstall nodejs and mongodb. I assume your computer has met these. And then, clone this repository to your computer, run a command line switch to its directory. and then type:
```shell
npm install -g gulp
```
and then:
```shell
npm install --save-dev gulp
```
and then install server side modules:
```shell
npm install
```
and if you don't have bower:
```shell
npm install -g bower
```
and then install client js files:
```shell
bower install
```
Next, click database.bat to run the database, if you aren't use windows, you should manully run database's serve.

Now, all requirements meet. so just run the server in shell by typing:
```shell
gulp
```
the server will start automaticly.





