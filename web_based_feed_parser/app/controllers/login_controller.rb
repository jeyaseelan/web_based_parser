require 'rubygems'
require 'digest/sha1'
class LoginController < ApplicationController
  
  def index
    render :action=>"authentication"
  end
  
  def authentication  
    begin  
      user = User.new(params[:user])  
      @logged_in_user = user.try_to_login  
      if request.get?
        session[:id] = nil
        session[:name] =  nil
        session[:role] = nil
      else
        user = User.new(params[:user])  
        @logged_in_user = user.try_to_login   
        if @logged_in_user
          session[:id] = @logged_in_user.id
          session[:name] =  @logged_in_user.name
          if @logged_in_user.admin == true
            session[:role] = "Admin" 
            redirect_to :controller=>"admin",:action=>"index"
          else
            session[:role] = "User" 
            redirect_to :controller=>"user",:action=>"index"
          end
        else
          flash[:notice] = "Invalid user" 
        end
      end
    rescue Exception => e
    end 
  end
  
  def logout
    begin  
      reset_session
      flash[:notice] = "Logged out successfully"
      redirect_to :action => "authentication"
    rescue Exception => e
    end 
  end
  
  def new_user
    begin
      if params[:user] and params[:user]!=""
        User.transaction {
          @user=User.new
          params[:user][:name]=params[:user][:name].strip.capitalize
          if @user.update_attributes(params[:user])
            salt=random_number(16)
            encrypt_password=Digest::SHA1.hexdigest("--#{salt}--#{params[:user][:password]}--")
            @user.update_attributes(:salt=>salt,:encrypt_password=>encrypt_password)
            session[:role]="User"
            session[:id]=@user.id
            session[:name]=@user.name
            redirect_to :controller=>"user",:action=>"index"
          else
            flash[:notice]=""
            if @user
              @user.errors.each_full { |message|
                flash[:notice]+=message.to_s+" <br>"
              }
            end
            raise Exception
          end
        }
      end
    rescue Exception => e
    end
  end
  
  
  
end
