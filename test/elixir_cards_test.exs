defmodule ElixirCardsTest do
  use ExUnit.Case
  doctest ElixirCards

  test "create_deck makes a 20 cards" do
    deck_length = length(ElixirCards.create_deck)
    assert deck_length == 20
  end

  test "first card of create_deck needs be Ace of Spades" do
    first_card = List.first(ElixirCards.create_deck)
    assert first_card == "Ace of Spades"
  end

  test "last card of create_deck needs be Five of Diamonds" do
    last_card = List.last(ElixirCards.create_deck)
    assert last_card == "Five of Diamonds"
  end

  test "shuffle a deck randomizes it" do
    deck = ElixirCards.create_deck
    refute deck == ElixirCards.shuffle(deck)
  end

  test "contains? needs return true for Ace of Spades" do
    deck = ElixirCards.create_deck
    assert ElixirCards.contains?(deck, "Ace of Spades") == true
  end

  test "contains? needs return false for Xablau" do
    deck = ElixirCards.create_deck
    assert ElixirCards.contains?(deck, "Xablau") == false
  end

  test "deal with 1 card needs be split deck and remainder 19 cards" do
    deck = ElixirCards.create_deck
    { hand, remainder_deck } = ElixirCards.deal(deck, 1)
    assert hand == ["Ace of Spades"]
    assert length(remainder_deck) == 19
  end

  test "deal with 10 cards needs be split deck and remainder 10 cards" do
    deck = ElixirCards.create_deck
    { hand, remainder_deck } = ElixirCards.deal(deck, 10)
    assert length(hand) == 10
    assert length(remainder_deck) == 10
  end

  test "deal with 10 cards on empty deck needs split deck and remainder 0 cards" do
    deck = []
    { hand, remainder_deck } = ElixirCards.deal(deck, 10)
    assert length(hand) == 0
    assert length(remainder_deck) == 0
  end

  # TODO: Needs mock disk write
  test "save deck on filename '/tmp/rafael' needs return :ok" do
    deck = ElixirCards.create_deck
    status = ElixirCards.save(deck, "/tmp/rafael")
    assert status == :ok
  end

  # TODO: Needs mock disk write
  test "save deck on filename '/xablau/rafael' needs return error message" do
    deck = ElixirCards.create_deck
    status = ElixirCards.save(deck, "/xablau/rafael")
    assert status == "Cannot write deck to this filename /xablau/rafael"
  end

  # TODO: Needs mock disk read
  test "load deck from filename '/tmp/rafael' needs return the deck" do
    deck = ElixirCards.load("./test/sample_deck")
    assert is_list(deck) == true
    assert length(deck) == 20
    assert List.first(deck) == "Ace of Spades"
    assert List.last(deck) == "Five of Diamonds"
  end

  # TODO: Needs mock disk read
  test "load deck from filename '/xablau/rafael' needs return error message" do
    error = ElixirCards.load("/xablau/sample_deck")
    assert error == "That file does not exist"
  end

  # TODO: Needs some mocks here too to test independent functions
  test "create_hand needs return a shuffled hand with 3 cards and remainder deck" do
    {hand, remainder_deck} = ElixirCards.create_hand(3)
    assert is_list(hand) == true
    assert is_list(remainder_deck) == true
    assert length(hand) == 3
    assert length(remainder_deck) == 17
  end

end
