# rubocop:disable Metrics/LineLength
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

  def friendship_message
    message = ''
    if @user.id != current_user[:id]
      if request_sent? && request_received?
        message << '<div>Your Friend.</div>'
        message << "<%= link_to 'Remove as friend', :controller => 'friendships', :action => 'destroy_both', :sender => current_user, :receiver => @user, :redirect_user => @user %>"
      elsif request_sent?
        message << "<%= link_to 'Cancel friend request', :controller => 'friendships', :action => 'destroy', :sender => current_user, :receiver => @user, :redirect_user => @user %>"
      elsif request_received?
        message << '<div>You have been requested as friend.</div>'
        message << "<%= link_to 'Accept request', :controller => 'friendships', :action => 'create', :sender => current_user, :receiver => @user %><br />"
        message << "<%= link_to 'Decline request', :controller => 'friendships', :action => 'destroy', :sender => @user, :receiver => current_user, :redirect_user => @user %>"
      else
        message << "<%= link_to 'Add as friend', :controller => 'friendships', :action => 'create', :sender => current_user, :receiver => @user %>"
      end
    end
    render inline: message
  end
end
# rubocop:enable Metrics/LineLength
