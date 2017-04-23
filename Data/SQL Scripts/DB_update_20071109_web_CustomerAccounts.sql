
--Makes alterations to the customer table, as required
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
ALTER TABLE dbo.customer
	DROP CONSTRAINT DF__customer__entere__6462DE5A
GO
ALTER TABLE dbo.customer
	DROP CONSTRAINT DF__customer__last_m__65570293
GO
CREATE TABLE dbo.Tmp_customer
	(
	cust_id int NOT NULL IDENTITY (1, 1),
	cust_sort_code char(20) NOT NULL,
	cust_name char(60) NOT NULL,
	cust_established_date datetime NOT NULL,
	cust_last_update_date datetime NOT NULL,
	cust_prim_salesmanid smallint NOT NULL,
	cust_status char(2) NOT NULL,
	cust_DB char(15) NULL,
	cust_Redbook char(15) NULL,
	credit_limit real NULL,
	DB_monitor char(2) NULL,
	terms_id char(12) NULL,
	entered_by char(32) NOT NULL,
	last_modified_by char(32) NOT NULL,
	email_address varchar(100) NULL,
	password char(32) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_customer ADD CONSTRAINT
	DF__customer__entere__6462DE5A DEFAULT (' ') FOR entered_by
GO
ALTER TABLE dbo.Tmp_customer ADD CONSTRAINT
	DF__customer__last_m__65570293 DEFAULT (' ') FOR last_modified_by
GO
SET IDENTITY_INSERT dbo.Tmp_customer ON
GO
IF EXISTS(SELECT * FROM dbo.customer)
	 EXEC('INSERT INTO dbo.Tmp_customer (cust_id, cust_sort_code, cust_name, cust_established_date, cust_last_update_date, cust_prim_salesmanid, cust_status, cust_DB, cust_Redbook, credit_limit, DB_monitor, terms_id, entered_by, last_modified_by)
		SELECT cust_id, cust_sort_code, cust_name, cust_established_date, cust_last_update_date, cust_prim_salesmanid, cust_status, cust_DB, cust_Redbook, credit_limit, DB_monitor, terms_id, entered_by, last_modified_by FROM dbo.customer WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_customer OFF
GO
ALTER TABLE dbo.cust_address
	DROP CONSTRAINT FK_CUST_ADD_HAS12_CUSTOMER
GO
ALTER TABLE dbo.cust_contacts
	DROP CONSTRAINT FK_CUST_CON_HAS14_CUSTOMER
GO
ALTER TABLE dbo.cust_notes
	DROP CONSTRAINT FK_CUST_NOT_HAS10_CUSTOMER
GO
DROP TABLE dbo.customer
GO
EXECUTE sp_rename N'dbo.Tmp_customer', N'customer', 'OBJECT' 
GO
ALTER TABLE dbo.customer ADD CONSTRAINT
	PK_CUSTOMER PRIMARY KEY CLUSTERED 
	(
	cust_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE UNIQUE NONCLUSTERED INDEX comp_id_name ON dbo.customer
	(
	cust_id,
	cust_name
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX ind3 ON dbo.customer
	(
	cust_status
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE UNIQUE NONCLUSTERED INDEX index2 ON dbo.customer
	(
	cust_sort_code
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX name ON dbo.customer
	(
	cust_name
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE TRIGGER [insert_cust] ON dbo.customer 
FOR INSERT as

/*4/18/01 new to track user_id */
	UPDATE customer SET entered_by = system_user
		FROM inserted
		WHERE customer.cust_id = inserted.cust_id
/*end of user_id stuff */


insert log_cust_changes
select cust_id, 'A', getdate(), null, 'N', space(1)  from inserted
GO
CREATE TRIGGER [update_cust] ON dbo.customer 
FOR UPDATE as

/*4/18/01 new to track user_id */
	UPDATE customer SET last_modified_by = system_user
		FROM inserted
		WHERE customer.cust_id = inserted.cust_id AND system_user <> 'sa'
/*end of user_id stuff */


/* customer name needs special handling for QuickBooks interface as this is used as the key for A/R invoice downloads */
if update (cust_name)
begin
insert log_cust_changes
select cust_id, 'C', getdate(), null, 'N' , 'cust_name' from inserted
end
else
begin
insert log_cust_changes
select cust_id, 'C', getdate(), null, 'N' ,space(1)  from inserted
end
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.cust_notes ADD CONSTRAINT
	FK_CUST_NOT_HAS10_CUSTOMER FOREIGN KEY
	(
	cust_id
	) REFERENCES dbo.customer
	(
	cust_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.cust_contacts ADD CONSTRAINT
	FK_CUST_CON_HAS14_CUSTOMER FOREIGN KEY
	(
	cust_id
	) REFERENCES dbo.customer
	(
	cust_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.cust_address ADD CONSTRAINT
	FK_CUST_ADD_HAS12_CUSTOMER FOREIGN KEY
	(
	cust_id
	) REFERENCES dbo.customer
	(
	cust_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT

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
ALTER TABLE dbo.cust_address
	DROP CONSTRAINT FK_CUST_ADD_HAS12_CUSTOMER
GO
COMMIT
BEGIN TRANSACTION
GO
ALTER TABLE dbo.cust_address
	DROP CONSTRAINT DF_cust_address_cust_city
GO
ALTER TABLE dbo.cust_address
	DROP CONSTRAINT DF_cust_address_cust_state
GO
ALTER TABLE dbo.cust_address
	DROP CONSTRAINT DF_cust_address_cust_zip
GO
CREATE TABLE dbo.Tmp_cust_address
	(
	cust_addr_id int NOT NULL IDENTITY (1, 1),
	cust_id int NOT NULL,
	cust_addr_1 char(60) NULL,
	cust_addr_2 char(60) NULL,
	cust_city char(40) NULL,
	cust_state char(2) NOT NULL,
	cust_zip char(16) NULL,
	cust_country char(40) NULL,
	cust_phone char(32) NULL,
	cust_fax char(32) NULL,
	cust_type char(10) NULL,
	cust_desc char(40) NULL
	)  ON [PRIMARY]
GO
ALTER TABLE dbo.Tmp_cust_address ADD CONSTRAINT
	DF_cust_address_cust_city DEFAULT (' ') FOR cust_city
GO
ALTER TABLE dbo.Tmp_cust_address ADD CONSTRAINT
	DF_cust_address_cust_state DEFAULT (' ') FOR cust_state
GO
ALTER TABLE dbo.Tmp_cust_address ADD CONSTRAINT
	DF_cust_address_cust_zip DEFAULT (' ') FOR cust_zip
GO
SET IDENTITY_INSERT dbo.Tmp_cust_address ON
GO
IF EXISTS(SELECT * FROM dbo.cust_address)
	 EXEC('INSERT INTO dbo.Tmp_cust_address (cust_addr_id, cust_id, cust_addr_1, cust_addr_2, cust_city, cust_state, cust_zip, cust_country, cust_phone, cust_fax, cust_type, cust_desc)
		SELECT cust_addr_id, cust_id, cust_addr_1, cust_addr_2, cust_city, cust_state, cust_zip, cust_country, cust_phone, cust_fax, cust_type, cust_desc FROM dbo.cust_address WITH (HOLDLOCK TABLOCKX)')
GO
SET IDENTITY_INSERT dbo.Tmp_cust_address OFF
GO
DROP TABLE dbo.cust_address
GO
EXECUTE sp_rename N'dbo.Tmp_cust_address', N'cust_address', 'OBJECT' 
GO
ALTER TABLE dbo.cust_address ADD CONSTRAINT
	PK_cust_address_1__17 PRIMARY KEY CLUSTERED 
	(
	cust_addr_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

GO
CREATE NONCLUSTERED INDEX city ON dbo.cust_address
	(
	cust_city
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
CREATE NONCLUSTERED INDEX has12_FK ON dbo.cust_address
	(
	cust_id
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE dbo.cust_address ADD CONSTRAINT
	FK_CUST_ADD_HAS12_CUSTOMER FOREIGN KEY
	(
	cust_id
	) REFERENCES dbo.customer
	(
	cust_id
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO
COMMIT




GO

IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetLogin'))
	BEGIN
		DROP PROCEDURE dbo.[SP_GetLogin]
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 9, 2007
		-- Description:	A stored procedure to check the login of a user
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_GetLogin 
		(
			@EmailAddress varchar(100),
			@PasswordHash char(32)
		)
		AS
		BEGIN
			Declare @UserId int 
			set @UserId = null
			SELECT @UserId=cust_id from customer where email_address=@EmailAddress and password=@PasswordHash
			return @UserId
		END
GO


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
			@CompanyName char(60)
		)
		AS
		BEGIN
			if EXISTS(select 1 from customer where email_address=@EmailAddress)
				return -2;
				
				
			Insert Into Customer (cust_sort_code,cust_name,cust_established_date,cust_last_update_date,
				cust_prim_salesmanid, cust_status, email_address,password)
				values
				('WEB_ENTERED',@CompanyName,getDate(),getDate(),1,'A',@EmailAddress,@PasswordHash);
			
			
			return SCOPE_IDENTITY();
		END
GO


IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetStates'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetStates
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 9, 2007
		-- Description:	A stored procedure to Get the list of states
		-- =============================================
		
		CREATE PROCEDURE [dbo].SP_GetStates
		AS
		BEGIN
			select State from web_states order by State
		END
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
			ltrim(rtrim(cust_phone))as cust_phone, ltrim(rtrim(cust_fax)) as cust_fax
			 From Cust_address where cust_id=@UserId
		END
GO





GO
/****** Object:  Table [dbo].[web_Order]    Script Date: 11/10/2007 16:02:37 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[web_Order](
	[OrderId] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[AddressId] [int] NULL,
	[CartId] [uniqueidentifier] NOT NULL,
	[Status] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_web_Order] PRIMARY KEY CLUSTERED 
(
	[OrderId] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
ALTER TABLE [dbo].[web_Order]  WITH CHECK ADD  CONSTRAINT [FK_web_Order_cust_address] FOREIGN KEY([AddressId])
REFERENCES [dbo].[cust_address] ([cust_addr_id])
GO
ALTER TABLE [dbo].[web_Order] CHECK CONSTRAINT [FK_web_Order_cust_address]
GO
ALTER TABLE [dbo].[web_Order]  WITH CHECK ADD  CONSTRAINT [FK_web_Order_customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[customer] ([cust_id])
GO
ALTER TABLE [dbo].[web_Order] CHECK CONSTRAINT [FK_web_Order_customer]
GO
ALTER TABLE [dbo].[web_Order]  WITH CHECK ADD  CONSTRAINT [FK_web_Order_web_Cart] FOREIGN KEY([CartId])
REFERENCES [dbo].[web_Cart] ([CartId])
GO
ALTER TABLE [dbo].[web_Order] CHECK CONSTRAINT [FK_web_Order_web_Cart]





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
			if @OrderId=0	
			BEGIN
				insert into web_order(CustomerId,AddressId,CartId,Status) values 
						(@UserId,null,@CartId, 'I')--I means initial, S is submitted, 1 is end-step 1, etc.
			
				set @OrderId= scope_identity()
			END
			select OrderId,CustomerId,AddressId,CartId,Status from web_Order where OrderId=@OrderId
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
			@OrderId int,@CustomerId int,@AddressId int,@Status char(1),
			@custAddress1 char(60), @custAddress2 char(60),@custCity char(40),@custState char(2), @custZip char(16),
			@custPhone char(32), @custFax char(32)
			
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
			
			Update web_order set AddressId=@AddressId,Status=@Status where OrderId=@OrderId
			
			
			select OrderId,CustomerId,AddressId,CartId,Status from web_Order where OrderId=@OrderId
		END
GO
