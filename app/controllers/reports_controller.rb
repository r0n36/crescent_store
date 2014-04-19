class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @report_tab = 'active'

    # Chart One ===================
    @reports = current_user.store.reports
    @todays_reports = current_user.store.reports.where('created_at > ?', 1.days.ago)
    @chart_one = []
    @todays_reports.each do |report|
      time = report.created_at + 6.hours #Lame technique. Will be fixed soon. This is only of Bangladesh and +6 TimeZone
      @chart_one << ["[Date.UTC(#{time.year}, #{time.month}, #{time.day}, #{time.hour}, #{time.min}), #{calculate_total_price_of_a_report(report)}]"]
    end
    @chart_one = @chart_one.join(', ')

    # Chart Two ===================
    @products = current_user.store.products
    @chart_two = []
    @products.each do |product|
      @chart_two << ["['#{product.attribute.category}', #{product.quantity}]"] unless product.attribute.category = 'Shoe'
      @chart_two << "{name: 'Shoe',y: #{product.quantity}, sliced: true,selected: true}" if product.attribute.category = 'Shoe'
    end
    @chart_two = @chart_two.join(', ')
  end

  # GET /reports/1
  # GET /reports/1.json
  def show
    @report_tab = 'active'
  end

  # GET /reports/new
  def new
    @report_tab = 'active'
    @report = Report.new
    @consumer = Consumer.new
  end

  # GET /reports/1/edit
  def edit
    @report_tab = 'active'
  end

  # POST /reports
  # POST /reports.json
  def create
    @consumer = Consumer.create!(consumer_params)
    #params[:consumer_id] = @consumer.id
    @report = Report.new(report_params)

    respond_to do |format|
      if @report.save
        @report.product.quantity = @report.product.quantity - @report.quantity
        @report.product.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render action: 'show', status: :created, location: @report }
      else
        format.html { render action: 'new' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reports/1
  # PATCH/PUT /reports/1.json
  def update
    @report.report_items.each do |report_item|
      quantity = params["report_item_#{report_item.id}"].to_i
      report_item.quantity = quantity
      report_item.save
      product = Product.find report_item.product_id
      product.quantity = product.quantity - quantity
      product.save!(:validate => false)
    end
    @consumer = Consumer.create!(consumer_params)
    respond_to do |format|
      if @report.update(report_params)
        @report.consumer_id = @consumer.id
        @report.save
        session[:report_id] = nil
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report.destroy
    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end

  def calculate_total_price_of_a_report(report)
    total_price = 0
    report.report_items.each do |item|
      product = Product.find item.product_id
      total_price += product.attribute.price
    end

    return (total_price + (total_price * 0.15))
  end

  def create_consumer
    puts 'Hello'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_report
      @report = Report.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def report_params
      #params[:report]
      params.require(:report).permit(:consumer_id, :seller_id, :product_id, :quantity, :consumer_attributes => [:first_name, :last_name, :email, :phone, :address])
    end

    def consumer_params
      params[:report][:consumers].permit(:first_name, :last_name, :email, :phone, :address)
    end
end