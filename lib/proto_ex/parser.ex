defmodule ProtoEx.Parser do

  # TODO: Test  
  def parse(proto) do
    {:ok, tokens, _} = :gpb_scan.string('#{proto}')
    {:ok, defs} = :gpb_parse.parse(tokens)

    defs
  end

end