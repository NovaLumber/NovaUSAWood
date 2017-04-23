
--Script to add 'receive email' bit field
/* To prevent any potential data loss issues, you should review this script in detail before running it outside the context of the database designer.*/
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
ALTER TABLE dbo.customer ADD
	receive_email bit NOT NULL CONSTRAINT DF_customer_receive_email DEFAULT 0,
	first_name char(60) NULL,
	last_name char(60) NULL
GO
COMMIT



IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_CreateWebAccount'))
	BEGIN
		DROP PROCEDURE dbo.[SP_CreateWebAccount]
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 9, 2007
		-- Description:	A stored procedure to create the login of a user
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_CreateWebAccount
		(
			@EmailAddress varchar(100),
			@PasswordHash char(32),
			@CompanyName char(60),
			@ReceiveEmail bit=0,
			@FirstName char(60),
			@LastName char(60),
			@CustSortCode char(10)
			
		)
		AS
		BEGIN
			if EXISTS(select 1 from customer where email_address=@EmailAddress)
				return -2;
				
				
			Insert Into Customer (cust_sort_code,cust_name,cust_established_date,cust_last_update_date,
				cust_prim_salesmanid, cust_status, email_address,password,receive_email,first_name,last_name)
				values
				(@CustSortCode,@CompanyName,getDate(),getDate(),1,'A',@EmailAddress,@PasswordHash,@ReceiveEmail,@FirstName,@LastName);
			
			
			return SCOPE_IDENTITY();
		END
GO


GO

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
			select OrderId,CustomerId,AddressId,CartId,Status from web_Order where OrderId=@OrderId
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
		
		IF @CartId is null OR 0=(Select count(*) from web_Cart where CartId=@CartId and CheckOutStatus='N')
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

			Select @OrderSubTotal = IsNull(Sum(Quantity * products.web_price*products.bf_per_sub_bundle),0),
			@WeightTotal = IsNull(Sum((weight_class.weight_per_mbf*products.bf_per_sub_bundle*Quantity)/1000.00),0)
			from web_CartRow 
			join products on web_CartRow.prod_id=products.prod_id
			join weight_class on products.weight_id=weight_class.weight_id
			where CartId=@CartId
			
			select CartId,@ItemCount as ItemCount,@OrderSubTotal as OrderSubTotal,@WeightTotal as WeightTotal
				from web_Cart where CartId=@CartId

			Select CartId,products.prod_id as ProdId,Quantity,[Order],products.short_desc as Description,
						products.web_price*products.bf_per_sub_bundle as Price,
						(weight_class.weight_per_mbf*products.bf_per_sub_bundle*Quantity)/1000.00 as Weight
						 from web_cartRow 
					inner join products on web_CartRow.prod_id=products.prod_id
					inner join weight_class on products.weight_id = weight_class.weight_id
					where CartId=@CartId order by [Order]
		
	END
	GO