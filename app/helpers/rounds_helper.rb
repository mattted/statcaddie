module RoundsHelper

  def mod_perm(user)
    if user_signed_in?
      true if current_user == user
    end
  end

  def boolean_circle(bool)
    if bool
      '<p class="text-success">&#9679;</p>'
    else
      '<p class="text-danger">&#9679;</p>'
    end
  end

end
