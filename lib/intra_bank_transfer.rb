# intra_bank_transfer.rb
require_relative 'transfer'

class IntraBankTransfer < Transfer

  def initialize(sender_account, amount, receiver_account, success=nil)
    super(sender_account, amount, receiver_account)
    @comission = 5
    @limit = 1000
    @success = success.nil? ? rand < 0.7 : success
  end
end
