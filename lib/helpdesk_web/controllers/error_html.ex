defmodule HelpdeskWeb.ErrorHTML do
  use HelpdeskWeb, :html

  # If you want to customize your error pages,
  # define a render/1 function here.
  def render(template, _assigns) do
    Phoenix.Controller.status_message_from_template(template)
  end
end
