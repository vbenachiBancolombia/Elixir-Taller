defmodule Main do
  def run do
    books = []
    users = []
    loans = []

    loop(books, users, loans)
  end

  defp loop(books, users, loans) do
    IO.puts("Seleccione una opción:")
    IO.puts("1. Agregar libro")
    IO.puts("2. Registrar usuario")
    IO.puts("3. Pedir prestado un libro")
    IO.puts("4. Listar todos los libros")
    IO.puts("5. Listar todos los usuarios")
    IO.puts("6. Listar todos los préstamos de un usuario")
    IO.puts("7. Salir")

    case IO.gets("Opción: ") |> String.trim() do
      "1" ->
        {books, users, loans} = add_book(books, users, loans)
        loop(books, users, loans)
      "2" ->
        {books, users, loans} = register_user(books, users, loans)
        loop(books, users, loans)
      "3" ->
        {books, users, loans} = borrow_book(books, users, loans)
        loop(books, users, loans)
      "4" ->
        IO.inspect(BookManagement.list_books(books))
        loop(books, users, loans)
      "5" ->
        IO.inspect(UserManagement.list_users(users))
        loop(books, users, loans)
      "6" ->
        IO.puts("Ingrese el ID del usuario:")
        user_id = IO.gets("") |> String.trim()
        IO.inspect(LoanManagement.list_user_loans(loans, user_id))
        loop(books, users, loans)
      "7" ->
        :ok
      _ ->
        IO.puts("Opción no válida")
        loop(books, users, loans)
    end
  end

  defp add_book(books, users, loans) do
    IO.puts("Ingrese el ISBN del libro:")
    isbn = IO.gets("") |> String.trim()
    IO.puts("Ingrese el título del libro:")
    title = IO.gets("") |> String.trim()
    IO.puts("Ingrese el autor del libro:")
    author = IO.gets("") |> String.trim()

    book = %BookManagement{isbn: isbn, title: title, author: author}
    books = BookManagement.add_book(books, book)
    {books, users, loans}
  end

  defp register_user(books, users, loans) do
    IO.puts("Ingrese el ID del usuario:")
    id = IO.gets("") |> String.trim()
    IO.puts("Ingrese el nombre del usuario:")
    name = IO.gets("") |> String.trim()

    user = %UserManagement{id: id, name: name}
    users = UserManagement.register_user(users, user)
    {books, users, loans}
  end

  defp borrow_book(books, users, loans) do
    IO.puts("Ingrese el ID del usuario:")
    user_id = IO.gets("") |> String.trim()
    IO.puts("Ingrese el ISBN del libro:")
    book_isbn = IO.gets("") |> String.trim()

    loans = LoanManagement.borrow_book(loans, user_id, book_isbn, books)
    {books, users, loans}
  end
end

Main.run()