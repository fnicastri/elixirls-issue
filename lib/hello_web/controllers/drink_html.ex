defmodule HelloWeb.DrinkHTML do
  use HelloWeb, :html

  embed_templates "drink_html/*"

  @doc """
  Renders a drink form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def drink_form(assigns)
end
