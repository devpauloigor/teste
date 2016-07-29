class Vwquestaoporusuario < ActiveRecord::Base

  def nrespusuario
    "#{nome} - #{count}"
  end


end
