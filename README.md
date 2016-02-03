# my-bower-private-package

This repository contains a Bower package that I created in order to learn how to create private Bower packages using [private-bower](https://www.npmjs.com/package/private-bower).

**SVN NOTE**:

> Please note that the repository's content has also been registered on SourceForge in order to illustrate the use of SVN to keep packages’ contents.
> See [https://sourceforge.net/projects/my-bower-package/](https://sourceforge.net/projects/my-bower-package/).

The process for creating package is identical for public and private packages.
For GIT, see [https://github.com/denis-beurive/my-bower-package](https://github.com/denis-beurive/my-bower-package).

For SVN, see the section "Using SVN".

What differs is that, instead of registering the package on a public server, we register it on our own private server (our instance of [private-bower](https://www.npmjs.com/package/private-bower)).

To do that, we have to configure Bower so that it will use our private packages registering server, instead of the default one (https://bower.herokuapp.com). 
The configuration is done through the Bower configuration file « `.bowerrc` ». See the [specifications](http://bower.io/docs/config/) for this file.

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

# Using SVN

* You create a JSON file called « [bower.json](http://sourceforge.net/p/my-bower-package/code/HEAD/tree/trunk/bower.json) » within the directory that contains all the files you want to package.
  This file represents the package’s [specification](https://github.com/bower/spec/blob/master/json.md).
* You create a repository on SourceForge that will contain the source of your package.
* You commit all the packages’ files to the SourceForge repository.
* You create a branch, under the directory "`tags`" (do not use any other directory name).
  Make sure that this tag and the value of the property « `version` », within the package’s specification file « `bower.json` », are identical.
* Then you can register the package to private-bower.


Some useful commands:

Creating the tag:

**WARNING** In order to find a specific version of the package, Bower will _automatically_ take the "base URI" of the package and catenate the string "`tags/<version>`".

	svn copy svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code/trunk \
			 svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code/tags/1.0.0 \
			 -m "Create the version 1.0.0"

In case you made an error:

	svn delete svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code/tags/1.0.0 -m "Ooops... error"

Register the private package with Bower:

	bower -V register my-bower-package-svn svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code

Please note that we specify the « base URI » only. That is, we omit the last subdirectory « `trunk` ». Bower will look at :

	<base URI>/tags/<version>

The console's output:

	$ bower -V register my-bower-package-svn svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code
	bower my-bower-package-svn#*   resolve svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code#*
	bower my-bower-package-svn#*    export 1.0.0
	bower my-bower-package-svn#*  resolved svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code#1.0.0
	? Registering a package will make it installable via the registry (http://beurive.ddns.net:6666), continue? Yes
	bower my-bower-package-svn    register svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code
	
	Package my-bower-package-svn registered successfully!
	All valid semver tags on svn+ssh://denis-beurive@svn.code.sf.net/p/my-bower-package/code will be available as versions.
	To publish a new version, just release a valid semver tag.
	
	Run bower info my-bower-package-svn to list the available versions.

Test:

	bower search my-bower-package-svn
	bower lookup my-bower-package-svn
	bower info my-bower-package-svn
	bower install my-bower-package-svn

**NOTE¨**:

* You may need to configure your local SSH environment (since we used "svn+ssh").
* In order to get it working, make sure to put the file "`.bowerrc`" into the current directory. 


