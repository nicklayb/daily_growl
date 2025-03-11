defmodule Rename do
  @match ~r/.*(\.exs|\.ex|\.heex)$/
  @ignore ~r/\.git/

  def walk_files(folder, acc, function, options \\ [])

  def walk_files("/" <> _ = folder, acc, function, options) do
    match = Keyword.get(options, :match, @match)

    folder
      |> File.ls!()
      |> Enum.reduce(acc, fn file, acc ->
      full_path = Path.join(folder, file)

      cond do
        File.dir?(full_path) ->
          walk_folder(full_path, acc, function, options)

        Regex.match?(match, file) ->
          function.({:file, full_path}, acc)

        true ->
          acc
      end
    end)
  end

  def walk_files(folder, acc, function, options) do
    folder
      |> Path.expand()
      |> walk_files(acc, function, options)
  end

  def walk_folder(folder, acc, function, options) do
    case function.({:dir, folder}, acc) do
      {:rename, new_name} -> 
        folder
          |> String.replace(folder, new_name)
          |> walk_files(acc, function, options)

      :discard ->
        acc

      :continue ->
        walk_files(folder, acc, function, options)
    end
  end
end

