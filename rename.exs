defmodule Rename do
  @match ~r/.*(\.exs|\.ex|\.heex)$/
  @ignore ~r/\.git/

  @default "caltar"

  def rename(to, from \\ @default) do
    walk_files("./", [], &rename_caltar({from, to}, &1, &2))
  end

  defp rename_caltar({from, to},{:file, file}, acc) do
    replace_content(file, {from, to})
    new_name = String.replace(file, from, to)
    :ok = File.rename(file, new_name)
    [new_name | acc]
  end

  defp rename_caltar({from, to}, {:dir, dir}, _) do
    new_name = String.replace(dir, from, to)

    :ok = File.rename(dir, new_name)

    if new_name != dir do
      {:rename, new_name}
    else
      :continue
    end
  end

  defp replace_content(file, {from, to}) do
    camelized_from = Macro.camelize(from)
    camelized_to = Macro.camelize(to)
    patterns = %{
      ":#{from}_web" => ":#{to}_web",
      ":#{from}" => ":#{to}",
      from => to,
      camelized_from <> "Web" => camelized_to <> "Web",
      camelized_from => camelized_to
    }

    content = File.read!(file)
    new_content = Enum.reduce(patterns, content, fn {old, new}, acc ->
      String.replace(acc, old, new)
    end)
    File.write!(file, new_content)
  end

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

