# frozen_string_literal: true

module Inputs
  class Base
    def initialize(path)
      @input = File.read(path)
    end
  end
end
