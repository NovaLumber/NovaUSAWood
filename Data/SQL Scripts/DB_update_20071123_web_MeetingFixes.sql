
	--Order in web_LocationJoin
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_AttributeLocationJoin'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_AttributeLocationJoin'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_AttributeLocationJoin.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_AttributeLocationJoin add Sort_Order int NOT NULL Default(0)
			END
	End


	--Order in CartRow
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_CartRow'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_CartRow'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_CartRow.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_CartRow add Sort_Order int NOT NULL Default(0)
			END
	End


	--Order in Filter
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_Filters'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_Filters'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_Filters.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_Filters add Sort_Order int NOT NULL Default(0)
			END
	End


	--Order in FilterEntries
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_FilterEntries'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_FilterEntries'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_FilterEntries.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_FilterEntries add Sort_Order int NOT NULL Default(0)
			END
	End


	--Order in LearnDocumentJoin
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_LearnDocumentJoin'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_LearnDocumentJoin'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_LearnDocumentJoin.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_LearnDocumentJoin add Sort_Order int NOT NULL Default(0)
			END
	End





	--Order in Location
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_Location'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_Location'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_Location.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_Location add Sort_Order int NOT NULL Default(0)
			END
	End



	--Order in Location_Hours
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_Location_Hours'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_Location_Hours'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_Location_Hours.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_Location_Hours add Sort_Order int NOT NULL Default(0)
			END
	End



	--Order in Location_Category
	if NOT exists ( select * from INFORMATION_SCHEMA.COLUMNS
	where TABLE_NAME='web_Location_Category'
	and COLUMN_NAME='Sort_Order' )
	Begin

		if exists( select * from INFORMATION_SCHEMA.COLUMNS
			where TABLE_NAME='web_Location_Category'
			and COLUMN_NAME='Order' )--Rename
			BEGIN
				EXECUTE sp_rename N'dbo.web_Location_Category.[Order]', N'Sort_Order', 'COLUMN' 
			END
		else--Create column
			BEGIN
			alter table web_Location_Category add Sort_Order int NOT NULL Default(0)
			END
	End



	--ALL The SP change scripts for the order->Sort_Order:
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

			select [CategoryId],[CategoryName],[CategoryDesc] from [Web_Location_Category] order By Sort_Order ASC
			select [LocationId],[CategoryId],[Name],[Address1],[Address2],[City],
				[State],[ZipCode],[PhoneNumber],[EmailAddress] from [Web_Location] order By Sort_Order ASC
			select [HoursId],[LocationId],[HoursString] from Web_Location_Hours order By Sort_Order ASC
		END
		GO
		
		
		
		
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

			select web_LearnDocument.DocumentId,DocumentAddress,DocumentName,DocumentDesc,Sort_Order,web_LearnDocumentJoin.LearnNodeId
				 from web_LearnDocument
				inner join web_LearnDocumentJoin on web_LearnDocument.DocumentId=web_LearnDocumentJoin.DocumentId
				where web_LearnDocumentJoin.LearnNodeId = @NodeId order by Sort_Order
		END
		GO
		
		
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
						
						SELECT AttributeName,Sort_Order,AttributeText,AttributeDesc from web_AttributeLocations
							right outer join [web_AttributeLocationJoin] on web_AttributeLocationJoin.LocationId=web_AttributeLocations.LocationId
							right outer join [web_Attributes] on web_attributelocationjoin.AttributeId=web_Attributes.AttributeId
							where LocationName=@LocationName and Sort_Order>=0 order by Sort_Order
					END
				GO
		
		
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
						select FilterId,FilterName,FilterDescr from web_Filters order by Sort_Order 
						Select EntryId,FilterId,EntryName,EntryDescr,0 as CountIfAdded from web_FilterEntries order by Sort_Order
					END
				GO
		GO
		
		
		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebProductsList'))
		BEGIN
			DROP PROCEDURE dbo.[SP_GetWebProductsList]
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
					size_cd,weight_id,bf_per_unit_of_sale,
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


		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_AddItemToCart'))
			BEGIN
				DROP PROCEDURE dbo.SP_AddItemToCart 
			END
			GO
			-- =============================================
			-- Author:		Erich Keane
			-- Create date: October 22, 2007
			-- Description:	A stored procedure to add an item to the user's cart
			-- =============================================
			CREATE PROCEDURE SP_AddItemToCart 
			( @CartId uniqueidentifier,
				@ProductId int,
				@QuantityToAdd int)
			AS
			BEGIN
				-- SET NOCOUNT ON added to prevent extra result sets from
				-- interfering with SELECT statements.
				SET NOCOUNT ON;
				
				if (select count(*) from web_Cart where CartId=@CartId and CheckoutStatus='N')=1 AND 
					(select count(*) from products where prod_id=@ProductId)=1 AND
					@QuantityToAdd > 0
				BEGIN
					update web_Cart set LastUpdated=getDate() where CartId=@CartId and CheckOutStatus = 'N' 
					if(select count(*) from web_CartRow where CartId=@CartId AND prod_id=@ProductId )=1
					BEGIN
						declare @curQuantity as int;
						select @curQuantity = Quantity from web_CartRow where CartId=@CartId AND prod_id=@ProductId;
						update web_CartRow set Quantity = (@curQuantity + @QuantityToAdd)
							 where CartId=@CartId AND prod_id=@ProductId;
					END
					ELSE--Entry doesn't exist for this item
					BEGIN
						declare @Order as int;
						select @Order = isnull((Max(Sort_Order)+1),0) from web_CartRow where CartId=@CartId
						insert into web_CartRow (CartId,prod_id,Quantity,Sort_Order) values
								(@CartId,@ProductId,@QuantityToAdd,@Order)
					select 1;
					END
				END
				return -1;
				--Else, do nothing, how can there be a bad cart?
				
			END
			GO
			
			
			IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetCart'))
		BEGIN
			DROP PROCEDURE dbo.SP_GetCart
		END
		GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: October 22, 2007
		-- Description:	A stored procedure to get the current user's cart for the web project
		-- =============================================
		CREATE PROCEDURE SP_GetCart 
		( @CartId uniqueidentifier = null )
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			--Status' are 'N'ew, 'F'inalized, or 'S'ubmitted
			IF @CartId is null OR 0=(Select count(*) from web_Cart where CartId=@CartId and (CheckOutStatus='N' or CheckOutStatus='F'))
			BEGIN
				--Create a new cart
				set @CartId = newid();
				INSERT INTO web_Cart (CartId,LastUpdated) values(@CartId, GetDate())
				
			END
			
				-- Get current cart data
				Declare @ItemCount int
				Declare @OrderSubTotal money
				Declare @WeightTotal float 
				
				Select @ItemCount = IsNull(Sum(Quantity),0) from web_CartRow where CartId=@CartId 

				Select @OrderSubTotal = IsNull(Sum(Quantity * products.web_price*products.bf_per_unit_of_sale),0),
				@WeightTotal = IsNull(Sum((weight_class.weight_per_mbf*products.bf_per_unit_of_sale*Quantity)/1000.00),0)
				from web_CartRow 
				join products on web_CartRow.prod_id=products.prod_id
				join weight_class on products.weight_id=weight_class.weight_id
				where CartId=@CartId
				
				select CartId,@ItemCount as ItemCount,@OrderSubTotal as OrderSubTotal,@WeightTotal as WeightTotal,CheckOutStatus
					from web_Cart where CartId=@CartId

				Select CartId,products.prod_id as ProdId,Quantity,Sort_Order,products.short_desc as Description,
							products.web_price*products.bf_per_unit_of_sale as Price,
							(weight_class.weight_per_mbf*products.bf_per_unit_of_sale*Quantity)/1000.00 as Weight
							 from web_cartRow 
						inner join products on web_CartRow.prod_id=products.prod_id
						inner join weight_class on products.weight_id = weight_class.weight_id
						where CartId=@CartId order by Sort_Order
			
		END
		GO
		
		
		
		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_UpdateCartItems'))
			BEGIN
				DROP PROCEDURE dbo.SP_UpdateCartItems 
			END
			GO
			-- =============================================
			-- Author:		Erich Keane
			-- Create date: October 22, 2007
			-- Description:	A stored procedure to add an item to the user's cart
			-- =============================================
			CREATE PROCEDURE SP_UpdateCartItems 
			( @CartId uniqueidentifier,
				@ProductIds varchar(max),
				@Quantitys varchar(max))
			AS
			BEGIN
				-- SET NOCOUNT ON added to prevent extra result sets from
				-- interfering with SELECT statements.
				SET NOCOUNT ON;
				
				if (select count(*) from web_Cart where CartId=@CartId and CheckOutStatus = 'N')=1
				BEGIN
					update web_Cart set LastUpdated=getDate() where CartId=@CartId and CheckOutStatus = 'N' 
					--CREATE TABLE #TempAssociation (int ProductId,int Quantity)	
					DECLARE @Product int, @ProdPos int
					DECLARE @Quantity int, @QuantityPos int
						SET @ProductIds = LTRIM(RTRIM(@ProductIds))+ ','
						SET @ProdPos = CHARINDEX(',', @ProductIds, 1)
						SET @Quantitys = LTRIM(RTRIM(@Quantitys))+ ','
						SET @QuantityPos = CHARINDEX(',', @Quantitys, 1)
					
					IF REPLACE(@ProductIds, ',', '') <> '' AND REPLACE(@Quantitys, ',', '') <> ''
						BEGIN
						WHILE @ProdPos > 0 AND @QuantityPos>0
						BEGIN
							SET @Product = LTRIM(RTRIM(LEFT(@ProductIds, @ProdPos - 1)))
							SET @Quantity = LTRIM(RTRIM(LEFT(@Quantitys, @QuantityPos - 1)))
							if (select count(*) from products where prod_id =@Product)=1 AND @Quantity>=0
							BEGIN
								
								if(select count(*) from web_CartRow where prod_id=@Product AND CartId=@CartId)>0
								BEGIN
									--Delete if quantity is 0
									if @Quantity = 0
										DELETE FROM web_CartRow where prod_id=@Product AND CartId=@CartId
									else--Update if product does exist
										UPDATE web_CartRow set Quantity = @Quantity where prod_id=@Product AND CartId=@CartId
								END
								ELSE
								BEGIN 
									--Insert if product doesnt exist in cart
									declare @Order as int;
									select @Order = isnull((Max(Sort_Order)+1),0) from web_CartRow where CartId=@CartId
									insert into web_CartRow (CartId,prod_id,Quantity,Sort_Order) values
										(@CartId,@Product,@Quantity,@Order)
								END
							END
							SET @ProductIds = RIGHT(@ProductIds, LEN(@ProductIds) - @ProdPos)
							SET @ProdPos = CHARINDEX(',', @ProductIds, 1)
							SET @Quantitys = RIGHT(@Quantitys, LEN(@Quantitys) - @QuantityPos)
							SET @QuantityPos = CHARINDEX(',', @Quantitys, 1)
						END
					END
				END	
			END
			GO
