# Summary

* [Introduction](https://github.com/Kirity/mri-pump-monitoring/blob/master/README.md#introduction)
* [Goals of the project](https://github.com/Kirity/mri-pump-monitoring/blob/master/README.md#goals-of-the-project)
* [MySql database installation with workbench](https://github.com/Kirity/mri-pump-monitoring/blob/master/README.md#mysql-database-installation-with-workbench)
* [Project architecture](https://github.com/Kirity/mri-pump-monitoring/blob/master/README.md#project-architecture)
* [Database details](https://github.com/Kirity/mri-pump-monitoring/blob/master/README.md#database-details)
* [Python file details](https://github.com/Kirity/mri-pump-monitoring/blob/master/README.md#python-file-details)
* [Raspberry pi set up](https://github.com/Kirity/mri-pump-monitoring/blob/master/README.md#raspberry-pi-set-up)

# Introduction

This project is being developed to monitor the parameters of the Magnetic Resonance Imaging (MRI) Pump, which is used as the cooling system to the MRI machine.

The cooling system is one of the critical systems of MRI, so it becomes necessary to monitor the functioning(i.e. parameters) of Pump.

Pressure, temperature, noise, and vibration of the pump are the assessment parameters, and they are been measured periodically with the help of raspberry pi kits.

# Goals of the project

1. To send the relevant data(parameters), measured at each MRI Pump to a central storage location.

2. Depending on data received and send out alerts to corresponding and responsible persons.

3. Providing a functionality to pull the data from the selected MRI when required.

4. Provide an interface to visualize and analyze the data.

# MySql database installation with workbench

Here MySql is the database used in this project. Workbench is also installed with database, so that, it is convenient for writing queries and administration.

* https://www.youtube.com/watch?v=aY6LiTbfckA (visited on 17-May-2017) use this link to see the installation help or please refer the video given named " How to Setup MySQL Workbench.mp4"

* Note down the "TCP/IP" Port Number. By default it will take 3306 and let it be, unless there is another process using this already. This can be seen as below

![image](https://user-images.githubusercontent.com/15073157/193932970-e30c47e2-00ed-4cd9-9b80-cc975748cdf9.png)


* Make sure you make note of it or remember the "Root Password"

![image](https://user-images.githubusercontent.com/15073157/193933010-ca0dc456-a06e-4137-a020-7cb508307e19.png)

## Creation of new schema

* Open the MySql workbench → give the password, which is set for root user
* It looks as below screen shot

![image](https://user-images.githubusercontent.com/15073157/193933042-8db60bdb-8b21-461a-87a8-4913ac8c4704.png)


* Click on the ![image](https://user-images.githubusercontent.com/15073157/193933072-6ab46166-a326-43c9-81f1-1ac136c3ee1c.png) icon which is shown in the below screen shot with arrow point to it

![image](https://user-images.githubusercontent.com/15073157/193933105-41edea5e-c2bd-4fca-b0f4-f43c388ceadc.png)

* A new page will be opened as below.
1. Field name "Name" give value as "mri".
2. Field name "Collation" let it be "Server Default"
3. Click on "Apply" button which is in bottom right corner of page
![image](https://user-images.githubusercontent.com/15073157/193933162-e2451638-545b-4bb7-9a82-9d8d72fdf0a1.png)


* Then a new pop-up page opens, as below, click on "Apply"

![image](https://user-images.githubusercontent.com/15073157/193933240-d9f14361-e1ac-4684-88d3-7819620253f5.png)


* Then again click on "Finish"

![image](https://user-images.githubusercontent.com/15073157/193933266-4f65aaf6-4bcf-49e0-a934-073b06010ba1.png)


* Then "mri" schema can be seen under section "SCHEMAS" (left pane), as shown below

![image](https://user-images.githubusercontent.com/15073157/193933298-d9cc2d4e-777c-4d86-a109-810b4bc00b8a.png)


## Import of table structures and with master data

1. Click on "Management" tab
2. Click on "Data Import/Restore"
3. Click on radio button "Import from Self-Contained File"
4. Select the " mriDBFile.sql" file given
5. In section "Default Target Schema" select "mri"
6. Click on "Start Import"

![image](https://user-images.githubusercontent.com/15073157/193933319-0b0079a5-c670-4c83-896a-80172b26269f.png)


* Then the below screen will appear

![image](https://user-images.githubusercontent.com/15073157/193933340-ba31a0ae-6edf-4bfb-b362-3d8ba9cb6f97.png)



* To confirm, that all tables are imported successfully, follow the below steps
1. Click on "Schemes"
2. Click Scheme "mri"
3. Click on Tables
A set of tables, should be displayed

![image](https://user-images.githubusercontent.com/15073157/193933369-3503f5f5-81f2-443a-807f-283136311623.png)

# Project architecture

![image](https://user-images.githubusercontent.com/15073157/193933717-17770da3-536d-4b45-9e0b-64a48106551a.png)

# Database details

Below figure represents the full database model.

![image](https://user-images.githubusercontent.com/15073157/193933881-71d42161-a727-47ab-9087-87d016e2f766.png)

# Python file details

* File name : RunningTasks.py
  * Path : [/home/pi/Documents/]MRI/code/RunningTasks.py
  * If there exists database connection on then, this will trigger all the execution points for the processing of measured types Temperature, Standard temperature Error, Pressure, Standard Pressure Error, Images, .wav files in the same order.
  * A file is created every time, this file has run. This file contains error message if any.
  * The new few file is the feed for table JobRunHistory
  * If there exists internet connection, a status mail will be sent and alert mails if any

* File name : TemperatureReading.py
 * Path : [/home/pi/Documents/]MRI/code/programms/TemperatureReading.py
 * Reads each temperature log file at a time from the provided path and save details of each file at a time into database.
 * In case of any error, the respective file will be move to error folder with actual file and anther new file with the same name and "_error" as post fix and error message in it.
 * In case of success, the file will be moved to archive folder.
 * After processing all files, a row will be inserted into table FileProcessHistory

* Files : PressureReading.py, SavingWavFiles.py, SaveTemperatureErrorLogs.py, SavePressureErrorLogs.py, ImagesReading.py

  * Path : [/home/pi/Documents/]MRI/code/programms/
  * All these files follow the same strategy of TemperatureReading.py but saving into their respective related tables.


# Raspberry pi set up

## Python Installation
* Open the terminal
*  run command "apt-get update" ( recommended but not compulsory, it may take 2-3 minutes )
*  then run command " sudo apt-get install python.pip"

## Creating the folder structure
* Create folder named "MRI", which will contain programs and log files, which will be generated
In development set up it looks as below
~[home/pi/Documents]/MRI
[path] is optional can be varied

* Put all the code given into MRI folder

## Update the config.cfg file

* Open config.cfg file, which is placed in [/home/pi/Documents]/MRI/code/config.cfg and update the following things with correct folder paths
o Under [code]
   * codeLoc
     o Under [LogsLocations]
   * TemperatureLogLocation
   * PressureLogLocation
   * waveFilesLocation
   * imageFilesLocation
   * outputLogLocation
   * JobHistoryLocation

* Under [MRIDetails]
   Set the value of MRI_ID corresponding to the ID to the Name column of MRILIST
   It looks as below
   MRI_ID = [xx]
   xx = some integer like 1 or 2 or 3 etc

* To change the mailing list [MailDetails] "to" can be updated Under [Database] section
     * provide the ipaddress of database for dbserverip
     * give the password for root, which was taken note in section 3.1
     * give the dbname which was created under section 3.2 which is "mri"
     * give the port number for "port", which is noted form section 3.1 Fig. Database port number

## Setting path for sensor data

Temperature, Pressure log files related to sensors should be placed in below path /home/pi/Documents/MRI/data/logs
Format and example file are placed in [/home/pi/Documents/MRI]/data/logs/archive

|Type File |name |
|----------|-----|
|Temperature|Temperature-2017-01-12-17-25.txt|
|Pressure|Pressure-2017-01-10-16-25.txt|
|Standard Temperature log|Temperature_2017-01-11 20:15:25.error|
|Standard Pressure log|Pressure_2017-01-02 01:15:10.error|

* Image Files
Any image file which needs to stored should be placed in below path
[/home/pi/Documents/MRI]/data/pics
Image file extension should be .jpg

* Sound Files or Recordings
Any sound recording should be placed in below path
[/home/pi/Documents/MRI]/data/wavefiles

## Running of application

Go to the location "[/home/pi/Documents/MRI]/code/" and run the file RunningTasks.py

* What should happen after running the RunningTasks.py ?
  * If log files i.e. .txt or .error are read successfully, they should be moved to archive folder.
  * If error, the log file and another file with the same name, will be moved to error folder.
  * Image and .wav files will be moved to archive folder
  * A file with name as date and time of run and with status id, will be created in folder "[/home/pi/Documents/MRI]/code/jobstatuslogs"
   Example : 2017-05-09 21:27:57_1.txt

  * If in config.cfg file section → [MailDetails] →to is set correctly and if there is internet connect a "Job Status" mail will be triggered. If there are any values which cross the set threshold values, the an alert mail(s) will be trigged too

## Setting up Flask : Micro-web frame work

* Flask is a micro web frame work, which is used as web server listening for web request's from outside.

*  Installation of Flask
  * Open the Terminal
  *run the command : sudo apt-get install python-pip
  * then run : sudo pip install Flask
*  Go to : "[/home/pi/Documents/MRI]/code/ and open file "flask_listener.py"
  * In line number : 15, change the path to "RunningTasks.py" to current set up

## Running and testing of flask job

* Go to : "[/home/pi/Documents/MRI]/code/ and run file "flask_listener.py". This micro web server will run on port number : 5000

If it is run form terminal, then it looks like below

![image](/uploads/c339f4e6f1a10883b9f0ace956366a2c/image.png)

* Don't close or kill the process of this. This process need to be running
In Raspberry PI or in any other system which is in the same network, open a browser and put the url http://[ip of PI]:5000/ and hit enter.
For example : http://192.168.0.2:5000/

* How to check if flask job has run successfully ?
 * In the browser a full log will be printed
 * A log file will be created in [/home/pi/Documents/]MRI/code/flaskJobLogs
 *  A mail will be trigged.

## Creating the folder structure

* Create folder named "MRI", which will contain programs and log files, which will be generated
In development set up it looks as below
~[home/pi/Documents]/MRI
[path] is optional can be varied

* Put all the code given into MRI folder

## Update the config.cfg file

* Open config.cfg file, which is placed in [/home/pi/Documents]/MRI/code/config.cfg and update the following things with correct folder paths
* Under [code]
  * codeLoc
  * Under [LogsLocations]
    * TemperatureLogLocation
    * PressureLogLocation
    * waveFilesLocation
    * imageFilesLocation
    * outputLogLocation
    * JobHistoryLocation
 *  Under [MRIDetails]
Set the value of MRI_ID corresponding to the ID to the Name column of MRILIST
It looks as below
MRI_ID = [xx]
xx = some integer like 1 or 2 or 3 etc
* To change the mailing list [MailDetails] "to" can be updated
* Under [Database] section
  * provide the ipaddress of database for dbserverip
  * give the password for root, which was taken note in section 3.1
  * give the dbname which was created under section 3.2 which is "mri"
MRI Pump Monitoring Technical Report
May 19, 2017 Page 14 o f 18
 * give the port number for "port", which is noted form section 3.1 Fig. Database port number

## Setting path for sensor data

Temperature, Pressure log files related to sensors should be placed in below path /home/pi/Documents/MRI/data/logs
Format and example file are placed in [/home/pi/Documents/MRI]/data/logs/archive

|Type|File name|
|----|---------|
|Temperature|Temperature-2017-01-12-17-25.txt|
|Pressure|Pressure-2017-01-10-16-25.txt|
|Standard Temperature log|Temperature_2017-01-11 20:15:25.error|
|Standard Pressure log|Pressure_2017-01-02 01:15:10.error|

 * Image Files
Any image file which needs to stored should be placed in below path
[/home/pi/Documents/MRI]/data/pics
Image file extension should be .jpg
*  Sound Files or Recordings
Any sound recording should be placed in below path
[/home/pi/Documents/MRI]/data/wavefiles


## Running of application

Go to the location "[/home/pi/Documents/MRI]/code/" and run the file RunningTasks.py
* What should happen after running the RunningTasks.py ?
   * If log files i.e. .txt or .error are read successfully, they should be moved to archive folder.
   * If error, the log file and another file with the same name, will be moved to error folder.
   * Image and .wav files will be moved to archive folder
   * A file with name as date and time of run and with status id, will be created in folder "[/home/pi/Documents/MRI]/code/jobstatuslogs"

    Example : 2017-05-09 21:27:57_1.txt

   * If in config.cfg file section → [MailDetails] →to is set correctly and if there is internet connect a "Job Status" mail will be triggered. If there are any values which cross the set threshold values, the an alert mail(s) will be trigged too.


## Setting up Flask : Micro-web frame work

Flask is a micro web frame work, which is used as web server listening for web request's from outside.

* Installation of Flask
  * Open the Terminal
  * run the command : sudo apt-get install python-pip
  * then run : sudo pip install Flask 

* Go to : "[/home/pi/Documents/MRI]/code/ and open file "flask_listener.py"
  *  In line number : 15, change the path to "RunningTasks.py" to current set up

## Running and testing of flask job

 * Go to : "[/home/pi/Documents/MRI]/code/ and run file "flask_listener.py". This micro web server will run on port number : 5000
If it is run form terminal, then it looks like below

![image](/uploads/dc94c5a1c13f7465450be44c9c0114a8/image.png)

* Don't close or kill the process of this. This process need to be running

 * In Raspberry PI or in any other system which is in the same network, open a browser and put   the url http://[ip of PI]:5000/ and hit enter.
For example : http://192.168.0.2:5000/

* How to check if flask job has run successfully ?

  * In the browser a full log will be printed
  * A log file will be created in [/home/pi/Documents/]MRI/code/flaskJobLogs
  * A mail will be trigged

