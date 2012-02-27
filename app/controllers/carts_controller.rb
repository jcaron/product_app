class CartsController < ApplicationController
  # GET /carts
  # GET /carts.xml
  def show
    @cart = Cart.find_by_id(session[:cart_id])
    @title = "Cart"
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cart }
    end
  end

  # GET /carts/1/edit
  def edit
    @cart = Cart.find_by_id(session[:cart_id])
    @title = "Edit cart"
  end

  # POST /carts
  # POST /carts.xml
  def create
    @cart = Cart.new(params[:cart])

    respond_to do |format|
      if @cart.save
        format.html { redirect_to(@cart, :notice => 'Cart was successfully created.') }
        format.xml  { render :xml => @cart, :status => :created, :location => @cart }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /carts/1
  # PUT /carts/1.xml
  def update
    @cart = Cart.find(params[:cart][:id])
    params[:cart][:id] = nil

    respond_to do |format|
      if @cart.update_attributes(params[:cart])
        format.html { redirect_to(cart_path, :notice => 'Cart was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cart.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /carts/1
  # DELETE /carts/1.xml
  def destroy
    @cart = Cart.find(params[:id])
    @cart.destroy

    respond_to do |format|
      format.html { redirect_to(carts_url) }
      format.xml  { head :ok }
    end
  end
end
