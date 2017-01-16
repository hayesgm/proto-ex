defmodule ProtoEx.GpbTest do
  use ExUnit.Case, async: true

  # Evaluate module
  ("./test/protos/gpb.proto"
    |> ProtoEx.from_file()
    |> ProtoEx.to_quoted()
    |> Code.eval_quoted)

  test "evaluation" do
    expected =
      File.read!('./test/protos/gpb_expected.exs')
      |> Code.string_to_quoted

    assert expected ==
      "./test/protos/gpb.proto"
      |> ProtoEx.from_file()
      |> ProtoEx.to_quoted()
  end

  describe "when evaluated" do
    test "encode and decode" do
      bin = <<10,7,97,98,99,32,100,
              101,102,16,217,2,26,13,97,64,101,
              120,97,109,112,108,101,46,99,111,109>>
      person = ProtoEx.decode(bin, Person)

      assert %Person{
        name:"abc def",
        id: 345,
        email: "a@example.com"
      } == person

      assert bin == ProtoEx.encode(person)
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