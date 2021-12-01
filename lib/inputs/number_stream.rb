# frozen_string_literal: true

module Inputs
  class NumberStream < Base
    def call
      @input.split("\n").map(&:to_i)
    end
  end
end
