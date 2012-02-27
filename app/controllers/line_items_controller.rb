class LineItemsController < ApplicationController
  def create
    @line_item = LineItem.new(params[:line_item])
    @product = @line_item.product
    if @product
      @line_item.unit_price = @line_item.product.unit_price
    end

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to(@product, 
          :notice => 'Product added to cart.') }
        format.js
      else
        format.html { redirect_to(root_path, 
         :notice => 'A error occured, the product was not added to the cart.')}
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item.product, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
          format.html { redirect_to root_path, :notice => 'An error occured while updating.' }
        format.xml  { render :xml => @line_item.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.xml
  def destroy
    @line_item = LineItem.find(params[:id])
    @line_item.destroy

    respond_to do |format|
      format.html { redirect_to(cart_path) }
      format.xml  { head :ok }
    end
  end
end
