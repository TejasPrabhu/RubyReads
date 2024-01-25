require 'rails_helper'

RSpec.describe BooksController, type: :controller do
    describe "authentication" do
        it "blocks unauthenticated access" do
            sign_in nil
            
            get :index
            
            expect(response).to redirect_to(new_user_session_path)
          end
          
          it "allows authenticated access" do
            sign_in
            
            get :index
            
            expect(response).to have_http_status(200)
          end
    end

    describe "CRUD" do
      it "creates new book" do
        sign_in
        book = Book.create(name: "book1", author: "author1", publisher: "publisher1", price: 30, stock: 30)
        get :index
        expect(response).to have_http_status(200)
      end

      it "deletes a book" do
        sign_in
        book = Book.create(name: "book2", author: "author2", publisher: "publisher2", price: 40, stock: 40)
        book.destroy
        get :index
        expect(response).to have_http_status(200)
      end

      it "updates a book" do
        sign_in
        book = Book.create(name: "book3", author: "author3", publisher: "publisher3", price: 50, stock: 50)
        book.update(price: 50, stock: 5)
        get :index
        expect(response).to have_http_status(200)
      end


    end
end