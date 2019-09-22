defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    #|> hd
    #|> parse_float
    #|> :math.sqrt()

    # Hint:
    # expr
    # |> split
    # |> tag_tokens  (e.g. [+, 1] => [{:op, "+"}, {:num, 1.0}]
    # |> convert to postfix
    # |> reverse to prefix
    # |> evaluate as a stack calculator using pattern matching
    initial = -1
    acc = 0
    operatorStack =[]
    digitStack =[]
    expr
    |> String.split(~r/\s+/)
    |> accumulator(operatorStack,digitStack);

end

def compute(operand1,operand2,itemPopped) do
value = 0
case itemPopped do
    "+" -> operand1 + operand2
    "-" -> operand1 - operand2
    "*" -> operand1 * operand2
    "/" -> operand1 / operand2
end
end

  def assignPrecedenceToOperators(operator) do
  precedence = 0
    case operator do
        "+" -> 1
        "-" -> 1
        "*" -> 2
        "/" -> 2
        _  -> precedence = 0
    end
  end
# https://blog.codeship.com/statefulness-in-elixir/
  def size(stack) do
    Enum.count(stack)
  end

  def pop(stack) do
    [last_in | rest] = stack
    {last_in , rest}
  end

  def push(stack, item) do
    [item | stack]
  end

def accumulator(splits, operatorStack, digitStack)  do
IO.inspect(splits)
IO.inspect(digitStack)
IO.puts(Enum.count(splits))
IO.inspect(splits)
  IO.puts("sssssssssssssssssgggggbbb")
if Enum.count(splits) > 0 do
[s | tail] = splits
IO.puts(s)
IO.inspect(s)
  IO.puts("sssssssssssssssssggggg")
    if s in ["*","/","+","-"] do
      #Precedence = assignPrecedenceToOperators(s)
      size = size(operatorStack)

      if size == 0 do
        operatorStack  = push(operatorStack, s)
        accumulator(tail,operatorStack,digitStack)

      else
        {itemPopped, operatorStack} = pop(operatorStack)
        accumulator(tail,operatorStack,digitStack)

        if assignPrecedenceToOperators(s) > assignPrecedenceToOperators(itemPopped) do
          operatorStack  = push(operatorStack, itemPopped)
          operatorStack  = push(operatorStack, s)
          IO.puts(digitStack)
          IO.puts("xxxxxxxxxxxxxxxxx")
          IO.inspect(operatorStack)
          accumulator(tail,operatorStack,digitStack)

        else

          #{itemPopped, operatorStack} = pop(operatorStack)
          {operand2, digitStack} = pop(digitStack)
          {operand1, digitStack} = pop(digitStack)
          acc = compute(operand1,operand2,itemPopped)
          operatorStack  = push(operatorStack, s)
          digitStack = push(digitStack,acc)
          accumulator(tail,operatorStack,digitStack)
      end
    end
    else
      {digit, _} = Integer.parse(s)
      digitStack = push(digitStack,digit)
      accumulator(tail,operatorStack,digitStack)
    end
else
  if size(operatorStack) != 0 do
    {itemPopped, operatorStack} = pop(operatorStack)
    {operand2, digitStack} = pop(digitStack)
    {operand1, digitStack} = pop(digitStack)
    acc = compute(operand1,operand2,itemPopped)
    IO.puts("aaacccccccccccccccccccccccccccccccccccccccccc")
    IO.puts(acc)
    IO.inspect(itemPopped)
    IO.inspect(operatorStack)
    digitStack = push(digitStack,acc)
    if size(operatorStack) != 0 do
      accumulator([],operatorStack,digitStack)
    else
      acc
    end
end
end
end
end
