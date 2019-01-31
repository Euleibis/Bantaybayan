# BANTAYBAYAN
Bantaybayan is an intermediary web platform for sharing public concerns easily and directly to the government as an alternative to other ways of reaching the government through social channels. It also aims to be  a centralised repository of public concerns for the government, since it minimises the need for classifying the reports, helping improve their public delivery services.
## Screenshots
![Reporting Problems/Concerns](https://s2.gifyu.com/images/Reporting-a-problem.gif)
![Alt Text](https://s2.gifyu.com/images/Viewing-your-page-that-lists-all-the-problems-you-reported-and-filtered-by-status.gif)
![Alt Text](https://s2.gifyu.com/images/Viewing-your-posts-and-commenting-on-updates.gif)

### Installation
-Bantaybayan requires mySQL and a browser compatible with Tomcat to run. It could also run in mobile/other devices as long as it is connected to the same internet connection used by the host computer currently running the program.
-For the database columns,paste these in mySQL and run before executing the program in your host computer.
```
ALTER USER 'root'@'localhost' IDENTIFIED BY 'insert the password you set for MySQL credentials here';
/*Concerns Table*/
CREATE TABLE tblConcerns(concernID INT, username VARCHAR(12), postdate DATETIME, concernStatus VARCHAR(20), replyStatus VARCHAR(20), category VARCHAR(50), recipient VARCHAR(256), district VARCHAR(50), sub TEXT, body TEXT, attachment MEDIUMTEXT, rating INT, replyDate DATETIME);
/*Accounts Table*/
CREATE TABLE tblAccounts(accountID INT, datecreated DATETIME, accounttype VARCHAR(2), username VARCHAR(12), password VARCHAR(30), email VARCHAR(256), title VARCHAR(50));
/*Comments Table*/
CREATE TABLE tblComments(commentID INT, concernID INT, username VARCHAR(12), commentText TEXT, dateCommented DATETIME, upvotes INT, downvotes INT, title VARCHAR(50));
```
## Built With

* [Java Servlet Pages](https://docs.oracle.com/javaee/5/tutorial/doc/bnagy.html) 
* [Apache Tomcat](https://tomcat.apache.org/tomcat-7.0-doc/jndi-datasource-examples-howto.html) - required for JSP to work on browser
* [MySQL](https://getbootstrap.com/) - database for the submitted information.
* [Bootstrap](https://getbootstrap.com/) - web framework used for website design


## Contributors

* **Remer Irineo** -
* **Gershom Gruta** 
* **Gian Pangan** 


