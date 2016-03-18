require 'net/https'
require 'uri'

class EventsController < ApplicationController
  before_filter :require_login

  def index; end
end
