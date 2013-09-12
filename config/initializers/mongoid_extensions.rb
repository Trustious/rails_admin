if defined?(::Mongoid::Document)
  require 'rails_admin/adapters/mongoid/extension'
  Mongoid::Document.send(:include, RailsAdmin::Adapters::Mongoid::Extension)
end
I18n.backend = I18n::Backend::SpecBackend.new


module Mongoid
    module Document
        class DelayedDeleteJob < Struct.new(:klass, :id)
            def perform
                old_flag = Delayed::Worker.delay_jobs
                Delayed::Worker.delay_jobs = false
                klass.find(id).destroy
                Delayed::Worker.delay_jobs = old_flag
            end
        end

        def destroy_delayed
            Delayed::Job.enqueue(DelayedDeleteJob.new(self.class, self.id), queue: 'delayed_destroy')
            true
        end
    end
end
