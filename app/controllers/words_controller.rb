class WordsController < ApplicationController
  before_action :set_word, only: [:show, :edit, :update, :destroy]

  # GET /words
  # GET /words.json
  def index
    #@words = Word.all
    @wordset = Wordset.where(:id => params[:wordset_id]).first
    @words = @wordset.words.order(:index)
  end

  # GET /words/1
  # GET /words/1.json
  def show
  end

  # GET /words/new
  def new
    #@word = Word.new
    @wordset = Wordset.where(:id => params[:wordset_id]).first
    @word = @wordset.words.build
    @word.index = @wordset.words.maximum(:index)
    if @word.index.nil? then
      @word.index = 0
    end
      @word.index += 1
  end

  # GET /words/1/edit
  def edit
  end

  # POST /words
  # POST /words.json
  def create
    #@word = Word.new(word_params)
    @wordset = Wordset.where(:id => params[:wordset_id]).first
    @word = @wordset.words.build(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to @word, notice: 'Word was successfully created.' }
        #format.html { redirect_to [@wordset, @word], notice: 'Word was successfully created.' }
        format.json { render :show, status: :created, location: @word }
      else
        format.html { render :new }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /words/1
  # PATCH/PUT /words/1.json
  def update
    respond_to do |format|
      if @word.update(word_params)
        format.html { redirect_to @word, notice: 'Word was successfully updated.' }
        #format.html { redirect_to [@wordset, @word], notice: 'Word was successfully updated.' }
        format.json { render :show, status: :ok, location: @word }
      else
        format.html { render :edit }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /words/1
  # DELETE /words/1.json
  def destroy
    @word.destroy
    respond_to do |format|
      #format.html { redirect_to words_url, notice: 'Word was successfully destroyed.' }
      format.html { redirect_to wordset_words_url(@wordset.id), notice: 'Word was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_word
      @word = Word.find(params[:id])
      @wordset = @word.wordset
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def word_params
      params.require(:word).permit(:question, :answer, :wordset_id)
    end
end
