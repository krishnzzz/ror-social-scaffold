module UsersHelper
  def request_sent?
    @user.received_requests.each do |request|
      if request.sender_id == current_user[:id]
        @sent_request = request
        return true
      end
    end
    false
  end

  def request_received?
    @user.sent_requests.each do |request|
      if request.receiver_id == current_user[:id]
        @received_request = request
        return true
      end
    end
    false
  end

  def no_request?(user)
    @user = user
    !request_sent? && !request_received? && user != current_user
  end
end
