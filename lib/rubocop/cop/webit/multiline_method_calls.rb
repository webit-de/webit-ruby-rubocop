# frozen_string_literal: true

module RuboCop
  module Cop
    module Webit
      # Checks for the usage of parentheses on multi-line method calls.
      #
      # @example
      #
      #   # bad (multiple lines without parentheses)
      #   puts foo,
      #     bar,
      #     baz
      #
      #   # good (multiple lines with parentheses)
      #   puts(
      #     foo,
      #     bar,
      #     baz
      #   )
      #
      #   # good (one line)
      #   puts foo, bar, baz
      #
      #   # good (assignment is special method call)
      #   obj.attr =
      #     if foo
      #       bar
      #     else
      #       baz
      #     end
      #
      class MultilineMethodCalls < RuboCop::Cop::Base
        extend AutoCorrector

        MSG_PARENTHESES = "Multiline method calls must have parentheses."

        def on_send(node)
          return if node.children.empty? || !multiline_method_call?(node)
          return if node.assignment_method?
          return if node.operator_method?

          unless node.parenthesized_call?
            add_offense(node, message: MSG_PARENTHESES) do |corrector|
              corrector.replace(node, "#{node.source.sub("#{node.method_name} ", "#{node.method_name}(")})")
            end
          end
        end

        alias on_csend on_send

        private

        def multiline_method_call?(node)
          node.type?(:call) && node.arguments.size.positive? && node.location.selector && node.location.selector.line != node.last_argument.loc.line
        end

      end
    end
  end
end
