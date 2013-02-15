module ApplicationHelper

  def full_title(page_title)
    base_title = "importr"
    page_title.empty? ? base_title : "#{base_title} | #{page_title}"
  end

  def truncate(string, length)
    if string.length > length
      string[0..length-4] + '...'
    else
      string
    end
  end
end
