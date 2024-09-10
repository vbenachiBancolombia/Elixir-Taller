defmodule Main do
  def run do
    state = %InventoryManager{}
    loop(state)
  end

  defp loop(state) do
    IO.puts("""
    Choose an option:
    1. Add Product
    2. List Products
    3. Increase Stock
    4. Sell Product
    5. View Cart
    6. Checkout
    7. Exit
    """)
    option = IO.gets("Option: ") |> String.trim() |> String.to_integer()

    new_state =
      case option do
        1 ->
          name = IO.gets("Product Name: ") |> String.trim()
          price = IO.gets("Product Price: ") |> String.trim() |> String.to_float()
          stock = IO.gets("Product Stock: ") |> String.trim() |> String.to_integer()
          InventoryManager.add_product(state, name, price, stock)

        2 ->
          InventoryManager.list_products(state)
          state

        3 ->
          id = IO.gets("Product ID: ") |> String.trim() |> String.to_integer()
          quantity = IO.gets("Quantity to Add: ") |> String.trim() |> String.to_integer()
          InventoryManager.increase_stock(state, id, quantity)

        4 ->
          id = IO.gets("Product ID: ") |> String.trim() |> String.to_integer()
          quantity = IO.gets("Quantity to Sell: ") |> String.trim() |> String.to_integer()
          InventoryManager.sell_product(state, id, quantity)

        5 ->
          InventoryManager.view_cart(state)
          state

        6 ->
          InventoryManager.checkout(state)

        7 ->
          IO.puts("Exiting...")
          :exit

        _ ->
          IO.puts("Invalid option")
          state
      end

    if new_state != :exit do
      loop(new_state)
    end
  end
end