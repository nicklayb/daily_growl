defmodule DailyGrowl.UseCase do
  def execute(use_case, params, options \\ []) do
    options = with_default_options(options)
    Box.UseCase.execute(use_case, params, options)
  end

  defp with_default_options(options) do
    Keyword.put(options, :run, &DailyGrowl.Repo.transaction/2)
  end

  defmacro delegate_use_case(name, use_case) do
    bang_name = :"#{name}!"

    quote do
      def unquote(bang_name)(params, options \\ []) do
        DailyGrowl.UseCase.execute(unquote(use_case), params, options)
      end

      def unquote(name)(params, options \\ []) do
        DailyGrowl.UseCase.execute(unquote(use_case), params, options)
      end
    end
  end
end
