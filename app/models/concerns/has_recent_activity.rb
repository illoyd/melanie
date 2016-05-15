module HasRecentActivity
  extend ActiveSupport::Concern

  included do

    def recent_activity
      @recent_activity ||= RecentActivity.new(start: self).execute
    end

  end

  class_methods do
  end

end