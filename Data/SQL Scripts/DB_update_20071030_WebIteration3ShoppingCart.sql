USE [nova]
GO
/****** Object:  Table [dbo].[web_Cart]    Script Date: 10/30/2007 19:47:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO


--Cart
	        	        GO
IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_CartRow') 
        drop table dbo.web_CartRow
        GO
        
        IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_Cart') 
        drop table dbo.web_Cart
        GO



	CREATE TABLE [dbo].[web_Cart](
		[CartId] [uniqueidentifier] NOT NULL,
		[LastUpdated] [datetime] NOT NULL,
		[CheckOutStatus] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL CONSTRAINT [DF_web_Cart_CheckOutStatus]  DEFAULT ('N'),
	 CONSTRAINT [PK_web_Cart] PRIMARY KEY CLUSTERED 
	(
		[CartId] ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]

	GO
	SET ANSI_PADDING OFF
	
	
	CREATE TABLE [dbo].[web_CartRow](
		[CartId] [uniqueidentifier] ROWGUIDCOL  NOT NULL,
		[prod_id] [int] NOT NULL,
		[Quantity] [int] NOT NULL CONSTRAINT [DF_web_CartRow_Quantity]  DEFAULT ((1)),
		[Order] [int] NOT NULL,
	 CONSTRAINT [PK_web_CartRow] PRIMARY KEY CLUSTERED 
	(
		[CartId] ASC,
		[prod_id] ASC
	)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
	) ON [PRIMARY]

	GO
	ALTER TABLE [dbo].[web_CartRow]  WITH CHECK ADD  CONSTRAINT [FK_web_CartRow_products] FOREIGN KEY([prod_id])
	REFERENCES [dbo].[products] ([prod_id])
	GO
	ALTER TABLE [dbo].[web_CartRow] CHECK CONSTRAINT [FK_web_CartRow_products]
	GO
	ALTER TABLE [dbo].[web_CartRow]  WITH CHECK ADD  CONSTRAINT [FK_web_CartRow_web_Cart] FOREIGN KEY([CartId])
	REFERENCES [dbo].[web_Cart] ([CartId])
	GO
	ALTER TABLE [dbo].[web_CartRow] CHECK CONSTRAINT [FK_web_CartRow_web_Cart]
	GO
	
	
	
	--Cart SP's
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
		
		IF @CartId is null OR 0=(Select count(*) from web_Cart where CartId=@CartId)
		BEGIN
			--Create a new cart
			set @CartId = newid();
			INSERT INTO web_Cart (CartId,LastUpdated) values(@CartId, GetDate())
			
		END
		
			-- Get current cart data
			Declare @ItemCount int
			Declare @OrderTotal money

			Select @ItemCount = IsNull(Sum(Quantity),0) from web_CartRow where CartId=@CartId

			Select @OrderTotal = IsNull(Sum(Quantity * products.web_price*products.bf_per_sub_bundle),0) from web_CartRow 
			join products on web_CartRow.prod_id=products.prod_id
			where CartId=@CartId

			select CartId,@ItemCount as ItemCount,@OrderTotal as OrderTotal from web_Cart where CartId=@CartId
			
			Select CartId,products.prod_id as ProdId,Quantity,[Order],products.short_desc as Description,
						products.web_price*products.bf_per_sub_bundle as Price from web_cartRow 
					inner join products on web_CartRow.prod_id=products.prod_id
					where CartId=@CartId order by [Order]
		
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
			
			if (select count(*) from web_Cart where CartId=@CartId)=1 AND 
				(select count(*) from products where prod_id=@ProductId)=1 AND
				@QuantityToAdd > 0
			BEGIN
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
					select @Order = isnull((Max([Order])+1),0) from web_CartRow where CartId=@CartId
					insert into web_CartRow (CartId,prod_id,Quantity,[Order]) values
							(@CartId,@ProductId,@QuantityToAdd,@Order)
				select 1;
				END
			END
			--Else, do nothing, how can there be a bad cart?
			
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
			
			if (select count(*) from web_Cart where CartId=@CartId)=1
			BEGIN
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
								select @Order = isnull((Max([Order])+1),0) from web_CartRow where CartId=@CartId
								insert into web_CartRow (CartId,prod_id,Quantity,[Order]) values
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



