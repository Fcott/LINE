module ApplicationHelper

  def user_picture(user)
    if user.image
      user.image
    else
      'https://ukla.org/images/icons/user-icon.svg'
    end
  end


 def alert_class_for(flash_type)
  {
    :success => 'alert-success',
    :error => 'alert-danger',
    :alert => 'alert-warning',
    :notice => 'alert-info'
  }[flash_type.to_sym] || flash_type.to_s
end

end
