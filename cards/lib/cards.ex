defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards

  ## Examples

      iex> Cards.create_deck
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Ace of Clubs",
       "Two of Clubs", "Three of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Ace of Diamonds", "Two of Diamonds",
       "Three of Diamonds"]

  """
  def create_deck do
    values = ["Ace", "Two", "Three"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  @doc """
    Returns a shuffle deck

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.shuffle(deck)
      ["Three of Diamonds", "Ace of Hearts", "Three of Hearts",
       "Three of Clubs", "Ace of Clubs", "Two of Spades", "Two of Hearts",
       "Ace of Spades", "Two of Clubs", "Three of Spades", "Two of Diamonds",
       "Ace of Diamonds"]

  """
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns if a deck contains an specific card

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Hearts")
      true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck. The `hand_size`
    argument indicates how many cards should be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  @doc """
    Saves a deck to filesystem

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.save(deck, "test_filename")
      :ok

  """
  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  @doc """
    Loads a deck from filesystem

  ## Examples

      iex> Cards.load("test_filename")
      ["Ace of Spades", "Two of Spades", "Three of Spades", "Ace of Clubs",
       "Two of Clubs", "Three of Clubs", "Ace of Hearts", "Two of Hearts",
       "Three of Hearts", "Ace of Diamonds", "Two of Diamonds",
       "Three of Diamonds"]

  """
  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "That file does not exist"
    end
  end

  @doc """
    Creates a shuffle hand with `hand_size` cards

  ## Examples

      iex> Cards.create_hand(5)
      {["Three of Clubs", "Two of Clubs", "Ace of Spades", "Two of Hearts",
        "Three of Hearts"],
       ["Ace of Diamonds", "Three of Diamonds", "Ace of Clubs",
        "Two of Diamonds", "Three of Spades", "Two of Spades", "Ace of Hearts"]}

  """
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
