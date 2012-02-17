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
        format.xml
      else
        format.html { redirect_to(@product, 
         :notice => 'A error occured, this product was not added to the cart.')}
      end
    end
  end

  # PUT /line_items/1
  # PUT /line_items/1.xml
  def update
    @line_item = LineItem.find(params[:id])

    respond_to do |format|
      if @line_item.update_attributes(params[:line_item])
        format.html { redirect_to(@line_item, :notice => 'Line item was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
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
      format.html { redirect_to(line_items_url) }
      format.xml  { head :ok }
    end
  end
end