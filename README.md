This project is a Bash script that I created to migrate data from the old system to the new Netbox system. 
The database migration did not work for me, so I thought it would be easier to retrieve the devices and other information using the API and create them in the new system using the API as well.

Please create a file "variablen.sh" with the following variables:

# Api-Token and URL from Source-Netbox
## token_source=
## url_source=

# Api-Token and URL from Destination-Netbox
## token_dest=
## url_dest=