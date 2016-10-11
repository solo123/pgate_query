require 'test_helper'

class KaifuQueryTest < ActionDispatch::IntegrationTest
  test "create kaifu_query no" do
    pq = payment_queries(:qry_1_no)
    kq = Biz::KaifuApi.create_kaifu_query(pq)

    assert_nil kq, 'kaifu_query not created!'
  end
  test "create kaifu_query" do
    AppConfig.set('kaifu.user.d0.org_id', 'pooul')
    AppConfig.set('kaifu.user.d0.tmk', '1234567890abcdef')

    pq = payment_queries(:qry_1)
    
    kq = Biz::KaifuApi.create_kaifu_query(pq)

    assert kq, 'kaifu_query not created!'
  end
end
