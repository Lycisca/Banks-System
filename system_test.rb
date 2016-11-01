require "minitest/autorun"
require_relative 'system'

describe System do
  before do
    @system = System.new()

    accounts = [
      { number: '11112222331234567890', amount: 30000 },  # Bank1 => Jim
      { number: '11112222330123456789', amount: 1000 },   # Bank1
      { number: '22222222331234567890', amount: 0 },      # Bank2 => Emma
      { number: '22222222330123456789', amount: 1000 }    # Bank2
    ]
    accounts.each do |account|
      @system.add_account(account[:number], account[:amount])
    end
  end

  describe "check new system has two banks" do
    it "should return two banks" do
      @system.banks.size.must_equal 2
    end
  end

  describe "check each bank has two accounts" do
    before do
      @banks = @system.banks
    end

    it "should return two accounts per bank" do
      @banks.each do |bank|
        bank.accounts.size.must_equal 2
      end
    end
  end

  describe "check inter-bank transfer with enougth money" do
    before do
      @sender_account   = @system.banks[0].accounts.first # amount: 30000
      @receiver_account = @system.banks[0].accounts.last # amount: 1000
      @transfer_amount  = 20000
    end

    it "should return sender_account with 10000 and receiver_account with 21000" do
      @system.make_transfer(@sender_account, @transfer_amount, @receiver_account)
      @sender_account.amount.must_equal 10000
      @receiver_account.amount.must_equal 21000
    end
  end

  describe "check inter-bank transfer without enougth money" do
    before do
      @sender_account   = @system.banks[0].accounts.first # amount: 30000
      @receiver_account = @system.banks[0].accounts.last # amount: 1000
      @transfer_amount  = 40000
    end

    it "should return error" do
      err = proc { @system.make_transfer(@sender_account, @transfer_amount, @receiver_account) }.must_raise RuntimeError
      err.message.must_match "You don´t have enought money"
    end
  end

  describe "check intra-bank transfer with enougth money" do
    before do
      @sender_account   = @system.banks[0].accounts.first # amount: 30000
      @receiver_account = @system.banks[1].accounts.first # amount: 0
      @transfer_amount  = 995
    end

    it "should return sender_account without amount (comission + transfer_amount) and receiver_account with 1995" do
      @system.make_transfer(@sender_account, @transfer_amount, @receiver_account, true)
      @sender_account.amount.must_equal 29000
      @receiver_account.amount.must_equal 995
      # puts @system.banks.map(&:transfers).inspect
    end
  end

  describe "check intra-bank transfer more than limit" do
    before do
      @sender_account   = @system.banks[0].accounts.first # amount: 30000
      @receiver_account = @system.banks[1].accounts.first # amount: 0
      @transfer_amount  = 2000
    end

    it "should return error" do
      err = proc { @system.make_transfer(@sender_account, @transfer_amount, @receiver_account, true) }.must_raise RuntimeError
      err.message.must_match "You cannot transfer more than 1000 euros"
    end
  end

  describe "check intra-bank transfer with not success" do
    before do
      @sender_account   = @system.banks[0].accounts.first # amount: 30000
      @receiver_account = @system.banks[1].accounts.first # amount: 0
      @transfer_amount  = 1
    end

    it "should return error" do
      err = proc { @system.make_transfer(@sender_account, @transfer_amount, @receiver_account, false) }.must_raise RuntimeError
      err.message.must_match "Transfer failures"
    end
  end
end
