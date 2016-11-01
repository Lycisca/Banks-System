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

  def add_transfer(transfer)
    transfers << {
      datetime:            DateTime.now().strftime("%d/%m/%Y"),
      origin_account:      transfer.sender_account,
      destination_account: transfer.receiver_account,
      amount:              transfer.amount
    }
  end
end

