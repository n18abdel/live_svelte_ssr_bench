defmodule LiveSvelteSsrBenchWeb.NumbersLive do
  use LiveSvelteSsrBenchWeb, :live_view

  def render(assigns) do
    ~H"""
    <%= for i <- 0..99 do %>
      <LiveSvelte.svelte name="Numbers" props={%{number: @number + i}} />
    <% end %>
    """
  end

  def handle_event("set_number", %{"number" => number}, socket) do
    {:noreply, assign(socket, :number, number)}
  end

  def mount(_params, _session, socket) do
    {:ok, assign(socket, :number, 5)}
  end
end
