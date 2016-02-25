defmodule AboutTuples do
  use Koans

  think "Getting tuples size is a kernel feature" do
    a_tuple = {:foo, :bar}
    assert tuple_size(a_tuple) == __?
  end

  think "Can reach tuple element with index" do
    a_tuple = {:foo, :bar}
    assert elem(a_tuple, 0) == __?
  end

  defmacrop erlang_elem(tuple, index) do
    # Note: Elixir provides access to erlang primitives with atom :erlang
    quote do: :erlang.element(unquote(index), unquote(tuple))
  end

  think "In erlang tuples and lists start at index 1, which is different in elixir" do
    a_tuple = {:foo, :bar}
    foo_index = 0
    assert elem(a_tuple, foo_index) == erlang_elem(a_tuple, foo_index + __?)
  end

  think "Can set a tuple element" do
    a_tuple = {:foo, :bar}
    baz_tuple = put_elem(a_tuple, 0, :baz)
    # Note: think about immutability
    assert elem(a_tuple, 0) == __?
    assert elem(baz_tuple, 0) == __?
  end

  think "Setting a tuple element that not exists raise an argument error" do
    a_tuple = {:foo, :bar}

    assert_raise ArgumentError, fn -> put_elem(a_tuple, __?, :baz) end
  end

  think "Can insert a tuple element" do
    a_tuple = {:foo, :bar}
    baz_tuple = Tuple.insert_at(a_tuple, 2, :baz)
    assert elem(baz_tuple, 2) == __?
  end

  think "Inserting a tuple element raise an argument error if index is invalid" do
    a_tuple = {:foo, :bar}
    assert_raise ArgumentError, fn -> Tuple.insert_at(a_tuple, __?, :baz) end
  end

  think "The building blocks of Elixir are tuples of three elements" do
    # Note: quote gives the representation of a block
    quoted_block = quote do
      a = 1 + 2
      assert a == 3
    end

    assert Koans.Check.tuple?(quoted_block)
    assert tuple_size(quoted_block) == __?
  end

  think "We can use tuples to define blocks" do
    # Note: unquote is the reverse of quote
    # It gives a block from its representation
    unquoted_block = unquote {:"{}", [], [1, 2, 3]}
    # Note: it's an hungarian notation
    # the atom :"{}" represent the function
    # the list [] contains metadatas like the line and module where code is defined
    # the list [1, 2, 3] are arguments passed to the function
    # For more infos see Macros and quote/unquote functions
    assert unquoted_block == __?
  end

  think "Are tuples enumerables ?" do
    assert_raise __?, fn -> Enum.empty?({1, 2, 3}) end
    # Note:
    # Do you smell the underlying machinery that make list and tuple types differents ?
  end
end
