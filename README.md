# INCEPTION-NEW

# WordPress LEMP Stack with Docker

This project sets up a WordPress website using a LEMP (Linux, Nginx, MariaDB, PHP) stack with Docker.

## Project Structure
```
srcs/
├── docker-compose.yml
├── requirements/
│   ├── mariadb/
│   │   ├── dockerfile
│   │   └── tools/
│   │       ├── conf/
│   │       │   ├── 50-server.cnf
│   │       │   └── my.cnf
│   │       └── setup_mariadb.sh
│   ├── nginx/
│   │   ├── dockerfile
│   │   └── tools/
│   │       ├── conf/
│   │       │   └── default
│   │       └── setup_nginx.sh
│   ├── wordpress/
│   │   ├── dockerfile
│   │   └── tools/
│   │       └── setup_wordpress.sh
│   └── Data/
│       └── [MariaDB data files]
└── srcs/
└── [WordPress core files]
```

## Service Descriptions

### 1. Nginx

- Based on Debian Bullseye
- SSL/TLS support
- Proxies PHP-FPM requests to WordPress
- Redirects HTTP to HTTPS

### 2. MariaDB

- Based on Debian Bullseye
- Custom configurations (/etc/mysql/my.cnf, /etc/mysql/mariadb.conf.d/50-server.cnf)
- Database initialization script included

### 3. WordPress

- Based on Debian Bullseye
- PHP 7.4 with necessary extensions
- Includes WP-CLI
- Automatic WordPress installation and configuration script

## Environment Variables

Create a `.env` file in the project root and set the following variables:

DB_NAME=wordpress
DB_USER=your_db_user
DB_PASSWORD=your_db_password
DB_ROOT_PASSWORD=your_root_password
WORDPRESS_URL=https://your-domain.com
WORDPRESS_ADMIN_USER=admin
WORDPRESS_ADMIN_PASSWORD=admin_password
WORDPRESS_ADMIN_EMAIL=admin@example.com
WORDPRESS_USER=user
WORDPRESS_USER_PASSWORD=user_password

## How to Run

This project uses a Makefile to simplify Docker operations. Here are the available commands:

0. **You will need to modify the volumes device path in the dockercompos.yml file to suit your directory path**
```	
volumes:
  server:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /Users/seodong-gyun/42/inception-new/srcs/requirements/srcs
  db_data:
    driver: local
    driver_opts:
      type: none
      o: bind
      device: /Users/seodong-gyun/42/inception-new/srcs/requirements/Data
```	

1. Navigate to the project directory.

2. Create the `.env` file in the `srcs` directory and set the required environment variables.

3. Use the following Makefile commands as needed:

   - Build and start all services:
     ```
     make all
     ```

   - Build the Docker images:
     ```
     make build
     ```

   - Start the services:
     ```
     make up
     ```

   - Stop the services:
     ```
     make down
     ```

   - Stop services and remove containers:
     ```
     make clean
     ```

   - Stop services, remove containers, volumes, and images:
     ```
     make fclean
     ```

   - Rebuild and restart all services:
     ```
     make re
     ```

4. Access the WordPress site in your browser using the domain you've configured in the Nginx settings.

Note: The Makefile assumes that the `docker-compose.yml` file is located in the `./srcs/` directory. If your file structure is different, you may need to adjust the paths in the Makefile.

## Makefile Contents

For reference, here's the content of the Makefile:

```makefile
all:
	make up
build:
	docker-compose build -f ./srcs/docker-compose.yml
up:
	docker-compose -f ./srcs/docker-compose.yml up -d
down:
	docker-compose down -f ./srcs/docker-compose.yml
clean:
	docker-compose -f ./srcs/docker-compose.yml down
	docker volume rm $$(docker volume ls -q) || true
fclean:
	docker-compose -f ./srcs/docker-compose.yml down
	docker volume rm $$(docker volume ls -q) || true
	docker image rm $$(docker images -aq) || true
re:
	make fclean
	make all
.PHONY : all build up down clean fclean re
```

## Important Notes

- This setup is intended for development environments. Additional security measures are needed for production use.
- The SSL certificate used is self-signed, which may trigger security warnings in browsers.
- To use a custom domain, modify the `server_name` directive in the Nginx configuration file (`requirements/nginx/tools/conf/default`).

## Troubleshooting

- View logs: `docker-compose logs [service_name]`
- Access a container: `docker exec -it [container_name] /bin/bash`
- Check WordPress setup issues: `/var/www/html/wordpress/error/log.txt`
- Investigate MariaDB problems: `/data/mysql/log.txt`

## Script Details

### MariaDB Setup (`setup_mariadb.sh`)

This script initializes the MariaDB database. It:
- Starts the MariaDB service
- Creates the WordPress database if it doesn't exist
- Sets up the database user and grants necessary privileges
- Secures the root user

### Nginx Setup (`setup_nginx.sh`)

The Nginx setup script:
- Generates a self-signed SSL certificate
- Configures Nginx to use SSL/TLS
- Sets up server blocks for HTTP to HTTPS redirection

### WordPress Setup (`setup_wordpress.sh`)

This script automates WordPress installation:
- Waits for the MariaDB service to be ready
- Downloads and configures WordPress using WP-CLI
- Creates the initial admin user and an additional user
- Verifies the WordPress configuration against environment variables

## Customizing the Domain

To use your own domain:
1. Open `requirements/nginx/tools/conf/default`
2. Locate the `server_name` directive
3. Replace the existing domain with your desired domain
4. Rebuild and restart the containers
