# SQL Server Reporting Services in Docker

creates a fresh install of SSRS in a container - pretty useful for dev / test - not for production use!

https://hub.docker.com/r/phola/ssrs

## Run it

This sample is uses mssql-server-windows-developer as a parent image and accepts all the commands listed there:

https://github.com/Microsoft/mssql-docker/tree/master/windows/mssql-server-windows-developer

In addtion it accepts two more env variables: </br>

- **ssrs_user**: Name of a new admin user that will be created to login to report server
- **ssrs_password**: Sets the password for the admin user

example:

```
docker run -d -p 1433:1433 -p 80:80 -v C:/temp/:C:/temp/ -e sa_password=<YOUR SA PASSWORD> -e ACCEPT_EULA=Y -e ssrs_user=SSRSAdmin -e ssrs_password=<YOUR SSRSAdmin PASSWORD> --memory 6048mb phola/ssrs
```

then access SSRS at http://localhost/reports and login using ssrs_user

## Tips

- **-p 80:80** to access report manager in browser
- **--memory 6048mb** to bump RAM

## Disclaimers

SSRS is defintely not supported in containers..

## Credits

- [Complete automated configuration of SQL Server 2017 Reporting Services - Sven Aelterman](https://svenaelterman.wordpress.com/2018/01/03/complete-automated-configuration-of-sql-server-2017-reporting-services/)

## License

MIT license. See the [LICENSE file](LICENSE) for more details.
