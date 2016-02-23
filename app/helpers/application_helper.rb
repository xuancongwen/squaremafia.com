module ApplicationHelper
  def bootstrap_class_for(flash_type)
    case flash_type.to_s
      when /success$/
        'alert-success'
      when /error$/
        'alert-danger'
      when /alert$/
        'alert-warning'
      when /notice$/
        'alert-info'
      else
        flash_type
    end
  end

  def flash_messages(opts = {})
    flash.each do |msg_type, message|
      concat(content_tag(:div, message, class: "alert #{bootstrap_class_for(msg_type.to_s)} fade in") do
        concat content_tag(:button, 'x', class: 'close', data: {dismiss: 'alert' })
        concat message
      end)
    end
    nil
  end
end
