class ReportsController < ApplicationController
  before_action :set_report, only: [:show, :edit, :update, :destroy]

  # GET /reports
  # GET /reports.json
  def index
    @report_tab = 'active'
    @reports = Report.all
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
    respond_to do |format|
      if @report.update(report_params)
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