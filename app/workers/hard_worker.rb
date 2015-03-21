class HardWorker
  include Sidekiq::Worker

  sidekiq_options retry: false


  ACCOUNT_SID = 'AC6261669e6373135b5291ad505b3cdbef'
  ACCOUNT_TOKEN = ''

    # base URL of this application
  BASE_URL = "http://54.178.233.94/appointmentreminder"

    # Outgoing Caller ID you have previously validated with Twilio
  CALLER_ID = '8618916577867'

  def perform(order_id)

    sleep(15)
    
    order = Order.find(order_id)

    data = {
      :from => CALLER_ID,
      :to => order.phone,
      :url => (BASE_URL + '/order?' + 'order_id=' + order.id.to_s)
    }

    client = Twilio::REST::Client.new(ACCOUNT_SID, ACCOUNT_TOKEN)
    client.account.calls.create(data)


  end
end