class QuestoesController < ApplicationController
  before_action :set_questao, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!
  
  # GET /questoes
  # GET /questoes.json
  def index
   # @pag = Questao.paginate(:page => params[:page], :per_page => 10)
    @SubGrupo_id = params[:SubGrupo_id ]

    @versao = Versao.select("numero").order('id desc').limit(1)

    
    #@questoes = Questao.all.order("id desc")
    #@questoes = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)

    @questoes = Questao.joins("left outer join audits on audits.auditable_type='Questao' and audits.auditable_id=questoes.id and audits.action='create' left outer join useres on useres.id=audits.user_id").select("questoes.id,questoes.descricao,useres.nome_completo as email").order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)   

    @SubGrupo = SubGrupo.all
    @pergunta_id = params[:questao_id]
    @pagen = 1
    if (params.has_key?(:page))
      @pagen = params[:page]
    end
    #qualificado = QuestaoSubgrupo.where('questao_id=?', @questoes.id).count()


    

  end

  # GET /questoes/1
  # GET /questoes/1.json

  def show
     @questoes = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)


  end

  # GET /questoes/new
  def new
    @SubGrupo_id = SubGrupo.all
    @questao = Questao.new
  end

  # GET /questoes/1/edit
  def edit
      @SubGrupo_id = SubGrupo.all
  end

  # POST /questoes
  # POST /questoes.json
  def create    

  
    @questao = Questao.new(questao_params)

    descricao = @questao.descricao

  
    #@validacao = Questao.where('descricao=?',descricao).count()
   #  @SubGrupo.SubGrupo_id = params [:SubGrupo_id].to_i
  
  #Rails.logger.debug("Retorno do erro: #{@validacao} <-- Validacao")
  #if (@validacao == 0)

    respond_to do |format|
      if @questao.save
        format.html { redirect_to @questao, notice: 'Questao was successfully created.' }
        format.json { render :show, status: :created, location: @questao }
      else
        format.html { render :index }
        format.json { render json: @questao.errors, status: :unprocessable_entity }
      end
    end
  
   #else

    #respond_to do |format|
	#format.html {redirect_to @questao, notice: '/Questao já cadastrada'}
    #end
    #render :js => "Questão já cadastrada!" 
    #redirect_to '/questoes'
   

    #end



  questao_id=params[:questao_id]
  useres_id=params[:useres_id]
 # @audita = Audita.new
 # ultimaquestao = Questao.last
 # usuariologado = User.where('id=?',current_user.id).take.id
 # questao_id = ultimaquestao.id
 # useres_id = usuariologado
 #@audita.questao_id = questao_id
 # @audita.useres_id = useres_id
   
  # @audita.save

 
 #@audita.save



  end

  # PATCH/PUT /questoes/1
  # PATCH/PUT /questoes/1.json
  def update
    respond_to do |format|
      if @questao.update(questao_params)
        format.html { redirect_to @questao, notice: 'Questao was successfully updated.' }
        format.json { render :show, status: :ok, location: @questao }
      else
        format.html { render :edit }
        format.json { render json: @questao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questoes/1
  # DELETE /questoes/1.json
  def destroy
    @questao.destroy
    respond_to do |format|
      format.html { redirect_to questoes_url, notice: 'Questao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


 def qualificacoes
   @questao = Questao.new
     @subgrupo_id = SubGrupo.all
   @pergunta_id = params[:questao_id]
  @qualificacoes = Questao.where("pergunta_id = ?",@pergunta_id)
 
      @respostas = Resposta.where("pergunta_id = ?",@pergunta_id)
   

  end

  def relatorio_qtdquestoes

 @rel = Vwquestaoporusuario.where("1=1")


  end

   def rel_quest_media_hora

   #@rel = VwMediaQuestoesHora.where
  data = params[:date_rel]

 @rel = VwMediaQuestoesHora.where("data = ?", data).select("nome_completo,COUNT(data) as total,calculo_horas(first(hora),last(hora)) as minutos_trabalhados,
   questao_minuto(cast(count(data) as text),calculo_horas(first(hora),last(hora))) as questao_minuto").group("nome_completo").order("questao_minuto desc")


  end

def consulta_questao
  
   @versao = Versao.select("numero").order('id desc').limit(1)
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
    @ret  = VwQuali.where('descricao ilike ?','%'+@descricao+'%').paginate(:page => params[:page], :per_page => 10)
    @descri = @descricao
  elsif (@squali == 'sim')
    @ret  = VwQuali.all.paginate(:page => params[:page], :per_page => 10)
    @descri = nil   
  elsif (@nquali == 'nao')
    @ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('questoes.id  not in (select questao_id from questao_subgrupos where questao_id = questoes.id)').select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
    @descri = nil      
  else
    @descricao = params[:descricao]
   # @ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('descricao ilike ?','%'+@descricao+'%').select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
   #@ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('questoes.id = ?',@descricao).select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
   @ret = ActiveRecord::Base.connection.select_all("select * from consulta_questao('#{@descricao}')").to_a.paginate(:page => params[:page], :per_page => 10)
  
  Rails.logger.debug(@ret)
    @descri = @descricao
  end

 
  @page = @ret

 
    
end

def consulta_questaonquali
    @descricao = params[:consulta][:descricao]
  
  @ret  = Questao.joins("left outer join auditas on auditas.questao_id=questoes.id left outer join useres on useres.id = auditas.useres_id").where('questoes.id  not in (select questao_id from questao_subgrupos where questao_id = questoes.id)').select('questoes.id as id, questoes.descricao as descricao, useres.nome_completo as email').order('questoes.id desc').paginate(:page => params[:page], :per_page => 10)
      
   @page = @ret.paginate(:page => params[:page], :per_page => 10)

    
end

def valida_questao 

    
    @desc = params[:descricao]

    @validacao = Questao.where('descricao=?',@desc).count()
  
  respond_to do |format|
      format.js
    end
    
end




  private
    # Use callbacks to share common setup or constraints between actions.
    def set_questao
      @questao = Questao.find(params[:id])

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def questao_params
      params.require(:questao).permit(:descricao, :figura, :SubGrupo_id)
    
    end

      def auditaquestao_params
         ultimaquestao = Questao.last
      params.require(:audita).permit(ultimaquestao.id, "2")
    
    end



end
