class Payment < ApplicationRecord
  
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

end
