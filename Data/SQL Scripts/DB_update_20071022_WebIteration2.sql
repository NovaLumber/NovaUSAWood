--SQL Scripts involved in setting up data source stuff for iteration 2
use [nova]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO



GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_Location_Hours') 
        drop table dbo.web_Location_Hours
        GO
        
        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_Location') 
        drop table dbo.[web_Location]
        GO
        

IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_Location_Category') 
        drop table dbo.web_location_category
GO
--Locations Section:
	--Create LocationCategory:
		CREATE TABLE [dbo].[web_Location_Category](
			[CategoryId] [int] IDENTITY(1,1) NOT NULL,
			[CategoryName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			[CategoryDesc] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		CONSTRAINT [PK_web_Location_Category] PRIMARY KEY CLUSTERED 
		(
			[CategoryId] ASC
		)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
			
	--Insert into Location Category
	INSERT INTO [dbo].[web_Location_Category]
		(CategoryName,[CategoryDesc]) Values
		('Washington','Stores in Washington State')
	INSERT INTO [dbo].[web_Location_Category]
		(CategoryName,[CategoryDesc]) Values
		('Washington Corporate','Corporate Stores in Washington State')
	INSERT INTO [dbo].[web_Location_Category]
		(CategoryName,[CategoryDesc]) Values
		('Oregon','Stores in Oregon')
	INSERT INTO [dbo].[web_Location_Category]
		(CategoryName,[CategoryDesc]) Values
		('Colorado','Stores in Colorado')
			
	--Create Location
		CREATE TABLE [dbo].[web_Location](
			[LocationId] [int] IDENTITY(1,1) NOT NULL,
			[CategoryId] [int] NOT NULL,
			[Name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			[Address1] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			[Address2] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
			[City] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			[State] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			[ZipCode] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			[PhoneNumber] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			[EmailAddress] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		 CONSTRAINT [PK_web_Location] PRIMARY KEY CLUSTERED 
		(
			[LocationId] ASC
		)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
		ALTER TABLE [dbo].[web_Location]  WITH CHECK ADD  CONSTRAINT [FK_web_Location_web_Location_Category] FOREIGN KEY([CategoryId])
		REFERENCES [dbo].[web_Location_Category] ([CategoryId])
		GO
		ALTER TABLE [dbo].[web_Location] CHECK CONSTRAINT [FK_web_Location_web_Location_Category]
		
		--Insert into Locations
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress]) 
		SELECT TOP 1 [CategoryId],'Mount Vernon Wood Monsters','100 Valley Mall Way','Ste 140','Mount Vernon',
		'WA','98273','3604282035','mtvernon@woodmonsters.com'
		 from [web_Location_Category] where [CategoryName]='Washington' 
		
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress])
		SELECT TOP 1 [CategoryId],'Everett Wood Monsters','406 SE Everett Mall Way',NULL,'Everett','WA',
		'98208', '4252123178','everett@woodmonsters.com' from [web_Location_Category] where [CategoryName]='Washington' 
		
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress]) 
		SELECT TOP 1 [CategoryId],'Kirkland Wood Monsters','11731 120th Avenue NE',NULL,'Kirkland','WA','98034',
		 '4258218254','kirkland@woodmonsters.com' from [web_Location_Category] where [CategoryName]='Washington' 
		
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress])
		SELECT TOP 1 [CategoryId],'Tukwila Wood Monsters','16600 West Vally Highway',NULL,'Tukwila','WA','98188',
		 '4252516801','kent@woodmonsters.com' from [web_Location_Category] where [CategoryName]='Washington' 
		
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress]) 
		SELECT TOP 1 [CategoryId],'Wood Monsters Inc.','Corporate Office',NULL,'Everett','WA','98208', 
		'4252584151','waltercoop@woodmonsters.com' from [web_Location_Category] where [CategoryName]='Washington Corporate' 
		
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress]) 
		SELECT TOP 1 [CategoryId],'Portland Wood Monsters','3424 NW Yeon Ave',NULL,'Portland','OR','97210',
		 '5032229663','portland@woodmonsters.com' from [web_Location_Category] where [CategoryName]='Oregon'
		
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress])
		SELECT TOP 1 [CategoryId],'Bend Wood Monsters','20505 Robal Road','Suite 4','Bend','OR','97701', '5413220496',
		'bend@woodmonsters.com' from [web_Location_Category] where [CategoryName]='Oregon' 
		
		INSERT INTO [dbo].[web_Location] 
		([CategoryId],[Name],[Address1],[Address2],[City],[State],[ZipCode],[PhoneNumber],[EmailAddress])
		SELECT TOP 1 [CategoryId],'Wood Monsters of Denver','607 S. Jason St.',NULL,'Denver','CO','80223',
		 '3037222860','denver@woodmonsters.com' from [web_Location_Category] where [CategoryName]='Colorado' 
		
		
	--Create Hours
			CREATE TABLE [dbo].[web_Location_Hours](
				[HoursId] [int] IDENTITY(1,1) NOT NULL,
				[LocationId] [int] NOT NULL,
				[HoursString] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			 CONSTRAINT [PK_web_Location_Hours] PRIMARY KEY CLUSTERED 
			(
				[HoursId] ASC
			)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
			) ON [PRIMARY]
			
			ALTER TABLE [dbo].[web_Location_Hours]  WITH CHECK ADD  CONSTRAINT [FK_web_Location_Hours_web_Location] FOREIGN KEY([LocationId])
			REFERENCES [dbo].[web_Location] ([LocationId])
			GO
			ALTER TABLE [dbo].[web_Location_Hours] CHECK CONSTRAINT [FK_web_Location_Hours_web_Location]
			
		--Insert into Hours
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Monday - Friday 10:00am-6:00pm',[LocationId] from [web_Location] where [Name]= 'Mount Vernon Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Saturday 10:00am-5:00pm',[LocationId] from [web_Location] where [Name]= 'Mount Vernon Wood Monsters'
	
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Sunday 12:00 noon-5:00pm',[LocationId] from [web_Location] where [Name]= 'Mount Vernon Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Monday - Saturday 9:00am-6:00pm',[LocationId] from [web_Location] where [Name]= 'Everett Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Sunday 10:00am-5:00pm',[LocationId] from [web_Location] where [Name]= 'Everett Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Monday - Saturday 10:00am-6:00pm',[LocationId] from [web_Location] where [Name]= 'Kirkland Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Sunday 10:00am-5:00pm',[LocationId] from [web_Location] where [Name]= 'Kirkland Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Monday - Saturday 9:00am-6:00pm',[LocationId] from [web_Location] where [Name]= 'Tukwila Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Sunday 10:00am-5:00pm',[LocationId] from [web_Location] where [Name]= 'Tukwila Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Corporate Office- By Appointment Only',[LocationId] from [web_Location] where [Name]= 'Wood Monsters Inc.'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Monday - Saturday 9:00am-6:00pm',[LocationId] from [web_Location] where [Name]= 'Portland Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Sunday 10:00am-5:00pm',[LocationId] from [web_Location] where [Name]= 'Portland Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Monday - Friday 8:00am-5:00pm',[LocationId] from [web_Location] where [Name]= 'Bend Wood Monsters'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Monday - Friday 9:00am-6:00pm',[LocationId] from [web_Location] where [Name]= 'Wood Monsters of Denver'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Saturday 10:00am-5:00pm',[LocationId] from [web_Location] where [Name]= 'Wood Monsters of Denver'
		
		INSERT INTO [dbo].[web_Location_Hours]
		([HoursString],[LocationId])
		SELECT TOP 1 'Sunday 12:00 noon-5:00pm',[LocationId] from [web_Location] where [Name]= 'Wood Monsters of Denver'
		
		
	--Create Locations Select Procedure
	GO
	IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebLocations'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetWebLocations
	END
	GO
	-- =============================================
	-- Author:		Erich Keane
	-- Create date: October 22, 2007
	-- Description:	A stored procedure to get the locations list for the web project
	-- =============================================
	CREATE PROCEDURE SP_GetWebLocations 
	AS
	BEGIN
		-- SET NOCOUNT ON added to prevent extra result sets from
		-- interfering with SELECT statements.
		SET NOCOUNT ON;

		select [CategoryId],[CategoryName],[CategoryDesc] from [Web_Location_Category]
		select [LocationId],[CategoryId],[Name],[Address1],[Address2],[City],
			[State],[ZipCode],[PhoneNumber],[EmailAddress] from [Web_Location]
		select [HoursId],[LocationId],[HoursString] from Web_Location_Hours
	END
	GO
		
