defmodule ElixirCards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards.

  ## Examples

      iex> ElixirCards.create_deck()
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Four of Spades",
       "Five of Spades", "Ace of Clubs", "Two of Clubs", "Three of Clubs",
       "Four of Clubs", "Five of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Four of Hearts", "Five of Hearts", "Ace of Diamonds",
       "Two of Diamonds", "Three of Diamonds", "Four of Diamonds", "Five of Diamonds"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    # this is a wrong/dumb solution
    #
    # cards = for suit <- suits do
    #   for value <- values do
    #     "#{value} #{suit}"
    #   end
    # end

    # List.flatten(cards)

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end

  end

  @doc """
    Randomize your deck returning a randomized list of strings
    representing your deck.

  ## Examples

      iex> deck = ElixirCards.create_deck
      iex> deck != ElixirCards.shuffle(deck)
      true

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card.

  ## Examples

      iex> deck = ElixirCards.create_deck
      iex> ElixirCards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = ElixirCards.create_deck
      iex> {hand, deck} = ElixirCards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Save a deck to binary file in your disk. The `filename`
    argument indicates name of file to store your deck.

  ## Examples

      iex> deck = ElixirCards.create_deck
      iex> ElixirCards.save(deck, "/tmp/sample_doctest")
      :ok

  """
  def save(deck, filename) do
    # this solution store deck in binary format
    binary = :erlang.term_to_binary(deck)
    case File.write(filename, binary) do
      :ok -> :ok
      {:error, _reason} -> "Cannot write deck to this filename #{filename}"
    end

    # another solution to write in ascii
    #
    # {:ok, file} = File.open(filename, [:write])
    # IO.binwrite(file, deck)
    # File.close(file)
  end

  @doc """
    Load a deck from binary file in your disk. The `filename`
    argument indicates name of file to read your deck from your
    disk.

  ## Examples

      iex> deck = ElixirCards.create_deck
      iex> ElixirCards.save(deck, "/tmp/sample_doctest")
      iex> loaded_deck = ElixirCards.load("/tmp/sample_doctest")
      iex> loaded_deck == deck
      true

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Create a deck using `create_deck` method, shuffle deck
    using `shuffle` method and divides a deck into a hand
    and the remainder of the deck using `deal` method.

    The `hand_size` argument indicates how many cards should
    be in the hand.

  """
  def create_hand(hand_size) do
    # this is a wrong/dumb solution
    #
    # deck = ElixirCards.create_deck
    # deck = ElixirCards.shuffle(deck)
    # ElixirCards.deal(deck, hand_size)

    # Using Pipe operator
    ElixirCards.create_deck
    |> ElixirCards.shuffle
    |> ElixirCards.deal(hand_size)
  end

end
