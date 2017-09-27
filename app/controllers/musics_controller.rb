class MusicsController < ApplicationController
  before_action :set_music, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show, :search]
  # GET /musics
  # GET /musics.json
  def search
      if params[:search].present?
        @searching = Music.search{ fulltext "#{params[:search]}" }
        @musics = @searching.results
        p @musics
      else
        @musics = Music.all
      end
  end

  def index
    @musics = Music.all.order('created_at DESC')
  end

  # GET /musics/1
  # GET /musics/1.json
  def show
    @reviews = Review.where(music_id: @music.id).order("created_at DESC")

    if @reviews.blank?
      @avg_review = 0
    else
      @avg_review = @reviews.average(:rating).round(2)
    end
  end

  # GET /musics/new
  def new
    @music = current_user.musics.build
  end

  # GET /musics/1/edit
  def edit
  end

  # POST /musics
  # POST /musics.json
  def create
    @music = current_user.musics.build(music_params)

    respond_to do |format|
      if @music.save
        format.html { redirect_to @music, notice: 'Успешно создана запись о музыке.' }
        format.json { render :show, status: :created, location: @music }
      else
        format.html { render :new }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /musics/1
  # PATCH/PUT /musics/1.json
  def update
    respond_to do |format|
      if @music.update(music_params)
        format.html { redirect_to @music, notice: 'Изменена запись о музыке.' }
        format.json { render :show, status: :ok, location: @music }
      else
        format.html { render :edit }
        format.json { render json: @music.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /musics/1
  # DELETE /musics/1.json
  def destroy
    @music.destroy
    respond_to do |format|
      format.html { redirect_to musics_url, notice: 'Удалена запись о музыке.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_music
      @music = Music.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def music_params
      params.require(:music).permit(:title, :description, :release_year, :artist, :image)
    end
end
