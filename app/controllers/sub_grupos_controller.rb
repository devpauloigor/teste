class SubGruposController < ApplicationController
  before_action :set_sub_grupo, only: [:show, :edit, :update, :destroy]
 before_filter :authenticate_user!
  # GET /sub_grupos
  # GET /sub_grupos.json
  def index
    @grupo_id = params[:grupo_id]
   
    @sub_grupos = SubGrupo.where("grupo_id = ?",@grupo_id)
  end

  # GET /sub_grupos/1
  # GET /sub_grupos/1.json
  def show
    @grupos = Grupo.all
     @subid = SubGrupo.find(params[:id])
   
    @grupoid = @subid.grupo_id
  end

  # GET /sub_grupos/new
  def new
    @sub_grupo = SubGrupo.new
    @grupo_id = Grupo.all
      end

  # GET /sub_grupos/1/edit
  def edit
    @subid = SubGrupo.find(params[:id])
   
    @grupoid = @subid.grupo_id

  end

  # POST /sub_grupos
  # POST /sub_grupos.json
  def create

    @sub_grupo = SubGrupo.new(sub_grupo_params)
    @sub_grupo.grupo_id = params[:grupo_id].to_i

    respond_to do |format|
      if @sub_grupo.save
        format.html { redirect_to @sub_grupo, notice: 'Sub grupo was successfully created.' }
        format.json { render :show, status: :created, location: @sub_grupo }
      else
        format.html { render :new }
        format.json { render json: @sub_grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sub_grupos/1
  # PATCH/PUT /sub_grupos/1.json
  def update
     @grupo_id = params[:grupo_id]
   
    @sub_grupos = SubGrupo.where("grupo_id = ?",@grupo_id)
    respond_to do |format|
      if @sub_grupo.update(sub_grupo_params)
        format.html { redirect_to @sub_grupo, notice: 'Sub grupo was successfully updated.' }
        format.json { render :show, status: :ok, location: @sub_grupo }
      else
        format.html { render :edit }
        format.json { render json: @sub_grupo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sub_grupos/1
  # DELETE /sub_grupos/1.json
  def destroy
    
    @sub_grupo.destroy
    redirect_to "/sub_grupos?grupo_id="+@sub_grupo.grupo_id.to_s
  
  end


 def cadsubgrupo
    
    nome=params[:nome]
    grupo_id=params[:grupo_id]
    @sub_grupo=SubGrupo.new


     @sub_grupo.nome = nome
     @sub_grupo.grupo_id = grupo_id
  

     @sub_grupo.save

    @subg=SubGrupo.where("grupo_id=?",grupo_id)
    respond_to do |format|
      format.js

    end

  end



  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sub_grupo
      @sub_grupo = SubGrupo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sub_grupo_params
      params.require(:sub_grupo).permit(:nome, :grupo_id)
    end
end