--Filters Section:


GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_FilterEntries') 
        drop table dbo.web_FilterEntries
        GO
        
        
        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_Filters') 
        drop table dbo.web_Filters
        GO
        

	--Create Filter tables
	CREATE TABLE [dbo].[web_Filters](
	[FilterId] [int] IDENTITY(1,1) NOT NULL,
	[FilterName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FilterDescr] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	CONSTRAINT [PK_web_Filters] PRIMARY KEY CLUSTERED 
	(
	[FilterId] ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]

	
	CREATE TABLE [dbo].[web_FilterEntries](
	[EntryId] [int] IDENTITY(1,1) NOT NULL,
	[FilterId] [int] NOT NULL,
	[EntryName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EntryDescr] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EntryConditions] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	 CONSTRAINT [PK_web_FilterEntries] PRIMARY KEY CLUSTERED 
	(
		[EntryId] ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]
	ALTER TABLE [dbo].[web_FilterEntries]  WITH CHECK ADD  CONSTRAINT [FK_web_FilterEntries_web_Filters] FOREIGN KEY([FilterId])
	REFERENCES [dbo].[web_Filters] ([FilterId])
	GO
	ALTER TABLE [dbo].[web_FilterEntries] CHECK CONSTRAINT [FK_web_FilterEntries_web_Filters]


	--Data for Filters
	INSERT INTO [web_Filters] (FilterName,FilterDescr) values('Species','The type of wood')
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Andiroba','Andiroba, Royal Mahogany','species_code =''AD''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Amendoim','Amendoim/Ybarro','species_code =''AM''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Ang Ped','Angelim Pedra','species_code =''AN''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Bacana','Bacana','species_code =''BA''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Bol Cambara','Bolivian Cambara','species_code =''BC''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Braz HW','Brazilian Hardwood','species_code =''BH''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Bldwd','Bloodwood','species_code =''BW''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Cambara','Cambara (Erisma uncinatum)','species_code =''CA''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'China Cedar','Chinese Cedar','species_code =''CC''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Curupau','Curupau','species_code =''CR''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Cumaru','Cumaru','species_code =''CU''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Red Cumaru','Red Cumaru','species_code =''CV''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Cypress','Cypress','species_code =''CY''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Euca','Eucalyptus','species_code =''EU''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Greenheart','Greenheart','species_code =''GH''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Guajara','Guajara / Moabi','species_code =''GU''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Hardwood','Hardwood','species_code =''HW''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Blk Ipe','Black Ipe','species_code =''IB''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Dk Ipe','Dark Ipe','species_code =''ID''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Ipe','Ipe','species_code =''IP''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Jatoba','Jatoba','species_code =''JA''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Kurupayra','Kurupayra','species_code =''KU''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Lapacho','Lapacho','species_code =''LA''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Mass','Massaranduba','species_code =''MA''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'P Rosewood','Para Rosewood','species_code =''MC''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Morado','Morado','species_code =''MO''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Misc','Miscellaneous','species_code =''MS''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Composite','Other Composite','species_code =''OC''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'PHrt','Purpleheart','species_code =''PH''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Rhino','RhinoDeck','species_code =''RH''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Santos','Santos Mahogany','species_code =''SA''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Sucupira','Sucupira','species_code =''SU''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Tauari','Tauari','species_code =''TA''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Tarara','Tarara','species_code =''TC''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Timborana','Timborana','species_code =''TI''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'Tiete','Tiete Rosewood','species_code =''TR''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'TigerWd','TigerWood','species_code =''TW''' from web_filters where FilterName= 'Species'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions)
		Select TOP 1 FilterId,'WRC','Western Red Cedar','species_code =''WR''' from web_filters where FilterName= 'Species'
		
	INSERT INTO [web_Filters] (FilterName,FilterDescr) values('Grade','The grade of wood')
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'First Clear','First Clear','grade_code =''#1 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#1 RGH','#1 RGH','grade_code =''#1p''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#2','#2','grade_code =''#2 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#2 SAP','#2 SAP','grade_code =''#2S''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#3','#3','grade_code =''#3 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#1 Com','#1 Com','grade_code =''1C ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#1 Com Sap','#1 Com Sap','grade_code =''1CS''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'2&Btr','2&Btr','grade_code =''2&B''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#2+ NPS','#2+ NPS','grade_code =''2+N''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#2 Com','#2 Com','grade_code =''2C ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#3 NH','#3 NH','grade_code =''3NH''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'A&Btr','A&Btr','grade_code =''A+ ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'B/C Grade','B/C Grade','grade_code =''B&C''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'C&Btr','C&Btr','grade_code =''C+ ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Clr Dk','Clr Dk','grade_code =''CLD''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Clear L','Clear L','grade_code =''CLL''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Clear','Clear','grade_code =''CLR''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'D&Btr','D&Btr','grade_code =''D+ ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'FAS','FAS','grade_code =''FAS''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'GR-02','GR-02','grade_code =''G2 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'GR-04 Select/Prime','GR-04 Select/Prime','grade_code =''G4 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'GR-03 Select','GR-03 Select','grade_code =''GP ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Microbevel Sel+','Microbevel Sel+','grade_code =''MB ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'NA','NA','grade_code =''NA ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'#1','#1','grade_code =''No1''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'MR T2 Ovl/Btr','MR T2 Ovl/Btr','grade_code =''OLB''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Prefin 1Com','Prefin 1Com','grade_code =''P2 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Prefin 1Com 1800','Prefin 1Com 1800','grade_code =''P3 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Prefin 1Com PS','Prefin 1Com PS','grade_code =''P4 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Prefin Intermed','Prefin Intermed','grade_code =''P5 ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Prefinished Clear','Prefinished Clear','grade_code =''PCL''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Prefinished Engineered','Prefinished Engineered','grade_code =''PE ''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Pref Select & Btr','Pref Select & Btr','grade_code =''PSE''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Short Clear','Short Clear','grade_code =''SCL''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Std & Btr','Std & Btr','grade_code =''SD+''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Select & Better','Select & Better','grade_code =''SE+''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Select','Select','grade_code =''SEL''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Short Select & Btr','Short Select & Btr','grade_code =''SSL''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'STK 1 FACE','STK 1 FACE','grade_code =''ST1''' from web_filters where FilterName= 'Grade'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'STK','STK','grade_code =''STK''' from web_filters where FilterName= 'Grade'
	
	INSERT INTO [web_Filters] (FilterName,FilterDescr) values('Grain','The grain of wood')
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'All Heart       ','All Heart       ','grain_code =''AH''' from web_filters where FilterName= 'Grain'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'FG              ','FG              ','grain_code =''FG''' from web_filters where FilterName= 'Grain'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'MG              ','MG              ','grain_code =''MG''' from web_filters where FilterName= 'Grain'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'SG              ','SG              ','grain_code =''SG''' from web_filters where FilterName= 'Grain'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'VG              ','VG              ','grain_code =''VG''' from web_filters where FilterName= 'Grain'
	
	INSERT INTO [web_Filters] (FilterName,FilterDescr) values('Usage','The usage of wood')
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Decking         ','Decking         ','usage_cd=''DE''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'ECB/WP4         ','ECB/WP4         ','usage_cd=''EB''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Cayenne Flg     ','Cayenne Flg     ','usage_cd=''FC''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'DE Fence Board  ','DE Fence Board  ','usage_cd=''FD''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Chestnut Flg    ','Chestnut Flg    ','usage_cd=''FH''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Flooring        ','Flooring        ','usage_cd =''FL''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Honey Flg       ','Honey Flg       ','usage_cd=''FN''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'FT Fence Board  ','FT Fence Board  ','usage_cd=''FT''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'NA              ','NA              ','usage_cd=''NA''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Piling          ','Piling          ','usage_cd =''PI''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Plywood         ','Plywood         ','usage_cd =''PL''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'S4S Radius Edge ','S4S Radius Edge ','usage_cd =''RE''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'RGH             ','RGH             ','usage_cd =''RG''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'S1S2E           ','S1S2E           ','usage_cd =''S1''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'S2S             ','S2S             ','usage_cd=''S2''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'S4S E4E         ','S4S E4E         ','usage_cd =''S4''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'S4S Square Edge ','S4S Square Edge ','usage_cd =''SB''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'S4S Grooved     ','S4S Grooved     ','usage_cd =''SG''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Shiplap         ','Shiplap         ','usage_cd =''SL''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'Kiln Sticks     ','Kiln Sticks     ','usage_cd =''St''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'T&G Patt 132    ','T&G Patt 132    ','usage_cd =''T2''' from web_filters where FilterName= 'Usage'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,'T&G Center Match','T&G Center Match','usage_cd =''TC''' from web_filters where FilterName= 'Usage'
	
	
	INSERT INTO [web_Filters] (FilterName,FilterDescr) values('Price Range','The Price of wood')
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,
		'<$2 sq ft.','Less than 2 dollars per square foot','web_price<2' from web_filters where FilterName= 'Price Range'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,
		'<$4 sq ft.','Less than 4 dollars per square foot','web_price<4' from web_filters where FilterName= 'Price Range'
		INSERT INTO [web_FilterEntries] (FilterId,EntryName,EntryDescr,EntryConditions) Select TOP 1 FilterId,
		'<$6 sq ft.','Less than 6 dollars per square foot','web_price<6' from web_filters where FilterName= 'Price Range'
		
		
		
	--Filter Stored PRocedure
	GO
	IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebFilters'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetWebFilters
	END
