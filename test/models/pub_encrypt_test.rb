require 'test_helper'

class PubEncryptTest < ActionDispatch::IntegrationTest
  test "mab" do
    js = {a: '123', c: 'abc', b: 999}
    mab = Biz::PubEncrypt.get_mab(js)
    assert_equal '123999abc',  mab
  end
end
