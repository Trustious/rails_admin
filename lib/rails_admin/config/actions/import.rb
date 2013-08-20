require Rails.root.join('lib/importer', 'generic_importer.rb')
require Rails.root.join('lib/exporter', 'exporter.rb')
require Rails.root.join('lib', 'association_manager.rb')


module RailsAdmin
  module Config
    module Actions
      class Import < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do
          Proc.new do
            if request.post? # Uploading File
              csv_file = params[:upload_file][:file]
              category = params[:upload_file][:category]

              if csv_file != nil && category != 'Category'
                importer =   Importer::GenericImporter.new
                importer.upload_spreadsheet category, csv_file
                flash[:success] = "Success ! The file:"+csv_file.original_filename+" containing "+ category.to_s+" was uploaded and is ready for import. You will recieve an email with import results once the file import is processed."
              elsif csv_file == nil 
               flash[:error] = "Opps! You forgot to select the file to be imported !"
             else 
              flash[:error] = "Opps! You forgot to select the item categoryegory for your file: "+csv_file.original_filename+"!"

            end 
          end
        end 
      end


      register_instance_option :bulkable? do
        false
      end

      register_instance_option :link_icon do
        'icon-folder-open'
      end
    end
  end
end
end
