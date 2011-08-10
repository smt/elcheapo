class UsersController < AuthorizedController

  def show
    @user = current_user
    @messages = @user.messages
  end

end
