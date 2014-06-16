class Order < ActiveRecord::Base
	belongs_to :user

	def purchase
		response = EXPRESS_GATEWAY.purchase(self.order_total.delete(',').to_i*100, {
		    :ip => ip_address,
		    :token => express_token,
		    :payer_id => payer_id
  		})
		response.success?
	end

	def express_token=(token)
	  write_attribute(:express_token, token)
	  if new_record? && !token.blank?
	    details = EXPRESS_GATEWAY.details_for(token)
	    self.payer_id = details.payer_id
	    self.first_name = details.params["first_name"]
	    self.last_name = details.params["last_name"]
	    self.payer = details.params["payer"]
	    self.name = details.params["name"]
	    self.street1 = details.params["street1"]
	    self.street2 = details.params["street2"]
	    self.city_name = details.params["city_name"]
	    self.state_or_province = details.params["state_or_province"]
	    self.country = details.params["country"]
	    self.country_name = details.params["country_name"]
	    self.postal_code = details.params["postal_code"]
	    self.order_total = details.params["order_total"]
	    self.order_total_currency_id = details.params["order_total_currency_id"]
	  end
	end
end