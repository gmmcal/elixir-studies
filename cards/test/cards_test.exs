defmodule CardsTest do
  use ExUnit.Case
  doctest Cards, except: [shuffle: 1, create_hand: 1]

  test "create_deck makes 12 cards" do
    deck_length = length(Cards.create_deck)
    assert deck_length == 12
  end

  test "shuffling a deck randomizes it" do
    deck = Cards.create_deck
    refute deck == Cards.shuffle(deck)
  end
end
