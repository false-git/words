# coding: utf-8
class MainController < ApplicationController
  def index
    @login_user = current_user
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

  def play
    @login_user = current_user
    @wordset = Wordset.find(params[:id])
    session[:play_wordset] = @wordset
    @words = @wordset.words
    session[:play_words] = @words
    @count = 0
    session[:play_count] = @count
    @ok = 0
    session[:play_ok] = @ok
    session[:ng_words] = []
    @word = @words[0]
    @prevword = nil
    @answer_ok = nil
  end

  def question
    @login_user = current_user
    @wordset = session[:play_wordset]
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
