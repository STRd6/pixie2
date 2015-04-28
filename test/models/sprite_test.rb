require 'test_helper'

class SpriteTest < ActiveSupport::TestCase
  setup do
    @sprite = create :sprite
  end

  context "derivation" do
    setup do
      @parent = create :sprite
      @sprite = create :sprite, :parent => @parent
    end

    should "have a parent" do
      # Reload from DB
      @sprite = Sprite.find(@sprite.id)

      assert_equal @parent, @sprite.parent
    end
  end

  context "tagging" do
    setup do
      @test_tag = "test"
      @sprite.update_attribute(:tag_list, @test_tag)
    end

    should "be taggable" do
      assert_difference "@sprite.tags.count", +1 do
        @sprite.add_tag("cool")
      end
    end

    should "be able to remove a tag" do
      assert_difference "@sprite.tags.count", -1 do
        @sprite.remove_tag(@test_tag)
      end
    end
  end

  context "removing duplicate comments" do
    setup do
      @sprite = create :sprite
      @commenter = create :user

      3.times do
        comment = build :comment, :commentable => @sprite, :commenter => @commenter, :body => "test duplicate"
        comment.save(:validate => false)
      end

      @sprite.reload
    end

    should "have duplicate comments removed" do
      assert_difference "@sprite.comments_count", -2 do
        @sprite.remove_duplicate_comments!
        @sprite.reload
      end
    end
  end
end
