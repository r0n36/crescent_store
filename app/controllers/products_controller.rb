class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @product_tab = 'active'
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product_tab = 'active'
  end

  # GET /products/new
  def new
    @product_tab = 'active'
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
    @product_tab = 'active'
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    respond_to do |format|
      if @product.save
        #@product.store_id = Store.where(location: params[:product][:stores][:store_name]).first.id if params[:product][:stores][:store_name].present?
        #@product.save
        @attribute = Attribute.new(:product_id => @product.id, :size => params[:product][:attributes][:size], :color => params[:product][:attributes][:color], :category => params[:product][:attributes][:category], :price => params[:product][:attributes][:price])
        @attribute.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render action: 'show', status: :created, location: @product }
      else
        format.html { render action: 'new' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    respond_to do |format|
      if @product.update(product_params)
        @product.store_id = Store.where(location: params[:product][:stores][:store_name]).first.id if params[:product][:stores][:store_name].present?
        @product.save
        @attribute = Attribute.find_by_product_id @product.id
        @attribute.size= params[:product][:attributes][:size]
        @attribute.color= params[:product][:attributes][:color]
        @attribute.category= params[:product][:attributes][:category]
        @attribute.price= params[:product][:attributes][:price]
        @attribute.save
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:name, :code, :quantity, :price, :size, :color, :category, :store_id)
  end
end
