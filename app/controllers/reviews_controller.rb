class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_music
  before_action :authenticate_user!

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @review.user_id = current_user.id
    @review.music_id = @music.id

    if @review.save
      redirect_to @music
    else
      render 'new'
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    @review.update(review_params)
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @music = Music.find(params[:music_id])
    @review = @music.reviews.find(params[:id])

    redirect_to music_path(@music)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    def set_music
      @music = Music.find(params[:music_id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:rating, :comment)
    end
end
