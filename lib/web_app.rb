require 'sinatra/base'
require 'twilio-ruby'
require 'rabbit_feed'
require_relative 'sample_conference_data'
require_relative '../config/initializers/rabbit_feed'


class WebApp <Sinatra::Base
  set :port, 4000

  get '/' do
    initTwilioClient

    erb :index

  end

  get '/call' do
    puts 'attemting to send call'
    #send call message on rabbit
    RabbitFeed::Producer.publish_event 'browser_call_request', {'worker_id' => SampleConferenceData::WORKER_ID}
  end

  def initTwilioClient
    capability = Twilio::Util::Capability.new(SampleConferenceData::TWILIO_ACCOUNT_SID, SampleConferenceData::TWILIO_AUTH_TOKEN)
    capability.allow_client_incoming(SampleConferenceData::WORKER_ID)
    @capability_token = capability.generate

    @worker_id = SampleConferenceData::WORKER_ID
  end

  run! if app_file == $0
end
