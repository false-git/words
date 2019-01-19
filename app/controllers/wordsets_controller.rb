class WordsetsController < ApplicationController
  before_action :set_wordset, only: [:show, :edit, :update, :destroy]

  # GET /wordsets
  # GET /wordsets.json
  def index
    @wordsets = Wordset.all
  end

  # GET /wordsets/1
  # GET /wordsets/1.json
  def show
  end

  # GET /wordsets/new
  def new
    @wordset = Wordset.new
  end

  # GET /wordsets/1/edit
  def edit
  end

  # POST /wordsets
  # POST /wordsets.json
  def create
    @wordset = Wordset.new(wordset_params)

    respond_to do |format|
      if @wordset.save
        format.html { redirect_to @wordset, notice: 'Wordset was successfully created.' }
        format.json { render :show, status: :created, location: @wordset }
      else
        format.html { render :new }
        format.json { render json: @wordset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /wordsets/1
  # PATCH/PUT /wordsets/1.json
  def update
    respond_to do |format|
      if @wordset.update(wordset_params)
        format.html { redirect_to @wordset, notice: 'Wordset was successfully updated.' }
        format.json { render :show, status: :ok, location: @wordset }
      else
        format.html { render :edit }
        format.json { render json: @wordset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /wordsets/1
  # DELETE /wordsets/1.json
  def destroy
    @wordset.destroy
    respond_to do |format|
      format.html { redirect_to wordsets_url, notice: 'Wordset was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_wordset
      @wordset = Wordset.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def wordset_params
      params.require(:wordset).permit(:name, :description)
    end
end
