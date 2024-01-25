class ReviewSearch
    include ActiveModel::Conversion
    extend  ActiveModel::Naming

    attr_accessor :user_name, :book_name

  end