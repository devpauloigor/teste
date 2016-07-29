class RespostasController < ApplicationController
    before_filter :authenticate_user!
  before_action :set_resposta, only: [:show, :edit, :update, :destroy]

  
  # GET /respostas
  # GET /respostas.json
  def index
   
    @pergunta_id = params[:questao_id]
    @respostas = Resposta.where("pergunta_id = ?",@pergunta_id)


    #@respostasU= Resposta.joins("left outer join audits on audits.auditable_id = respostas.id left outer join useres on audits.user_id = useres.id"  ).where('audits.auditable_type =? and audits.action = ? and respostas.pergunta_id =?',"Resposta", "create",@pergunta_id).select ('audits.auditable_id,audits.user_id, respostas.*, useres.id as user , useres.email')
   @respostasU= Resposta.joins("inner join audits on audits.auditable_id = respostas.id inner join useres on useres.id = audits.user_id").where("audits.auditable_id = respostas.id and audits.user_id = useres.id and audits.auditable_type =? and audits.action = ? and respostas.id = ?","Resposta","update",1).select("respostas.id, useres.email, audits.auditable_type")

  end

  # GET /respostas/1
  # GET /respostas/1.json
  def show


   @pagen = 1
    


  @pergunta_id = params[:questao_id]
  # @respostasU= Resposta.joins("left outer join audits on audits.auditable_id = respostas.id left outer join useres on audits.user_id = useres.id"  ).where('audits.auditable_type =? and audits.action = ? and respostas.pergunta_id =?',"Resposta", "create",@pergunta_id).select ('audits.auditable_id,audits.user_id, respostas.*, useres.id as user , useres.email')
     @respostas = Resposta.where("pergunta_id = ?",@pergunta_id)
 @respostasU= Resposta.joins("inner join audits on audits.auditable_id = respostas.id inner join useres on useres.id = audits.user_id").where("audits.auditable_id = respostas.id and audits.user_id = useres.id and audits.auditable_type =? and audits.action = ? and respostas.id = ?","Resposta","update",314).select("respostas.id, useres.email, audits.auditable_type")
  end

  # GET /respostas/new
  def new
    @resposta = Resposta.new
    @resposta1 = Resposta.new
    @questao_id = params[:questao_id]
    @C = 0
    @C1 = 0
  end

  # GET /respostas/1/edit
  def edit

    @pagen = 1



  @pergunta_id = params[:questao_id]
  # @respostasU= Resposta.joins("left outer join audits on audits.auditable_id = respostas.id left outer join useres on audits.user_id = useres.id"  ).where('audits.auditable_type =? and audits.action = ? and respostas.pergunta_id =?',"Resposta", "create",@pergunta_id).select ('audits.auditable_id,audits.user_id, respostas.*, useres.id as user , useres.email')
     @respostas = Resposta.where("pergunta_id = ?",@pergunta_id)
 @respostasU= Resposta.joins("inner join audits on audits.auditable_id = respostas.id inner join useres on useres.id = audits.user_id").where("audits.auditable_id = respostas.id and audits.user_id = useres.id and audits.auditable_type =? and audits.action = ? and respostas.id = ?","Resposta","update",314).select("respostas.id, useres.email, audits.auditable_type")


    @resp = Resposta.find(params[:id])
    @questao_id = @resp.pergunta_id
    @C = @resp.correta

  end

  # POST /respostas
  # POST /respostas.json
  def create


    @resposta = Resposta.new(resposta_params,resposta_params1)
    
    #@resposta.correta = params[:correta]
    @resposta.save
   
   
  end

  # PATCH/PUT /respostas/1
  # PATCH/PUT /respostas/1.json
  def update
   
     @resposta.update(resposta_params)
    redirect_to "/respostas?questao_id="+@resposta.pergunta_id.to_s

  end

  # DELETE /respostas/1
  # DELETE /respostas/1.json
  def destroy
    @resposta.destroy
    @pagen = 1
       #redirect_to "/respostas?questao_id="+@resposta.pergunta_id.to_s

       redirect_to "/respostas?questao_id="+@resposta.pergunta_id.to_s+"&&pagina=questoes&&page="+@pagen.to_s
    
  end

  def cadresposta
    @C = 0
    @C1 = 0
    descricao=params[:descricao]
    correta=params[:correta]
    pergunta_id=params[:pergunta_id]
    @resposta=Resposta.new

    @resposta.descricao=descricao
    @resposta.correta = correta
    @resposta.pergunta_id=pergunta_id

    @resposta.save

    @resp=Resposta.where("pergunta_id=?",pergunta_id)
    respond_to do |format|
      format.js

    end

  end

  def relatorio_qtdrespostas

 @rel = Vwrespostaporusuario.where("1=1")


  end





  private
    # Use callbacks to share common setup or constraints between actions.
    def set_resposta
      @resposta = Resposta.find(params[:id])

     
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def resposta_params
      params.require(:resposta).permit(:descricao, :correta, :pergunta_id)
    
    end

   
   
end
