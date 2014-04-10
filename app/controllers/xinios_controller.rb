class XiniosController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_xinio_legality

  def show
    render :text => params[:echostr]
  end

  def create
    if params[:xml][:MsgType] == "text"
      render "echo", :formats => :xml
    end
  end

  private
  def check_xinio_legality
    array = [Rails.configuration.xinio_token, params[:timestamp], params[:nonce]].sort
    render :text => "Forbidden", :status => 403 if params[:signature] != Digest::SHA1.hexdigest(array.join)
  end
end