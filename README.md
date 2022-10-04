# Project overview
This project is being developed to monitor the parameters of the Magnetic Resonance Imaging (MRI) Pump, which is used as the cooling system to the MRI machine.

The cooling system is one of the critical systems of MRI, so it becomes necessary to monitor the functioning(i.e. parameters) of Pump.

Pressure, temperature, noise, and vibration of the pump are the assessment parameters, and they are been measured periodically with the help of raspberry pi kits.

• Our project aim is to send the relevant data(parameters), measured at each MRI Pump to a central storage location.

• Depending on data received and send out alerts to corresponding and responsible persons.

• Providing a functionality to pull the data from the selected MRI when required.

• Provide an interface to visualize and analyze the data.

* [MySql database installation with workbench](https://gitlab.com/rapuru/mripumpmonitoring/wikis/Database-installation-and-set-up)
* [Project-architecture](https://gitlab.com/rapuru/mripumpmonitoring/wikis/Project-architecture)
* [Database details](https://gitlab.com/rapuru/mripumpmonitoring/wikis/database-details)
* [Python file details](https://gitlab.com/rapuru/mripumpmonitoring/wikis/python-file-details)
* [Raspberry pi set up](https://gitlab.com/rapuru/mripumpmonitoring/wikis/raspberry-pi-set-up)

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

