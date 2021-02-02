module UsersHelper
  def request_sent?
    @user.received_requests.any? { |request| (request.sender_id == current_user[:id]) }
  end

  def request_received?
    @user.sent_requests.any? { |request| (request.receiver_id == current_user[:id]) }
  end

  def no_request?(user)
    @user = user
    !request_sent? && !request_received? && user != current_user
  end
end
