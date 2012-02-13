class ProductsController < ApplicationController
  # GET /products
  # GET /products.xml
  def index
    @products = Product.all
    @title = "All products"
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @products }
    end
  end

  # GET /products/1
  # GET /products/1.xml
  def show
    @product = Product.find(params[:id])
    @category = Category.find(@product.category_id) unless 
      @product.category_id.nil?
    @title = @product.name
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/new
  # GET /products/new.xml
  def new
    @product = Product.new
    @title = "New product"
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @product }
    end
  end

  # GET /products/1/edit
  def edit
    @product = Product.find(params[:id])
    @title = "Edit #{@product.name}"
  end

  # POST /products
  # POST /products.xml
  def create
    @product = Product.new(params[:product])
    respond_to do |format|
      if !params[:product][:sub_category_id].nil? && @product.save
        params[:product][:sub_category_id].each do |id|
          @product.relationships.create(:sub_category_id => id)
        end
        format.html { redirect_to(@product, :notice => 'Product was successfully created.') }
        format.xml  { render :xml => @product, :status => :created, :location => @product }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /products/1
  # PUT /products/1.xml
  def update
    @product = Product.find(params[:id])
    unless params[:product][:sub_category_id].nil?
      current_sub = @product.sub_categories.map{ |sub| "#{sub.id}" }
      # will need to add any relationships that don't exist yet
      add_sub = params[:product][:sub_category_id] - current_sub
      # will need to remove any relationships that are no longer selected
      remove_sub = current_sub - params[:product][:sub_category_id]
      # need to reset the product's category id just in case it has changed that
      @product.set_category params[:product][:category_id].to_i
      @product.save
      add_sub.each do |id|
        # add each new sub-category
        @product.add_sub_category!(id.to_i)
      end
      remove_sub.each do |id|
        # remove the relationships to the removed sub categories
        bad_id = Relationship.where(:product_id => @product.id, 
          :sub_category_id => id).first
        bad_id.destroy
      end
    end
    respond_to do |format|
      if @product.update_attributes(params[:product])
        format.html { redirect_to(@product, :notice => 'Product was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @product.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.xml
  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to(products_url) }
      format.xml  { head :ok }
    end
  end
end
