# Dev Setup (macOS)

A personalized checklist for setting up a new development environment on macOS.

#### Table of Contents

1. [Xcode CLT](#xcode-clt)
2. [Homebrew](#homebrew)
3. [Git](#git)
4. [Node.js](#nodejs)
5. [Sublime Text](#sublime-text)
6. [PHPStorm](#phpstorm)
7. Deployment/VM's
	- [VirtualBox](#virtualbox) + modern.IE
	- [Vagrant](#vagrant)
	- Docker
8. [DevDesktop](#devdesktop)
9. [Drush](#drush)
10. Other

---

## Xcode CLT

An important dependency before Homebrew can work is the **Command Line Tools** for **Xcode**.

If you are running **OS X 10.9 Mavericks** or newer, then you can install the Xcode Command Line Tools directly from the command line:

	$ xcode-select --install
	
If you have issues with the above method, try downloading **'Command Line Tools (macOS Sierra) for Xcode 8'** from [Apple Developer Downloads](https://developer.apple.com/download/more/) and installing this package.

## Homebrew

Package managers make it so much easier to install and update applications (for Operating Systems) or libraries (for programming languages). The most popular one for OS X is [Homebrew](http://brew.sh/).

#### Install

After **Xcode Command Line Tools** has been installed, paste the following line into the terminal, hit **Enter** and follow the steps on the screen:

    $ ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
	
##### Skip next step if PATH for Homebrew is already set within .bash_paths

One thing we need to do is tell the system to use programs installed by Homebrew (in `/usr/local/bin`) rather than the OS default if it exists. We do this by adding `/usr/local/bin` to your `$PATH` environment variable:

    $ echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

Close and open a new terminal window, then run the following command to make sure everything works:

    $ brew doctor
    
#### Usage

To install a package (or **Formula** in Homebrew vocabulary) simply type:

    $ brew install <formula>
        
To update Homebrew's directory of formulae, run:

    $ brew update

To see if any of your packages need to be updated:

    $ brew outdated
    
To update a package:

    $ brew upgrade <formula>
   
To remove a package:

    $ brew remove <formula>
        
Homebrew keeps older versions of packages installed, in case you want to roll back. That rarely is necessary, so you can do some cleanup to get rid of those old versions:

    $ brew cleanup

To see what you have installed (with their version numbers):

    $ brew list --versions

## Git

To install [Git](http://git-scm.com/), simply run:

    $ brew install git

When done, to test that it installed fine you can run:

    $ git --version

And `$ which git` should output `/usr/local/bin/git`.

Let's set up some basic configuration. Download the [.gitconfig](/chrishrtmn/dev-setup-macos/blob/master/.gitconfig) file to your home directory:

    $ cd ~
    $ curl -O https://raw.githubusercontent.com/chrishrtmn/dev-setup-macos/master/.gitconfig

It will add some color to the `status`, `branch`, and `diff` Git commands, as well as a couple aliases. Feel free to take a look at the contents of the file, and add to it to your liking.

Define your Git user (should be the same name and email you use for [GitHub](https://github.com/)):

    $ git config --global user.name "Your Name Here"
    $ git config --global user.email "your_email@youremail.com"

They will get added to your `.gitconfig` file.

To push code to your GitHub repositories, we're going to use the recommended HTTPS method (versus SSH). So you don't have to type your username and password everytime, let's enable Git password caching as described [here](https://help.github.com/articles/set-up-git):

    $ git config --global credential.helper osxkeychain

**Note**: On a Mac, it is important to remember to add `.DS_Store` (a hidden OS X system file that's put in folders) to your `.gitignore` files. You can take a look at this repository's [.gitignore](/chrishrtmn/dev-setup-macos/blob/master/.gitignore) file for inspiration.

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
- To upgrade all or a particular package: `$ npm update [<package>]`
- To uninstall a package: `$ npm uninstall <package>`    
- To upgrade Node and NPM: `$ brew upgrade node`
- To uninstall Node and NPM: `$ brew uninstall node`

To install a package and save it in your project's `package.json` file: 
	
	$ npm install <package> --save

Node modules are installed locally in the `node_modules` folder of each project by default, but install these packages globally as they are used as commands in your shell.

- **Gulp** `$ npm install -g gulp`
- **Grunt** `$ npm install -g grunt-cli`

Any packages that you use **in** your project (like **Bower**) should be done with `require('package-name')`, then installed locally at the root of your project.

## Sublime Text
Once [Sublime Text 3](http://www.sublimetext.com/) is installed, you'll want to install [Package Control](https://sublime.wbond.net/installation), and then install the following packages:

- Alignment
- DocBlockr
- Drupal
- Git
- GitGutter
- jQuery
- PHP Twig
- Sass
- SCSS
- Sidebar Enhancements
- Theme - SoDaReloaded


Let's configure our editor a little. Go to **Sublime Text 3 > Preferences > Settings - User** and paste the following in the file that just opened:

	{
		"bold_folder_labels": true,
		"color_scheme": "Packages/User/SublimeLinter/Monokai (SL).tmTheme",
		"default_line_ending": "unix",
		"draw_white_space": "all",
		"enable_tab_scrolling": false,
		"ensure_newline_at_eof_on_save": true,
		"fade_fold_buttons": false,
		"fallback_encoding": "UTF-8",
		"find_selected_text": true,
		"font_options":
		[
			"subpixel_antialias"
		],
		"highlight_line": true,
		"ignored_packages":
		[
			"Vintage"
		],
		"open_files_in_new_window": false,
		"rulers":
		[
			80
		],
		"shift_tab_unindent": true,
		"tab_size": 2,
		"theme": "SoDaReloaded Dark.sublime-theme",
		"translate_tabs_to_spaces": true,
		"trim_automatic_white_space": true,
		"trim_trailing_white_space_on_save": true,
		"use_tab_stops": true,
		"word_separators": "./\\()\"'-:,.;<>~!@#%^&*|+=[]{}`~?"
	}


Tweak these to your preference. When done, save the file and close it.

A popular Theme is the [Soda Theme](https://github.com/buymeasoda/soda-theme). To install it, run:

    $ cd ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/
    $ git clone https://github.com/buymeasoda/soda-theme/ "Theme - Soda"

Then go to **Sublime Text 3 > Preferences > Settings - User** and add the following two lines:

    "theme": "Soda Dark.sublime-theme",
    "soda_classic_tabs": true

Restart Sublime Text for all changes to take affect.

**Command line alias to open any directory or file in Sublime:**
https://ashleynolan.co.uk/blog/launching-sublime-from-the-terminal

## PHPStorm 
Documentation coming soon.

## VirtualBox 
Download and install the [VirtualBox](https://www.virtualbox.org/wiki/Downloads) package from the website.

## Vagrant 
Download and install the [Vagrant](https://www.vagrantup.com/downloads.html) package from the website. Avoid installing Vagrant via system package managers.

## DrupalVM 
Download and install the [DrupalVM](https://www.drupalvm.com/) package from the website. Further Github documentation can be found [here](https://github.com/geerlingguy/drupal-vm).

## Acquia Dev Desktop 
Download and install the [Dev Desktop](https://dev.acquia.com/downloads) from the website. There are Drupal Distros here if interested.

## Laravel, Homestead
- [Laravel](https://laravel.com/)
- [Laravel Homestead](https://laravel.com/docs/5.3/homestead)
- [Setup Guide](https://scotch.io/tutorials/getting-started-with-laravel-homestead)
- Further documentation coming soon.

## Composer
Composer documentation coming soon.

---

[Back to Top](#dev-setup-macos)
