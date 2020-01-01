require 'minitest/autorun'
require 'minitest/pride'
require './lib/museum'
require 'mocha/minitest'

class MuseumTest <Minitest::Test

  def test_it_exists
    dmns = Museum.new("Denver Museum of Nature and Science")
    assert_instance_of Museum, dmns
  end

  def test_it_has_attributes
    dmns = Museum.new("Denver Museum of Nature and Science")

    assert_equal "Denver Museum of Nature and Science", dmns.name
    assert_equal [], dmns.exhibits
  end

  def test_it_can_add_exhibits
    # gems_and_minerals = Exhibit.new("Gems and Minerals", 0)
    # dead_sea_scrolls = Exhibit.new("Dead Sea Scrolls", 10)
    # imax = Exhibit.new("IMAX", 15)
    imax = mock("IMAX")
    gems_and_minerals = mock("Gems and Minerals")
    dead_sea_scrolls = mock("Dead Sea Scrolls")
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    assert_equal [gems_and_minerals,dead_sea_scrolls,imax], dmns.exhibits
  end


  def test_patrons_starts_empty
    dmns = Museum.new("Denver Museum of Nature and Science")
    assert_equal [], dmns.patrons
  end

  def test_it_can_admit_patrons
    dmns = Museum.new("Denver Museum of Nature and Science")

    bob = mock("Bob")
    sally = mock("Sally")

    dmns.admit(bob)
    dmns.admit(sally)

    assert_equal [bob,sally], dmns.patrons
  end

  def test_it_can_list_admitted_patrons_by_name
    dmns = Museum.new("Denver Museum of Nature and Science")

    bob = mock("Bob")
    sally = mock("Sally")

    dmns.admit(bob)
    dmns.admit(sally)
    bob.stubs(:name).returns("Bob")
    sally.stubs(:name).returns("Sally")
    assert_equal ["Bob","Sally"], dmns.patrons_by_name
  end

  def test_it_can_tell_you_the_average_exhibit_cost
    dmns = Museum.new("Denver Museum of Nature and Science")
    imax = mock("IMAX")
    gems_and_minerals = mock("Gems and Minerals")
    dead_sea_scrolls = mock("Dead Sea Scrolls")
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)
    
    imax.stubs(:cost).returns(15)
    gems_and_minerals.stubs(:cost).returns(5)
    dead_sea_scrolls.stubs(:cost).returns(10)

    assert_equal 10, dmns.average_exhibit_cost
  end

  def test_there_are_recommended_exhibits_for_a_given_patron
    imax = mock("IMAX")
    gems_and_minerals = mock("Gems and Minerals")
    dead_sea_scrolls = mock("Dead Sea Scrolls")
    dmns = Museum.new("Denver Museum of Nature and Science")
    dmns.add_exhibit(gems_and_minerals)
    dmns.add_exhibit(dead_sea_scrolls)
    dmns.add_exhibit(imax)

    imax.stubs(:name).returns("IMAX")
    gems_and_minerals.stubs(:name).returns("Gems and Minerals")
    dead_sea_scrolls.stubs(:name).returns("Dead Sea Scrolls")
    
    bob = mock("Bob")
    sally = mock("Sally")
    # bob.add_interest("Dead Sea Scrolls")
    # bob.add_interest("Gems and Minerals")
    # sally.add_interest("IMAX")
    bob.stubs(:interests).returns(["Dead Sea Scrolls", "Gems and Minerals"])
    sally.stubs(:interests).returns(["IMAX"])
    
    #hint: look at the recommend_exhibits() method and figure out which method you need to be called on which object, and then stub from there.
    assert_equal [gems_and_minerals,dead_sea_scrolls], dmns.recommend_exhibits(bob)
    assert_equal [imax], dmns.recommend_exhibits(sally)
  end

end
