module ApplicationHelper

  def rewrite(text)
    $rewriter.rewrite(text)
  end

  def timeago(time, options = {})
    options[:class] ||= "timeago"
    content_tag(:time, time.to_s, options.merge(datetime: time.getutc.iso8601)) if time
  end

end
