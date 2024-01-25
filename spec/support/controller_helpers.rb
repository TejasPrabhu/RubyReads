module ControllerHelpers
    def sign_in(user = double("admin", :username => "admin@ncsu.edu", :password => "123456", :name => "admin", :email => "admin@ncsu.edu", :address => "NC", :credit_card_number => 1234556789012345, :phone_number => "98123456780"))
      if user.nil?
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {scope: :user})
        allow(controller).to receive(:current_user).and_return(nil)
      else
        allow(request.env['warden']).to receive(:authenticate!).and_return(user)
        allow(controller).to receive(:current_user).and_return(user)
      end
    end
  end