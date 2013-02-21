# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActsAsTaggableOn::TagsHelper

  def tab_link_to(caption, url)
    if url.class == String
      url = Rails.application.routes.recognize_path url
    end

    match = params[:controller] == url[:controller]
    match &&= params[:action] == url[:action] if url[:action]
    klass = match ? 'menu_select' : 'menu_inicial'
    link_to caption, url, {:class => klass}
  end

  def facebook_like_button
     raw %&<script src="http://connect.facebook.net/en_US/all.js#xfbml=1"></script><fb:like-box href="http://www.facebook.com/pages/Agendatech/190166907684709" width="230" show_faces="true" stream="false" header="true"></fb:like-box>&
  end

  def fb_urls_dos_eventos
	 urls = Evento.para_o_ano(Time.now.year).collect{|evento| %Q{"#{evento_full_url(evento)}"} }
	 raw(urls.join(","))
  end
end


