require 'rubygems'
require 'open-uri'
require 'rss/0.9'
require 'rss/1.0'
require 'rss/2.0'
require 'rss/parser'
require "rexml/document"
require 'rss/maker'
class UserController < ApplicationController
  before_filter :authorize,:except=>[:new_user,:view_article,:index]
  
  def index
    begin
      @user_rss_types=UserRssType.find(:all,:conditions=>["user_id=#{session[:id]}"])
      @rss_type_selected=[]
      @user_rss_types.each do |user_rss_type|
        @rss_type_selected << user_rss_type.rss_type_id
      end
      @rss_type_selected=@rss_type_selected*","
      @rss_types=[]
      @rss_types=RssType.find(:all,:conditions=>["id in (#{@rss_type_selected})"]) if @rss_type_selected.length > 0
    rescue StandardError => e
      puts e
    end
  end
  
  def add_type
    begin
      @user_rss_types=UserRssType.find(:all,:conditions=>["user_id=#{session[:id]}"])
      @rss_type_selected=[]
      @user_rss_types.each do |user_rss_type|
        @rss_type_selected << user_rss_type.rss_type_id.to_s
      end
      @rss_types=RssType.find(:all,:conditions=>["id!='-9999'"])
      render :layout=>false
    rescue StandardError => e
      puts e
    end
  end
  
  def edit_type
    begin
      @user_rss_type=[]
      @user_rss_type=UserRssType.find(:all,:conditions=>["rss_type_id=#{params[:edit_id]} AND user_id=#{session[:id]}"])
      @s=false
      @s=true if @user_rss_type!=nil and @user_rss_type[0].open_type=="new"
      render :layout=>false
    rescue StandardError => e
      puts e
    end
  end
  
  def sub_index
    begin
      @user_rss_types=UserRssType.find(:all,:conditions=>["user_id=#{session[:id]}"])
      if params[:delete_id] and params[:delete_id]!=nil
        UserRssType.delete_all("rss_type_id=#{params[:delete_id]} AND user_id=#{session[:id]}")
        UserRssTypeRssContent.delete_all("rss_type_id=#{params[:delete_id]} AND user_id=#{session[:id]}")
      end
      if params[:edit_id] and params[:edit_id]!=nil
        @user_rss_type= UserRssType.find(params[:edit_id])
        s="new" if params[:rss_type_edit][:id] == "1"
        s="_blank" if params[:rss_type_edit][:id] == "0"
        @user_rss_type.update_attributes(:open_type=>s)
      end
      if  params[:rss_type] and  params[:rss_type]!=""
        params[:rss_type].each{|key,value|
          @user_rss_type=nil
          @user_rss_type=UserRssType.find(:all,:conditions=>["rss_type_id=#{key} and user_id=#{session[:id]}"])
          if @user_rss_type!=nil and @user_rss_type.length > 0
            UserRssType.delete_all("rss_type_id=#{key} AND user_id=#{session[:id]}") if value.to_i == 0
            UserRssTypeRssContent.delete_all("rss_type_id=#{key} AND user_id=#{session[:id]}") if value.to_i == 0
          else
            if value.to_i==1
              @user_rss_type=UserRssType.new
              @user_rss_type.update_attributes(:rss_type_id=>key,:user_id=>session[:id])
            end
          end
        }
      end    
      @user_rss_types=UserRssType.find(:all,:conditions=>["user_id=#{session[:id]}"])
      @rss_type_selected=[]
      @user_rss_types.each do |user_rss_type|
        @rss_type_selected << user_rss_type.rss_type_id
      end
      @rss_type_selected=@rss_type_selected*","
      @rss_types=[]
      @rss_types=RssType.find(:all,:conditions=>["id in (#{@rss_type_selected})"]) if @rss_type_selected.length > 0
    rescue Exception => e
    end
  end
  
  def view_rss
    begin
      @rss_type=RssType.find(params[:rss_id]);
      @user_rss_type=UserRssType.find(:all,:conditions=>["user_id=#{session[:id]} and rss_type_id=#{params[:rss_id]}"])
      render :layout=>false
    rescue StandardError => e
      puts e
    end
  end
  
  def view_article
    begin
      @rss_content=RssContent.find(params[:id])
    rescue StandardError => e
      puts e
    end
    
  end
  
  def set_view_status
    begin
      if params[:rss_content] and params[:rss_content][:"#{params[:rss_content_id]}"]!=""
        @user_rss_content=[]
        @user_rss_content= UserRssTypeRssContent.find(:all,:conditions=>["rss_type_id =#{params[:rss_type_id]} and user_id=#{session[:id]} and rss_content_id=#{params[:rss_content_id]}"])
        if params[:rss_content][:"#{params[:rss_content_id]}"].to_s == "1"
          @user_rss_content[0].update_attributes(:viewed=>false)
        else
          @user_rss_content[0].update_attributes(:viewed=>true)
        end
      end
    rescue StandardError => e
      puts e
    end
  end
  
end
