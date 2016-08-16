# RTView MySQL Integration in Docker

##Background
RTView-MySQL integration in Docker helps achieve the following goal: 
* Provide users with a pre-configured MySQL database instance to be used with RTView. 
* Allows RTView to use the MySQL instance as a data store for historical analysis. 

##Pre-requisites
* Install the Docker Engine (Docker Version 1.11) on the Server (Oracle Linux 7) where you would run the remote MySQL instance. 
* Ensure to update YUM and have the UEK4 (Unbreakable Enterprise Kernal 4) in the Linux server. 
* In the Client side, where you would run RTView, install Java version 1.5 and the RTView software. 

##Steps to Install and Run MySQL Database Instance in Docker

###Step 1: Start the Docker Engine using the following command. 
*sudo start docker*
###Step 2: Copy the MySQL Docker file and the relevant configuration files to the Linux server.
	Dockerfile, run.sh, my.cnf
###Step 3: Create a new directory in the server /opt/DATA with write permission. 
*mkdir /opt/DATA*
###Step 4: Build Docker image from the files copied over in step #1
*docker build -t mysql-rtview .*
	
	You will see a message, "Successfully build..." when the image is built without any errors. 
###Step 5: Confirm if the image is indeed built by running: 
*docker images*
	
	You will see the image created with the name "mysql-rtview"
###Step 6: Run the Docker image with the MySQL instance as follows:
*docker run -d --name=MYSQL -p 3306:3306 -v /opt/DATA/MYSQL:/var/lib/mysql  mysql-rtview*
	
	name - name of the MySQL instance
	p - Port number used by the MySQL insance
	v - Data directory
	
	You will see an alpha numeric string printing out if the run command is successful. 
###Step 7: Confirm if the MySQL instance started by the above step is running
*docker ps -a*
	
	You will see your MySQL instance listed as 'mysql-rtview'
##Using the MySQL Instance for RTView History
* Ensure to have the JDBC driver for the MySQL database is installed in your client machine and it is available in the RTView class path. 

   (JDBC driver versions tested: mysql-connector-java-5.1.39 and mysql-connector-java-5.1.38) 

* Configure a new SQL database connection to MySQL instance in RTView Builder. You need the correct inputs for the following connection parameters. 
	* Database name
	* User name
	* Password	
	* JDBC URL
	* JDBC driver name
* Create a sample display that connects to the remote MySQL instance on docker using SQL data attachment in Builder. This is to verify if the Builder is able to talk to the remote MySQL instance. 
* Configure the RTView historian to use the remote MySQL instance. 
*historian.sl.rtview.historian.driver=com.mysql.jdbc.Driver*
*historian.sl.rtview.historian.url=jdbc:mysql://192.0.0.0:3306/RTVHISTORY*
*historian.sl.rtview.historian.username=root*
*historian.sl.rtview.historian.password=my-secret-pw*

* Start the data server and the historian
* Check the historian logs to see if the data is being written to the remote MySQL database instance. 

##How to Run a MySQL client application in Docker
* You can start one or many MySQL client applications in docker. 
	*docker run -it --name=MYSQL-CLIENT  mysql-rtview mysql -u root -h 192.0.0.0 –P 3306 –p*
* After starting the client application you will be asked to enter the password for the MySQL instance in an interactive manner. 
	Enter password: my-secret-pw
* You can run the following MySQL commands directly against the MySQL database instance from the console. A few examples below: 
	* show databases; (lists all available databases)
	* use RTVHISTORY; (choose the database RTVHISTORY)
	* show tables;	(shows all tables in the selected database)

##Files in the Repository
###Dockerfile
Docker image for MySQL database
###my.cnf
Contains configuration information about your MySQL instance
###run.sh
Run script
	
##Resources
* Download RTView: http://sl.com/evaluation-request/
* Download Docker Engine: https://docs.docker.com/engine/installation/
* Documentation on RTView Historian: http://sldownloads.sl.com/docs/rtview/670/CORE/Historian/Historian.htm
