# @start snippet
require "twilio-ruby"

class AppointmentreminderController < ApplicationController

  skip_before_action :verify_authenticity_token

  # your Twilio authentication credentials
  ACCOUNT_SID = 'AC6261669e6373135b5291ad505b3cdbef'
  ACCOUNT_TOKEN = ''

  # base URL of this application
  BASE_URL = "http://54.178.233.94/appointmentreminder"

  # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '8618916577867'


  # client = Twilio::REST::Client.new('AC6261669e6373135b5291ad505b3cdbef', '8ff22adbce29626a452763349a46e503')
  # client.account.calls.create({ from: "8618916577867", to: "+8613564634333", url: "http://54.178.233.94/appointmentreminder/reminder"})

  def index
  end

  # Use the Twilio REST API to initiate an outgoing call
  def makecall
    # parameters sent to Twilio REST API

    order = Order.new(params[:order].to_unsafe_h)

    order.save


    data = {
      :from => CALLER_ID,
      :to => order.hotel.phone,
      :url => BASE_URL + '/reminder',
    }

    begin
      client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
      call = client.account.calls.create(data)
      order.sid = call.sid
    rescue StandardError => bang
      redirect_to :action => 'error', 'msg' => "Error #{bang}"
      return
    end

    redirect_to :action => "index", 'msg' => "Calling #{order.hotel.phone}..."
  end
  # @end snippet

  # @start snippet
  # TwiML response that reads the reminder to the caller and presents a
  # short menu: 1. repeat the msg, 2. directions, 3. goodbye
  def reminder
    @post_to = BASE_URL + '/directions'
    render :action => "reminder.xml.builder", :layout => false 
  end
  # @end snippet

  # @start snippet
  # TwiML response that inspects the caller's menu choice:
  # - says good bye and hangs up if the caller pressed 3
  # - repeats the menu if caller pressed any other digit besides 2 or 3
  # - says the directions if they pressed 2 and redirect back to menu
  def directions
    if params['Digits'] == '3'
      order = Order.find(sid: params[:CallSid]) || Order.last
      order.update_status(status: false)
      HardWorker.perform_async(order.id)

      redirect_to :action => 'goodbye'
      return
    end

    if params['Digits'] == '2'
      order = Order.find(sid: params[:CallSid]) || Order.last
      order.update_status(status: true)
      HardWorker.perform_async(order.id)

      redirect_to :action => 'ok'
      return
    end


    if !params['Digits'] or params['Digits'] != '2'
      redirect_to :action => 'reminder'
      return
    end


    render :action => "directions.xml.builder", :layout => false 
  end
  # @end snippet

  # TwiML response saying with the goodbye message. Twilio will detect no
  # further commands after the Say and hangup
  def goodbye
    render :action => "goodbye.xml.builder", :layout => false 
  end

  def ok
    render :action => "ok.xml.builder", :layout => false 
  end  

  def order
    order = Order.find(params[:order_id])
    @message = order.status? ? "Hello this is a call from C trip. Your booking is confirmed. We look forward to your visit." : "Hello this is a call from C trip. I'm very sorry sir, our rooms are fully booked. You can find another hotel on www dot C trip
    dot com. Thank you."
    render :action => "order.xml.builder", :layout => false 
  end  

  def list
    @orders = Order.order(id: :desc)
  end
end
