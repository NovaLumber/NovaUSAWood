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
			--in the case where its an invalid learnnodeid, send to top most
			if(@NodeId is null OR (select count(*) from web_LearnNode where LearnNodeId=@NodeId)=0)
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
		
		
		
		GO
		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetPromotions'))
		BEGIN
			DROP PROCEDURE dbo.SP_GetPromotions
		END
		GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 24, 2007
		-- Description:	A stored procedure to get the Promotions for the front page
		-- =============================================
		CREATE PROCEDURE SP_GetPromotions
		@NodeId as int = null
		AS
		BEGIN
			select promotion.promo_id,title,subtitle,FilterEntry_id,description,image2filename as [image],image1filename as thumbImage
			 from promotion 
			join products on products.prod_id = promotion.prod_id
			order by sort_order ASC
		END
		GO
		
		
		
	--Table to hold data once the order is submitted	
	CREATE TABLE dbo.web_SubmittedOrderData
	(
	OrderId int NOT NULL,
	SubTotal money NOT NULL,
	TaxCost money NOT NULL,
	ShippingOptionId int NOT NULL,
	ShippingOptionName varchar(MAX) NOT NULL,
	ShippingCost money NOT NULL,
	Total money NOT NULL,
	SubmittedDate datetime NOT NULL
	)  ON [PRIMARY]
	 TEXTIMAGE_ON [PRIMARY]
	GO
	ALTER TABLE dbo.web_SubmittedOrderData ADD CONSTRAINT
	PK_web_SubmittedOrderData PRIMARY KEY CLUSTERED 
	(
	OrderId
	) WITH( STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]

	GO
	ALTER TABLE dbo.web_SubmittedOrderData ADD CONSTRAINT
	FK_web_SubmittedOrderData_web_Order FOREIGN KEY
	(
	OrderId
	) REFERENCES dbo.web_Order
	(
	OrderId
	) ON UPDATE  NO ACTION 
	 ON DELETE  NO ACTION 
	
GO



		
		GO
		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_SetOrderSubmitted'))
		BEGIN
			DROP PROCEDURE dbo.SP_SetOrderSubmitted
		END
		GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 24, 2007
		-- Description:	A stored procedure to get the Promotions for the front page
		-- =============================================
		CREATE PROCEDURE SP_SetOrderSubmitted
		(
			@OrderId int,@Subtotal money,@TaxCost money,@ShippingOptionId int,@ShippingOptionName varchar(max),
			@ShippingCost money, @Total money
		)
		AS
		BEGIN
			if NOT exists (select OrderId from web_SubmittedOrderData where OrderId=@OrderId)
			BEGIN
			update web_Order set Status = 'S' where OrderId=@OrderId
			insert into web_SubmittedOrderData (OrderId,SubTotal,TaxCost,ShippingOptionId,ShippingOptionName,
			ShippingCost,Total, SubmittedDate) values(@OrderId,@SubTotal,@TaxCost,@ShippingOptionId,@ShippingOptionName,
			@ShippingCost,@Total, GetDate())
			END
		END
		GO
		
		
		GO
		IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetSubmittedOrder'))
		BEGIN
			DROP PROCEDURE dbo.SP_GetSubmittedOrder
		END
		GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: November 24, 2007
		-- Description:	A stored procedure to get the Promotions for the front page
		-- =============================================
		CREATE PROCEDURE SP_GetSubmittedOrder
		(
			@OrderId int
		)
		AS
		BEGIN
			--Web Order
			Select BillingAddressId,ShippingOption,CustomerId,Status,CartId,AddressId,OrderId
				from web_Order where OrderId=@OrderId
			--Address Tables
			select cust_firstname,cust_lastname,cust_city,cust_zip,cust_fax,cust_phone,cust_state,
				cust_addr_2,cust_addr_1,cust_id,cust_addr_id
				from cust_address 
				inner join web_order on BillingAddressId=cust_addr_id or AddressId =cust_addr_id
		
			select SubmittedDate,Total,ShippingCost,ShippingOptionName,
			ShippingOptionId,TaxCost,SubTotal,OrderId
			from web_SubmittedOrderData where OrderId = @OrderId
			
			
			
		END
		GO