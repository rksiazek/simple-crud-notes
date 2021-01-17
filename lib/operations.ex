defmodule Operations do
  @moduledoc false

  defimpl Inspect, for: EntModel do
    def inspect(ent, _opts) do
      """
      ===========|=====================
         Title   :     #{ent.name}
      #{ent.id} ) -------|---------------------
         Content :     #{ent.value}
      ===========|=====================
      """
    end
  end

  defmacro __using__(_) do
    quote do
      defmacro input(label) do
        quote do
          IO.gets(unquote(label) <> "\n> ")
          |> String.trim()
        end
      end

      defmacro inputOrDefault(label, defaultValue) do
        quote do
          input = input(unquote(label) <> " (or leave empty to remain '#{unquote(defaultValue)}')")
          if (input != "") do
            input
          else
            unquote(defaultValue)
          end
        end
      end

      defmacro out(expr) do
        quote do
          IO.puts(unquote(expr))
        end
      end
    end
  end
end
