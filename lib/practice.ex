defmodule Practice do
  @moduledoc """
  Practice keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def double(x) do
    2 * x
  end

  def calc(expr) do
    # This is more complex, delegate to lib/practice/calc.ex
    Practice.Calc.calc(expr)
  end

  def factor(x) do
    # Maybe delegate this too.
    Practice.Factorization.primeFactor(x)
  end

  # TODO: Add a palindrome? function.
  def palindrome(x) do
    x = String.downcase(x)
    rev = String.reverse(x)
    rev == x
  end
end
