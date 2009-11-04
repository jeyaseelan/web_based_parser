module AdminHelper
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
      return @p,@postfeed,@postlink,@postdescription,@postdate,@rss_title,@rss_link,@rss_desc
    rescue StandardError => e
      puts e
    end
  end
end
