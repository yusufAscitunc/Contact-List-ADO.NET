USE [master]
GO
/****** Object:  Database [ContactList]    Script Date: 2/14/2022 8:34:40 AM ******/
CREATE DATABASE [ContactList]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ContactList', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ContactList.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'ContactList_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\ContactList_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [ContactList] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ContactList].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ContactList] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ContactList] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ContactList] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ContactList] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ContactList] SET ARITHABORT OFF 
GO
ALTER DATABASE [ContactList] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ContactList] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ContactList] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ContactList] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ContactList] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ContactList] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ContactList] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ContactList] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ContactList] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ContactList] SET  ENABLE_BROKER 
GO
ALTER DATABASE [ContactList] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ContactList] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ContactList] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ContactList] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ContactList] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ContactList] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ContactList] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ContactList] SET RECOVERY FULL 
GO
ALTER DATABASE [ContactList] SET  MULTI_USER 
GO
ALTER DATABASE [ContactList] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ContactList] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ContactList] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ContactList] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [ContactList] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [ContactList] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'ContactList', N'ON'
GO
ALTER DATABASE [ContactList] SET QUERY_STORE = OFF
GO
USE [ContactList]
GO
/****** Object:  Table [dbo].[Contacts]    Script Date: 2/14/2022 8:34:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Contacts](
	[ContactID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[MobileNumber] [nchar](11) NOT NULL,
	[Email] [nvarchar](30) NULL,
	[Address] [nvarchar](250) NULL,
 CONSTRAINT [PK_Contacts] PRIMARY KEY CLUSTERED 
(
	[ContactID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserList]    Script Date: 2/14/2022 8:34:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserList](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [nvarchar](20) NOT NULL,
	[Password] [nvarchar](20) NOT NULL,
 CONSTRAINT [PK_UserList] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UQ_UserID] UNIQUE NONCLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  StoredProcedure [dbo].[AddContact]    Script Date: 2/14/2022 8:34:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Proc [dbo].[AddContact]
@Name nvarchar(50),
@Surname nvarchar(50),
@MobileNumber nchar(11),
@Email nvarchar(30),
@Address nvarchar(250)
AS
INSERT INTO Contacts (Name, Surname, MobileNumber, Email, Address)
VALUES (@Name, @Surname, @MobileNumber, @Email, @Address)
GO
/****** Object:  StoredProcedure [dbo].[DeleteContact]    Script Date: 2/14/2022 8:34:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Proc [dbo].[DeleteContact]
(@ID int)
as
delete Contacts Where ContactID = @ID
GO
/****** Object:  StoredProcedure [dbo].[ListContacts]    Script Date: 2/14/2022 8:34:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[ListContacts]
as
Select * from Contacts
GO
/****** Object:  StoredProcedure [dbo].[UpdateContacts]    Script Date: 2/14/2022 8:34:40 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[UpdateContacts]
@ID int,
@Name nvarchar(50),
@Surname nvarchar(50),
@MobileNumber nchar(11),
@Email nvarchar(30),
@Address nvarchar(250)
AS
update Contacts set Name = @Name, Surname = @Surname, MobileNumber = @MobileNumber, Email = @Email, Address = @Address
WHERE @ID = ContactID
GO
USE [master]
GO
ALTER DATABASE [ContactList] SET  READ_WRITE 
GO
