# LOCAL DEV DOCKER INFO

####WARNING:
If working on **Windows** make sure to use **Docker for Windows with WSL2 integration**. Keep the project files on WSL volume (\\$wsl\[DISTRO_NAME]\[PROJECT_PATH])

### Git submodule add instructions for existing project: ####
1. Go to docker folder (f.e. ./docker/)
2. Fire submodule add command in docker folder
   `git submodule add git@github.com:papablack/docker-boilerplate.git <submodule path>`
   submodule path is f.e "dev" if you want docker in docker/dev

### Git submodule install instructions for existing project: ####
1. Fire submodule update command
   `git submodule update --init --recursive`

### Local setup instructions: ####
1. Navigate to docker folder
	`cd /docker/*`
2. Run
   `cp .env.dist .env` then edit .env with your preferred settings
3. Run if network is not created prior to your build
	`docker network create main_network`
4. Run
   `docker-compose up`
5. Setup your hosts file to move domain set in .env (default: **dev.app**) 

### Good practices

There are install.sh files in docker services.
Those were created to handle WSL and other virtual machines folder sync order situations.
F.e.: In WSL docker had access to sync project folder only after running entrypoints. Thus install.sh was created.

Every `docker-compose up --build` will rebuild system but there are some resources that should persist such operations
like **database, ssl keys or dependency installs**

If you ever need full container rebuild please delete proper install check file from **Docker-DEV/_config**

It can also be removed to repeat install process with just docker-compose up. Notice that your entrypoint and install file will not change in container without `docker-compose up --build`
