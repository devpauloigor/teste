class QuestaoSubgruposController < ApplicationController
  before_action :set_questao_subgrupo, only: [:show, :edit, :update, :destroy]
 before_filter :authenticate_user!
  # GET /questao_subgrupos
  # GET /questao_subgrupos.json
  def index
    @questao_subgrupos = QuestaoSubgrupo.all
     #@SubGrupo_id = params[:SubGrupo_id ]
     tema_id = params[:tema_id]
    @questoes = Questao.all.order("id desc")
    #@SubGrupo = SubGrupo.all
    @pergunta_id = params[:questao_id]
    @tema_id = Tema.all
 
    
  end

  # GET /questao_subgrupos/1
  # GET /questao_subgrupos/1.json
  def show
  end

  # GET /questao_subgrupos/new
  def new
    @questao_subgrupo = QuestaoSubgrupo.new
    @questao_id = params[:questao_id]
    sub_grupo_id= params[:sub_grupo_id]



  end

  # GET /questao_subgrupos/1/edit
  def edit
  end

  # POST /questao_subgrupos
  # POST /questao_subgrupos.json
  def create
    @questao_subgrupo = QuestaoSubgrupo.new(questao_subgrupo_params)

   
   @questao_subgrupo.save
     
  end

  # PATCH/PUT /questao_subgrupos/1
  # PATCH/PUT /questao_subgrupos/1.json
  def update
    respond_to do |format|
      if @questao_subgrupo.update(questao_subgrupo_params)
        format.html { redirect_to @questao_subgrupo, notice: 'Questao subgrupo was successfully updated.' }
        format.json { render :show, status: :ok, location: @questao_subgrupo }
      else
        format.html { render :edit }
        format.json { render json: @questao_subgrupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questao_subgrupos/1
  # DELETE /questao_subgrupos/1.json
  def destroy     


    @questao_subgrupo.destroy  

    redirect_to "/qualificacoes?questao_id="+@questao_subgrupo.questao_id.to_s

  end


  def qualificacoes


    
    @questao = Questao.new
    @subgrupo_id = SubGrupo.all
    @tema_id = Tema.all
    @pergunta_id = params[:questao_id]
    questao_id= params[:questao_id]
    @qualificacoes = Questao.where("pergunta_id = ?",@pergunta_id)
 
    @respostas = Resposta.where("pergunta_id = ?",@pergunta_id)


    questao_id= params[:questao_id]
    tema_id= params[:tema_id]

       #@respsubg=QuestaoSubgrupo.joins('inner join sub_grupos on sub_grupos.id =questao_subgrupos.sub_grupo_id').where("questao_id=?", questao_id).select('sub_grupos.nome, questao_subgrupos.id')

    @resptem=QuestaoSubgrupo.joins('inner join temas on temas.id =questao_subgrupos.tema_id').where("questao_id=?", questao_id).select('temas.descricao, questao_subgrupos.id')

 

  end



  def novoqualificacoes

   
  
  


    @contador = 0 
    
   @questao = Questao.new
     @subgrupo_id = SubGrupo.all
     @tema_id = Tema.all
   @pergunta_id = params[:questao_id]
    questao_id= params[:questao_id]
  @qualificacoes = Questao.where("pergunta_id = ?",@pergunta_id)
      




 questao_id= params[:questao_id]
    tema_id= params[:tema_id]

       #@respsubg=QuestaoSubgrupo.joins('inner join sub_grupos on sub_grupos.id =questao_subgrupos.sub_grupo_id').where("questao_id=?", questao_id).select('sub_grupos.nome, questao_subgrupos.id')

      @resptem=QuestaoSubgrupo.joins('inner join temas on temas.id =questao_subgrupos.tema_id').where("questao_id=?", questao_id).select('temas.descricao, questao_subgrupos.id')

 @respostas = Resposta.where("pergunta_id = 5263")

#-------------------- codigo do consulta ---------------------------


 @nquali = params[:nquali]
  @squali = params[:squali]

  
  @pagen = 1
  if (params.has_key?(:page))
      @pagen = params[:page]
    end

  if(@nquali == 'nao' && params.has_key?(:descricao))
    @descricao = params[:descricao]
    @ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('questoes.id  not in (select questao_id from questao_subgrupos where questao_id = questoes.id) and descricao ilike ?','%'+@descricao+'%').select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
    @descri = @descricao
  elsif(@squali == 'sim' && params.has_key?(:descricao))
    @descricao = params[:descricao]
    @ret  = VwQuali.where('descricao ilike ?','%'+@descricao+'%').paginate(:page => params[:page], :per_page => 30)
    @descri = @descricao
  elsif (@squali == 'sim')
    @ret  = VwQuali.all.paginate(:page => params[:page], :per_page => 30)
    @descri = nil   
  elsif (@nquali == 'nao')
    @ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('questoes.id  not in (select questao_id from questao_subgrupos where questao_id = questoes.id)').select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
    @descri = nil      
  else
    @descricao = params[:descricao]
   # @ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('descricao ilike ?','%'+@descricao+'%').select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
   #@ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('questoes.id = ?',@descricao).select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
   @ret = ActiveRecord::Base.connection.select_all("select * from consulta_questao('#{@descricao}')").to_a.paginate(:page => params[:page], :per_page => 30)
  
  Rails.logger.debug(@ret)
    @descri = @descricao


  end


  @page = @ret


#--------------------Fim do código do consulta --------------------

  end

  def mostraresp
    
    pergunta_id=params[:pergunta_id]

   @resp=Resposta.where("pergunta_id=?",pergunta_id)
    respond_to do |format|
      format.js

    end


 end


 def cadnovotema
 quali = params[:quali]
 tema_id= params[:tema_id]

 corte = quali.split("|")

 i = 0
 contador = corte.size
Rails.logger.debug("Dados #{quali} - #{corte}")


while i < contador do

 @questao_subgrupo=QuestaoSubgrupo.new
 @questao_subgrupo.questao_id=corte[i]
 @questao_subgrupo.tema_id= tema_id

 @questao_subgrupo.save
 i+=1

end
redirect_to :back
  respond_to do |format|
      format.js

    end
      Rails.logger.debug(quali)

 end

def subgrupo
   @grupo = params[:grupo]

  @subgrupo = SubGrupo.where('grupo_id=?',@grupo).select('id,nome')
  
  respond_to do |format|
      format.js

    end
end

def carregasubgrupo
   

  @csubgrupo = SubGrupo.all
  
  respond_to do |format|
      format.js

    end
end

 def cadrespostasubgrupo
    
    questao_id= params[:questao_id]
    tema_id= params[:tema_id]


    
    @questao_subgrupo=QuestaoSubgrupo.new

    @questao_subgrupo.questao_id=questao_id
    @questao_subgrupo.tema_id=tema_id

    @validacao = QuestaoSubgrupo.where('questao_id=? and tema_id=?',questao_id,tema_id).count()
       #select count(*) from questao_subgrupos where questao_id = 22297 and tema_id = 21 
   
    
    if (@validacao == 0)

    @questao_subgrupo.save

     end

    #@respsubg=QuestaoSubgrupo.joins('inner join sub_grupos on sub_grupos.id =questao_subgrupos.sub_grupo_id').where("questao_id=?", questao_id).select('sub_grupos.nome')
    @resptem=QuestaoSubgrupo.joins('inner join temas on temas.id =questao_subgrupos.tema_id').where("questao_id=?", questao_id).select('temas.descricao')
    respond_to do |format|
      format.js

    end
 
 


  end



   def autocomplete
    @temas = VwConsultaTema.where('descricao ilike ?',"%#{params[:term]}%").select('descricao')
    respond_to do |format|
      format.json{
        render json: @temas.map(&:descricao)
      }
    end
  end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questao_subgrupo
      @questao_subgrupo = QuestaoSubgrupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questao_subgrupo_params
      params.require(:questao_subgrupo).permit(:questao_id, :tema_id)
    end
end


