class TypemodesController < ApplicationController
  # GET /typemodes
  # GET /typemodes.json
  def index
    @typemodes = Typemode.order("store_id").all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @typemodes }
    end
  end

  # GET /typemodes/1
  # GET /typemodes/1.json
  def show
    @typemode = Typemode.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @typemode }
    end
  end

  # GET /typemodes/new
  # GET /typemodes/new.json
  def new
    @typemode = Typemode.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @typemode }
    end
  end

  # GET /typemodes/1/edit
  def edit
    @typemode = Typemode.find(params[:id])
  end

  # POST /typemodes
  # POST /typemodes.json
  def create
    @typemode = Typemode.new(params[:typemode])

    respond_to do |format|
      if @typemode.save
        format.html { redirect_to @typemode, notice: 'Typemode was successfully created.' }
        format.json { render json: @typemode, status: :created, location: @typemode }
      else
        format.html { render action: "new" }
        format.json { render json: @typemode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /typemodes/1
  # PUT /typemodes/1.json
  def update
    @typemode = Typemode.find(params[:id])

    respond_to do |format|
      if @typemode.update_attributes(params[:typemode])
        format.html { redirect_to @typemode, notice: 'Typemode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @typemode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /typemodes/1
  # DELETE /typemodes/1.json
  def destroy
    @typemode = Typemode.find(params[:id])
    @typemode.destroy

    respond_to do |format|
      format.html { redirect_to typemodes_url }
      format.json { head :no_content }
    end
  end
end
