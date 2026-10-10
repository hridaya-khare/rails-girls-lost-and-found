module ItemsHelper
  ITEM_EMOJIS = {
    /bottle|flask|tumbler/ => "💧", /key/ => "🔑", /phone|mobile|iphone/ => "📱",
    /\bid\b|card|pass/ => "🪪", /umbrella/ => "☂️", /earphone|headphone|airpod|earbud/ => "🎧",
    /wallet|purse/ => "👛", /book|notebook|diary/ => "📘", /laptop|macbook/ => "💻",
    /bag|backpack/ => "🎒", /watch/ => "⌚", /glasses|specs|spectacles/ => "👓",
    /charger|cable/ => "🔌", /calculator/ => "🧮", /jacket|hoodie|sweater/ => "🧥",
    /pen\b|pencil/ => "🖊️", /ring|necklace|bracelet|earring/ => "💍", /cap\b|hat/ => "🧢"
  }

  def item_emoji(item)
    ITEM_EMOJIS.find { |pattern, _| item.title.to_s.downcase.match?(pattern) }&.last || "📦"
  end

  def status_badge(item)
    if item.resolved?
      tag.span "✓ Returned", class: "badge badge--returned"
    else
      tag.span item.status.capitalize, class: "badge badge--#{item.status}"
    end
  end

  def item_visual(item, css_class)
    if item.photo.attached? && item.photo.persisted?
      image_tag item.photo, alt: item.title, class: "#{css_class} #{css_class}--photo", loading: "lazy"
    else
      tag.div item_emoji(item), class: "#{css_class} #{css_class}--placeholder #{css_class}--#{item.status}", aria: { hidden: true }
    end
  end

  def filter_link(label, status, count = nil)
    active = params[:status].to_s == status.to_s
    link_to items_path(status: status.presence, q: params[:q].presence), class: [ "chip", ("chip--active" if active) ], aria: { current: (active ? "page" : nil) } do
      safe_join([ label, (tag.span(count, class: "chip__count") if count) ].compact, " ")
    end
  end
end
