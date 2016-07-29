module QuestoesHelper


def Qualificado(questao)
	    @ret = ""
	#@qualificacao = QuestaoSubgrupo.joins('inner join temas on questao_subgrupos.tema_id = temas.id where questao_subgrupos.questao_id =?',questao.to_i).select('temas.descricao')
	#qualificado = QuestaoSubgrupo.joins('inner join temas on questao_subgrupos.tema_id = temas.id').where('questao_subgrupos.questao_id=?',questao).select('temas.descricao')
	qualificado = VwLegenda.where('id=?',questao).order('legenda asc')
	qualificado.each do |quali|
		"<font color='#000000'>"+ @ret += quali.legenda+"<br>""</font>"
	end

    return @ret.html_safe
end


def Resposta(questao)
	    @ret = ""
        
       @respostas1 = Resposta.where("pergunta_id = ?",questao)

       @respostas1.each do |resposta|

       @respostacorreta = resposta.correta

       if @respostacorreta == 1
          @respostacorreta = " Correta"
           @corr = "text-success"

        else
         @respostacorreta = " Incorreta"        
          @corr = "text-danger"
          end
#end
	#@qualificacao = QuestaoSubgrupo.joins('inner join temas on questao_subgrupos.tema_id = temas.id where questao_subgrupos.questao_id =?',questao.to_i).select('temas.descricao')
	
	
    
    #resposta = Resposta.where('pergunta_id=?',questao).select('descricao')
    #resposta.each do |resp|

		@ret += "<span class='"+@corr+"'>"+resposta.descricao+"<br>""</span>"
	end

    return @ret.html_safe
end

end
