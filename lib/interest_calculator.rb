module InterestCalculator
  def interest_rate
    0.1
  end

 def calculate_daily_interest_on(balance)
   interest = balance * interest_rate / 365
   if interest < 0 then
     interest = BigDecimal("-0.01") if interest > BigDecimal("-0.01")
   else
     interest = BigDecimal("0.01") if interest < BigDecimal("0.01")
   end
 end
end