GO
				-- =============================================
				-- Author:		Erich Keane
				-- Create date: October 22, 2007
				-- Description:	A stored procedure to get the web filters counts list for the web project
				-- =============================================
				CREATE PROCEDURE SP_GetWebFilters
				AS
				BEGIN
					select FilterId,FilterName,FilterDescr from web_Filters
					Select EntryId,FilterId,EntryName,EntryDescr,0 as CountIfAdded from web_FilterEntries
				END
			GO
	GO
	IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebFilters_Count'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetWebFilters_Count
	END
GO
				-- =============================================
				-- Author:		Erich Keane
				-- Create date: October 22, 2007
				-- Description:	A stored procedure to get the web filters counts list for the web project
				-- =============================================
				CREATE PROCEDURE SP_GetWebFilters_Count 
				@EntryList as varchar(max)
				AS
				BEGIN
					-- SET NOCOUNT ON added to prevent extra result sets from
					-- interfering with SELECT statements.
					SET NOCOUNT ON;
					
					CREATE TABLE #TempList (Condition varchar(max))	
					DECLARE @EntryCondition varchar(max), @Pos int
					SET @EntryList = LTRIM(RTRIM(@EntryList))+ ','
					SET @Pos = CHARINDEX(',', @EntryList, 1)

					--Gets the list of entry conditions 
					IF REPLACE(@EntryList, ',', '') <> ''
					BEGIN
					WHILE @Pos > 0
					BEGIN
						SET @EntryCondition = LTRIM(RTRIM(LEFT(@EntryList, @Pos - 1)))
						IF @EntryCondition <> ''
						BEGIN
							INSERT INTO #TempList (Condition) 
							SELECT EntryConditions from web_FilterEntries where EntryId = (CAST(@EntryCondition as int))
						END
						SET @EntryList = RIGHT(@EntryList, LEN(@EntryList) - @Pos)
						SET @Pos = CHARINDEX(',', @EntryList, 1)

					END
					END


					Declare @EntryQuery varchar(MAX)
					Declare @CountQuery varchar(MAX)
					Declare CondCursor CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY FOR SELECT * from #TempList 

					Set @CountQuery = 'SELECT count(*) from products where 1=1 ';

					OPEN CondCursor
					
					--Generates the standard count query, based on the current selected stuff
					Fetch NEXT From CondCursor INTO @EntryCondition
					While (@@FETCH_STATUS <>-1)
					begin
						SET @CountQuery = @CountQuery + 'AND '+@EntryCondition+' ';
						Fetch NEXT From CondCursor INTO @EntryCondition
					end
					CLOSE CondCursor
					DEALLOCATE CondCursor

					Set @EntryQuery =''
					Declare @EntryId int
					Declare EntryCursor CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY FOR SELECT EntryConditions,EntryId from web_FilterEntries
					
					--Generates the final filter query, a union of a select of every single one
					Open EntryCursor
					Fetch NEXT From EntryCursor into @EntryCondition,@EntryId
					While(@@FETCH_STATUS<>-1)
					begin
						if(@EntryQuery<>'')	SET @EntryQuery =@EntryQuery+' UNION ';
						
						Set @EntryQuery = @EntryQuery + 'select EntryId,('+@CountQuery+' AND '+
													@EntryCondition+' ) as CountIfAdded from web_FilterEntries where EntryId='+ cast(@EntryId as varchar(100))

						Fetch NEXT From EntryCursor into @EntryCondition,@EntryId
					end
					Close EntryCursor
					execute(@EntryQuery)


				END
			GO
	--Product Stored Procedures Section:
	
