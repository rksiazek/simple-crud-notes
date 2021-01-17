defmodule Controller do
  @moduledoc false

  require EntModel
  use Operations

  @doc """

  """

  def processRequestedOption({ents, identity}, optionId) do
    case optionId do
      "1" -> save({ents, identity}, promptForEntData())
      "2" -> edit({ents, identity}, promptForEntId())
      "3" -> delete({ents, identity}, promptForEntId())
      "4" -> listNotes(ents); {ents, identity}
      "0" -> exit(:shutdown)
      _ -> out "Wrong option number provided."; {ents, identity};
    end
  end

  def promptForEntId() do
    inputNumber("Enter ID")
  end

  def promptForEntData() do
    %EntModel{id: nil, name: (input "Title"), value: (input "Description")}
  end

  def promptForEntData(ent) do
    %EntModel{id: ent.id, name: (inputOrDefault("New title", ent.name)), value: (inputOrDefault("New description", ent.value))}
  end

  def listNotes(ents) do
    ents
    |> Map.values()
    |> Enum.each(&IO.inspect/1)
  end

  def save({ents, identity}, %EntModel{id: nil, name: _, value: _} = newEnt) do
    {Map.put(ents, identity, %EntModel{newEnt | id: identity}), identity + 1}
  end

  def save({ents, identity}, editedEnt) do
  { ents
    |> Map.update!(editedEnt.id, &%EntModel{&1 | name: editedEnt.name})
    |> Map.update!(editedEnt.id, &%EntModel{&1 | value: editedEnt.value}),
    identity
  }
  end

  def edit({ents, identity}, entId) do
    storedEnt = Map.get(ents, entId)

    if(storedEnt == nil) do
      out "Entity does not exist!"
      edit({ents, identity}, promptForEntId())
    else
      save({ents, identity}, promptForEntData(storedEnt))
    end
  end

  def delete({ents, identity}, entId) do
    {Map.delete(ents, entId), identity}
  end

  def inputNumber(label) do
    case Integer.parse(input(label)) do
      {_ = parsedNum, _ = _tail} -> parsedNum
      :error -> out "Invalid number!"; inputNumber(label)
    end
  end
end