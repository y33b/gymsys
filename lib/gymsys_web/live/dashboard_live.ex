defmodule GymsysWeb.DashboardLive do
  use GymsysWeb, :live_view
  alias Gymsys.GroupData
  alias Gymsys.PermissionData
  @impl true
  def mount(_params, _session, socket) do
    {:ok,assign(socket,groups: GroupData.list_groups(),group_form: to_form(%{}),permission_form: to_form(%{}),permissions: PermissionData.list_permissions())}
  end
  @impl true
  def render(assigns) do
    ~H"""
    <div class="min-h-screen bg-gray-50 p-6">
      <div class="mx-auto max-w-7xl">

        <!-- Header -->
        <div class="mb-8">
          <h1 class="text-3xl font-bold text-gray-900">
            Dashboard
          </h1>
          <p class="mt-1 text-sm text-gray-500">
            Manage groups and permissions
          </p>
        </div>

        <!-- Groups -->
        <div class="mb-8 rounded-xl bg-white p-6 shadow-sm ring-1 ring-gray-200">

          <div class="mb-6 flex items-center justify-between">
            <div>
              <h2 class="text-xl font-semibold text-gray-900">
                Groups
              </h2>
              <p class="text-sm text-gray-500">
                Create and manage user groups
              </p>
            </div>

            <span class="rounded-full bg-gray-100 px-3 py-1 text-sm font-medium text-gray-700">
              {length(@groups)} groups
            </span>
          </div>

          <!-- Add group -->
          <.form
            for={@group_form}
            phx-submit="add_group"
            class="mb-6 flex gap-3"
          >
            <div class="flex-1">
              <.input
                type="text"
                field={@group_form[:name]}
                placeholder="Group name"
              />
            </div>

            <.button class="cursor-pointer border-2 border-solid px-5">
              Add group
            </.button>
          </.form>

          <!-- Groups table -->
          <div class="overflow-hidden rounded-lg border border-gray-200">
            <table class="w-full text-left text-sm">
              <thead class="bg-gray-50 text-xs uppercase text-gray-500">
                <tr>
                  <th class="px-4 py-3">Name</th>
                  <th class="px-4 py-3">ID</th>
                  <th class="px-4 py-3 text-right">Actions</th>
                </tr>
              </thead>

              <tbody class="divide-y divide-gray-200">
                <tr :for={group <- @groups} class="hover:bg-gray-50">
                  <td class="px-4 py-3 font-medium text-gray-900">
                    {group.name}
                  </td>

                  <td class="px-4 py-3 font-mono text-xs text-gray-500">
                    {group.id}
                  </td>

                  <td class="px-4 py-3 text-right">
                    <.button
                      phx-click="delete_group"
                      phx-value-id={group.id}
                      class="bg-red-600 hover:bg-red-700 px-5 py-2 "
                    >
                      Delete
                    </.button>
                  </td>
                </tr>

                <tr :if={@groups == []}>
                  <td colspan="3" class="px-4 py-8 text-center text-gray-500">
                    No groups yet.
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

        <!-- Permissions -->
        <div class="rounded-xl bg-white p-6 shadow-sm ring-1 ring-gray-200">

          <div class="mb-6 flex items-center justify-between">
            <div>
              <h2 class="text-xl font-semibold text-gray-900">
                Permissions
              </h2>
              <p class="text-sm text-gray-500">
                Create and manage application permissions
              </p>
            </div>

            <span class="rounded-full bg-gray-100 px-3 py-1 text-sm font-medium text-gray-700">
              {length(@permissions)} permissions
            </span>
          </div>

          <!-- Add permission -->
          <.form
            for={@permission_form}
            phx-submit="add_permission"
            class="mb-6 grid gap-4 md:grid-cols-3"
          >
            <.input
              type="text"
              field={@permission_form[:code]}
              placeholder="Permission code"
            />

            <.input
              type="text"
              field={@permission_form[:name]}
              placeholder="Permission name"
            />

            <.input
              type="text"
              field={@permission_form[:module]}
              placeholder="Module"
            />

            <div class="md:col-span-3">
              <.button class="cursor-pointer border-2 border-solid px-5">
                Add permission
              </.button>
            </div>
          </.form>

          <!-- Permissions table -->
          <div class="overflow-hidden rounded-lg border border-gray-200">
            <table class="w-full text-left text-sm">
              <thead class="bg-gray-50 text-xs uppercase text-gray-500">
                <tr>
                  <th class="px-4 py-3">Code</th>
                  <th class="px-4 py-3">Name</th>
                  <th class="px-4 py-3">Module</th>
                  <th class="px-4 py-3">ID</th>
                  <th class="px-4 py-3 text-right">Actions</th>
                </tr>
              </thead>

              <tbody class="divide-y divide-gray-200">
                <tr :for={permission <- @permissions} class="hover:bg-gray-50">

                  <td class="px-4 py-3">
                    <code class="rounded bg-gray-100 px-2 py-1 text-xs font-medium text-gray-700">
                      {permission.code}
                    </code>
                  </td>

                  <td class="px-4 py-3 font-medium text-gray-900">
                    {permission.name}
                  </td>

                  <td class="px-4 py-3 text-gray-600">
                    {permission.module}
                  </td>

                  <td class="px-4 py-3 font-mono text-xs text-gray-500">
                    {permission.id}
                  </td>

                  <td class="px-4 py-3 text-right">
                    <.button
                      phx-click="delete_permission"
                      phx-value-id={permission.id}
                      class="cursor-pointer bg-red-600 hover:bg-red-700 px-5 py-2"
                    >
                      Delete
                    </.button>
                  </td>

                </tr>

                <tr :if={@permissions == []}>
                  <td colspan="5" class="px-4 py-8 text-center text-gray-500">
                    No permissions yet.
                  </td>
                </tr>
              </tbody>
            </table>
          </div>
        </div>

      </div>
    </div>
    """
  end
  @impl true

  def handle_event("add_group", %{"name" => name}, socket) do
    case GroupData.create_group(%{"name" => String.downcase(name)}) do
      {:ok, group} ->
        {:noreply,
         socket |> stream_insert(:group, group)}
    
      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
  @impl true

  def handle_event("delete_group", %{"id" => id}, socket) do
    group = GroupData.get_group!(id)
    {:ok, _} = GroupData.delete_group(group)

    {:noreply, stream_delete(socket, :group,group)}
  end
  
  @impl true

  def handle_event("add_permission", %{"name" => name,"code"=>code,"module"=>mdodue}, socket) do
    case PermissionData.create_permission(%{"name" => name,"code"=>code,"module"=>mdodue}) do
      {:ok, permission} ->
        {:noreply,
         socket |> stream_insert(:permission, permission)}
    
      {:error, changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end
  @impl true

  def handle_event("delete_permission", %{"id" => id}, socket) do
    permission = PermissionData.get_permission!(id)
    {:ok, _} = PermissionData.delete_permission(permission)
    {:noreply, stream_delete(socket, :permission, permission)}
  end

end
