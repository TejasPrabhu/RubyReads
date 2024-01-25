class ReviewsController < ApplicationController
  before_action :find_book, only: [:new, :create, :edit, :update, :destroy]
  before_action :find_review, only: [:edit, :update, :destroy]
  before_action :authenticate_user! #, only: [:new, :create, :edit, :update, :destroy, :index, :my_reviews]


  def index
    @hide_search = true
    if is_admin
      @reviews = Review.all.order("created_at DESC")
    end
    @search = ReviewSearch.new()

    if params[:review_search]

      book_name_search = review_search_params[:book_name]
      user_name_search = review_search_params[:user_name]


      if !user_name_search.empty?
        @user = User.find_by(username: user_name_search)
        @reviews = Review.where(user_id: @user&.id)
      elsif !book_name_search.empty?
        @reviews = Review.joins(:book).where('books.name = ?', book_name_search)
      end

    end
  end

  # def my_reviews
  #   @reviews = Review.where(user_id: params[:id])
  #   if @reviews[0].user.id == current_user.id
  #     render 'reviews/index'
  #   end
  # end

  def my_reviews
    @reviews = Review.where(user_id: current_user.id)
    render 'reviews/index'
  end



  def new
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)
    @review.book_id = @book.id
    @review.user_id = current_user.id

    if @review.save
      redirect_to book_path(@book)
    else
      render 'new'
    end
  end

  def edit
    if @review.user != current_user
      redirect_to root_url, alert: "You are not authorized to edit this review."
    end
  end

  def show
    @book = Book.find(params[:book_id])
    @review = @book.reviews.find(params[:id])

    head :no_content
  end

  def update
    if @review.user != current_user
      redirect_to root_url, alert: "You are not authorized to edit this review."
    else
      if @review.update(review_params)
        redirect_to book_path(@book), notice: "Review updated successfully."
      else
        render 'edit'
      end
    end
  end

  def destroy
    @review.destroy
    redirect_to book_path(@book)
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end


  def find_book
    @book = Book.find(params[:book_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end


  def review_search_params
    params.require(:review_search).permit(:user_name, :book_name)
  end

end
