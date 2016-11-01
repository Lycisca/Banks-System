# transfer.rb

class Transfer

  attr_reader :sender_account, :amount, :receiver_account

  def initialize(sender_account, amount, receiver_account)
    @sender_account = sender_account
    @amount = amount
    @receiver_account = receiver_account
  end

  def apply(origin_account, destination_account)
    if valid_transfer(origin_account.amount)
      origin_account.amount -= (@amount + @comission)
      destination_account.amount += @amount
    end
  end

  private

  def valid_transfer(account_amount)
    raise 'You don´t have enought money' if account_amount < (@amount + @comission)
    raise "You cannot transfer more than #{@limit} euros" if @amount > @limit
    raise 'Transfer failures' unless @success
    true
  end
end
