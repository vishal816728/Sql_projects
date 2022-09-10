use MyDB
Go
--Library Management System
--An Online library  who has millions of books in order to maintain their data they use database

-- creating the for the Readers 

create table Reader(
  reader_id int Primary key,
  first_name varchar(100),
  middle_name varchar(100),
  last_name varchar(100),
  city varchar(50),
  Mobile char(10),
  occupation varchar(25),
  DOB Date, 
  );


insert into Reader values(1001,'Ramesh','chandra','sharma','Mumbai','5251624612','student','1999-12-06')

insert into Reader values(1002,'suresh','chandra','sharma','varanshi','5251624612','student','1999-12-06')
insert into Reader values(1003,'mahesh','chandra','sharma','kanpur','5251624612','student','1999-12-06')
insert into Reader values(1004,'Ram','singh','dinkar','lucknow','5251624612','student','1999-12-06')
insert into Reader values(1005,'ravi','kumar','ranjan','akbarpur','5251624612','student','1999-12-06')
insert into Reader values(1006,'nishant',null,'choudhary','vijay nagar','5251624612','student','1999-12-06')
insert into Reader values(1007,'Guru',null,'pandey','mysore','5251624612','student','1999-12-06')
insert into Reader values(1008,'shakti',null,'kapoor','Akbarpur','5251624612','student','1999-12-06')
insert into Reader values(1009,'Vinay','pratap','sharma','Goa','5251624612','student','1999-12-06')
insert into Reader values(1010,'john','c.','abrahm','Mumbai','5251624612','student','1999-12-06')
insert into Reader values(1011,'Vaishali',null,'kharbanda','kanpur','5251624612','student','1999-12-06')
insert into Reader values(1012,'yamini',null,'bajpeyi','Bareli','5251624612','student','1999-12-06')
insert into Reader values(1013,'Amit','s.','chaurasiya','Allahabad','5251624612','student','1999-12-06')
insert into Reader values(1014,'cloe',null,'field','Mumbai','5251624612','student','1999-12-06')
insert into Reader values(1015,'Radeesh','RD','sharma','Ahamdabad','5251624612','student','1999-12-06')
insert into Reader values(1016,'Satyam','kumar','verma','lucknow','5251624612','student','1999-12-06')

select * from dbo.Reader

 
 --creating the book table
   -- bid means book id
 create table Book(
      bid int primary key,
	  biddername varchar(255),
	  bookcategory varchar(100)
 )

 insert into Book values(10001,'The cat in the Hat','Story')
 insert into Book values(10005,'Learn Sql Hands-on','Programming')
 insert into Book values(20007,'JavaScript for Beginners','Programming')
 
 --altering the biddername to bookname
exec sp_rename 'Book.biddername','BookName','column';
exec sp_rename 'Book.bid','BookId','column';
 select * from Book



 -- creating the table active-readers

 create table active_readers(
    account_id int primary key,
	reader_id int,
	BookId int,
	Active_type varchar(10),
	Active_status varchar(10),
	foreign key(reader_id) references Reader(reader_id),
	foreign key(BookId) references Book(BookId) 
 )

 select * from active_readers


 insert into active_readers values(101,1014,10001,'Regular','Active')
 insert into active_readers values(104,1004,10005,'Premium','Active')
 insert into active_readers values(105,1003,10005,'Regular','Active')
 insert into active_readers values(106,1006,10001,'Regular','Suspended')

 select * from active_readers

 -- creating a table to issue a book

 create table bookissue_details(
           issueNumber int primary key,
		   account_id int,
		   BookId int,
		   Bookname varchar(255),
		   number_of_books_issued int,
		   foreign key (account_id) references active_readers(account_id)
 )

 insert into bookissue_details values(301,104,10005,'Learn Sql Hands-on',1)
 insert into bookissue_details values(302,101,10001,'The cat in the Hat',1)
 insert into bookissue_details values(303,105,10005,'Learn Sql Hands-on',1)
 insert into bookissue_details values(304,106,10001,'The cat in the Hat',0)

 select * from bookissue_details

 select * from active_readers

 select * from active_readers where Active_status='Active'
 select count(account_id) as totalNumberofReaders from active_readers where Active_type='Regular'

 select bd.issueNumber,bd.account_id,bd.BookId,bd.Bookname,bd.number_of_books_issued,ar.reader_id,rd.first_name,rd.last_name from bookissue_details bd
 inner join active_readers ar
 on(bd.account_id=ar.account_id)
 inner join Reader rd
 on(ar.reader_id=rd.reader_id)
 where number_of_books_issued>0