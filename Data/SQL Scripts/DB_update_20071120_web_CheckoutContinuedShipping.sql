BEGIN TRANSACTION
SET QUOTED_IDENTIFIER ON
SET ARITHABORT ON
SET NUMERIC_ROUNDABORT OFF
SET CONCAT_NULL_YIELDS_NULL ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.web_Order ADD
	ShippingOption int NULL,
	BillingAddressId int NULL
GO
COMMIT


IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_CreateWebOrder'))
	BEGIN
		DROP PROCEDURE dbo.[SP_CreateWebOrder]
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 9, 2007
		-- Description:	A stored procedure to Create a new order
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_CreateWebOrder
		(
			@CartId uniqueidentifier,
			@UserId int
		)
		AS
		BEGIN
			declare @OrderId int
			select @OrderId = OrderId from web_order where CartId=@CartId and CustomerId =@UserId and Status<>'S'
			--Will reload an order if one is already open for this cart
			if @OrderId=0 or @OrderId is null
			BEGIN
				insert into web_order(CustomerId,AddressId,CartId,Status) values 
						(@UserId,null,@CartId, 'I')--I means initial, S is submitted, 1 is end-step 1, etc.
			
				set @OrderId= scope_identity()
			END
			select OrderId,CustomerId,AddressId,BillingAddressId,CartId,Status,ShippingOption from web_Order where OrderId=@OrderId
		END
GO


IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_SaveWebOrder'))
	BEGIN
		DROP PROCEDURE dbo.SP_SaveWebOrder
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 9, 2007
		-- Description:	A stored procedure to Create a new order
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_SaveWebOrder
		(
			@OrderId int,@CustomerId int,@AddressId int, @BillingAddressId int, @Status char(1),@ShippingOption int,
			@custAddress1 char(60), @custAddress2 char(60),@custCity char(40),@custState char(2), @custZip char(16),
			@custPhone char(32), @custFax char(32),
			
			@BillingFirstName char(60), @BillingLastName char(60),@BillingAddress1 char(60), @BillingAddress2 char(60),
			@BillingCity char(40),@BillingState char(2), @BillingZip char(16),@BillingPhone char(32),@BillingFax char(32)
			
		)
		AS
		BEGIN
			if @AddressId <=0 --create a new address if one wasn't selected from a previous one
			BEGIN
				Insert into cust_address (cust_id,cust_addr_1,cust_addr_2,cust_city,cust_state,cust_zip,cust_phone,
				cust_fax,cust_type) values (@CustomerId,@custAddress1,@CustAddress2,@CustCity,@CustState,@CustZip,
				@custPhone,@custFax,'S')
				
				set @AddressId =Scope_Identity();
			END
			
			if @BillingAddressId <=0 --Create a new address if one wasn't selected from prev. list (id is null if none selected, and none entered!)
			BEGIN
				Insert into cust_address (cust_id,cust_addr_1,cust_addr_2,cust_city,cust_state,cust_zip,cust_phone,
				cust_fax,cust_type) values (@CustomerId,@BillingAddress1,@BillingAddress2,@BillingCity,@BillingState,@BillingZip,
				@BillingPhone,@BillingFax,'B')
				
				set @BillingAddressId = Scope_Identity();
			END
			
			Update web_order set AddressId=@AddressId,Status=@Status,ShippingOption=@ShippingOption,BillingAddressId = @BillingAddressId
			 where OrderId=@OrderId
			
			
			select OrderId,CustomerId,AddressId,BillingAddressId, CartId,Status,ShippingOption from web_Order where OrderId=@OrderId
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

			Select CartId,products.prod_id as ProdId,Quantity,[Order],products.short_desc as Description,
						products.web_price*products.bf_per_unit_of_sale as Price,
						(weight_class.weight_per_mbf*products.bf_per_unit_of_sale*Quantity)/1000.00 as Weight
						 from web_cartRow 
					inner join products on web_CartRow.prod_id=products.prod_id
					inner join weight_class on products.weight_id = weight_class.weight_id
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
					select @Order = isnull((Max([Order])+1),0) from web_CartRow where CartId=@CartId
					insert into web_CartRow (CartId,prod_id,Quantity,[Order]) values
							(@CartId,@ProductId,@QuantityToAdd,@Order)
				select 1;
				END
			END
			return -1;
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



IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_SetCartStatus'))
		BEGIN
			DROP PROCEDURE dbo.SP_SetCartStatus
		END
		GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: October 22, 2007
		-- Description:	A stored procedure to add an item to the user's cart
		-- =============================================
		CREATE PROCEDURE SP_SetCartStatus 
		( @CartId uniqueidentifier,
			@Status char(1))
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			
			if (select count(*) from web_Cart where CartId=@CartId)=1
			BEGIN
				 update web_Cart set CheckOutStatus = @Status,LastUpdated=GetDate() where CartId=@CartId
			END	
		END
		GO
		
		
		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetStateSalesTax'))
		BEGIN
			DROP PROCEDURE dbo.SP_GetStateSalesTax
		END
		GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: October 22, 2007
		-- Description:	A stored procedure to add an item to the user's cart
		-- =============================================
		CREATE PROCEDURE SP_GetStateSalesTax
		( @State char(2),
		  @TaxRate decimal OUTPUT )
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			select @TaxRate = TaxRate from web_States where State=@State
		END
		GO