GO
	IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebProductsList'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetWebProductsList
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: October 22, 2007
		-- Description:	A stored procedure to get the web filters counts list for the web project
		-- =============================================
		CREATE PROCEDURE SP_GetWebProductsList
		@EntryList as varchar(1000)
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			
			Declare @ProductQuery as varchar(MAX)
			Set @ProductQuery ='SELECT prod_id,short_desc,short_desc+'' - ''+long_desc as both_desc,
				long_desc,web_price,image3filename,image2filename,image1filename,
				grade_code,grain_code,species_code,inventory_label,condition_code,usage_cd,
				size_cd,weight_id,bf_per_sub_bundle,
				default_unit_id from products where 1=1';
	
			DECLARE @EntryCondition varchar(1000), @Pos int
			SET @EntryList = LTRIM(RTRIM(@EntryList))+ ','
			SET @Pos = CHARINDEX(',', @EntryList, 1)

			--Gets the list of entry conditions 
			IF REPLACE(@EntryList, ',', '') <> ''
			BEGIN
				WHILE @Pos > 0
				BEGIN
					SET @EntryCondition = LTRIM(RTRIM(LEFT(@EntryList, @Pos - 1)))
					IF @EntryCondition <> ''
					BEGIN
						Select @EntryCondition=EntryConditions from web_FilterEntries where EntryId= Cast(@EntryCondition as int)
						Set @ProductQuery= @ProductQuery + ' AND '+@EntryCondition+' '
							
					END
					SET @EntryList = RIGHT(@EntryList, LEN(@EntryList) - @Pos)
					SET @Pos = CHARINDEX(',', @EntryList, 1)

				END
			END
			ELSE
			BEGIN
				Set @ProductQuery = @ProductQuery + ' AND OnFeature = 1';
			END
			
			Select unit_id,unit_label,price_label,bf_conversion_type,price_to_unit_factor,bf_conversion_factor,use_net_size 
				from unit; 
			select weight_id,weight_short_desc,weight_desc,weight_per_mbf from weight_class;
			select size_cd,size_desc,size_nom_thick,length,size_nom_width,net_width,net_thick,net_length,net_desc 
				from sizes;
			select condition_code,condition_desc from condition;
			select usage_cd,usage_desc from usage;
			select grade_code,grade_desc from grade;
			select grain_code,grain_desc from grain;
			select species_code,species_description,species_abbrev from species;
			Execute(@ProductQuery)
		END
	GO

