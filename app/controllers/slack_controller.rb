require 'net/https'
require 'uri'

class SlackController < ApplicationController
  before_filter :require_login

  def show
  end

  def invite
    # this is an undocumented api. we use it to save manual work of inviting/reconciling members. hope it keeps working...
    uri = URI.parse('https://squaremafia.slack.com/api/users.admin.invite')

    request = Net::HTTP::Post.new(uri.path)
    request.set_form_data({'email' => current_user.email, 'token' => Rails.application.secrets[:slack_api_key]})

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER
    response = http.request(request)
    resp = JSON.parse(response.body)

    if response.code == '200' && resp['ok']
      flash[:success] = 'Success! Check your email for an invite!'
    else
      if resp['error'] == 'already_in_team'
        flash[:success] = "You're already a member of the slack team. No invite needed!"
      elsif resp['error'] == 'already_invited'
        flash[:error] = '=You already have an invite. Check your email?'
      else
        Rails.logger.warn "Something went wrong with a slack invite: #{response.code} #{resp.inspect}"
        flash[:error] = 'Something went wrong with your invite. Try again?'
      end
    end
    redirect_to :slack
  end
end