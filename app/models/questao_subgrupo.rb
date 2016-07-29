class QuestaoSubgrupo < ActiveRecord::Base
  belongs_to :questao
  belongs_to :sub_grupo

   has_many :useres
   audited
end
