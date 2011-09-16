class TwilioController < ApplicationController
  def call
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'Welcome to kawlin with us. Please enter your pin number.', :voice => 'woman'
      r.Gather 'numDigits' => 6, :action => twilio_call_with_code_url
    end

    return render :text => response.text
  end


  def call_with_code
    conference_call = ConferenceCall.find_by_code(params['Digits'])
    if conference_call
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Entering conference room.', :voice => 'woman'
        r.Conference conference_call.code
      end
    else
      response = Twilio::TwiML::Response.new do |r|
        r.Say 'Invalid pin. Please try again.', :voice => 'woman'
        r.Redirect twilio_call_url
      end
    end

    return render :text => response.text
  end
end
