-------------------
Description
-------------------

Under the umbrella of Data-Integration, this is a tool that deals specifically with Oracle databases. The import and export are handled by separate scripts.
This tool allows the user to import data into Thor from an Oracle DB (oracle_importer.sh) and to export data from the Thor landing zone to an Oracle DB (oracle_exporter.sh). 
Before running this tool, some software needs to be installed on the system that the scripts are being run on:

-------------------
Pre-Requisites:
-------------------

1. Install Oracle client:

https://help.ubuntu.com/community/Oracle%20Instant%20Client

is a site that has good instructions. This is to enable the use of the command line utility SQLPlus, which is used by the import script.

2. Install Oracle database:

http://www.oracle.com/technetwork/database/database-technologies/express-edition/downloads/index.html

is the official site. This is to enable the use of SQL Loader, a command line utility provided by Oracle to load data into the database from a flat file.


Note: 1) The versions of Oracle client and Oracle database need to match. There will be library troubles otherwise.
2) Remember to export the Oracle lib directory to the LD_LIBRARY_PATH. Alternatively, configure bashrc/write a module.
3) The Pre-requisites to installing Oracle are implicit. A recent Java version is required.


--------------------
Usage:
--------------------

The import utility is run with the following arguments:
./oracleloader.sh username password hostname:port serviceid tablename1,path1 tablename2,path2 ...

The export utility is run with the following arguments:
./oracle_exporter.sh filename username password hostname:port serviceid tablename

Note: The importer can bulk load any number of tables per connection into Thor, but the exporter now handles only one file -> one table.

--------------------
Troubleshooting:
--------------------

1. SQLPlus not found error:
Solution:
a) Verify installation of Oracle Client, if necessary reinstall.
b) Add the ORA_HOME/lib directory to LD_LIBRARY_PATH or your bashrc, where ORA_HOME is the location of your local Oracle Client installation.
/usr/lib/oracle/12.1/client64/lib is the lib directory of my installed Oracle Client.

2. Known-hosts prompt during the first use of script to access HPCC.
Continue to add the HPCC key to your known-hosts file.
Problems related to scp can mostly be solved by truncating the known-hosts file and adding the key afresh, when prompted the next time.

-------------------
Miscellanea:
-------------------

These scripts can be used from within ECL code by invoking the std package to run a command line script. This allows for tighter integration of the extractor, transformer and loader.

At this point, this utility requires user intervention at the following places :
a) Specifying a record structure for newly imported tables into Thor.
b) Specifying a table structure for the exported data in Oracle db, using ctl files.
This can be avoided, by mapping the ECL datatypes to Oracle datatypes, using Hibernate. This would enable the script to be smart enough to figure out that a varchar(x) in Oracle can be interpreted as a STRINGx in ECL. In turn, the script can be used end to end without any user intervention, except the user provided ECL-transform code, and the connection params to Oracle db.

SQL Loader allows the load of .zip files into Oracle db, and going forward, this tool (oracle_exporter.sh) could be enhanced to support this facility in order to save space / be utilized for very large datasets.





