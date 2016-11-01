# bank.rb
require 'date'
require_relative 'account'

class Bank

  attr_reader :code, :accounts, :transfers

  def initialize(code)
    @code = code
    @accounts = []
    @transfers = []
  end

  def add_account(number, amount)
    accounts << Account.new(number, amount)
  end

  def add_history(sender_account, amount, receiver_account)
    transfers << {
      datetime: DateTime.now().strftime("%d/%m/%Y"),
      origin_account: sender_account,
      destination_account: receiver_account,
      amount: amount
    }
  end
end

