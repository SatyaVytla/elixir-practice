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
    acc = 0
    operatorStack =[]
    digitStack =[]
    sps = String.split(expr, ~r/\s+/)
    if Enum.count(sps) == 1 do
     [x] = sps
     x = parse_float(x)
     x
    else
    sps
    |> accumulator(operatorStack,digitStack);
end
end

def compute(operand1,operand2,itemPopped) do
case itemPopped do
    "+" -> operand1 + operand2
    "-" -> operand1 - operand2
    "*" -> operand1 * operand2
    "/" -> operand1 / operand2
end
end

  def assignPrecedenceToOperators(operator) do
    case operator do
        "+" -> 1
        "-" -> 1
        "*" -> 2
        "/" -> 2
        _  -> 0
    end
  end

# For appending into stack and removing item from stack referred https://blog.codeship.com/statefulness-in-elixir/

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
    if Enum.count(splits) > 0 do
    [s | tail] = splits

    if s in ["*","/","+","-"] do
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
          accumulator(tail,operatorStack,digitStack)

        else
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
