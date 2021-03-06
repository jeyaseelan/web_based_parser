module UserHelper
  def parse_rss(url)
    begin
      rss = RSS::Parser.parse(open(url){|fd|fd.read})
      @rss_title = rss.channel.title
      @rss_link = rss.channel.link
      @rss_desc = rss.channel.description
      item_rss=rss.items.collect{|item|item.title}
      item_link=rss.items.collect{|item|item.link }
      item_description=rss.items.collect{|item|item.description}
      item_date=rss.items.collect{|item|item.date}
      @p=item_rss.length
      @postfeed=item_rss
      @postlink=item_link
      @postdescription=item_description
      @postdate=item_date
      return @p,@postfeed,@postlink,@postdescription,@postdate
    rescue StandardError => e
      puts e
    end
    
  end
  
  
  def check_status(rss_id,content_id)
    begin
      new_creation=false
      read_status=true
      @user_rss_content= UserRssTypeRssContent.find(:all,:conditions=>["rss_type_id =#{rss_id} and user_id=#{session[:id]} and rss_content_id=#{content_id}"])
      if @user_rss_content==nil or @user_rss_content.length==0
        @user_rss_content=UserRssTypeRssContent.new
        @user_rss_content.update_attributes(:rss_type_id=>rss_id,:rss_content_id=>content_id,:user_id=>session[:id],:viewed=>true)
        new_creation=true
      else
        read_status=@user_rss_content[0].viewed
      end
      return new_creation,read_status
    rescue StandardError => e
      puts e
    end
  end
  
end 
      

