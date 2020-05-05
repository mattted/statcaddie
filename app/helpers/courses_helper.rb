module CoursesHelper
  def mod_perm(user)
    true if current_user.id == user.id
  end
end
