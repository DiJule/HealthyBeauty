class AdminController < ApplicationController
  before_action :require_admin

  def dashboard
    @users = User.all
    @products = Product.all
    @orders = Order.all
    @categories = Category.all

    # Analytics: activity logs
    # Activity counts by day (last 14 days)
    from = 13.days.ago.beginning_of_day
    @activity_by_day = ActivityLog.where("created_at >= ?", from)
                                 .group("date(created_at)")
                                 .order("date(created_at)")
                                 .count
    # Fill missing days with 0
    (13.days.ago.to_date..Date.today).each do |date|
      @activity_by_day[date] ||= 0
    end
    
    @activity_by_day = @activity_by_day.sort_by { |date, _| date }.to_h


    # Top paths - provide at least empty data
    @top_paths = ActivityLog.group(:path).order("count(id) DESC").limit(10).count("id")
    @top_paths ||= {}

    # Requests per hour for today (0..23)
    hours = ActivityLog.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now).pluck(:created_at).map { |t| t.in_time_zone.hour }
    hour_counts = hours.tally
    @requests_per_hour = (0..23).map { |h| hour_counts[h] || 0 }
  end
end
