defmodule Practice.Factorization do

  def parse_Int(text) do
    if is_integer(text) == true do
      num = text
      num

      else
      {num, _} = Integer.parse(text)
       num
    end

  end

  def primeFactor(x) do
    num = parse_Int(x)
    factors = []
    if num <= 1 do
      factors
    else
      res = factorize(factors,num,2)
      #res = parse_Int(res)
      res
    end
  end

  def factorize(factors,num,seed) do
    if num == 2 do
      factors ++ [num]

    else
        if seed < num do
          if rem(num, seed) == 0 do
            factors = factors ++ [seed]
            factorize(factors,div(num,seed), seed)

          else
            factorize(factors,num,seed + 1)
          end

        else
          if num > 2 do
            factors = factors ++ [seed]
            factors
          end
        end
    end
  end
end
