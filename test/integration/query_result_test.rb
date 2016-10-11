require 'test_helper'

class QueryTest < ActionDispatch::IntegrationTest
  test '真实返回结果测试' do
    body = '{"organizationId":"puerhanda","sendTime":"20160924011507",'\
      '"t0RespDesc":"承兑或交易成功","payResult":"00","transType":"B003",'\
      '"sendSeqId":"Q1474650907","t0RespCode":"00","transTime":"20160920",'\
      '"payDesc":"支付成功","orgSendSeqId":"P1000003",'\
      '"respCode":"00","respDesc":"交易成功"}'

  end
end
