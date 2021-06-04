# frozen_string_literal: true

require_relative 'project'

module Credence
  # Behaviors of the currently logged in account
  class Document
    attr_reader :id, :filename, :relative_path, :description, # basic info
                :content,
                :project # full details

    def initialize(info)
      process_attributes(info['attributes'])
      process_included(info['include'])
    end

    private

    def process_attributes(attributes)
      @id             = attributes['id']
      @filename       = attributes['filename']
      @relative_path  = attributes['relative_path']
      @description    = attributes['description']
      @content        = attributes['content']
    end

    def process_included(included)
      @project = Project.new(included['project'])
    end
  end
end
