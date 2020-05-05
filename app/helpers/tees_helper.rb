module TeesHelper
  def tee_list_group_style(tee)
    case tee.color.downcase
    when "black"
      "list-group-item-action list-group-item-dark"
    when "blue"
      "list-group-item-action list-group-item-primary"
    when "white"
      ""
    when "gold"
      "list-group-item-action list-group-item-warning"
    when "red"
      "list-group-item-action list-group-item-danger"
    end
  end
end
