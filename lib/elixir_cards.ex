defmodule ElixirCards do
  @moduledoc """
  Documentation for `ElixirCards`.
  """

  @doc """
  Create Deck

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
  Shuffle Deck

  ## Examples

      iex> ElixirCards.shuffle(["Ace", "Two", "Three"])
      ["Three", "Ace", "Two"]
      iex> ElixirCards.shuffle(["Ace", "Two", "Three"])
      ["Three", "Two", "Ace"]
      iex> ElixirCards.shuffle([])
      []

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  Contains some card in a Deck

  ## Examples

      iex> ElixirCards.contains?(["Ace", "Two", "Three"], "Two")
      true
      iex> ElixirCards.contains?(["Ace", "Two", "Three"], "Four")
      false

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Deal cards based on a deck

  ## Examples

      iex> ElixirCards.deal(["Ace", "Two", "Three"], 1)
      {["Ace"], ["Two", "Three"]}

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
  Save deck to file

  ## Examples

      iex> ElixirCards.save(["Ace", "Two", "Three"], "my_deck")
      :ok

  """
  def save(deck, filename) do
    # this solution store deck in binary format
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)

    # another solution to write in ascii
    #
    # {:ok, file} = File.open(filename, [:write])
    # IO.binwrite(file, deck)
    # File.close(file)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, _reason} -> "That file does not exist"
    end
  end

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
