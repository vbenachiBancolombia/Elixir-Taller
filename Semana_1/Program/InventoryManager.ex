defmodule InventoryManager do
  defstruct inventory: [], cart: []

  @type product :: %{
                     id: integer,
                     name: String.t(),
                     price: float,
                     stock: integer
                   }

  @type cart_item :: {integer, integer}

  def add_product(%{inventory: inventory} = state, name, price, stock) do
    id = Enum.count(inventory) + 1
    product = %{id: id, name: name, price: price, stock: stock}
    %{state | inventory: [product | inventory]}
  end

  def list_products(%{inventory: inventory}) do
    Enum.each(inventory, fn product ->
      IO.puts("ID: #{product.id}, Name: #{product.name}, Price: #{product.price}, Stock: #{product.stock}")
    end)
  end

  def increase_stock(%{inventory: inventory} = state, id, quantity) do
    updated_inventory = Enum.map(inventory, fn product ->
      if product.id == id do
        %{product | stock: product.stock + quantity}
      else
        product
      end
    end)
    %{state | inventory: updated_inventory}
  end

  def sell_product(%{inventory: inventory, cart: cart} = state, id, quantity) do
    {product, updated_inventory} = Enum.split_with(inventory, fn product -> product.id == id end)
    case product do
      [%{stock: stock} = p] when stock >= quantity ->
        updated_product = %{p | stock: stock - quantity}
        updated_cart = [{id, quantity} | cart]
        %{state | inventory: [updated_product | updated_inventory], cart: updated_cart}
      _ ->
        IO.puts("Insufficient stock or product not found")
        state
    end
  end

  def view_cart(%{cart: cart, inventory: inventory}) do
    total_cost = Enum.reduce(cart, 0.0, fn {id, quantity}, acc ->
      product = Enum.find(inventory, fn product -> product.id == id end)
      acc + product.price * quantity
    end)
    Enum.each(cart, fn {id, quantity} ->
      product = Enum.find(inventory, fn product -> product.id == id end)
      IO.puts("Product: #{product.name}, Quantity: #{quantity}, Subtotal: #{product.price * quantity}")
    end)
    IO.puts("Total Cost: #{total_cost}")
  end

  def checkout(%{cart: cart} = state) do
    view_cart(state)
    %{state | cart: []}
  end
end