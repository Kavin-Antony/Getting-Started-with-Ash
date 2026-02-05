defmodule HelpdeskWeb.CoreComponents do
  use Phoenix.Component

  attr :flash, :map, default: %{}, doc: "the map of flash messages"
  def flash_group(assigns) do
    ~H"""
    <div :for={{kind, message} <- @flash} class="flash-group">
      <p class={kind}><%= message %></p>
    </div>
    """
  end

  attr :type, :string, default: "text"
  attr :field, Phoenix.HTML.FormField
  attr :label, :string, default: nil
  def input(assigns) do
    ~H"""
    <div class="input-group">
      <label :if={@label} for={@field.id}><%= @label %></label>
      <input type={@type} name={@field.name} id={@field.id} value={@field.value} />
      <div :for={msg <- @field.errors} class="error"><%= translate_error(msg) %></div>
    </div>
    """
  end

  attr :class, :string, default: nil
  slot :inner_block, required: true
  def button(assigns) do
    ~H"""
    <button class={@class}>
      <%= render_slot(@inner_block) %>
    </button>
    """
  end

  def translate_error({msg, opts}) do
    # You can make use of gettext module here if available
    # HelpdeskWeb.Gettext.dgettext("errors", msg, opts)
    msg
  end
  def translate_error(msg), do: msg
end
