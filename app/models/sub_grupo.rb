class SubGrupo < ActiveRecord::Base

	belongs_to :grupo
has_many :useres
	  audited

end
