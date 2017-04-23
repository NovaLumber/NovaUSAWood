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
		( @CartId uniqueidentifier = null,
		  @GetClosed bit= 0
		 )
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			--Status' are 'N'ew, 'F'inalized, or 'S'ubmitted
			
			if @GetClosed=1 and 0<(Select count(*) from web_Cart where CartId=@CartId and CheckOutStatus='S')
			BEGIN
				if 0=(Select count(*) from web_Cart where CartId=@CartId and CheckOutStatus='S')
					return
			END
			ELSE
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