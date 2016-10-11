require 'test_helper'

class QueryTest < ActionDispatch::IntegrationTest
  test "routes" do
    assert_generates "/query", controller: "query", action: "qry"
  end
  test "query test" do
    js = {
      org_id: 'pooul',
      trans_type: 'Q001',
      order_time: Time.now.strftime("%Y%m%d%H%M%S"),
      order_id: 'P0001',
      mac: 'abcd'
    }

    post query_url, params: {data: js.to_json}
    assert_response :success
    r = Biz::PubEncrypt.json_parse(response.body.to_s)
    assert_equal 'A0', r[:resp_code], '应是A0-mac错'

    js[:mac] = Biz::PaymentBiz.get_client_mac(js)
    post query_url, params: {data: js.to_json}
    assert_response :success
    #puts "response.body = " + response.body
    r = Biz::PubEncrypt.json_parse(response.body.to_s)
    assert_equal '12', r[:resp_code], '应是12-无此交易'
=begin
    t.belongs_to :client, index: true
    t.string :org_id
    t.string :query_type
    t.string :order_time
    t.string :order_id
    t.string :pay_result
    t.string :pay_desc
    t.string :resp_code
    t.string :resp_desc
    t.string :mac
=end
  end

  test "直接返回client_payment中status=7的支付结果" do
    js = Biz::PooulApi.query(payment_queries(:qry_7))
    assert_equal '00', js[:resp_code].to_s
    assert_equal '777', js[:pay_code].to_s
    assert_equal '7',  js[:t0_code].to_s
  end
  test "需要调用上游查询" do
    
  end
end
