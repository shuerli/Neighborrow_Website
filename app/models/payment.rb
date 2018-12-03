class Payment < ApplicationRecord
  
  def paypal_url(return_path)
      values = {
          business: "sixneighborrow-facilitator@gmail.com",
          cmd: "_xclick",
          upload: 1,
          return: "http://localhost",
          invoice: id,
          amount: self.add_credit,
          currency:  "CAD",
          quantity: '1',
          description: "Neighborrow credit top up"
      }
      "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

end
