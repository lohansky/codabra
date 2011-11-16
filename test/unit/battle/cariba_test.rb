require 'test_helper'

class Battle::CaribaTest < ActiveSupport::TestCase
  test "cariba battle" do
    cariba = battles(:cariba)

    cariba.fight
    assert cariba.status == 'fighting'
    cariba.run
    assert cariba.status == 'finished'
    assert cariba.winner == cariba.creator or cariba.winner == cariba.player

  end
end
