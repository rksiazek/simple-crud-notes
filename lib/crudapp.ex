defmodule Crudapp do
  @moduledoc """
  Documentation for `Crudapp`.
  """

  require Controller
  require Operations
  use Operations

  def main(_args) do
    out "=== Simple notes CRUD app ==="

    ents = %{}
    identity = 0
    mainMenu({ents, identity})
  end

  def mainMenu({ents, identity}) do
    showMenu()
    mainMenu(Controller.processRequestedOption({ents, identity}, listenForChoice()))
  end

  def showMenu() do
    out "\n\n===================="
    out "1. Create note"
    out "2. Edit note"
    out "3. Remove note"
    out "4. List notes"
    out ""
    out "0. Exit"
    out "====================\n\n"
  end

  def listenForChoice() do
    input "Chosen option: "
  end
end
