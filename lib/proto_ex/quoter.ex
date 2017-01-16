defmodule ProtoEx.Quoter do
  
  # TODO: Test
  def to_quoted(defs) do
    Enum.map(defs |> IO.inspect, &(do_quote(&1, [top_module: "Elixir"])))
  end

  def do_quote({{:msg, module}, sub_defs}, [top_module: top_module]) do
    fields = for {:field, field, _, type, _, _, _} <- sub_defs, do: {field, type}

    module_name = String.to_atom("#{top_module}.#{module}")
    quoted_sub_defs = do_quote(sub_defs, [top_module: module_name]) |> Enum.filter(&(&1 != nil))

    innards = {:__block__, [], quote_fields(fields) ++ quoted_sub_defs}
    

    x = quote do
      defmodule unquote(module_name), do: unquote(innards)
    end
    x |> Macro.to_string |> IO.puts
    x
  end

  def do_quote(defs, ctx) when is_list(defs) do
    # TODO: Upgrade
    Enum.map(defs, &(do_quote(&1, ctx)))
  end

  def do_quote({:field, field, num, dunno, type, variety, []}, _ctx) do
    nil
  end

  def do_quote({{:enum, field}, values_kw}, [top_module: top_module]) do
    sub_defs = for {k, v} <- values_kw do
      kd = String.to_atom(String.downcase(to_string(k)))

      type = quote do
        @spec unquote(kd)() :: number()
      end
      func = quote do
        def unquote(kd)() do
          unquote(v)
        end
      end

      [type, func]
    end

    inner = {:__block__, [], List.flatten(sub_defs)}
    field_name = String.to_atom("#{top_module}.#{field}")

    quote do
      defmodule unquote(field_name), do: unquote(inner)
    end
  end

  def do_quote(_els, _ctx) do
    nil
  end

  def quote_fields(fields) do
    field_vars = for {field, _type} <- fields do
      {field, nil}
    end |> Enum.into([])

    types = quote do
      @type t :: unquote(field_vars)
    end
    struct = quote do
      defstruct unquote(field_vars)
    end

    [types, struct]
  end
end