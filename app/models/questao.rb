class Questao < ActiveRecord::Base
	 self.per_page = 10

     WillPaginate.per_page = 10
	 has_many :useres
	  audited
	has_attached_file :figura, styles: { medium: "300x300>", thumb: "100x100>" }, :default_url =>  ActionController::Base.helpers.asset_path('missing.png')
	validates_attachment_content_type :figura,styles: { medium: "300x300>", thumb: "100x100>" }, :content_type => %w(image/jpeg image/jpg image/png)



end
