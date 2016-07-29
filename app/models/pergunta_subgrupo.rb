class PerguntaSubgrupo < ActiveRecord::Base
  belongs_to :pergunta
  belongs_to :sub_grupo
end
