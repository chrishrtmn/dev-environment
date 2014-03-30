# Overview

This document is my way of setting up a modern local & development environment on Mac OS X Mavericks that caters to Drupal 7 with some Node & Ruby sweetsauce thrown in the pot. It also covers [OpenShift](https://www.openshift.com) as the primary host provider. Mix these all together and "baby, you got a stew going!"

Comments or suggestions? Send me a 140 character tweet on [Twitter](https://twitter.com/chrishrtmn).

---

# Table of Contents

- Local Environment
	- Xcode Command Line Tools
	- Homebrew
	- Git
	- .bash_profile
	- Ruby
		- rbenv
		- Gems
		- Bundler
	- Node.js
		- npm
		- Grunt
		- Gulp
		- Guard
	- Sublime Text 3
	- Drupal Related & Modules
	- Folder Heirarchy & Structure
	- Other Sweetsauce
- Development Environment
	- Hostgator
	- OpenShift
- Mac OS X Apps
- Coming Soon

---

# Local Environment Setup

Need some text. Need some text. Need some text. Need some text. Need some text. Need some text. Need some text. Need some text. Need some text. Need some text.

## Xcode Command Line Tools

**Note: OS X 10.9 Mavericks or later:** Install the Xcode Command Line Tools directly from the command line with:

	$ xcode-select --install

Follow the instructions in the pop-up windows to continue installation. Should take roughly around 30 minutes.

## Homebrew

The most popular package manager for OS X is [Homebrew](http://brew.sh/).

##### Install

    $ ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go/install)"

One thing we need to do is tell the system to use programs installed by Hombrew (in `/usr/local/bin`) rather than the OS default if it exists. We do this by adding `/usr/local/bin` to your `$PATH` environment variable:

    $ echo 'export PATH="/usr/local/bin:$PATH"' >> ~/.bash_profile

Open an new terminal tab with **Cmd+T** (you should also close the old one), then run the following command to make sure everything works:

    $ brew doctor

##### Usage

To install a package (or **Formula** in Homebrew vocabulary) simply type:

    $ brew install <formula>

To update Homebrew's directory of formulae, run:

    $ brew update

**Note**: I've seen that command fail sometimes because of a bug. If that ever happens, run the following (when you have Git installed):

    $ cd /usr/local
    $ git fetch origin
    $ git reset --hard origin/master

To see if any of your packages need to be updated:

    $ brew outdated

To update a package:

    $ brew upgrade <formula>

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

Let's set up some basic configuration. Download the [.gitconfig](/nicolahery/mac-dev-setup/blob/master/.gitconfig) file to your home directory:

    $ cd ~
    $ curl -O https://raw.github.com/nicolashery/mac-dev-setup/master/.gitconfig

It will add some color to the `status`, `branch`, and `diff` Git commands, as well as a couple aliases. Feel free to take a look at the contents of the file, and add to it to your liking.

Next, we'll define your Git user (should be the same name and email you use for [GitHub](https://github.com/) and [Heroku](http://www.heroku.com/)):

    $ git config --global user.name "Your Name Here"
    $ git config --global user.email "your_email@youremail.com"

They will get added to your `.gitconfig` file.

To push code to your GitHub repositories, we're going to use the recommended HTTPS method (versus SSH). So you don't have to type your username and password everytime, let's enable Git password caching as described [here](https://help.github.com/articles/set-up-git):

    $ git config --global credential.helper osxkeychain

**Note**: On a Mac, it is important to remember to add `.DS_Store` (a hidden OS X system file that's put in folders) to your `.gitignore` files. You can take a look at this repository's [.gitignore](/nicolahery/mac-dev-setup/blob/master/.gitignore) file for inspiration.

## My .bash_profile

This file can be edited with `$ vi ~/.bash_profile` in the terminal. When in `vi`, hit `I` to enter insert mode and hit `esc` to leave insert mode. Type `:q` to quit or `:x` to save & quit.

	source ~/.bashrc
	source ~/.profile

	# Terminal
	alias ls='ls -G'
	export CLICOLOR=1
	export LSCOLORS=ExFxCxDxBxegedabagacad

	# MAMP Aliases
	# alias mysql=/Applications/MAMP/Library/bin/mysql
	# alias mysqldump=/Applications/MAMP/Library/bin/mysqldump
	# alias mysqladmin=/Applications/MAMP/Library/bin/mysqladmin

	# Bundler Aliases
	alias bcw='bundle exec compass watch'
	alias bcc='bundle exec compass compile'
	alias bi='bundle install'
	alias bu='bundle update'

	# Homebrew - Update System Path
	export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

	# rbenv
	eval "$(rbenv init -)"

## Ruby 

### rbenv (or chruby)

Ruby management

	$ something here

### Gems

[RubyGems](http://rubygems.org/), the Ruby package manager.

    $ which gem

Update to its latest version with:

    $ gem update --system

##### Install

To install a "gem" (Ruby package), run:

    $ gem install <gemname>

To install without generating the documentation for each gem (faster):

    $ gem install <gemname> --no-document

To see what gems you have installed:

    $ gem list

To check if any installed gems are outdated:

    $ gem outdated

To update all gems or a particular gem:

    $ gem update [<gemname>]

RubyGems keeps old versions of gems, so feel free to do come cleaning after updating:

    $ gem cleanup

I mainly use Ruby for the CSS pre-processor [Compass](http://compass-style.org/), which is built on top of [Sass](http://sass-lang.com/):

    $ gem install compass --no-document

##### Gems

- breakpoint
- bundler
- compass
- compass-normalize
- compass-rgbapng
- css_parser
- sass
- sass_globbing
- singularitygs
- toolkit
- ***others***

### Bundler

Junk

## Node.js & NPM

Install [Node.js](http://nodejs.org/) with Homebrew:

    $ brew update
    $ brew install node

The formula also installs the [npm](https://npmjs.org/) package manager. However, as suggested by the Homebrew output, we need to add `/usr/local/share/npm/bin` to our path so that npm-installed modules with executables will have them picked up.

To do so, add this line to your `~/.path` file, before the `export PATH` line:

```bash
PATH=/usr/local/share/npm/bin:$PATH
```

Open a new terminal for the `$PATH` changes to take effect.

We also need to tell npm where to find the Xcode Command Line Tools, by running:

    $ sudo xcode-select -switch /usr/bin

Node modules are installed locally in the `node_modules` folder of each project by default, but there are at least two that are worth installing globally. Those are [CoffeeScript](http://coffeescript.org/) and [Grunt](http://gruntjs.com/):

    $ npm install -g coffee-script
    $ npm install -g grunt-cli

##### Npm usage

To install a package:

    $ npm install <package> # Install locally
    $ npm install -g <package> # Install globally

To install a package and save it in your project's `package.json` file:

    $ npm install <package> --save

To see what's installed:

    $ npm list # Local
    $ npm list -g # Global

To find outdated packages (locally or globally):

    $ npm outdated [-g]

To upgrade all or a particular package:

    $ npm update [<package>]

To uninstall a package:

    $ npm uninstall <package>


### Bower

Install Bower
 
### Grunt, Gulp, Guard 

- Grunt Starter `https://github.com/robdecker/grunt-starter`

- LiveReload
- Compass/Sass
- Others


## Sublime Text 3

[Sublime Text 3](http://www.sublimetext.com/) is my favorite text editor. Once Sublime Text is installed, you'll want to install [Package Control](https://sublime.wbond.net/installation) and then install the following packages:

- Alignment
- CSSComb
- DocBlockr
- Drupal
- jQuery
- jQuery Snippets pack
- Live CSS
- Sass
- SCSS
- SFTP
- Sidebar Enhancements
- SublimeLinter
- Theme - Soda
- Sublime Tern
- git
- GitGutter
- PHP Twig tmBundle


Let's configure our editor a little. Go to **Sublime Text 3 > Preferences > Settings - User** and paste the following in the file that just opened:

	{
		"bold_folder_labels": true,
		"color_scheme": "Packages/User/Monokai (SL).tmTheme",
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
			"SublimeLinter",
			"Vintage",
			"Grunt",
			"CSScomb"
		],
		"open_files_in_new_window": false,
		"rulers":
		[
			80
		],
		"shift_tab_unindent": true,
		"tab_size": 2,
		"theme": "Soda Light.sublime-theme",
		"translate_tabs_to_spaces": true,
		"trim_automatic_white_space": true,
		"trim_trailing_white_space_on_save": true,
		"use_tab_stops": true,
		"word_separators": "./\\()\"'-:,.;<>~!@#%^&*|+=[]{}`~?"
	}


Feel free to tweak these to your preference. When done, save the file and close it.

Now for the color. I'm going to change two things: the **Theme** (which is how the tabs, the file explorer on the left, etc. look) and the **Color Scheme** (the colors of the code). Again, feel free to pick different ones, or stick with the default.

A popular Theme is the [Soda Theme](https://github.com/buymeasoda/soda-theme). To install it, run:

    $ cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages/
    $ git clone https://github.com/buymeasoda/soda-theme/ "Theme - Soda"

Then go to **Sublime Text 2 > Preferences > Settings - User** and add the following two lines:

    "theme": "Soda Dark.sublime-theme",
    "soda_classic_tabs": true

Restart Sublime Text for all changes to take affect.

To extend more in Sublime Text, a good place to start would be to install the [Sublime Package Control](http://wbond.net/sublime_packages/package_control/installation).

##### Sync with Dropbox

	http://andrew.hedges.name/blog/2012/01/19/sublime-text-2-more-sublime-with-a-drop-of-dropbox
	
	http://wheels.onebuttonapps.net/2012/04/use-dropbox-to-store-your-sublime-text-2-settings/
	
	http://misfoc.us/post/18018400006/syncing-sublime-text-2-settings-via-dropbox

## Drupal

Set up a Drupal 7 environment or use my [Quickstart](http://google.com) repo for a quick and painless setup with the use of Drush to update modules.

### Permissions

So and so

### Modules

These modules are highly recommended for all projects if possible. They help with standards and they bring everything together in a way that makes development easier.

Recommended:

	Fences
		- SOMETHING ABOUT HTML5 for content type fields? ********
	HTML5 Tools
		- Google Chrome Frame
		- HTML5 doctype with or without RDF
		- Markup/form changes
		- Removes cdata tags from inline CSS & Javascript
	Magic
		- Adv. CSS Agg
		- Exclude CSS files
		- Moves Javascript to footer
		- Backport of Drupal 8 Javascript handling
		- Exclude Javascript files
		- Rebuild Theme Registry on page reload
		- Display viewport width indicator
		- Display indicator with classes applied to HTML (best with Modernizr)
		- Export theme settings
	Modernizr
		- html5shiv
		- Yepnope.js (Modernizr.load)
	Respond.js
	
Other:
	
	Dismiss
	

### Drupal Themes

##### Aurora

If you're not using my custom Quickstart theme, I'd recommend Aurora as a base theme for all your Drupal theming needs.

Credit to Snugug

- Sass 
- Compass
- Grunt
- [Toolkit](https://github.com/Team-Sass/toolkit)
- Magic
- Bower
	- Animate.css (scss)
    - Formalize
    - Normalize
    - PIE

##### Center

https://drupal.org/project/center

- settings[dev_mode] = TRUE
	- Shows comments in dev mode

### Drush

Info

## Folder Heirarchy & Structure

SMACSS or whatever:

##### Root directory

- .gitignore
- .htaccess
- Humans.txt
- php.ini with 256MB
	- php_value memory_limit = "512M"
- README.md

##### Drupal Sites directory

- libraries
- modules
	- contrib
	- custom
	- features
- patches
- themes

##### Project directory

- assets/
	- css/
	- fonts/
	- images/
	- images-min/
	- images-source/
	- js/
	- sass/
		- design/
		- global/
		- layout/
		- style.scss
	- vendor/
		- formalize
		- normalize
		- animate.css (scss)	
- templates/
	- system/
		- html.tpl.php
		- page.footer.inc
		- page.header.inc
		- page.tpl.php
- .bowerrc
- .editorconfig
- .gitignore
- .jshintrc
- composer.json
- package.json
- bower.json
- .ruby-version (rvm and rbenv)
- .ruby-gemset (rvm only)
- Gruntfile.js
- Guardfile
- config.rb (needed with bower?)
- gemfile
- gemfile.lock
- favicon.ico
- screenshot.png
- apple-touch-icon-precomposed-114x114.png
- apple-touch-icon-precomposed-144x144.png
- apple-touch-icon-precomposed-72x72.png
- apple-touch-icon-precomposed.png
- libraries.make ?
- project.info
- template.php

## LESS

CSS preprocessors are becoming quite popular, the most popular processors are [LESS](http://lesscss.org/) and [SASS](http://sass-lang.com). Preprocessing is a lot like compiling code for CSS. It allows you to reuse CSS in many different ways. Let's start out with using LESS as a basic preprocessor, it's used by a lot of popular CSS frameworks like [Bootstrap](http://getbootstrap.com/).

##### Install

To install LESS you have to use NPM / Node, which you installed earlier using Homebrew. In the terminal use:

    $ npm install less --global

Note: the `--global` flag is optional but it prevents having to mess around with file paths. You can install without the flag, just know what you're doing.

You can check that it installed properly by using:

    $ lessc --version

This should output some information about the compiler:

    lessc 1.5.1 (LESS Compiler) [JavaScript]

Okay, LESS is installed and running. Great!

##### Usage

There's a lot of different ways to use LESS. Generally I use it to compile my stylesheet locally. You can do that by using this command in the terminal:

    $ lessc template.less template.css

The two options are the "input" and "output" files for the compiler. The command looks in the current directory for the LESS stylesheet, compiles it, and outputs it to the second file in the same directory. You can add in paths to keep your project files organized:

    $ lessc less/template.less css/template.css

Read more about LESS on their page here: http://lesscss.org/

---

# Development Environment Setup

Coming soon.

## Hostgator

Coming soon.

## OpenShift

Coming soon.

---

# Mac OS X Apps

Development and design apps that you'll want to download and install.

- **Browsers**
	- Chrome
	- Firefox
		- Firebug [website](https://getfirebug.com/downloads)
		- FireSass [website](https://addons.mozilla.org/en-US/firefox/addon/firesass-for-firebug)
		- Pearl Crescent Page Saver [website](https://addons.mozilla.org/en-US/firefox/addon/pagesaver)
- **Development**	
	- Alfred
	- CodeBox
	- CodeKit
	- Colors
	- Dash
	- Github
	- Gradient
	- MAMP PRO
	- Mou
	- Sequel Pro
	- SourceTree
	- SpeedLimit
	- Sublime Text 3
	- Transmit
	- Versions
	- VMware Fusion
		- modern.IE [website](http://www.modern.ie/en-us/virtualization-tools#downloads)
- **Design**
	- Adobe Suite
	- Icon Slate
	- Pixelmator
	- Sketch
	- Slicy
- **Dashboard Widgets**
	- Git Commands
	- PHP Function Reference (PHPfr)
	- Tick

---

# Coming Soon 

##### MySQL + Sequel Pro

MySQL socket errors with MAMP (also applies to Drush)

"Can’t connect to local MySQL server through socket /tmp/mysql.sock"

	$ ln -s /Applications/MAMP/tmp/mysql/mysql.sock /tmp/mysql.sock

##### Composer?

Blah

---

# Extras

##### Favicons

- Favicons: https://github.com/audreyr/favicon-cheat-sheet
- Favico.js: http://lab.ejci.net/favico.js/

##### Needs

	http://sonspring.com/journal/html5-in-drupal-7
	- template.php pruning
	- minification
	- etc

- Selectivizr.js?
- CSS3 Media Queries JS?
- Respond.js?
- CSS3 PIE? (Compass?)
- HTML5 shiv?

##### CSS Animations

- Animate.css: http://daneden.me/animate/
- CSS3 Animation Cheat Sheet: http://www.justinaguilar.com/animations/index.html