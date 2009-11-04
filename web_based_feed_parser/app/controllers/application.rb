# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'c8912a52cb8b5cbd923a22959f4bce07'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  def authorize
    unless session[:id] and session[:role]=="User"
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login", :action => "authentication")
    end
  end
  
  def authorize_admin
    unless session[:id] and session[:role]=="Admin"
      flash[:notice] = "Please log in"
      redirect_to(:controller => "login", :action => "authentication")
    end
  end
  
  def random_number(char_len)
    salt=""
    chars = ("A".."Z").to_a + ("0".."9").to_a
    1.upto(char_len) { |i| salt << chars[rand(chars.size-1)] }
    return salt
  end
  
  def create_rss(rss_tye_id)
    begin
      @rss_type=RssType.find(rss_tye_id)
      version = "2.0"
      content = RSS::Maker.make(version) do |m|
        m.channel.title = "#{@rss_type.name} News"
        m.channel.link = "preview"
        m.channel.description = "#{@rss_type.desc}"
        @rsscontents=RssContent.find(:all,:conditions=>["rss_type_id=#{rss_tye_id} and select_status='true'"])
        puts Time.now
        @rsscontents.each do |rss_content|
          i = m.items.new_item
          i.title = rss_content.title
          i.link =rss_content.id
          i.description = rss_content.description
          i.date = rss_content.posted_at.strftime("%a, %d %b %Y %H:%M:%S %Z")
        end
      end
      directory = "public/rss"
      @rsstype=RssType.find(rss_tye_id)
      filename=@rsstype.rssfile
      filename=filename.to_s+".xml"
      path = File.join(directory, filename)
      File.open(path, "w+") { |f| f.write("#{content}") }
    rescue StandardError => e
      puts e
    end
    
  end
  
  
  def parse_rss(url)
    begin
      rss = RSS::Parser.parse(open(url){|fd|fd.read})
      item_rss=rss.items.collect{|item|item.title}
      item_link=rss.items.collect{|item|item.link  }
      item_description=rss.items.collect{|item|item.description}
      @p=item_rss.length
      @postfeed=item_rss
      @postlink=item_link
      @postdescription=item_description
    rescue StandardError => e
      puts e
    end
  end
  
end
