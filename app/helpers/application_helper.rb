module ApplicationHelper
  def avatar(user, size: :md)
    hue = user.id.to_i * 47 % 360
    tag.span user.initials, class: "avatar avatar--#{size}", style: "--avatar-hue: #{hue}", title: user.name, aria: { hidden: true }
  end
end
