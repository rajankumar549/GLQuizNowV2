module ViewHelper
  def render_pill_badges(str = "")
    tagHTML = ""
    str = "" if str.nil?
    case str.downcase
    when "active"
      tagHTML = "<span class=\"badge badge-pill badge-success\">#{str}</span>"
    when "disabled"
      tagHTML = "<span class=\"badge badge-pill badge-danger\">#{str}</span>"
    else
      tagHTML = "<span class=\"badge badge-pill badge-primary\">#{str}</span>"
    end
    tagHTML
  end
end

