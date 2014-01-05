require 'rails_admin/config/actions/merge_tags'
require 'rails_admin/config/actions/merge_items'
require 'rails_admin/config/actions/moderate'
require 'rails_admin/config/actions/import'

  module RailsAdmin
    module Config
      module Actions
        class MergeTags < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
        class MergeItems < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
        class Moderate < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
        class Import < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
        class Export < RailsAdmin::Config::Actions::Base
          RailsAdmin::Config::Actions.register(self)
        end
      end
    end
  end
RailsAdmin.config do |config|
  
  config.actions do
    dashboard
    photopanel
    index
    new 
    show
    edit
    delete
    export do
     visible do
        bindings[:abstract_model].model.to_s == "Item"
      end
    end
    import do
      visible do
        bindings[:abstract_model].model.to_s == "Item"
      end
    end
    show_in_app
    bulk_delete
    merge_tags do
      visible do
        bindings[:abstract_model].model.to_s == "Tag"
      end
    end
    moderate do
      visible do
        bindings[:abstract_model].model.to_s == "Item" || bindings[:abstract_model].model.to_s == "Tag" || bindings[:abstract_model].model.to_s == "Photo"
      end
    end
    merge_items do
      visible do
        bindings[:abstract_model].model.to_s == "Item"
      end
    end
  end
end
