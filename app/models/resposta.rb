class Resposta < ActiveRecord::Base
 has_many :useres
	  audited

	  conn = ActiveRecord::Base.connection

      result = conn.execute "select res.id, aud.auditable_id, use.email, aud.auditable_type
                              from respostas res, audits aud, useres use
                               where aud.auditable_id = res.id and aud.user_id = use.id and aud.auditable_type ='Resposta' and action = 'update' and res.id = 314"
                               
           result.each do |usuario|
      puts "email: %s" % usuario[1] 
      puts 

      end
	
end
