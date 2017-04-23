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

			Select @OrderSubTotal = IsNull(Sum(Quantity * products.web_price*products.bf_per_unit_of_sale),0),
			@WeightTotal = IsNull(Sum((weight_class.weight_per_mbf*products.bf_per_unit_of_sale*Quantity)/1000.00),0)
			from web_CartRow 
			join products on web_CartRow.prod_id=products.prod_id
			join weight_class on products.weight_id=weight_class.weight_id
			where CartId=@CartId
			
			select CartId,@ItemCount as ItemCount,@OrderSubTotal as OrderSubTotal,@WeightTotal as WeightTotal
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
	
	
	GO
	IF EXISTS (select * from syscomments where id = object_id ('dbo.SP_GetWebProductsDetails'))
	BEGIN
		DROP PROCEDURE dbo.SP_GetWebProductsDetails
	END
	GO
		-- =============================================
		-- Author:		Erich Keane
		-- Create date: October 22, 2007
		-- Description:	A stored procedure to get the web filters counts list for the web project
		-- =============================================
		CREATE PROCEDURE SP_GetWebProductsDetails
		@ProductId as int
		AS
		BEGIN
			-- SET NOCOUNT ON added to prevent extra result sets from
			-- interfering with SELECT statements.
			SET NOCOUNT ON;
			
			Select unit_id,unit_label,price_label,bf_conversion_type,price_to_unit_factor,bf_conversion_factor,use_net_size 
				from unit inner join products on unit_id=default_unit_id where prod_id = @ProductId; 
			select weight_class.weight_id,weight_short_desc,weight_desc,weight_per_mbf from weight_class
				inner join products on weight_class.weight_id=products.weight_id where prod_id = @ProductId;
			select sizes.size_cd,size_desc,size_nom_thick,length,size_nom_width,net_width,net_thick,net_length,net_desc 
				from sizes inner join products on sizes.size_cd=products.size_cd where prod_id = @ProductId;
			select condition.condition_code,condition_desc from condition 
				inner join products on condition.condition_code=products.condition_code where prod_id = @ProductId;
			select usage.usage_cd,usage_desc from usage inner join products on usage.usage_cd=products.usage_cd where prod_id = @ProductId;
			select grade.grade_code,grade_desc from grade inner join products on grade.grade_code=products.grade_code where prod_id = @ProductId;
			select grain.grain_code,grain_desc from grain inner join products on grain.grain_code=products.grain_code where prod_id = @ProductId;
			select species.species_code,species_description,species_abbrev from species 
				inner join products on species.species_code=products.species_code where prod_id = @ProductId;
			SELECT prod_id,short_desc,short_desc+' - '+long_desc as both_desc,
				long_desc,web_price,image3filename,image2filename,image1filename,
				grade_code,grain_code,species_code,inventory_label,condition_code,usage_cd,
				size_cd,weight_id,bf_per_unit_of_sale,
				default_unit_id from products where prod_id = @ProductId
		END
	GO
