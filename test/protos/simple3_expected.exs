defmodule Person do
  defmodule PhoneNumber do
    defmodule PhoneType do
      defmacro MOBILE, do: 0
      defmacro HOME, do: 1
      defmacro WORK, do: 2
    end

    @type phone_type :: int32()

    @type t :: %{
      number: String.t(),
      type: phone_type()
    }
    defstruct [
      number: "",
      type: nil
    ]
  end

  @type t :: %{
    name: String.t,
    id: int32(),
    email: String.t,
    phone: [PhoneNumber.t]
  }
  defstruct [
    name: "",
    id: 0,
    email: "",
    phone: [],
  ]
end

defmodule AddressBook do
  @type t :: %{
    person: [Person.t]
  }
  defstruct [
    person: []
  ]
end