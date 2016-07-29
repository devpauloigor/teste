class TemasController < ApplicationController
  before_action :set_tema, only: [:show, :edit, :update, :destroy]

  # GET /temas
  # GET /temas.json
  def index


   
   @subgrupo_id = SubGrupo.all
    @subgrupo_id = params[:subgrupo_id]
   # @temas = Tema.where("subgrupo_id = ?",@subgrupo_id)
   @temas = Tema.where("sub_grupo_id= ?", @subgrupo_id)
   

   #@tema = Tema.find(params[:id])
    #@SubGrupo_id= @tema.sub_grupo_id
  
    #@tema.update(tema_params)

  #  @Grupo = SubGrupo.find(params[:id])

   # @SubGrupo_id= @Grupo.grupo_id



  end

  # GET /temas/1
  # GET /temas/1.json
  def show
  end

  # GET /temas/new
  def new
    @tema = Tema.new
    @subgrupo_id = Grupo.all

  end

  # GET /temas/1/edit
  def edit
    @tema = Tema.find(params[:id])
    @SubGrupo_id= @tema.sub_grupo_id

  end

  # POST /temas
  # POST /temas.json
  def create
    @tema = Tema.new(tema_params)

    respond_to do |format|
      if @tema.save
        format.html { redirect_to @tema, notice: 'Tema was successfully created.' }
        format.json { render :show, status: :created, location: @tema }
      else
        format.html { render :new }
        format.json { render json: @tema.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /temas/1
  # PATCH/PUT /temas/1.json
  def update

     @tema = Tema.find(params[:id])
    @SubGrupo_id= @tema.sub_grupo_id
  
    @tema.update(tema_params)

       redirect_to "/temas?subgrupo_id="+@SubGrupo_id.to_s

       
     
  end

  # DELETE /temas/1
  # DELETE /temas/1.json
  def destroy
    @tema.destroy
    respond_to do |format|
      format.html { redirect_to temas_url, notice: 'Tema was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

def cadtemas
  descricao=params[:descricao]
  sub_grupo_id = params[:sub_grupo_id]
  questao_id = params[:questao_id]

  @temas = Tema.new

  @temas.descricao = descricao
  @temas.sub_grupo_id = sub_grupo_id

  @temas.save

   @questao_subgrupo=QuestaoSubgrupo.new


    @questao_subgrupo.questao_id=questao_id
    @questao_subgrupo.tema_id=@temas.id

 
    

    @questao_subgrupo.save
    
    @resptem=QuestaoSubgrupo.joins('inner join temas on temas.id =questao_subgrupos.tema_id').where("questao_id=?", questao_id).select('temas.descricao')
    respond_to do |format|
      format.js

    end

end



def cadtemasnovo
  descricao=params[:descricao]
  sub_grupo_id = params[:sub_grupo_id]
   quali = params[:quali]
 

  @temas = Tema.new

  @temas.descricao = descricao
  @temas.sub_grupo_id = sub_grupo_id

  @temas.save

   
    #--- Setando o tema novo nas questões selecionadas ---

    corte = quali.split("|")

    i = 0
    contador = corte.size
    while i < contador do

    @questao_subgrupo=QuestaoSubgrupo.new
    @questao_subgrupo.questao_id=corte[i]
    @questao_subgrupo.tema_id= @temas.id

    @questao_subgrupo.save
    i+=1

    end
   
    respond_to do |format|
    format.js

    end
    

end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tema
      @tema = Tema.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tema_params
      params.require(:tema).permit(:descricao, :sub_grupo_id)
    end
end
