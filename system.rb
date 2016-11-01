# system.rb
require_relative 'lib/bank'
require_relative 'lib/inter_bank_transfer.rb'
require_relative 'lib/intra_bank_transfer.rb'

class System

  attr_reader :banks, :accounts

  def initialize
    @banks = []
  end

  def add_bank(bank_code)
    new_bank = Bank.new(bank_code)
    @banks << new_bank
    new_bank
  end

  def add_account(number, mount)
    bank_code = number.to_s[0..3]
    bank = @banks.find{ |b| b.code == bank_code }

    if bank
      bank.add_account(number, mount)
    else
      new_bank = add_bank(bank_code)
      new_bank.add_account(number, mount)
    end
  end

  def add_transfer(sender_account, amount, receiver_account, success=nil)
    same_bank = sender_account.code_bank == receiver_account.code_bank

    arguments = [sender_account, amount, receiver_account]
    transfer = same_bank ? InterBankTransfer.new(*arguments) : IntraBankTransfer.new(*arguments, success)

    transfer.apply(sender_account, receiver_account)

    write_history(*arguments)
  end

  private

  def write_history(sender_account, amount, receiver_account)
    bank_sender   = @banks.find{ |b| b.code == sender_account.code_bank }
    bank_receiver = @banks.find{ |b| b.code == receiver_account.code_bank }

    [bank_sender, bank_receiver].each do |bank|
      bank.send('add_history', sender_account, amount, receiver_account )
    end

  end
end

