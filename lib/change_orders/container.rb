# frozen_string_literal: true

module ChangeOrders
  class Container
    def initialize(first: nil, rest: nil)
      @first = first
      @rest = rest
    end

    def changes
      (Array(@first) + Array(@rest&.changes)).freeze
    end

    def push(node)
      Container::new(first: node, rest: self)
    end

    def inspect
      "#<ChangeOrders::Container @changes=\r\n#{changes.map(&:inspect).join("\r\n")}>"
    end
    alias_method :to_s, :inspect

    def execute_all(visitor)
      changes.each{|change| change.accept(visitor)}
    end
  end
end
