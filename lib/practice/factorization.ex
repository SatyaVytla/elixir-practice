defmodule Practice.Factorization do

  def parse_Int(text) do
    {num, _} = Integer.parse(text)
    num
  end

  def primeFactor(x) do
    num = parse_Int(x)
    factors = []
    if num <= 1 do
      factors
    else
      res = factorize(factors,num,2)
      res
    end
  end

  def factorize(factors,num,seed) do
  IO.inspect(factors)
  IO.puts(factors)
  IO.puts(num)
  IO.puts(seed)
  IO.puts("11111111111111111111111")
    if num == 2 do
      factors ++ [num]

    else
        if seed < num do
          if rem(num, seed) == 0 do
            #factors = [factors | seed]
            #num = div(num,seed)
            factors = factors ++ [seed]
            factorize(factors,div(num,seed),seed)

          else
            factorize(factors,num,seed + 1)
          end

        else
          if num > 2 do
            factors = factors ++ [seed]
            IO.puts(factors)
            factors
          end
        end
    end
  end #func end

end
