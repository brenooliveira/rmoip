module Rmoip
  class Recebedor
    include Commons

    private
    def valid_attr
      [ :login_moip, :apelido ]
    end
  end
end