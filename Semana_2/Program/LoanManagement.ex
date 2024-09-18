defmodule LoanManagement do
  defstruct user_id: "", book_isbn: ""

  def borrow_book(loans, user_id, book_isbn, books) do
    if BookManagement.check_availability(books, book_isbn) do
      [%LoanManagement{user_id: user_id, book_isbn: book_isbn} | loans]
    else
      loans
    end
  end

  def return_book(loans, user_id, book_isbn) do
    Enum.reject(loans, fn loan -> loan.user_id == user_id and loan.book_isbn == book_isbn end)
  end

  def list_user_loans(loans, user_id) do
    Enum.filter(loans, fn loan -> loan.user_id == user_id end)
  end
end