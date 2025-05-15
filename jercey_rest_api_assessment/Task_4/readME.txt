Please use your port number in the URL's (replace 8087 with your port number). 
use below URL's after started your tomcat server. 

go to \jercey_rest_api_assessment\Task_4\rest_filter_api\src\main\java\com\praveen\util\DbConnection.java

replace 5432 to your port number and replace hello with your db name. reference given in the below line

jdbc:postgresql://localhost:5432/hello

1. http://localhost:8087/helloApp/webresources/users/filter_user?name=a
2. http://localhost:8087/helloApp/webresources/users/filter_user?name=praveen
3. http://localhost:8087/helloApp/webresources/users/filter_user?country=india
4. http://localhost:8087/helloApp/webresources/users/filter_user?name=a&country=india