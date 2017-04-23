--Location Sort Ordering

if ((SELECT COALESCE(COL_LENGTH('web_Location','Order'),0))=0)
	Alter Table [web_Location] Add [Order] int NOT NULL Default (0)
	go
if ((SELECT COALESCE(COL_LENGTH('web_Location_Category','Order'),0))=0)
	Alter Table [web_Location_Category] Add [Order] int NOT NULL Default (0)
	go
if ((SELECT COALESCE(COL_LENGTH('web_Location_Hours','Order'),0))=0)
	Alter Table [web_Location_Hours] Add [Order] int NOT NULL Default (0)
	go
	
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

		select [CategoryId],[CategoryName],[CategoryDesc] from [Web_Location_Category] order By [Order] ASC
		select [LocationId],[CategoryId],[Name],[Address1],[Address2],[City],
			[State],[ZipCode],[PhoneNumber],[EmailAddress] from [Web_Location] order By [Order] ASC
		select [HoursId],[LocationId],[HoursString] from Web_Location_Hours order By [Order] ASC
	END
	GO
	
-- Filter Sort Ordering
if ((SELECT COALESCE(COL_LENGTH('web_Filters','Order'),0))=0)
	Alter Table [web_Filters] Add [Order] int NOT NULL Default (0) 
if ((SELECT COALESCE(COL_LENGTH('web_FilterEntries','Order'),0))=0)
	Alter Table [web_FilterEntries] Add [Order] int NOT NULL Default (0)
	
	
	
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
					select FilterId,FilterName,FilterDescr from web_Filters order by [Order] 
					Select EntryId,FilterId,EntryName,EntryDescr,0 as CountIfAdded from web_FilterEntries order by [Order] 
				END
			GO
	GO