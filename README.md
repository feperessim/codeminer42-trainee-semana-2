# codeminer42-trainee-semana-2

## Table of Contents
* [General info](#general-info)
* [Technologies](#technologies)
* [Setup](#setup)
* [Using and testing](#using-and-testing)

## General info

The aim of this repository is to track the codeminer42's week 2 challenges.


## Technologies

The project was created with the following technologies:

* Ruby Version Manager (RVM): rvm 1.29.12
* Ruby Interpreter: ruby 3.1.0p0
* Bundle: Bundler 2.3.5
* Rspec: RSpec 3.10
	- rspec-core 3.10.1
	- rspec-expectations 3.10.2
	- rspec-mocks 3.10.2
	- rspec-support 3.10.3


## Setup
To run this project you need to follow the following instructions:

### 1. Setting up the project locally
1. Clone the repository locally;
2. Navigate into the newly cloned repo and create a new directory named "games_logs_files"
3. Download the file "games.log" into the newly created folder "games_logs_files".

#### 1.1. Instructions:
```console
foo@bar:~$ git clone https://github.com/feperessim/codeminer42-trainee-semana-2.git
foo@bar:~$ cd codeminer42-trainee-semana-2/
foo@bar:~$ mkdir games_logs_files
foo@bar:~$ cd games_logs_files
foo@bar:~$ curl https://gist.githubusercontent.com/fabiosammy/ba973184e82e930043df8d4aa002bde4/raw/220e137b2aeffd01d062d1b575e9e6e8a24b410c/games.log -o games.log
foo@bar:~$ cd ..
```

### 2. Installing dependencies
1. Install the Ruby Version Manager (RVM) version >= 1.29.12;
2. Install  Ruby Interpreter: ruby 3.1.0p0  with the RVM;
3. Configure the command interpreter for recognizing the ruby install
4. Install the dependency manager Bundle;
5. Install the rspec dependency with Bundle.

##### 2.1. Instructions for installing Ruby Version Manager RVM
* 2.1.1.  Install GPG keys: 
```console
foo@bar:~$ gpg2 --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
```

* 2.1.2.   Install RVM: 
```console
foo@bar:~$ \curl -sSL https://get.rvm.io | bash -s stable
```
* 2.1.3. Troubleshooting and further informations
For Troubleshooting and further informations see: https://rvm.io/ 



##### 2. Instructions for installing Ruby Interpreter Version 3.1.0

* 2.1.  Install Ruby 3.1.0 
```console
foo@bar:~$ rvm install ruby 3.1.0
foo@bar:~$ rvm use 3.1.0
```

##### 3. Instructions for configure the command interpreter
###### 3.1 Bash users
* 3.1.1 Add the following lines to your ".bashrc" config file:

```bash
export PATH="$PATH:$HOME/.rvm/bin"                                                                                                                                                                                 
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"                                                                                                                                               
```
##### 4. Install the dependency manager Bundle;
* 4.1. Install Bundler 

```console
foo@bar:~$ gem install bundler
```

##### 5. Install the rspec dependency with Bundle.
* 5.1. Install the dependencies with bundler

```console
foo@bar:~$ bundler install
```

## Using and testing
* 1. Running the task 1 main file 

```console
foo@bar:~$ ruby main.rb
  0:00 ------------------------------------------------------------
```

* 2. Running rspec
```console
foo@bar:~$ bundle exec rspec
```
or

```console
foo@bar:~$ rspec --format documentation
```
