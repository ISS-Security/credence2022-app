# frozen_string_literal: true

require_relative 'project'

module Credence
  # Behaviors of the currently logged in account
  class Projects
    attr_reader :all

    def initialize(projects_list)
      @all = projects_list.map do |proj|
        Project.new(proj)
      end
    end
  end
end
