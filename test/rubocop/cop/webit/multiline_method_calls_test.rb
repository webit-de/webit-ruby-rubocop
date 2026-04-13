# frozen_string_literal: true

require "test_helper"
require "rubocop/cop/webit/multiline_method_calls"

module RuboCop
  module Cop
    module Webit
      class MultilineMethodCallsTest < ::Minitest::Test

        def setup
          @cop = RuboCop::Cop::Webit::MultilineMethodCalls.new
          @commissioner = RuboCop::Cop::Commissioner.new([@cop])
        end

        def test_method_call_without_parentheses
          source = <<~CODE
            puts :bad,
              :worse,
              :worst
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          refute_empty report.offenses
          assert_match("Multiline method calls must have parentheses.", report.offenses.first.message)

          corrected_source = report.offenses.first.corrector.process
          # This is the expected correction in terms of this cop. Other cops
          # ensure the correct linebreak and indentation.
          expected_correction = <<~CODE
            puts(:bad,
              :worse,
              :worst)
          CODE
          assert_equal expected_correction, corrected_source
        end

        def test_good_with_parentheses
          source = <<~CODE
            puts(
              :good,
              :better,
              :best
            )
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          assert_empty report.offenses
        end

        def test_good_with_further_processing
          source = <<~CODE
            Foo.call(
              :good,
              :better,
              :best
            )[:model]
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          assert_empty report.offenses
        end

        def test_good_on_one_line
          source = <<~CODE
            puts :good, :better, :best
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          assert_empty report.offenses
        end

        def test_good_on_assignments
          source = <<~CODE
            foo.bar =
              if condition
                :good
              else
                :better
              end
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          assert_empty report.offenses
        end

        def test_multi_line_receiver
          source = <<~CODE
            foo(
              :arg1
            ).bar baz(:arg2),
              :arg3
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          refute_empty report.offenses
          assert_match("Multiline method calls must have parentheses.", report.offenses.first.message)
        end

        def test_good_with_multi_line_receiver_and_method_chaining_on_single_line
          source = <<~CODE
            foo(
              :arg1
            ).bar baz(:arg2), :arg3
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          assert_empty report.offenses
        end

        def test_good_with_multi_line_receiver_and_method_chaining_on_single_line_with_ugly_break
          # Nobody would write this, but it is valid in terms of this cop.
          source = <<~CODE
            foo(
              :arg1
            ).
              bar baz(:arg2), :arg3
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          assert_empty report.offenses
        end

        def test_multi_line_method_call_with_safe_navigation
          source = <<~CODE
            foo&.bar :arg1,
              :arg2
          CODE

          report = @commissioner.investigate(@cop.parse(source))
          refute_empty report.offenses
          assert_match("Multiline method calls must have parentheses.", report.offenses.first.message)
        end

      end
    end
  end
end
