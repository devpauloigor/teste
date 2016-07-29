class Vwrespostaporusuario < ActiveRecord::Base

  def nrespusuario
    "#{nome} - #{count}"
  end


end
