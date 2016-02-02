# my-bower-package

This repository contains a Bower package that I created in order to learn how to create private Bower packages using [private-bower](https://www.npmjs.com/package/private-bower).

Bower is built on top of GIT. Packages’ sources must be kept within a GIT repository. It may be GitHub, or it may be another repository. For this example, I use a public GitHub repository since it is a handy solution… but everything on GitHub is publicly available. However, using a public repository on GitHub or a private GIT repository on a private server does not matter (passing from one to the other is just a matter of Bower’s configuration).

The process for creating a public package is identical for public and private packages. SEE [https://github.com/denis-beurive/my-bower-package](https://github.com/denis-beurive/my-bower-package).

What differs is that, instead of registering the package on a public server, we register it on our own private server (our instance of [private-bower](https://www.npmjs.com/package/private-bower)).

To do that, we have to configure Bower so that it will use our private packages registering server, instead of the default one (https://bower.herokuapp.com). 
The configuration is done through the Bower configuration file « .bowerrc ». See the [specifications](http://bower.io/docs/config/) for this file.

Assuming that our instance of private-bower is accessible via the URL: `http://bower-server.yourdomain:7777`, then your `.bowerrc` file looks something like:

	{
		"analytics": false,
		"registry": {
	    	"search": [
				"http://bower-server.yourdomain:7777",
				"https://bower.herokuapp.com"
			],
			"register": "http://bower-server.yourdomain:7777",
			"publish": "http://bower-server.yourdomain:7777"
		},
		"timeout": 300000
	}

This configuration file tells Bower:

* To register packages to our private Bower server (at `http://bower-server.yourdomain:7777`).
* Publish packages to our private Bower server.
* Search for packages, first from our private Bower server, then from the default one (at `https://bower.herokuapp.com`).

Registering the package:

	bower register my-bower-private-package git://github.com/denis-beurive/my-bower-package.git

Make sure bower can find the registered package:

	bower search my-bower-private-package
	bower lookup my-bower-private-package
	bower info my-bower-private-package

Please note the commands above should be executed from the local GIT repository, because the repository's directory contains the configuration file `.bowerrc`.

Below, you can find my configuration file for "private-bower":

	{
	    "port": 6666,
	    "registryFile": "/opt/bower/bowerRepository.json",
	    "timeout": 144000,
	    "public": {
	        "disabled": false,
	        "registry": "http://bower.herokuapp.com/packages/",
	        "registryFile": "/opt/bower/bowerRepositoryPublic.json",
	        "whitelist": [],
	        "blacklist": []
	    },
	    "authentication": {
	        "enabled": false,
	        "key": "PASSWPRD"
	    },
	    "repositoryCache": {
	        "cachePrivate": false,
	        "git": {
	            "enabled": false,
	            "cacheDirectory": "/opt/bower/gitRepoCache",
	            "host": "localhost",
	            "port": 6789,
	            "publicAccessURL" : null,
	            "refreshTimeout": 10
	        },
	        "svn": {
	            "enabled": false,
	            "cacheDirectory": "/opt/bower/svnRepoCache",
	            "host": "localhost",
	            "port": 7891,
	            "publicAccessURL" : null,
	            "refreshTimeout": 10
	        }
	    },
	    "proxySettings" : {
	        "enabled": false,
	        "host": "proxy",
	        "username": "name",
	        "password" : "pass",
	        "port": 8080,
	        "tunnel": false
	    },
	    "log4js" : {
	        "enabled": true,
	        "configPath" : "/opt/bower/log4js.conf.json"
		}
	}

Please note that after the package `my-bower-private-package` has been registered, you find its reference within the file `bowerRepository.json` (property `registryFile`).

	{
	    "my-bower-private-package": {
	        "name": "my-bower-private-package",
	        "url": "git://github.com/denis-beurive/my-bower-package.git",
	        "hits": 1
	    }
	}



