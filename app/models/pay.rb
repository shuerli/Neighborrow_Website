class Pay < ApplicationRecord
  
  serialize :notification_params, Hash
  def paypal_url(return_path)
      values = {
          business: "sixneighborrow-facilitator@gmail.com",
          cmd: "_xclick",
          upload: 1,
          return: "http://localhost:3000#{return_path}",
          amount: self.add_credit,
          item_name: "Neighborrow Credit",
      }
      "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end
  
  def payout_url(return_path)
      values = {
          :sender_batch_header => {
              :sender_batch_id => SecureRandom.hex(8),
              :email_subject => 'You have a Payout!',
          },
          :items => [
          {
              :recipient_type => 'EMAIL',
              amount: self.withdraw_credit,
              :receiver => 'shirt-supplier-one@mail.com',
          }
          ]
      }
      "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
