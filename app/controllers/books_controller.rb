class BooksController < ApplicationController
  before_action :find_book, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :index]
  before_action :get_avg_reviews, only: [:show]
  def index
    @search = BookSearch.new()
    books = Book.all

    if params[:book_search]

      author_search = book_search_params[:author]
      rating_search = book_search_params[:rating]
      if !author_search.empty?
        books = books.where({author: author_search})
      end
      if !rating_search.empty?
        books_meeting_rating_criteria = []
        books.each do |book|
          average_rating = book.reviews.average(:rating)
          if average_rating != nil && average_rating >= rating_search.to_f
            books_meeting_rating_criteria.push(book.id)
          end
        end
        books = books.where(id: books_meeting_rating_criteria)
      end
      @search.author = author_search
      @search.rating = rating_search
    end

    @books = books.order("created_at DESC")
  end

  def show
    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
  end

  def new
    @book = current_user.books.build
  end

  def edit

  end

  def update
    if @book.update(book_params)

      respond_to do |format|
        format.html { redirect_to book_path(@book), notice: "Book was successfully updated." }
        format.json { head :no_content }
      end
    else
      render 'edit'
    end
  end

  def destroy
    @book.destroy

    respond_to do |format|
      format.html { redirect_to books_url, notice: "Book was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create
    @book = current_user.books.build(book_params)

    if @book.save
      respond_to do |format|
        format.html { redirect_to root_path, notice: "Book was successfully added." }
        format.json { head :no_content }
      end
    else
      render 'new'
    end
  end

  private

  def book_params
    params.require(:book).permit(:name, :author, :publisher, :price, :stock)
  end

  def book_search_params
    params.require(:book_search).permit(:author, :rating)
  end

  def find_book
    @book = Book.find(params[:id])
  end

  def get_avg_reviews
    if @book.reviews.blank?
      @average_review = 0
    else
      @average_review = @book.reviews.average(:rating).round(2)
    end
  end
end
