# Installing MySQL with Docker
[MY NOTES, not included in Traversy course]

## Install  Docker Desktop
To install MySQL using Docker, you need to have Docker installed on your machine. If you don't have Docker installed, you can download it from the [Docker website](https://www.docker.com/get-started).

## Pull MySQL Docker Image
Once you have Docker installed, you can pull the MySQL Docker image from Docker Hub. 
- SEE: https://hub.docker.com/_/mysql
- Start Docker Desktop if it's not already running.
- Open your terminal and run the following command:
```bash
docker pull mysql:latest
```
This will download the latest MySQL image.

## Run MySQL Container
After pulling the image, you can run a MySQL container using the following command:
```bash
docker run --name mysql-container -e MYSQL_ROOT_PASSWORD=Axml-xsl0123 -p 3306:3306 -d mysql:latest
```
Replace `yourpassword` with a secure password of your choice. This command does the following:
- `--name mysql-container`: Names the container `mysql-container`.
- `-e MYSQL_ROOT_PASSWORD=Axml-xsl0123`: Sets the root password for MySQL.
- `-p 3306:3306`: Maps port 3306 of the container to port 3306 on your host machine.
- `-d`: Runs the container in detached mode.
- `mysql:latest`: Specifies the image to use.

## Verify MySQL Container is Running
You can verify that the MySQL container is running by executing the following command:
```bash
docker ps
```
You should see your MySQL container listed. 


## Download MySQL Workbench
See mysql/05-mysql-workbench.md

## Connect to MySQL
You can connect to the MySQL server running in the Docker container using the MySQL client. If you have MySQL installed on your host machine, you can use the following command:
```bash
mysql -h 127.0.0.1 -P 3306 -u root -p
```