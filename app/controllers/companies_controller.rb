class CompaniesController < ApplicationController
  # GET /companies
  # GET /companies.json
  def index

      url = "http://duedil.io/v3/#{params["locale"]}/companies/#{params["reg_co_num"]}".downcase if (params["locale"] && params["reg_co_num"])
      url = params["url"] if params["url"]

      @companies = Company.all unless (params["search_term"] || url)
      @search_results = Company.duedil_search(params["search_term"], 10)  if params["search_term"]

      if url
        existing_record = Company.existing_record(url)
        if existing_record
          if params["check_existing"]
            @autopopulate_fields = {existing_record: true}
            @autopopulate_fields[:name] = existing_record.name
          else
            @autopopulate_fields = Company.autopopulate_fields(url)
            @autopopulate_fields[:existing_record] = true
          end
        else
          @autopopulate_fields = Company.autopopulate_fields(url)
        end
      end

    respond_to do |format|
      format.html # index.html.erb
      if @search_results
        format.json { render json: @search_results }
      elsif @autopopulate_fields
        format.json { render json: @autopopulate_fields}
      end
    end
  end

  # GET /companies/1
  # GET /companies/1.json
  def show
    @company = Company.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/new
  # GET /companies/new.json
  def new
    @company = Company.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @company }
    end
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
    @editing = true
  end

  # POST /companies
  # POST /companies.json
  def create
    @company = Company.new(params[:company])

    respond_to do |format|
      if @company.save
        format.html { redirect_to @company, notice: 'Company was successfully created.' }
        format.json { render json: @company, status: :created, location: @company }
      else
        format.html { render action: "new" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /companies/1
  # PUT /companies/1.json
  def update
    @company = Company.find(params[:id])

    respond_to do |format|
      if @company.update_attributes(params[:company])
        format.html { redirect_to @company, notice: 'Company was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @company.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /companies/1
  # DELETE /companies/1.json
  def destroy
    @company = Company.find(params[:id])
    @company.destroy

    respond_to do |format|
      format.html { redirect_to companies_url }
      format.json { head :no_content }
    end
  end
end
