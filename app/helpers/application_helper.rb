# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def facebook_like_iframe width = 540, url = current_url
    '<iframe src="http://www.facebook.com/plugins/like.php?href=' + u(url) + '&amp;layout=button_count&amp;show_faces=false&amp;width=' + width.to_s + '&amp;action=like&amp;font=arial&amp;colorscheme=light" allowtransparency="true" style="margin: 10px 0 0 0; width: ' + width.to_s + 'px; height: 20px;" scrolling="no" frameborder="0"></iframe>'
  end

  def title_image object, style
    @controller.request.protocol + @controller.request.host_with_port + object.url(style, false)
  end

  def set_title_image object, style = :box
    content_for(:title_image){ title_image object, style }
  end

  def current_url
    u(url_for(:only_path => false))
  end

  def alt_for_object t
    return "" if t.nil?
    return "#{h t.selectable_thing}#{" von #{h t.brand} " if t.brand }#{" in #{h t.picture.room}" if t.picture.room } auf TIPISH!" if t.is_a? Thing
    return "Gruppe #{h(t.name)} in Kategorie #{h(t.channel_category.name)} auf TIPISH!" if t.is_a? Channel
    return "#{t.is_thing? && !t.thing.nil? && !t.thing.selectable_thing.to_s.blank? ? h(t.thing.selectable_thing.to_s) : 'Bild'}#{" in #{h(t.room.to_s)}" if t.room} von #{h(t.general_user.display_name)} auf TIPISH!" if t.is_a? Picture
    return "#{h(t.display_name)} auf TIPISH!" if t.is_a? GeneralUser
    (t.respond_to?(:name) ? h(t.name) : (t.respond_to?(:room) ? h("#{t.room}") : ''))
  rescue
    ""
  end

  def dyn_image_tag(object, style, options = {})
    image_size = object.styles[style][:geometry] if object.respond_to?(:styles) rescue nil
    if !image_size.blank? && image_size.last == "#"
      options[:style] ||= ""
      width, height = image_size.split('x').collect(&:to_i)
      options[:style] += [:width, :height].collect {|v| "#{v.to_s}: #{eval(v.to_s)}px;"}.join(" ") if width > 0 && height > 0 # && width < 185 && height < 185
    end
    url_path = object.url(style, false)
    if url_path.starts_with?('/system') && CloudfrontFiles.on_cloudfront(url_path) # && Rails.env == 'production'
      return image_tag(url_path.sub(/^\/system/, CLOUDFRONTDYN_HOST), options)
    else
      return image_tag(url_path, options)
    end
  end

  def set_title cont
    content_for(:title){ cont }
  end

  def on_last_line? arr_size, per_line, i
    return true if per_line == 0
    elements_on_last_line = arr_size % per_line
    elements_on_last_line = per_line if elements_on_last_line == 0
    arr_size - elements_on_last_line <= i
  end

  def image_link_to_rss *url
    generate_rss_link url, :image
  end

  def link_to_rss *url
    generate_rss_link url, :fl
  end

  def generate_rss_link url, style = :image
    with_auto_discovery_link = true
    if url.is_a? Symbol
      url = send("#{url}_path", :format => :rss)
    elsif url.is_a? Array
      if url.size > 1
        str = url.shift
        url << {:format => :rss}
        url = send("#{str}_path", :format => :rss)
      else
        if url.first.is_a? Symbol
          url = send("#{url.first}_path", :format => :rss)
        else
          url = url.first
        end
      end
      #      url << {:format => :rss}
      #url = url_for(url)
    else
      #pass
    end

    ret = []
    if style == :image
      ret << link_to(image_tag('icons/link_icons/feed.png'), url, :title => 'RSS feed anmelden')
    elsif style == :fl
      ret << content_tag(:div, :class => 'fl rss-link'){ link_to('RSS', url, :title => 'RSS feed anmelden') }
    end
    ret << auto_discovery_link_tag(:rss, url) if with_auto_discovery_link
    ret.join
  end

  def link_to_add_yours url, title = 'Upload'
    content_tag(:div, :class => 'fl add-yours-link'){ link_to(title, url, :title => title) }
  end

  def link_to_pink_box name, url, link_options = {}
    content_tag(:div, :class => 'fl pink-link-box', :style => 'margin-right: 1px;') do
      link_to(name, url, {:title => name}.merge(link_options))
    end
  end

  def link_to_more url, name = 'Weitere anzeigen'
    content_tag(:div, :class => 'fr more-link'){ link_to(name, url, :title => name) }
  end

  def render_static_content sc
    sc.content_type == "textile" ? textilize_without_paragraph(sc.content) : sc.content
  end

  def background_for_static_content key
    sc = StaticContent.get(key, "")
    return sc.background.blank? ? '#fff' : sc.background
  end

  def static_content? key
    !StaticContent.get(key, "").content.blank?
  end

  def static_content key, default = "", default_style = "textile"
    static_content_box key, false, default, default_style
  end

  def static_content_box key, draw_box = true, default = "", default_style = "textile"
    sc = StaticContent.get(key, default, default_style)
    #return "" if sc.content.blank?
    admin_link = current_user.admin? ? content_tag(:div, link_to("edit", edit_admin_static_content_path(sc)),
      :style => "font-size: 1.2em; position: absolute; background: #fff; opacity: 0.7; z-index:10;") : ''
    div_for(sc, :class => draw_box ? 'static-content-box' : ''){ "#{admin_link}#{render_static_content(sc)}" }
  end

  def render_fl_objects objects, pic_method = :pic, pic_style = :box
    render :partial => '/shared/render_fl_objects', :locals => {:objects => objects, :pic_method => pic_method, :pic_style => pic_style}
  end

  def prepare_text text
    html_escape(text).gsub(/(\r)?\n/, tag(:br))
  end

  def modifyable? object
    write_access? object
  end

  def colorpicker_include_tag
    content = stylesheet_link_tag("colorPicker", :media => :all) + "\n"
    content += javascript_include_tag("yahoo.color.js") + "\n"
    content += javascript_include_tag("colorPicker") + "\n"
    content
  end

  def colorpicker_input_tag(f, method, reset_to = nil)
    swatch_id = "#{f.object_name.to_s}_#{method}_swatch"
    content_tag(:div, [f.hidden_field(method),
        content_tag(:div, content_tag(:button, nil, :class => "colorbox", :id => swatch_id )),
        (reset_to ? content_tag(:div, link_to("Reset to original color", '#', :onclick => "reset_color('#{"#{f.object_name.to_s}_#{method}"}', '#{reset_to}'); return false;")) : nil)
      ]
    )
  end

  def colorpicker_initialize(fields, options = {})
    fields_js = "[\"" + fields.to_a.join("\",\"") + "\"]"
    content = <<-INITIALIZE_JS
<script type="text/javascript" defer="true">
// <![CDATA[
#{fields_js}.each(function(idx) {
	new Control.ColorPicker(idx, { "swatch" : idx + "_swatch", IMAGE_BASE : "/images/colorpicker/" });
});
// ]]>
</script>
    INITIALIZE_JS
  end

  def labeled_check_box_field f, field, lbl = nil
    lbl ||=  field.to_s.humanize
    content_tag(:div,
      [f.check_box(field), ' ', f.label(field, lbl)],
      :class => 'check-box-div'
    )
  end

  def labeled_text_field f, field, lbl = nil
    lbl ||=  field.to_s.humanize
    #    content_tag(:div,
    #      #[label_tag(f.object_name.to_s + "_#{field}", lbl), tag(:br), f.text_field(field)]
    #      [f.label(field, lbl), tag(:br), f.text_field(field)]
    #    )
    content_tag(:div,
      #[label_tag(f.object_name.to_s + "_#{field}", lbl), tag(:br), f.text_field(field)]
      [content_tag(:div, f.label(field, lbl)), content_tag(:div, f.text_field(field))]
    )
  end

  def button_submit_tag name = 'Speichern', before_submit = '', type = nil, options = {}
    button_title = {:positive => 'tick', :negative => 'cross'}[type] || ''
    button_title += " #{name}"
    options.merge!({:class => "normal-button #{type.to_s}", :onclick => "#{before_submit}$(this).up('form').submit(); return false;"})
    if !options[:confirm].blank?
      options[:onclick] = "if (!#{confirm_javascript_function(options[:confirm])}) return false;" + options[:onclick]
    end
    content_tag(:button,
      button_title, options
    )
  end

  def link_to_submit name
    link_to name, "#", :onclick => "$(this).up('form').submit();", :type => 'submit'
  end

  def button_link_to name, options = {}, html_options = {}
    html_options[:class] = 'button'
    link_to name, options, html_options
  end

  def button_back_tag name = 'Zurück', type = :javascript, html_options = {}
    if type == :javascript
      content_tag(:button,
        "#{name}",
        :class => "normal-button", :onclick => "history.back(); return false;"
      )
    else
      html_options[:class] = 'button'
      link_to name, :back, html_options
    end
  end

  def toggle_edit_form_js highlight_bg = true
    'onmouseover="$(this).addClassName(\'edit-click' + (highlight_bg ? ' hovered' : '') +
      '\');" onmouseout="$(this).removeClassName(\'edit-click' + (highlight_bg ? ' hovered' : '') + '\');"' +
      'onclick="toggle_edit_form(this); return false;"'
  end

  def activerecord_error_list(errors)
    error_list = '<ul class="error_list">'
    error_list << errors.collect do |e, m|
      "<li>#{e.humanize unless e == "base"} #{m}</li>"
    end.to_s << '</ul>'
    error_list
  end

  def clearer
    content_tag(:div, nil, :class => 'clearer')
  end

  def featured_content &block
    cont = content_tag(:div,
      [content_tag(:div, [capture(&block)], :class => 'featured-main'),
        content_tag(:div, link_to('Featured Content - want to feature as well?', services_path), :class => 'featured-footer')],
      :class => 'featured')
    block_called_from_erb?(block) ? concat(cont) : cont
  end

  def float_div options = nil, &block
    cont = content_tag(:div, capture(&block) + clearer, options)
    block_called_from_erb?(block) ? concat(cont) : cont
  end

  def float direction, &block
    cont = content_tag(:div, capture(&block), :class => direction)
    block_called_from_erb?(block) ? concat(cont) : cont
  end

  def fl &block
    float('fl', &block)
  end

  def fr &block
    float('fr', &block)
  end

  def navi_link name, path, other_paths = [], last = nil
    other_paths = [] if other_paths.nil?
    other_paths << {:controller => path, :action => 'show'}
    last_class = ''
    last_class = ' last-child' if last == :last
    last_class = ' second-last-child' if last == :second_last

    cls = (current_page?(path) ? 'hover' : '')
    other_paths.each{|v| cls = 'hover' if current_page?(v)}
    content_tag(:li,
      link_to(name, path),
      :class => cls + last_class
    )
  end

end
