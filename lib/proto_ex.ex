defmodule ProtoEx do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    # Define workers and child supervisors to be supervised
    children = [
      # Starts a worker by calling: ProtoEx.Worker.start_link(arg1, arg2, arg3)
      # worker(ProtoEx.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProtoEx.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # TODO: Spec, etc
  def from_file(file) do
    {:ok, contents} = File.read(file)

    load(contents)
  end

  def load(proto) do
    ProtoEx.Parser.parse(proto)
  end

  def to_quoted(parsed) do
    ProtoEx.Quoter.to_quoted(parsed)
  end

  def encode(binary, obj) do
    
  end

  def decode(obj)
end