GO
	IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebProductsDetails'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetWebProductsDetails
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: October 22, 2007
		-- Description:	A stored procedure to get the web filters counts list for the web project
		-- =============================================
		CREATE PROCEDURE SP_GetWebProductsDetails
		@ProductId as int
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			
			Select unit_id,unit_label,price_label,bf_conversion_type,price_to_unit_factor,bf_conversion_factor,use_net_size 
				from unit inner join products on unit_id=default_unit_id where prod_id = @ProductId; 
			select weight_class.weight_id,weight_short_desc,weight_desc,weight_per_mbf from weight_class
				inner join products on weight_class.weight_id=products.weight_id where prod_id = @ProductId;
			select sizes.size_cd,size_desc,size_nom_thick,length,size_nom_width,net_width,net_thick,net_length,net_desc 
				from sizes inner join products on sizes.size_cd=products.size_cd where prod_id = @ProductId;
			select condition.condition_code,condition_desc from condition 
				inner join products on condition.condition_code=products.condition_code where prod_id = @ProductId;
			select usage.usage_cd,usage_desc from usage inner join products on usage.usage_cd=products.usage_cd where prod_id = @ProductId;
			select grade.grade_code,grade_desc from grade inner join products on grade.grade_code=products.grade_code where prod_id = @ProductId;
			select grain.grain_code,grain_desc from grain inner join products on grain.grain_code=products.grain_code where prod_id = @ProductId;
			select species.species_code,species_description,species_abbrev from species 
				inner join products on species.species_code=products.species_code where prod_id = @ProductId;
			SELECT prod_id,short_desc,short_desc+' - '+long_desc as both_desc,
				long_desc,web_price,image3filename,image2filename,image1filename,
				grade_code,grain_code,species_code,inventory_label,condition_code,usage_cd,
				size_cd,weight_id,bf_per_sub_bundle,
				default_unit_id from products where prod_id = @ProductId
		END
	GO




	--Attribute Ordering
	
	        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_AttributeLocationJoin') 
        drop table dbo.web_AttributeLocationJoin
        GO
        
        	        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_Attributes') 
        drop table dbo.web_Attributes
        GO
        
        	        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_AttributeLocations') 
        drop table dbo.web_AttributeLocations
        GO
	
	GO
	CREATE TABLE [dbo].[web_AttributeLocations](
			[LocationId] [int] IDENTITY(1,1) NOT NULL,
			[LocationName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		 CONSTRAINT [PK_web_AttributeLocations] PRIMARY KEY CLUSTERED 
		(
			[LocationId] ASC
		)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY],
		 CONSTRAINT [IX_web_AttributeLocations] UNIQUE NONCLUSTERED 
		(
			[LocationName] ASC
		)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	GO
	CREATE TABLE [dbo].[web_Attributes](
			[AttributeId] [int] IDENTITY(1,1) NOT NULL,
			[AttributeName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		 CONSTRAINT [PK_web_Attributes] PRIMARY KEY CLUSTERED 
		(
			[AttributeId] ASC
		)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]
	GO
	CREATE TABLE [dbo].[web_AttributeLocationJoin](
	[LocationId] [int] NOT NULL,
	[AttributeId] [int] NOT NULL,
	[Order] [int] NOT NULL,
	[AttributeText] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AttributeDesc] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
		 CONSTRAINT [PK_web_AttributeLocationJoin] PRIMARY KEY CLUSTERED 
		(
			[LocationId] ASC,
			[AttributeId] ASC
		)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
		) ON [PRIMARY]

		GO
		SET ANSI_PADDING OFF
		GO
		ALTER TABLE [dbo].[web_AttributeLocationJoin]  WITH CHECK ADD  CONSTRAINT [FK_web_AttributeLocationJoin_web_AttributeLocations] FOREIGN KEY([LocationId])
		REFERENCES [dbo].[web_AttributeLocations] ([LocationId])
		GO
		ALTER TABLE [dbo].[web_AttributeLocationJoin] CHECK CONSTRAINT [FK_web_AttributeLocationJoin_web_AttributeLocations]
		GO
		ALTER TABLE [dbo].[web_AttributeLocationJoin]  WITH CHECK ADD  CONSTRAINT [FK_web_AttributeLocationJoin_web_Attributes] FOREIGN KEY([AttributeId])
		REFERENCES [dbo].[web_Attributes] ([AttributeId])
		GO
		ALTER TABLE [dbo].[web_AttributeLocationJoin] CHECK CONSTRAINT [FK_web_AttributeLocationJoin_web_Attributes]
	
	--Data:
	INSERT INTO [web_AttributeLocations] (LocationName) values ('ProductList')
	INSERT INTO [web_AttributeLocations] (LocationName) values ('ProductDetails')
	
	INSERT INTO [web_Attributes] (AttributeName) values ('Species')
	INSERT INTO [web_Attributes] (AttributeName) values ('Grade')
	INSERT INTO [web_Attributes] (AttributeName) values ('Grain')
	INSERT INTO [web_Attributes] (AttributeName) values ('Usage')
	INSERT INTO [web_Attributes] (AttributeName) values ('Condition')
	INSERT INTO [web_Attributes] (AttributeName) values ('Inventory')
	INSERT INTO [web_Attributes] (AttributeName) values ('WeightClass')
	INSERT INTO [web_Attributes] (AttributeName) values ('WeightPerBoardFoot')
	INSERT INTO [web_Attributes] (AttributeName) values ('Size')
	INSERT INTO [web_Attributes] (AttributeName) values ('NominalSize')
	INSERT INTO [web_Attributes] (AttributeName) values ('NetSize')
	INSERT INTO [web_Attributes] (AttributeName) values ('BoardFeetPerBox')
	INSERT INTO [web_Attributes] (AttributeName) values ('Price')
	INSERT INTO [web_Attributes] (AttributeName) values ('PricePerBox')
	
	--Product List Entries
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Species'),1,'Species','SpeciesDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Grade'),2,'Grade','GradeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Grain'),3,'Grain','GrainDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Usage'),4,'Usage','UsageDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Condition'),5,'Condition','ConditionDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Inventory'),6,'Inventory','InventoryDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='WeightClass'),7,'WeightClass','WeightClassDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='WeightPerBoardFoot'),8,'WeightPerBoardFoot','WeightPerBoardFootDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Size'),9,'Size','SizeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='NominalSize'),10,'NominalSize','NominalSizeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='NetSize'),11,'NetSize','NetSizeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='BoardFeetPerBox'),12,'BoardFeetPerBox','BoardFeetPerBoxDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Price'),13,'Price','PriceDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductList'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='PricePerBox'),14,'PricePerBox','PricePerBoxDesc' 
	--Product Description entries
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Species'),1,'Species','SpeciesDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Grade'),2,'Grade','GradeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Grain'),3,'Grain','GrainDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Usage'),4,'Usage','UsageDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Condition'),5,'Condition','ConditionDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Inventory'),6,'Inventory','InventoryDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='WeightClass'),7,'WeightClass','WeightClassDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='WeightPerBoardFoot'),8,'WeightPerBoardFoot','WeightPerBoardFootDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Size'),9,'Size','SizeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='NominalSize'),10,'NominalSize','NominalSizeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='NetSize'),11,'NetSize','NetSizeDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='BoardFeetPerBox'),12,'BoardFeetPerBox','BoardFeetPerBoxDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='Price'),13,'Price','PriceDesc' 
	INSERT INTO [web_AttributeLocationJoin] (LocationId, AttributeId, [Order],AttributeText,AttributeDesc)
		SELECT (Select Top 1 LocationId from web_AttributeLocations where LocationName='ProductDetails'),
		(Select Top 1 AttributeId from web_Attributes where AttributeName='PricePerBox'),14,'PricePerBox','PricePerBoxDesc' 
		
		
		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebAttributes'))
			BEGIN
				DROP PROCEDURE dbo.SP_GetWebAttributes
			END
			GO
				-- =============================================
				-- Author:		Erich Keane
				-- Create date: October 22, 2007
				-- Description:	A stored procedure to get the web filters counts list for the web project
				-- =============================================
				CREATE PROCEDURE SP_GetWebAttributes
				@LocationName as varchar(100)
				AS
				BEGIN
					-- SET NOCOUNT ON added to prevent extra result sets from
					-- interfering with SELECT statements.
					SET NOCOUNT ON;
					
					SELECT AttributeName,[Order],AttributeText,AttributeDesc from web_AttributeLocations
						right outer join [web_AttributeLocationJoin] on web_AttributeLocationJoin.LocationId=web_AttributeLocations.LocationId
						right outer join [web_Attributes] on web_attributelocationjoin.AttributeId=web_Attributes.AttributeId
						where LocationName=@LocationName and [Order]>=0 order by [Order]
				END
			GO
			
			
	-- Learn- About
	
	        	        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_LearnDocumentJoin') 
        drop table dbo.web_LearnDocumentJoin
        GO
        
                	        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_LearnDocument') 
        drop table dbo.web_LearnDocument
        GO
        
                	        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_LearnNode') 
        drop table dbo.web_LearnNode
        GO
        
		--Tables
			CREATE TABLE [dbo].[web_LearnNode](
				[LearnNodeId] [int] IDENTITY(1,1) NOT NULL,
				[LearnNodeName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
				[LearnNodeDesc] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
				[ParentId] [int] NULL,
			 CONSTRAINT [PK_web_LearnNode] PRIMARY KEY CLUSTERED 
			(
				[LearnNodeId] ASC
			)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
			) ON [PRIMARY]

			GO
			SET ANSI_PADDING OFF
			GO
			ALTER TABLE [dbo].[web_LearnNode]  WITH CHECK ADD  CONSTRAINT [FK_web_LearnNode_web_LearnNode] FOREIGN KEY([ParentId])
			REFERENCES [dbo].[web_LearnNode] ([LearnNodeId])
			GO
			ALTER TABLE [dbo].[web_LearnNode] CHECK CONSTRAINT [FK_web_LearnNode_web_LearnNode]
			GO
			CREATE TABLE [dbo].[web_LearnDocument](
				[DocumentId] [int] IDENTITY(1,1) NOT NULL,
				[DocumentAddress] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
				[DocumentName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
				[DocumentDesc] [varchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
			 CONSTRAINT [PK_web_LearnDocument] PRIMARY KEY CLUSTERED 
			(
				[DocumentId] ASC
			)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
			) ON [PRIMARY]

			GO
			CREATE TABLE [dbo].[web_LearnDocumentJoin](
				[LearnNodeId] [int] NOT NULL,
				[DocumentId] [int] NOT NULL,
				[Order] [int] NOT NULL,
			 CONSTRAINT [PK_web_LearnDocumentJoin] PRIMARY KEY CLUSTERED 
			(
				[LearnNodeId] ASC,
				[DocumentId] ASC,
				[Order] ASC
			)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
			) ON [PRIMARY]

			GO
			ALTER TABLE [dbo].[web_LearnDocumentJoin]  WITH CHECK ADD  CONSTRAINT [FK_web_LearnDocumentJoin_web_LearnDocument] FOREIGN KEY([DocumentId])
			REFERENCES [dbo].[web_LearnDocument] ([DocumentId])
			GO
			ALTER TABLE [dbo].[web_LearnDocumentJoin] CHECK CONSTRAINT [FK_web_LearnDocumentJoin_web_LearnDocument]
			GO
			ALTER TABLE [dbo].[web_LearnDocumentJoin]  WITH CHECK ADD  CONSTRAINT [FK_web_LearnDocumentJoin_web_LearnNode] FOREIGN KEY([LearnNodeId])
			REFERENCES [dbo].[web_LearnNode] ([LearnNodeId])
			GO
			ALTER TABLE [dbo].[web_LearnDocumentJoin] CHECK CONSTRAINT [FK_web_LearnDocumentJoin_web_LearnNode]
	
	
		--Dummy Data
			INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) values ('Wood Monsters Learn-About',
				'A collection of documents to help you learn more about the business',null)
				
			INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) 
				select 'Customer Care','Documents to help you learn about ordering, processing, and how we care for you.',
				LearnNodeId from web_LearnNode where ParentId is Null -- to find the root node
			INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) 
				select 'Product Installation','Documents to help you Install your new product.',
				LearnNodeId from web_LearnNode where ParentId is Null -- to find the root node
			INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) 
				select 'Flooring','Documents to teach you flooring basics.',
				LearnNodeId from web_LearnNode where ParentId is Null -- to find the root node
			INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) 
				select 'Product Warranties','The Warranties we offer with our products.',
				LearnNodeId from web_LearnNode where ParentId is Null -- to find the root node
			
			--Child Items

				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Customer Care 1','Documents to help you learn about ordering, processing, and how we care for you. 1',LearnNodeId from web_LearnNode where LearnNodeName='Customer Care' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Installation 1','Documents to help you Install your new product. 1',LearnNodeId from web_LearnNode where LearnNodeName='Product Installation' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Flooring 1','Documents to teach you flooring basics. 1',LearnNodeId from web_LearnNode where LearnNodeName='Flooring' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Warranties 1','The Warranties we offer with our products. 1',LearnNodeId from web_LearnNode where LearnNodeName='Product Warranties' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Customer Care 2','Documents to help you learn about ordering, processing, and how we care for you. 2',LearnNodeId from web_LearnNode where LearnNodeName='Customer Care' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Installation 2','Documents to help you Install your new product. 2',LearnNodeId from web_LearnNode where LearnNodeName='Product Installation' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Flooring 2','Documents to teach you flooring basics. 2',LearnNodeId from web_LearnNode where LearnNodeName='Flooring' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Warranties 2','The Warranties we offer with our products. 2',LearnNodeId from web_LearnNode where LearnNodeName='Product Warranties' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Customer Care 3','Documents to help you learn about ordering, processing, and how we care for you. 3',LearnNodeId from web_LearnNode where LearnNodeName='Customer Care' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Installation 3','Documents to help you Install your new product. 3',LearnNodeId from web_LearnNode where LearnNodeName='Product Installation' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Flooring 3','Documents to teach you flooring basics. 3',LearnNodeId from web_LearnNode where LearnNodeName='Flooring' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Warranties 3','The Warranties we offer with our products. 3',LearnNodeId from web_LearnNode where LearnNodeName='Product Warranties' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Customer Care 4','Documents to help you learn about ordering, processing, and how we care for you. 4',LearnNodeId from web_LearnNode where LearnNodeName='Customer Care' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Installation 4','Documents to help you Install your new product. 4',LearnNodeId from web_LearnNode where LearnNodeName='Product Installation' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Flooring 4','Documents to teach you flooring basics. 4',LearnNodeId from web_LearnNode where LearnNodeName='Flooring' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Warranties 4','The Warranties we offer with our products. 4',LearnNodeId from web_LearnNode where LearnNodeName='Product Warranties' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Customer Care 5','Documents to help you learn about ordering, processing, and how we care for you. 5',LearnNodeId from web_LearnNode where LearnNodeName='Customer Care' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Installation 5','Documents to help you Install your new product. 5',LearnNodeId from web_LearnNode where LearnNodeName='Product Installation' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Flooring 5','Documents to teach you flooring basics. 5',LearnNodeId from web_LearnNode where LearnNodeName='Flooring' 
				INSERT INTO web_LearnNode (LearnNodeName,LearnNodeDesc,ParentId) select 'Product Warranties 5','The Warranties we offer with our products. 5',LearnNodeId from web_LearnNode where LearnNodeName='Product Warranties' 
							
			
			INSERT INTO web_LearnDocument(DocumentAddress,DocumentName,DocumentDesc) 
				values ('Documents\2007_w9.pdf','Test Doc','Doc Description') -- only need 1 document...
				
			--Document assocations
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Wood Monsters Learn-About'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,1 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Wood Monsters Learn-About'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,2 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Wood Monsters Learn-About'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,3 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Wood Monsters Learn-About'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,4 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Wood Monsters Learn-About'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 1'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 2'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 3'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 4'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Customer Care 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Installation 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Flooring 5'    
				INSERT INTO web_LearnDocumentJoin (LearnNodeId,DocumentId,[Order])    select LearnNodeId,DocumentId,5 from web_LearnNode inner join web_LearnDocument on 1=1 where LearnNodeName='Product Warranties 5'    
							
							
			--Stored Procedure
			GO
				IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebLearnAbout'))
				BEGIN
					DROP PROCEDURE dbo.SP_GetWebLearnAbout
				END
				GO
				-- =============================================
				-- Author:		Erich Keane
				-- Create date: October 22, 2007
				-- Description:	A stored procedure to get the locations list for the web project
				-- =============================================
				CREATE PROCEDURE SP_GetWebLearnAbout 
				@NodeId as int = null
				AS
				BEGIN
					-- SET NOCOUNT ON added to prevent extra result sets from
					-- interfering with SELECT statements.
					SET NOCOUNT ON;

					if(@NodeId is null)
						select @NodeId=LearnNodeId from web_LearnNode where ParentId is null

					select LearnNodeId,LearnNodeName,LearnNodeDesc,ParentId,
						(select count(*) from web_LearnDocumentJoin where LearnNodeId = web_LearnNode.LearnNodeId) 
						as NumberOfDocuments from web_LearnNode

					select web_LearnDocument.DocumentId,DocumentAddress,DocumentName,DocumentDesc,[Order] from web_LearnDocument
						inner join web_LearnDocumentJoin on web_LearnDocument.DocumentId=web_LearnDocumentJoin.DocumentId
						where web_LearnDocumentJoin.LearnNodeId = @NodeId order by [Order]
				END
				GO