--SQL to add the columns first and last name to the address
alter table dbo.cust_address add
	cust_firstname char(60) NULL,
	cust_lastname char(60) NULL
GO
	
	
IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetAddresses'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetAddresses
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 9, 2007
		-- Description:	A stored procedure to check the login of a user
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_GetAddresses
		(@UserId int)
		AS
		BEGIN
			Select cust_addr_id,cust_id,ltrim(rtrim(cust_addr_1)) as cust_addr_1,ltrim(rtrim(cust_addr_2)) as cust_addr_2,
			ltrim(rtrim(cust_city)) as cust_city,ltrim(rtrim(cust_state)) as cust_state,ltrim(rtrim(cust_zip)) as cust_zip,
			ltrim(rtrim(cust_phone))as cust_phone, ltrim(rtrim(cust_fax)) as cust_fax,ltrim(rtrim(cust_firstname)) as cust_firstname,
			ltrim(rtrim(cust_lastname)) as cust_lastname
			 From Cust_address where cust_id=@UserId
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
			@custPhone char(32), @custFax char(32),@custFirstName char(60), @custLastName char(60),
			
			@BillingFirstName char(60), @BillingLastName char(60),@BillingAddress1 char(60), @BillingAddress2 char(60),
			@BillingCity char(40),@BillingState char(2), @BillingZip char(16),@BillingPhone char(32),@BillingFax char(32)
			
		)
		AS
		BEGIN
			if @AddressId <=0 --create a new address if one wasn't selected from a previous one
			BEGIN
				Insert into cust_address (cust_id,cust_addr_1,cust_addr_2,cust_city,cust_state,cust_zip,cust_phone,
				cust_fax,cust_type,cust_firstname,cust_lastname) 
				values (@CustomerId,@custAddress1,@CustAddress2,@CustCity,@CustState,@CustZip,
				@custPhone,@custFax,'S',@custFirstName,@custLastName)
				
				set @AddressId =Scope_Identity();
			END
			
			if @BillingAddressId <=0 --Create a new address if one wasn't selected from prev. list (id is null if none selected, and none entered!)
			BEGIN
				Insert into cust_address (cust_id,cust_addr_1,cust_addr_2,cust_city,cust_state,cust_zip,cust_phone,
				cust_fax,cust_type,cust_firstname,cust_lastname)
				 values (@CustomerId,@BillingAddress1,@BillingAddress2,@BillingCity,@BillingState,@BillingZip,
				@BillingPhone,@BillingFax,'B',@BillingFirstName,@BillingLastName)
				
				set @BillingAddressId = Scope_Identity();
			END
			
			Update web_order set AddressId=@AddressId,Status=@Status,ShippingOption=@ShippingOption,BillingAddressId = @BillingAddressId
			 where OrderId=@OrderId
			
			
			select OrderId,CustomerId,AddressId,BillingAddressId, CartId,Status,ShippingOption from web_Order where OrderId=@OrderId
		END
GO

CREATE TABLE dbo.web_ExpressOrderTokens
	(
	OrderId int NOT NULL,
	CartId uniqueidentifier NOT NULL,
	Token varchar(100) NOT NULL,
	InsertDate datetime NOT NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.web_ExpressOrderTokens ADD CONSTRAINT
	PK_web_ExpressOrderTokens PRIMARY KEY CLUSTERED 
	(
	OrderId,
	CartId,
	Token,
	InsertDate
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]



IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_InsertExpressToken'))
	BEGIN
		DROP PROCEDURE dbo.SP_InsertExpressToken
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 24, 2007
		-- Description:	A stored procedure to handle the beginning of express checkout stuff
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_InsertExpressToken
		(
			@OrderId int,@CartId uniqueidentifier, @token varchar(100)
		)
		AS
		BEGIN
			insert into web_ExpressOrderTokens (OrderId,CartId,Token,InsertDate) values
				(@OrderId,@CartId,@token,getdate())
		END
GO

IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetExpressToken'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetExpressToken
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 24, 2007
		-- Description:	A stored procedure to get an express checkout's token
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_GetExpressToken
		(
			@token varchar(100)
		)
		AS
		BEGIN
			Declare @OrderId as int
			select top 1 @OrderId=OrderId from web_ExpressOrderTokens where token = @token
				order by InsertDate desc
				
			select OrderId,CustomerId,AddressId,BillingAddressId,CartId,Status,ShippingOption from web_Order where OrderId=@OrderId
		END
GO