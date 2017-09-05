defmodule CardsTest do
  use ExUnit.Case
  doctest Cards, except: [shuffle: 1, create_hand: 1]
end
