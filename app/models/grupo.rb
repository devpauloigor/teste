class Grupo < ActiveRecord::Base
	has_many :useres
    audited
end
