# frozen_string_literal: true

class Condition
  include ActiveModel::Model

  attr_accessor :text, :icon, :code
end
