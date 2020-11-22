class Transfer
	attr_reader :sender, :receiver, :amount
	attr_accessor :status
	def initialize(sender, receiver, amount)
	    @sender = sender
	    @receiver = receiver
	    @amount = amount
	    @status = "pending"
	end

	def valid?
	    self.sender.valid? && self.receiver.valid?
	end

	def execute_transaction
	    if !self.sender.valid? || self.amount > self.sender.balance || !self.valid?
		self.status = "rejected"
	    end
	    if self.status == "pending" && self.valid? && self.amount < self.sender.balance
		self.sender.balance -= self.amount
		self.receiver.balance += self.amount
		self.status = "complete"
		return "complete"
	    end
	    "Transaction rejected. Please check your account balance."
	end

	def reverse_transfer
	    if self.status == "complete"
		self.sender.balance += self.amount
		self.receiver.balance -= self.amount
		self.status = "reversed"
	    end
	end	
end
