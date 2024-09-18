defmodule BookManagement do
  defstruct isbn: "", title: "", author: "", available: true

  def add_book(collection, book) do
    [book | collection]
  end

  def list_books(collection) do
    collection
  end

  def check_availability(collection, isbn) do
    Enum.any?(collection, fn book -> book.isbn == isbn and book.available end)
  end
end