module CoursesHelper

  def mod_perm(user)
    if user_signed_in?
      true if current_user == user
    end
  end

end
