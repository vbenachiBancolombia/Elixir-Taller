defmodule Departamento do
  @moduledoc """
  This module defines the Department struct and related functions.
  """

  defmodule Department do
    @moduledoc """
    Defines the Department struct with common attributes.
    """

    @enforce_keys [:name]
    @derive {Jason.Encoder, only: [:id, :name]}
    defstruct [:id, :name]

    @type t :: %__MODULE__{
                 id: integer() | nil,
                 name: String.t()
               }

    @doc """
    Creates a new Department struct.

    ## Parameters
    - `name`: String, the department's name (required)
    - `opts`: Keyword list of optional attributes (optional)

    ## Returns
    - `%Departamento.Department{}`: A new Department struct
    """
    def new(name, opts \\ []) do
      struct!(__MODULE__, [name: name] ++ opts)
    end
  end
end