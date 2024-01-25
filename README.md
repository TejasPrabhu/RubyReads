# Online Book Shopping System
CSC 517 Program 2

# GitHub Repository
<https://github.ncsu.edu/ajoshi24/book-shop-website>

# Deployed URL (deployed on NCSU VCL)
<http://152.7.177.160:3000>

# Dependencies
devise gem

https://dev.to/drnic/friendly-ids-for-ruby-on-rails-1c8p

# Users
There is single admin user added to the database during db seed operation

username: admin

password: 123456

# Running Bookshop Application
`cd book-shop-website`

`bundle install`

`rails db:migrate`

`rails db:seed`

`rails server`

# Assumptions

- Deleting book will delete all transactions associated with that book.
- When user locks a book, it other users will see that book is locked when they visit the book list. There is no push mechanism implemented that refreshes UI.
- Admin user can also purchase books even though they are a superuser
- Shopping cart submission can create independent transactions for each book in the cart. If a transaction fails, it will not be removed from the cart, so the user can reattempt.

# Application Navigation Menu
## Signup
This is where a user can register themselves to use the application
## Signin
This is where a user can authenticate with the application
## Book Shop
This allows user to see listing of all books available in the bookshop. They can search for, purchase books, see book details, & manage book reviews.
Administrators can add new books from here. 
## My Profile
This allows a user to manage their personal profile settings, delete their account, & change their password.
## My Purchases
Provides a list of all purchases made by the authenticated user. They can see transaction details from here too by selecting a purchase.
## Cart
This is a users shopping cart where they can add book(s) for later purchase.
## My Reviews
Provides a list of all reviews made by the authenticated user.
## Search Reviews
Allows user to search reviews across the application
## All Reviews
Provides a list of all reviews made by users.
## Users
Provides administrators a list of all users registered. They can add, update, & delete user accounts from here.
## Logout
Terminate authenticated users session. They will be redirected to signin page. 


# Features

## Admin Features
### Completed Features
- Log in with a username and password.
- Edit her/his own profile - should not be able to update ID, username, and password.
- Admin should not be able to delete the admin account (nor should anyone else).
- View all the books that are available on the website
- List books written by a specific author.
- View all the users signed up for the website
- List reviews written for a specific book (with book name) 
- List reviews written by a specific user (with username)
- Create/view/edit users.
- Create/view/edit books.
- Create/view/edit/delete reviews.

### Features In - Progress


## User Features
### Completed Features
- Sign up for a new account.
- Log in with a username and password.
- Edit her/his own profile, but should not be able to update their ID.(Add remaining fields)
- Delete their own account.(Delete functionality broken)(Use button instead of link)
- View all the books that are available on the website
- List books that have an average rating over a certain amount.(Add search bar)
- List books written by a specific author.(Add search bar)
- Buy a book or books
- Check their own purchase history (or transaction history)
- Write a review of a book
- Edit the review he/she wrote, but should not be able to edit reviews that were written by other users.


### Features In - Progress


## General Features
### Completed Features
- There should be a link on the user’s home page to let the user:
    - Edit his/her profile.
    - List his/her shopping history.
    - List reviews are written by him/herself.
    - List all books on the website with their name, author, publisher, price, stock, and average rating.
    - Search for reviews written by a specific user (with username).
    - Search for reviews written for a specific book (with the book name).
- There should be a link on the admin’s home page to let the admin:
    - Edit his/her profile.
    - List all users who have signed up for the website
    - List all books on the website with their name, author, publisher, price, stock, and average rating. (rating should not go above 5)
    - List all reviews written by all users.
- There should always be a way to let the user go back to the homepage.
- Price should be automatically calculated when buying books.
- Stock should be recalculated after each transaction.
- Rating should be recalculated after each review is submitted.
- There will be only one admin in the system, and the account is preconfigured. The admin account cannot be deleted.
- No other users should be able to access each other’s profile.
- No users should be able to edit another user’s review.
- In your README file, please document how to access certain pages in your app. Here are several examples:
    - By clicking what button on what page a user can buy a book.
    - By clicking what button on what page a user can edit a review written by him/her.
    - By clicking what button on what page an admin can delete a user.
    - If a user gets deleted, all reviews written by this user should be deleted as well.
    - If a book gets deleted, all reviews written for this book should be deleted as well. (add cascade delete)
    - Ensure you have necessary validations (i.e., price, stock cannot be negative, email address should be valid).
    - Ensure the value for necessary fields is not empty before saving to the database.
    - Make sure users are not able to access resources that they are not allowed to by changing the URL.


### Features In - progress

# Extra Credit
- Transaction form is pre-populated with user profile information.
- Book Locking - When transaction is started by a user, they obtain lock on the book. If a user has a lock on a book, then others cannot buy the book (The "Buy" link will be disabled)
- Shopping Cart - User can add multiple book(s) to their cart from the book shop. Clicking add multiple times for a book will increment its' quantity. The cart will be populated with users profile information.

# Demo
### Admin Features

#### Adding New Books
https://media.github.ncsu.edu/user/27459/files/b2ec8bc8-bd94-49d4-9587-9b323caad00a

### User Features

### Sign Up & Log In
https://media.github.ncsu.edu/user/27459/files/9016cf34-524e-4d45-a4fc-ff94e1483195

#### Updating and deleting user profile
https://media.github.ncsu.edu/user/27459/files/a6ba585c-2be5-42d0-961b-ba130733e199

#### Buying a book and viewing the purchase history
https://media.github.ncsu.edu/user/27459/files/3d53c204-55e6-400b-9e13-4d6f037863af

#### Adding, Updating, Deleting a book review and rating
https://media.github.ncsu.edu/user/27459/files/670605ba-067f-44b4-b507-d8ffdcb9510b

#### Filtering books with Author name and rating
https://media.github.ncsu.edu/user/27459/files/1d50b8d5-c3e4-443f-9c48-eae43aabd865

#### Viewing own reviews & filtering reviews by username and book
https://media.github.ncsu.edu/user/27459/files/dc32030a-279f-4d03-b8d2-d56820ec93a7








