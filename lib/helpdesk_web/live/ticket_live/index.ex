defmodule HelpdeskWeb.TicketLive.Index do
  use HelpdeskWeb, :live_view

  def mount(_params, _session, socket) do
    form =
      Helpdesk.Support.Ticket
      |> AshPhoenix.Form.for_create(:open, api: Helpdesk.Support)
      |> to_form()

    tickets = Helpdesk.Support.Ticket |> Ash.read!()

    {:ok, assign(socket, form: form, tickets: tickets)}
  end

  def render(assigns) do
    ~H"""
    <div class="max-w-4xl mx-auto py-10 px-4">
      <div class="mb-12">
        <h2 class="text-3xl font-bold mb-6 text-gray-900">Create Ticket</h2>
        <.form for={@form} phx-change="validate" phx-submit="save" class="space-y-6 bg-white p-6 rounded-lg shadow">
          <.input field={@form[:subject]} label="Subject" type="text" />
          
          <div>
            <.button class="w-full flex justify-center py-2 px-4 border border-transparent rounded-md shadow-sm text-sm font-medium text-white bg-brand hover:bg-brand/90 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-brand">
              Create Ticket
            </.button>
          </div>
        </.form>
      </div>

      <div>
        <h3 class="text-2xl font-bold mb-4 text-gray-900">Existing Tickets</h3>
        <div class="bg-white shadow overflow-hidden sm:rounded-md">
          <ul role="list" class="divide-y divide-gray-200">
            <li :for={ticket <- @tickets} class="px-4 py-4 sm:px-6 hover:bg-gray-50">
              <div class="flex items-center justify-between">
                <p class="text-sm font-medium text-brand truncate"><%= ticket.subject %></p>
                <div class="ml-2 flex-shrink-0 flex items-center gap-2">
                  <p class="px-2 inline-flex text-xs leading-5 font-semibold rounded-full bg-green-100 text-green-800">
                    <%= ticket.status %>
                  </p>
                  <button :if={ticket.status == :open} phx-click="close" phx-value-id={ticket.id} class="text-xs text-red-600 hover:text-red-900 font-medium">
                    Close
                  </button>
                </div>
              </div>
              <div class="mt-2 sm:flex sm:justify-between">
                <div class="sm:flex">
                  <p class="flex items-center text-sm text-gray-500">
                    ID: <%= ticket.id %>
                  </p>
                </div>
              </div>
            </li>
          </ul>
        </div>
      </div>
    </div>
    """
  end

  def handle_event("close", %{"id" => id}, socket) do
    ticket = socket.assigns.tickets |> Enum.find(& &1.id == id)
    
    ticket
    |> Ash.Changeset.for_update(:close)
    |> Ash.update!()

    {:noreply, push_navigate(socket, to: ~p"/tickets")}
  end

  def handle_event("validate", %{"form" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)
    {:noreply, assign(socket, form: form)}
  end

  def handle_event("save", %{"form" => params}, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form, params: params) do
      {:ok, _ticket} ->
        {:noreply,
         socket
         |> put_flash(:info, "Ticket created successfully!")
         |> push_navigate(to: ~p"/tickets")}

      {:error, form} ->
        {:noreply, assign(socket, form: form)}
    end
  end
end
