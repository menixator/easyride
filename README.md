# EasyRide

EasyRide is a Java EE web application made as part of UFCF85-30-3 Enterprise Systems Development.

## Setup
- Create Derby database.
- Plug in the correct configuration into `/src/main/java/com/easyride/dao/BaseDao.java.`
- Run `migrations.sql` in the database.
- By default, these three users will be created:
    - Username: `admin@easyride` password: `admin`
    - Username: `driver@easyride` password: `driver`
    - Username: `customer@easyride` password: `customer`
- Run the application

The code is hosted at [https://github.com/menixator/easyride](https://github.com/menixator/easyride)