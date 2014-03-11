module RailsAdmin
  module Config
    module Actions
      class Photopanel < RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)

        register_instance_option :root? do
          true
        end

        register_instance_option :breadcrumb_parent do
          nil
        end

        register_instance_option :controller do
          Proc.new do
            if !params['entry_id'].nil?
              @entry_id = params['entry_id']
              @tag = params['tag']
              if params['reviews'].nil?
                @photos = AdminPhotoPanelManager.get_pending_photos_from_entry(@entry_id)
                @item_name = params['item_name']
              else
                AdminPhotoPanelManager.update_photos_states(@entry_id, params)
                @entries = AdminPhotoPanelManager.get_entries_with_pending_photos params['tag']
                flash[:success] = 'Reviews for the selected images submitted succesfully.'
              end
            elsif !params['tag'].nil?
              @entries = AdminPhotoPanelManager.get_entries_with_pending_photos params['tag']
              @tag = params['tag']
            end
            render "photopanel"
          end
        end

        register_instance_option :route_fragment do
          'photopanel'
        end

        register_instance_option :link_icon do
          'icon-wrench'
        end

        register_instance_option :statistics? do
          true
        end
      end
    end
  end
end
