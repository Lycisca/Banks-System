# account.rb
class Account

  attr_accessor :number, :amount, :code_bank

  def initialize(number, amount=nil)
    amount ||= 0
    raise ArgumentError, 'Number must have 10 digits' if ( number.size < 10 )
    @number = number
    @amount = amount.to_f
    @code_bank = number[0..3]
  end
end

