module RailsAdmin
  module Config
    module Actions
      class Export < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:get, :post]
        end

        register_instance_option :controller do

          Proc.new do

             if request.post?
                @ids = list_entries(false, @model_config, :export).entries.map(& :_id)
                Exporter::Exporter.new.export_query_items @ids, current_person
                flash[:success] = "#{@ids.count} items will be exported, you will recieve an email with export results shortly."
                redirect_to back_or_index
             else
               render @action.template_name
           end
          end
        end

        register_instance_option :bulkable? do
          true
        end

        register_instance_option :link_icon do
          'icon-share'
        end
      end
    end
  end
end
