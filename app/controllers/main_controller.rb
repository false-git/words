# coding: utf-8
class MainController < ApplicationController
  def index
    @login_user = current_user
    if !@login_user.nil? then
      @wordsets = []
      for wordset in Wordset.order(:index) do
        ok_count = 0
        ng_count = 0
        wordset_length = wordset.words.length
        for word in wordset.words do
          score = word.scores.find_by(user_id: @login_user.id)
          if !score.nil? then
            ok_count += score.q_a_ok
            ng_count += score.q_a_ng
          end
        end
        wordset.instance_variable_set(:@ok_count, ok_count)
        wordset.instance_variable_set(:@ng_count, ng_count)
        wordset.instance_variable_set(:@length, wordset_length)
        if ok_count + ng_count > 0 then
          wordset.instance_variable_set(:@ok_rate, 100 * ok_count / (ok_count + ng_count))
        else
          wordset.instance_variable_set(:@ok_rate, '-')
        end
        if wordset_length > 0 then
          wordset.instance_variable_set(:@challenge, 1.0 * (ok_count + ng_count) / wordset_length)
        else
          wordset.instance_variable_set(:@challenge, 0.0)
        end
        @wordsets << wordset
      end
    end
  end

  def login
    @login_user = User.find_by(name: params[:name])
    if @login_user.nil? then
      @message = 'おまえは誰だ！'
      render "main/index"
    else
      session[:current_user_id] = @login_user.id
      redirect_to :root
    end
  end

  def logout
    reset_session
    redirect_to :root
  end

  def current_user
    @_current_user ||= session[:current_user_id] &&
                    User.find_by(id: session[:current_user_id])
  end

  def play_init
    @count = 0
    @ok = 0
    session[:play_words] = @words
    session[:ng_words] = []
    session[:play_count] = @count
    session[:play_ok] = @ok
    @word = @words[0]
    @prevword = nil
    @answer_ok = nil
  end

  def play
    @login_user = current_user
    wordset = Wordset.find(params[:id])
    @words = wordset.words.order(:index)
    cookies.permanent[:last_wordsets] = JSON.generate([params[:id]])
    play_init
  end

  def play_random
    @login_user = current_user
    @words = []
    scores = []
    wordset_ids = params[:wordset_id]
    if wordset_ids.nil? then
      @message = 'どれか選んでおくれよ。'
      index()
      render "main/index"
      return
    end
    cookies.permanent[:last_wordsets] = JSON.generate(wordset_ids)
    for word in Word.where(wordset_id: wordset_ids).shuffle
      score = word.scores.find_by(user_id: @login_user.id)
      if score.nil? then
        @words << word
      else
        scores << score
      end
      break if @words.length >= 30
    end
    if @words.length < 30 then
      scores.sort! {|a, b| a.q_a_ok == b.q_a_ok ? rand(3) - 1 : a.q_a_ok <=> b.q_a_ok}
      limit = 30 - @words.length - 1
      limit = scores.length - 1 if limit > scores.length
      for index in 0..limit do
        @words << scores[index].word
      end
    end
    play_init
    render 'play'
  end

  def question
    @login_user = current_user
    @words = session[:play_words]
    @count = session[:play_count]
    @ok = session[:play_ok]
    @ng_words = session[:ng_words]
    @prevword = @words[@count]
    @count += 1
    if @count == @words.length then
      @word = nil
    else
      @word = @words[@count]
    end
    @answer = params[:answer]
    @score = @prevword.scores.find_by(user_id: @login_user.id)
    @score = @prevword.scores.build({user: @login_user, q_a_ok: 0, q_a_ng: 0, a_q_ok: 0, a_q_ng: 0}) if @score.nil?
    if @prevword.answer == @answer then
      @score.q_a_ok += 1
      @answer_ok = true
      @ok += 1
      session[:play_ok] = @ok
    else
      @score.q_a_ng += 1
      @answer_ok = false
      @ng_words << @prevword
    end
    @score.save
    session[:play_count] = @count
    render 'play'
  end
end
