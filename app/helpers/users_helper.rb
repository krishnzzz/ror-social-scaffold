module UsersHelper
  def request_sent?
    @user.received_requests.any? { |request| (request.sender_id == current_user[:id]) }
  end
end
