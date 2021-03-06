require 'nokogiri'
class Preview < ActiveRecord::Base
  has_many :comments, foreign_key: "preview_id", class_name: "Comment"


  def self.build_html(html,css_input,js_input)

    merged = Nokogiri::HTML(html);
    head   = merged.at_css "html > head";
    body   = merged.at_css "html > body";


    if not head then;
      head = Nokogiri::XML::Node.new "head", merged;
      merged.at_css("html").prepend_child(head);
    end

    # gsap = Nokogiri::XML::Node.new "script", merged;
    # gsap['src'] = 'http://cdnjs.cloudflare.com/ajax/libs/gsap/1.14.2/TweenMax.min.js';
    # head.add_child(gsap);

    jq  = Nokogiri::XML::Node.new "script", merged;
    jq['src'] = 'http://ajax.aspnetcdn.com/ajax/jQuery/jquery-1.11.2.min.js';
    head.add_child(jq);

    dat = Nokogiri::XML::Node.new "script", merged;
    dat['src'] ="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"
    head.add_child(dat);

    css = Nokogiri::XML::Node.new "style", merged;
    head.add_child(css);
    css.content = css_input;


    js  = Nokogiri::XML::Node.new "script", merged;
    body.add_child(js);
    js.content = js_input;


    return merged.to_html;
  end


end
