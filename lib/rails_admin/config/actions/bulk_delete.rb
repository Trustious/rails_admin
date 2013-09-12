module RailsAdmin
  module Config
    module Actions
      class BulkDelete < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :collection do
          true
        end

        register_instance_option :http_methods do
          [:post, :delete]
        end

        register_instance_option :controller do
          Proc.new do

            if request.post? # BULK DELETE
              @objects = list_entries(false, @model_config, :destroy)
              render @action.template_name
            elsif request.delete? # BULK DESTROY
              @objects = list_entries(false, @model_config, :destroy)
              processed_objects = @abstract_model.destroy(@objects)

              flash[:success] = "#{pluralize(processed_objects.count, "item")} being deleted currently. It may take some time, you will find them gone shortly."

              redirect_to back_or_index
            end
          end
        end

        register_instance_option :authorization_key do
          :destroy
        end

        register_instance_option :bulkable? do
          true
        end
      end
    end
  end
end
