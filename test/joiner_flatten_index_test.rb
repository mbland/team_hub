# team_hub - Components for creating a team Hub using Jekyll
#
# Written in 2015 by Mike Bland (michael.bland@gsa.gov)
# on behalf of the 18F team, part of the US General Services Administration:
# https://18f.gsa.gov/
#
# To the extent possible under law, the author(s) have dedicated all copyright
# and related and neighboring rights to this software to the public domain
# worldwide. This software is distributed without any warranty.
#
# You should have received a copy of the CC0 Public Domain Dedication along
# with this software. If not, see
# <https://creativecommons.org/publicdomain/zero/1.0/>.
#
# @author Mike Bland (michael.bland@gsa.gov)

require_relative "test_helper"
require_relative "../lib/team_hub/joiner"

require "minitest/autorun"

module TeamHub
  class FlattenIndexTest < ::Minitest::Test
    def test_empty_index
      assert_empty Joiner.flatten_index({})
    end

    def test_index
      orig = {
        'mbland' => {'name' => 'mbland'},
        'afeld' => {'name' => 'afeld'},
        'mhz' => {'name' => 'mhz'},
      }
      assert_equal(
        [{'name' => 'mbland'}, {'name' => 'afeld'}, {'name' => 'mhz' }],
        Joiner.flatten_index(orig))
    end

    def test_index_with_private_values
      orig = {
        'mbland' => {'name' => 'mbland'},
        'afeld' => {'name' => 'afeld'},
        'mhz' => {'name' => 'mhz'},
        'private' => {
          'gboone' => {'name' => 'gboone'},
          'ekamlley' => {'name' => 'ekamlley'},
        },
      }
      assert_equal(
        [{'name' => 'mbland'}, {'name' => 'afeld'}, {'name' => 'mhz' },
         {'private' => [{'name' => 'gboone'}, {'name' => 'ekamlley'}]}],
        Joiner.flatten_index(orig))
    end
  end
end
