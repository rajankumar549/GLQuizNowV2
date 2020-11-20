module ApplicationHelper
  def ApplicationHelper.parse_boolean_str (var = "")
    return (var.to_s =~ /^true$/i) == 0
  end

  def ApplicationHelper.status_str(status = false)
    return 'Active' if status

    'Disabled'
  end
end
