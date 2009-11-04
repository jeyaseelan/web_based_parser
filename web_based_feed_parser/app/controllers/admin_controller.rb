require 'rubygems'
require 'open-uri'
require 'rss/0.9'
require 'rss/1.0'
require 'rss/2.0'
require 'rss/parser'
require "rexml/document"
require 'rss/maker'
class AdminController < ApplicationController
  before_filter :authorize_admin
  def index
    @rss_content=RssContent.find(:first,:conditions=>["select_status=true"],:order=>"posted_at")
  end
  
  def manage_rss_type
    begin
      @rss_types=nil
      @rss_types=RssType.find(:all,:conditions=>["id!='-9999'"])
    rescue StandardError => e
      puts e
    end
  end
  
  def new_edit_rss
    begin
      flash[:sucess]='true'
      @rss_type=nil
      if params[:id] and params[:id]!=""
        @rss_type=RssType.find(params[:id])
      end
    rescue Exception => e
      render :action=>"manage_rss_type"
    end
  end
  
  def new_edit_rss_content
    begin
      flash[:sucess]='true'
      @rss_type_content=nil
      if params[:id] and params[:id]!=""
        @rss_content=RssContent.find(params[:id])
      end
      @rss_types=RssType.find(:all,:conditions=>["id!='-9999'"])
      @rss_type=RssType.find(params[:rss_type_id])
    rescue Exception => e
    end
  end
  
  def save_edit_rss
    msg=""
    if params[:id] and params[:id]!=""
      @rss_type=RssType.find(params[:id])
      msg="Successfully Rss Category  Updated"
    else
      @rss_type=RssType.new
      msg="Successfully Rss Category Created"
    end  
    RssType.transaction {
      if @rss_type.update_attributes(params[:rss_type])
        create_rss(params[:rss_type])
        flash[:notice]=msg
        redirect_to :action=>"manage_rss_type" 
      else
        create_rss(params[:rss_type])
        flash[:notice]=""
        flash[:sucess]='false'
        if @rss_type
          @rss_type.errors.each_full { |message|
            flash[:notice]+=message.to_s+" <br>"
          }
        end
        redirect_to :action=>"manage_rss_type"
      end
    }
  end
  
  def save_edit_rss_content
    begin
      msg=""
      params[:rss_content][:rss_type_id]=params[:rss_type][:id]
      if params[:edit]=="true"
        @rss_content=RssContent.find(params[:id])
        msg="Successfully Rss Content  Updated"
      else
        @rss_content=RssContent.new
        msg="Successfully Rss Category Created"
      end  
      RssContent.transaction {
        if @rss_content.update_attributes(params[:rss_content])
          create_rss(params[:rss_content][:rss_type_id])
          flash[:notice]=msg
          flash[:sucess]='true'
          redirect_to :action=>"manage_rss_type_content",:rss_type=>params[:rss_type]
        else
          create_rss(params[:rss_content][:rss_type_id])
          flash[:notice]=""
          flash[:sucess]='false'
          if @rss_type
            @rss_type.errors.each_full { |message|
              flash[:notice]+=message.to_s+" <br>"
            }
          end
          redirect_to :action=>"manage_rss_type_content",:rss_type=>params[:rss_type]
        end
      }
    rescue StandardError => e
      puts e
    end
  end
  
  def delete_rss_type
    begin
      RssType.delete_rss_type(params[:id])
      flash[:notice]="Successfully Rss Category  Deleted"
      redirect_to :action=>"manage_rss_type" 
    rescue StandardError => e
      puts e
    end
  end
  
  def delete_rss_type_content
    begin
      RssContent.delete_rss_content(params[:id])
      create_rss(params[:rss_type_id])
      flash[:notice]="Successfully Rss Content Deleted"
      redirect_to :action=>"manage_rss_type_content",:rss_type=>{:id=>params[:rss_type_id]} 
    rescue StandardError => e
      puts e
    end
  end
  
  def manage_rss_type_content
    begin
      @rss_contents=[]
      @rss_types=RssType.find(:all,:conditions=>["id!='-9999'"])
      if params[:rss_type] and params[:rss_type][:id]!=nil
        @rss_type=RssType.find(params[:rss_type][:id])
        @rss_contents=RssContent.find(:all,:conditions=>["rss_type_id=#{params[:rss_type][:id]}"])
      end
    rescue StandardError => e
      puts e
    end
  end
  
  def generate_rss_feed
    begin
      @rss_contents=[]
      @rss_types=RssType.find(:all)
      if params[:rss_type] and params[:rss_type][:id]!=nil and params[:rss_type][:id]!="-9999"
        @rss_contents=RssContent.find(:all,:conditions=>["rss_type_id=#{params[:rss_type][:id]}"])
        @rss_type=RssType.find(params[:rss_type][:id])
      end
      
      if params[:rss_type] and params[:rss_type][:id]=="-9999"
        @rss_types=RssType.find(:all,:conditions=>["id!='-9999'"])
        @rss_types.each do |rss_type|
          create_rss(rss_type.id)
          @rss_types=RssType.find(:all)
          @rss_type=RssType.find(params[:rss_type][:id])
          flash[:notice]="succssfully Rss Created for all categories"
        end
      end
      
    rescue StandardError => e
    end
  end
  
  def create_rss_feed
    begin
      params[:rss_content].each{|key,value| 
        rss_content= RssContent.find(key)
        rss_content.update_attributes(:select_status => value)
      }
      create_rss(params[:rss_type][:id])
      @rss_type=RssType.find(params[:rss_type][:id]) 
      flash[:notice]="succssfully Rss Created "
      redirect_to :action=>"generate_rss_feed",:rss_type=>{:id=>params[:rss_type][:id]} 
    rescue StandardError => e
    end
  end
  
  def parse_feed
    begin
      @rss_types=RssType.find(:all,:conditions=>["id!='-9999'"])
    rescue StandardError => e
      puts e
    end
  end
  
  def preview_rss
    begin
      @rss_contents=RssContent.find(:all,:conditions=>["select_status=true"])
    rescue StandardError => e
      puts e
    end
  end
  
  def view_article
    begin
      @rss_content=RssContent.find(params[:id])
    rescue StandardError => e
    end
  end
  
  def ajax_empty
  end
  
end
