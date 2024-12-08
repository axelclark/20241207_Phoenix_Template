defmodule TemplateWeb.PostLive.Show do
  use TemplateWeb, :live_view

  alias Template.Blog

  @impl true
  def render(assigns) do
    ~H"""
    <.header>
      Post <%= @post.id %>
      <:subtitle>This is a post record from your database.</:subtitle>
      <:actions>
        <.button phx-click={JS.dispatch("click", to: {:inner, "a"})}>
          <.link navigate={~p"/posts/#{@post}/edit?return_to=show"}>
            Edit post
          </.link>
        </.button>
      </:actions>
    </.header>

    <.list>
      <:item title="Title"><%= @post.title %></:item>
      <:item title="Body"><%= @post.body %></:item>
    </.list>

    <.back navigate={~p"/posts"}>Back to posts</.back>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "Show Post")
     |> assign(:post, Blog.get_post!(id))}
  end
end
