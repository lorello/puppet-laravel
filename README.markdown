####Table of Contents

1. [Overview](#overview)
2. [Module Description - What the module does and why it is useful](#module-description)
3. [Setup - The basics of getting started with laravel](#setup)
    * [What laravel affects](#what-laravel-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with laravel](#beginning-with-laravel)
4. [Usage - Configuration options and additional functionality](#usage)
5. [Reference - An under-the-hood peek at what the module is doing and how](#reference)
5. [Limitations - OS compatibility, etc.](#limitations)
6. [Development - Guide for contributing to the module](#development)

##Overview

The module install and manage any app developed with the PHP Framework Laravel.
It does not setup the Lamp stack for you, it simply get the code, set
directory permissions, run composer, migrate, etc... to get the app running
and if needed and wanted get it updated.

It's known to work on Puppet >= 2.7 and <= 3.6.

##Module Description

The module has been developed with profiles&roles approach in mind:
the module take care of configuring the app and aims to be independent from the
technology stack you choose: you could have a classic LAMP profile or use Nginx
and MariaDB without the need to modify this application module.

The module checkout the code using VCSRepo PuppetLabs module, then it ensure
that all directories needed for Laravel have the right permissions.

The first time the App is installed, the module run a sequence of command
to bootstrap code&database:

    $ composer install
    # foreach module that has a `migrations` directory:
    $ php migrate --package=AUTHOR/MODULE
    $ php migrate
    $ php seed

On each code update, the command executed are instead

    $ composer update
    # foreach module that has a `migrations` directory:
    $ php migrate --package=AUTHOR/MODULE
    $ php migrate

##Setup

###What laravel affects

The define `app` take a path as parameter: all changes made from the module
are inside this path.  

###Setup Requirements **OPTIONAL**

A complete setup requires you to install a webserver and a database server.

###Beginning with laravel

Create a define for your app with the only two needed parameters:
```ruby
laravel::app { 'laravel.example.com':
  app_key     => '12345678901234567890123456789012',
  source      => 'https://github.com/davzie/laravel-bootstrap',
}
```

##Usage

Put the classes, types, and resources for customizing, configuring, and doing the fancy stuff with your module here.

##Reference

  * `class laravel`: empty class, not used.
  * `define laravel::app` the define that do the work

##Limitations

The module is tested under Ubuntu 12.04, but it use very basic resources from OS
so it probably runs under other OS without any change, feel free to do a PR
if something is needed to support your preferred OS.
