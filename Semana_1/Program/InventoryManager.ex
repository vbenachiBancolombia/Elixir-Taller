defmodule InventoryManager do
  defstruct products: %{}, cart: %{}

  def add_product(state, name, price, stock) do
    id = Enum.count(state.products) + 1
    product = %{id: id, name: name, price: price, stock: stock}
    %{state | products: Map.put(state.products, id, product)}
  end

  def list_products(state) do
    Enum.each(state.products, fn {_, product} ->
      IO.puts("ID: #{product.id}, Name: #{product.name}, Price: #{product.price}, Stock: #{product.stock}")
    end)
  end

  def increase_stock(state, id, quantity) do
    update_product(state, id, fn product ->
      %{product | stock: product.stock + quantity}
    end)
  end

  def sell_product(state, id, quantity) do
    update_product(state, id, fn product ->
      %{product | stock: product.stock - quantity}
    end)
  end

  def view_cart(state) do
    Enum.each(state.cart, fn {_, product} ->
      IO.puts("ID: #{product.id}, Name: #{product.name}, Quantity: #{product.quantity}")
    end)
  end

  def checkout(state) do
    IO.puts("Checking out...")
    %{state | cart: %{}}
  end

  defp update_product(state, id, update_fn) do
    case Map.get(state.products, id) do
      nil ->
        IO.puts("Product not found")
        state
      product ->
        updated_product = update_fn.(product)
        %{state | products: Map.put(state.products, id, updated_product)}
    end
  end
end