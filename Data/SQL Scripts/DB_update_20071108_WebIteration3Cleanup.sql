use nova



if EXISTS (select * from sysindexes where name='IX_web_CartRow')
		DROP INDEX dbo.web_cartRow.IX_web_CartRow
CREATE NONCLUSTERED INDEX [IX_web_CartRow] ON [dbo].[web_CartRow] 
(
	[Order] ASC
)WITH (PAD_INDEX  = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF) ON [PRIMARY]


--Cart SP's
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
		
		IF @CartId is null OR 0=(Select count(*) from web_Cart where CartId=@CartId)
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
	
	IF EXISTS (SELECT 1 
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_TYPE='BASE TABLE' 
    AND TABLE_NAME='web_States') 
        drop table dbo.web_states
        GO
	
	GO
/****** Object:  Table [dbo].[web_States]    Script Date: 11/09/2007 18:32:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[web_States](
	[State] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TaxRate] [float] NOT NULL,
 CONSTRAINT [PK_web_States] PRIMARY KEY CLUSTERED 
(
	[State] ASC
)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]

GO
	
	truncate table web_states
		INSERT INTO web_States (TaxRate,State) values (4.00,'AL')
		INSERT INTO web_States (TaxRate,State) values (0,'AK')
		INSERT INTO web_States (TaxRate,State) values (5.60,'AZ')
		INSERT INTO web_States (TaxRate,State) values (6.00,'AR')
		INSERT INTO web_States (TaxRate,State) values (6.00,'CA')
		INSERT INTO web_States (TaxRate,State) values (2.90,'CO')
		INSERT INTO web_States (TaxRate,State) values (6.00,'CT')
		INSERT INTO web_States (TaxRate,State) values (0,'DE')
		INSERT INTO web_States (TaxRate,State) values (6.00,'FL')
		INSERT INTO web_States (TaxRate,State) values (4.00,'GA')
		INSERT INTO web_States (TaxRate,State) values (4.00,'HI')
		INSERT INTO web_States (TaxRate,State) values (6.00,'ID')
		INSERT INTO web_States (TaxRate,State) values (6.25,'IL')
		INSERT INTO web_States (TaxRate,State) values (6.00,'IN')
		INSERT INTO web_States (TaxRate,State) values (5.00,'IA')
		INSERT INTO web_States (TaxRate,State) values (5.30,'KS')
		INSERT INTO web_States (TaxRate,State) values (6.00,'KY')
		INSERT INTO web_States (TaxRate,State) values (4.00,'LA')
		INSERT INTO web_States (TaxRate,State) values (5.00,'ME')
		INSERT INTO web_States (TaxRate,State) values (5.00,'MD')
		INSERT INTO web_States (TaxRate,State) values (5.00,'MA')
		INSERT INTO web_States (TaxRate,State) values (6.00,'MI')
		INSERT INTO web_States (TaxRate,State) values (6.50,'MN')
		INSERT INTO web_States (TaxRate,State) values (7.00,'MS')
		INSERT INTO web_States (TaxRate,State) values (4.23,'MO')
		INSERT INTO web_States (TaxRate,State) values (0,'MT')
		INSERT INTO web_States (TaxRate,State) values (5.50,'NE')
		INSERT INTO web_States (TaxRate,State) values (6.50,'NV')
		INSERT INTO web_States (TaxRate,State) values (0,'NH')
		INSERT INTO web_States (TaxRate,State) values (7.00,'NJ')
		INSERT INTO web_States (TaxRate,State) values (5.00,'NM')
		INSERT INTO web_States (TaxRate,State) values (4.00,'NY')
		INSERT INTO web_States (TaxRate,State) values (4.25,'NC')
		INSERT INTO web_States (TaxRate,State) values (5.00,'ND')
		INSERT INTO web_States (TaxRate,State) values (5.50,'OH')
		INSERT INTO web_States (TaxRate,State) values (4.50,'OK')
		INSERT INTO web_States (TaxRate,State) values (0,'OR')
		INSERT INTO web_States (TaxRate,State) values (6.00,'PA')
		INSERT INTO web_States (TaxRate,State) values (7.00,'RI')
		INSERT INTO web_States (TaxRate,State) values (5.00,'SC')
		INSERT INTO web_States (TaxRate,State) values (4.00,'SD')
		INSERT INTO web_States (TaxRate,State) values (7.00,'TN')
		INSERT INTO web_States (TaxRate,State) values (6.25,'TX')
		INSERT INTO web_States (TaxRate,State) values (4.75,'UT')
		INSERT INTO web_States (TaxRate,State) values (6.00,'VT')
		INSERT INTO web_States (TaxRate,State) values (4.00,'VA')
		INSERT INTO web_States (TaxRate,State) values (6.00,'WV')
		INSERT INTO web_States (TaxRate,State) values (5.00,'WI')
		INSERT INTO web_States (TaxRate,State) values (6.50,'WA')
		INSERT INTO web_States (TaxRate,State) values (5.75,'DC')
		INSERT INTO web_States (TaxRate,State) values (4.00,'WY')
	GO
