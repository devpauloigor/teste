class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

    devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :timeoutable

  self.primary_key = "id"

  belongs_to :questao
	  audited

	belongs_to :resposta
	  audited

    belongs_to :grupo
    audited

     belongs_to :sub_grupo

     belongs_to :questao_subgrupo
    audited







  def timeout_in
    1500.seconds
  end

def login=(login)
    @login = login
  end

  def login
    @login || self.email
     attr_accessible :nome, :login
 end 
  

 # def user_params
  #  params.require(:user).permit(:nome, :email, :Perfil, :password, :password_confirmation)
   
   #end
   


# Virtual attribute for authenticating by either username or email
# This is in addition to a real persisted field like 'username'
attr_accessor :login


# Overwrite Devise’s find_for_database_authentication method
def self.find_for_database_authentication(warden_conditions)
   conditions = warden_conditions.dup
   login = conditions.delete(:login)
   where(conditions).where(["lower(nome) = :value OR lower(email) = :value", { :value =>
     login.strip.downcase }]).first
end

protected

 # Attempt to find a user by it's email. If a record is found, send new
 # password instructions to it. If not user is found, returns a new user
 # with an email not found error.
 def self.send_reset_password_instructions(attributes={})
   recoverable = find_recoverable_or_initialize_with_errors(reset_password_keys, attributes, :not_found)
   recoverable.send_reset_password_instructions if recoverable.persisted?
   recoverable
 end 

 def self.find_recoverable_or_initialize_with_errors(required_attributes, attributes, error=:invalid)
   (case_insensitive_keys || []).each { |k| attributes[k].try(:downcase!) }

   attributes = attributes.slice(*required_attributes)
   attributes.delete_if { |key, value| value.blank? }

   if attributes.size == required_attributes.size
     if attributes.has_key?(:login)
        login = attributes[:login]
        record = find_record(login)
     else
       record = where(attributes).first
     end
   end  

   unless record
     record = new

     required_attributes.each do |key|
       value = attributes[key]
       record.send("#{keyvalue}")
       record.errors.add(key, value.present? ? error : :blank)
     end
   end
   record
 end

 def self.find_record(login)
   where(["nome = :value OR email = :value", { :value => login }]).first
 end




end
