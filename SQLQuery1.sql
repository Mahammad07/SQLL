create database kitabxanaa

use kitabxanaa

create table Bookss 
	(Id int primary key identity,
	Name nvarchar(20),
	PageCount int
	)

create table Authorss
	(Id int primary key identity,
	Name nvarchar(20),
	Surname nvarchar(20)
	)

alter table Bookss
add AuthorsId int constraint CK_AI references Authorss(Id)

create view usv_GetAlInfo
as
select b.Id,b.Name,b.PageCount, (a.Name+' '+a.Surname) 'AauthorFullname' from Bookss b
join Authorss a
On b.AuthorsId=a.Id

select * from usv_GetAlInfo

create procedure usp_GetAllInfoByName
@CheckName nvarchar(20)
as
begin
select b.Id,b.Name,b.PageCount, (a.Name+' '+a.Surname) 'AauthorFullname' from Bookss b
join Authorss a
On b.AuthorsId=a.Id
where b.Name=@CheckName
end

exec usp_GetAllInfoByName 'Sefiller'

create view usv_GetALLInfooAboutAuthors
as
select a.Id,(a.Name+'  '+a.Surname) 'AuthorsFullname',count(b.Name) 'BookCount',sum(b.PageCount)'MaxPageCount' from Authorss a
join Bookss b
On a.Id= b.AuthorsId
group by a.Name


select* from usv_GetALLInfooAboutAuthors







