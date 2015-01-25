require 'test_helper'

class TestToriDefine < Test::Unit::TestCase
  setup do
    @orig = Tori.config.filename_callback
    Tori.config.filename_callback = ->(model){
      model
    }
    Tori.config.backend = Tori::Backend::FileSystem.new Pathname("test").join("tmp")
  end

  teardown do
    Tori.config.filename_callback = @orig
    FileUtils.rm_rf("test/tmp")
  end

  class Dammy
    def path
      "path"
    end
  end

  test "#initialize" do
    assert_instance_of Tori::File, Tori::File.new(nil, nil)
  end

  test "#to_s" do
    assert { "test" == Tori::File.new("test", nil).to_s }
  end

  test "#exist?" do
    assert { true == Tori::File.new(__FILE__, nil).exist? }
    assert { false == Tori::File.new("nothing_file", nil).exist? }
  end

  test "#copy?" do
    assert { false == Tori::File.new(__FILE__, nil).copy? }
    assert { true == Tori::File.new(__FILE__, Dammy.new).copy? }
  end
end