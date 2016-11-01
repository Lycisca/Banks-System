# inter_bank_transfer.rb
require_relative 'transfer'

class InterBankTransfer < Transfer

  def initialize(sender_account, amount, receiver_account)
    super
    @comission = 0
    @limit = Float::INFINITY
    @success = true
  end
end
