defmodule ProtoEx.Simple3Test do
  use ExUnit.Case, async: true

  # Evaluate module
  ("./test/protos/simple3.proto"
    |> ProtoEx.from_file()
    |> ProtoEx.to_quoted()
    |> Code.eval_quoted)

  test "evaluation" do
    expected =
      File.read!('./test/protos/simple3_expected.exs')
      |> Code.string_to_quoted

    assert expected ==
      "./test/protos/simple3.proto"
      |> ProtoEx.from_file()
      |> ProtoEx.to_quoted()
  end

  describe "when evaluated" do
    setup do
      # Load the actual module when test is set-up

      :ok
    end

    test "module exists and can be created" do
      %AddressBook{
        person: [
          %Person{
            name: "Bob Smith",
            phone: [
              %Person.PhoneNumber{
                number: "123",
                type: Person.PhoneType.mobile
              }
            ]
          }
        ]
      }
    end

  #   test "it is valid" do
  #     input = File.read("./simple3.in")
  #     address_book = ProtoEx.decode(binary, Simple3.AddressBook)

  #     %Simple3.AddressBook{person: person} = address_book

  #     assert Enum.count(person) == 2

  #     [p1|p2|[]] = person

  #     assert p1.name = "Bob Jones"
  #     assert p1.id = 5
  #     assert p1.email = "bobjones@example.com"
  #     assert Enum.count(p1.phone) == 1
  #     [phone|[]] = p1.phone
  #     assert phone.number == "1112223333"
  #     assert phone.type == Simple3.Person.PhoneType.HOME

  #     assert p2.name == "Tom Smith"
  #     assert Enum.count(p2.phone) == 0

  #     assert ProtoEx.encode(address_book) == input
  #   end
  end
end