/* Used MS-SQL 2019 Express version */
/* 1. Create tables */ 
CREATE TABLE [dbo].[User Header](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[first_name] [varchar](max) NULL,
	[last_name] [varchar](max) NOT NULL,
	[city] [varchar](max) NOT NULL,
	[zipcode] [varchar](max) NOT NULL,
 CONSTRAINT [PK_User Header] PRIMARY KEY CLUSTERED 
( [id] ASC)
)

CREATE TABLE [dbo].[User Password History](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[password] [varchar](max) NOT NULL,
	[change_date] [datetime] DEFAULT (getdate()) NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_User Password] PRIMARY KEY CLUSTERED 
([id] ASC)
)

/* 2. Create a foreign key constraint */
ALTER TABLE [dbo].[User Password History]  WITH CHECK ADD  CONSTRAINT [FK_User Password History_User Header] FOREIGN KEY([user_id])
REFERENCES [dbo].[User Header] ([id])
ON UPDATE CASCADE
ON DELETE CASCADE

/* 3. Write a SQL query to return all users' active password */
SELECT [password] FROM [dbo].[User Password History] WHERE [IsActive] = 1

/* 4. Write SQL to add a new row to the password table 
   Assuming user id exists in the 'User Header' table. */
INSERT INTO [dbo].[User Password History] ([user_id],[password],[isActive]) VALUES (1,'asdasdfwr',1);

/* 5. Write SQL to remove the active flag from the previously active row
   Assuming this query runs prioir to the 4th query */
UPDATE [dbo].[User Password History] SET [isActive]=0 WHERE [user_id]=1;

/* 6. Extra Credit : Wrap 4,5 in a transaction */
CREATE PROCEDURE AddNewPassword   
	@userID int,
	@password varchar(max)
AS   
	UPDATE [dbo].[User Password History] SET [isActive]=0 WHERE [user_id]=@userID;
	INSERT INTO [dbo].[User Password History] ([user_id],[password],[isActive]) VALUES (@userID,@password,1);

/* RUN for debugging */
EXEC	@return_value = [dbo].[AddNewPassword]
		@userID = 1,
		@password = N'rffdfrtdgrt'