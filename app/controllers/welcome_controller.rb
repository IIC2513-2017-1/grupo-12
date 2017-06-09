class WelcomeController < ApplicationController
  def index
    @projects = Project.all
    maximof = 0
    maximos = 0
    @projects.each do |project|
      numf = project.savers.count
      nums = project.donations.pluck(:user_id).uniq.count
      if maximof < numf
        maximof = numf
        @pmax = project
      end
      if maximos < nums
        maximos = nums
        @smax = project
      end
    end

  end
end
