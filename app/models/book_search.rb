class BookSearch
  include ActiveModel::Conversion
  extend  ActiveModel::Naming

  attr_accessor :author, :rating

end

