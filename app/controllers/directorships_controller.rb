class DirectorshipsController < ApplicationController
  # GET /directorships
  # GET /directorships.json
  def index
    @directorships = Directorship.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @directorships }
    end
  end

  # GET /directorships/1
  # GET /directorships/1.json
  def show
    @directorship = Directorship.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @directorship }
    end
  end

  # GET /directorships/new
  # GET /directorships/new.json
  def new
    @directorship = Directorship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @directorship }
    end
  end

  # GET /directorships/1/edit
  def edit
    @directorship = Directorship.find(params[:id])
  end

  # POST /directorships
  # POST /directorships.json
  def create
    @directorship = Directorship.new(params[:directorship])

    respond_to do |format|
      if @directorship.save
        format.html { redirect_to @directorship, notice: 'Directorship was successfully created.' }
        format.json { render json: @directorship, status: :created, location: @directorship }
      else
        format.html { render action: "new" }
        format.json { render json: @directorship.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /directorships/1
  # PUT /directorships/1.json
  def update
    @directorship = Directorship.find(params[:id])

    respond_to do |format|
      if @directorship.update_attributes(params[:directorship])
        format.html { redirect_to @directorship, notice: 'Directorship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @directorship.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /directorships/1
  # DELETE /directorships/1.json
  def destroy
    @directorship = Directorship.find(params[:id])
    @directorship.destroy

    respond_to do |format|
      format.html { redirect_to directorships_url }
      format.json { head :no_content }
    end
  end
end
