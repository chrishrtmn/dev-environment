# Dev Environment (macOS)

A personalized checklist for setting up a new development environment on macOS.

#### Table of Contents

- [Xcode CLT](#xcode-clt)
- [Homebrew](#homebrew)
- [Git](#git)
- [Node.js](#nodejs)
- [VirtualBox](#virtualbox) + [modern.IE](http://modern.ie)
- [SSH](#ssh)
- [Composer & Drush](#composer--drush)

---

<br><br>

## Xcode CLT

An important dependency before Homebrew can work is the **Command Line Tools** for **Xcode**.

If you are running **OS X 10.9 Mavericks** or newer, then you can install the Xcode Command Line Tools directly from the command line:

	$ xcode-select --install
	
If you have issues with the above method, try downloading **'Command Line Tools (macOS Sierra) for Xcode 8'** from [Apple Developer Downloads](https://developer.apple.com/download/more/) and installing this package.

<br><br>

## Homebrew

Package managers make it so much easier to install and update applications (for Operating Systems) or libraries (for programming languages). The most popular one for OS X is [Homebrew](http://brew.sh/).

#### Install

After **Xcode Command Line Tools** has been installed, paste the following line into the terminal, hit **Enter** and follow the steps on the screen:

    $ /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	
**NOTE: Skip this next step if PATH for Homebrew is already set within .bash_profile.** One thing we need to do is tell the system to use programs installed by Homebrew (in `/usr/local/bin`) rather than the OS default if it exists. We do this by adding `/usr/local/bin` to your `$PATH` environment variable:

    $ echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

Make sure everything works: `$ brew doctor`
    
#### Usage

To install a package (or **Formula** in Homebrew vocabulary) simply type: `$ brew install <formula>`
        
To update Homebrew's directory of formulae, run: `$ brew update`

To see if any of your packages need to be updated: `$ brew outdated`
    
To update a package: `$ brew upgrade <formula>`
   
To remove a package: `$ brew remove <formula>`
        
Cleanup old versions: `$ brew cleanup`

To see what you have installed (with their version numbers): `$ brew list --versions`
    
To see top-level packages installed: `$ brew leaves`

<br><br>

## Git

To install [Git](http://git-scm.com/), simply run:

    $ brew install git

When done, to test that it installed fine you can run:

    $ git --version

And `$ which git` should output `/usr/local/bin/git`.

Let's set up some basic configuration. Download the [.gitconfig](/chrishrtmn/dev-environment/master/.gitconfig) file to your home directory:

    $ cd ~
    $ curl -O https://raw.githubusercontent.com/chrishrtmn/dev-environment/master/.gitconfig

Feel free to take a look at the contents of the file, and add to it to your liking.

Define your Git user (should be the same name and email you use for [GitHub](https://github.com/)):

    $ git config --global user.name "Your Name Here"
    $ git config --global user.email "your_email@youremail.com"

They will get added to your `.gitconfig` file.

To push code to your GitHub repositories, we're going to use the recommended HTTPS method (versus SSH). So you don't have to type your username and password everytime, let's enable Git password caching as described [here](https://help.github.com/articles/set-up-git):

    $ git config --global credential.helper osxkeychain

<br><br>

## Node.js

#### Install
Install [Node.js](http://nodejs.org/) with Homebrew:

    $ brew update
    $ brew install node

The formula also installs the [NPM](https://npmjs.org/) package manager. Test if Node is working with the commands below:

	$ node
	> console.log('Hello node');
	
#### Usage

- To install a package locally: `$ npm install <package>`
- To install a package globally: `$ npm install -g <package>`
- To see what's installed locally: `$ npm list`
- To see what's installed globally: `$ npm list -g`
- To find outdated packages (locally or globally): `$ npm outdated [-g]`
- To upgrade all or a particular package: `$ brew update` and then `$ npm update [<package>]`
- To uninstall a package: `$ npm uninstall <package>`    
- To upgrade Node and NPM: `$ brew update` and then `$ brew upgrade node`
- To uninstall Node and NPM: `$ brew uninstall node`

Node modules are installed locally in the `node_modules` folder of each project by default, but install these packages globally as they are used as commands in your shell.

- **create-react-app** `$ npm install -g create-react-app`
- **vue-cli** `$ npm install -g vue-cli`
- **Yarn** `$ npm install -g yarn`

Any packages that you use **in** your project should be done with `require('package-name')`, then installed locally at the root of your project.

To install a package and save it in your project's `package.json` file: 
	
	$ npm install <package> --save
	
To install a package and save it as a development dependency: 
	
	$ npm install <package> --save-dev

<br><br>

## VirtualBox 
Download and install the [VirtualBox](https://www.virtualbox.org/wiki/Downloads) package from the website.

[Modern.ie](http://modern.ie) is used for virtual machines for IE browser testing.

<br><br>

## SSH
Copy over your SSH dotfiles over to the Home directory and enable read/write permissions:

	$ chmod 600 ~/.ssh/id_rsa
	
<br><br>

## Composer & Drush

Install Composer with Homebrew:

	$ brew update
	$ brew tap homebrew/dupes
	$ brew tap homebrew/php
	$ brew install php56
	$ brew install composer
	
Test Composer with:

	$ composer -V
	
Install Drush with Composer:

	$ composer global require drush/drush:dev-master
	$ sudo ln -s $HOME/.composer/vendor/bin/drush /usr/local/bin/drush

Check Drush status with:

	$ drush status

<br><br>

---
[Back to Top](#dev-environment-macos)
