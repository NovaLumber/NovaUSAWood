
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebFilters_Count'))
	BEGIN
		DROP PROCEDURE dbo.[SP_GetWebFilters_Count]
	END
	GO

				-- =============================================
				-- Author:		Erich Keane
				-- Create date: October 22, 2007
				-- Description:	A stored procedure to get the web filters counts list for the web project
				-- =============================================
				-- Modified by: Steve Getsiv
				-- Mod Date(s): Nov 7, 2007
				-- Added where clause to only get prod's with 1000 BF or more
				-- =============================================
				
				CREATE PROCEDURE [dbo].[SP_GetWebFilters_Count] 
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
					Declare @ConditionClause varchar(MAX)

					Declare CondCursor CURSOR LOCAL FORWARD_ONLY STATIC READ_ONLY FOR SELECT * from #TempList 

					Set @CountQuery = 'SELECT count(*) from products ';

					-- Set @ConditionClause = 'where 1=1';
					Set @ConditionClause = 'where prod_id in (SELECT prod_id from tickets where status = ''I'' group by prod_id having sum(bf) > 1000)';

					Set @CountQuery = @CountQuery + @ConditionClause;

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

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO




SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
		-- Modified by: Steve Getsiv
		-- Mod Date(s): Nov 7, 2007
		-- Added where clause to only get prod's with 1000 BF or more
		-- =============================================

		CREATE PROCEDURE [dbo].[SP_GetWebProductsList]
		@EntryList as varchar(1000)
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			
			Declare @ProductQuery as varchar(MAX);
			Declare @ConditionClause as varchar(MAX);

			Set @ProductQuery ='SELECT prod_id,short_desc,short_desc+'' - ''+long_desc as both_desc,
				long_desc,web_price,image3filename,image2filename,image1filename,
				grade_code,grain_code,species_code,inventory_label,condition_code,usage_cd,
				size_cd,weight_id,bf_per_sub_bundle,
				default_unit_id from products ';

			-- Set @ConditionClause = 'where 1=1';
			Set @ConditionClause = 'where prod_id in (SELECT prod_id from tickets where status = ''I'' group by prod_id having sum(bf) > 1000)';

			Set @ProductQuery = @ProductQuery + @ConditionClause;
	
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

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER OFF
GO

