class QueryController < ApplicationController
  def qry
    js = Biz::PaymentBiz.parse_data_json(params[:data])
    if js[:resp_code] != '00'
      render json: js
      return
    end

    q = PaymentQuery.new
    Biz::PaymentBiz.update_json(q, js)
    unless q.client = Client.find_by(org_id: js[:org_id])
      render json: {resp_code: '03', resp_desc: '无此商户:' + js[:org_id]}
      return
    end
    uid = "#{js[:org_id]}-#{js[:order_time]}-#{js[:order_id]}"
    unless q.client_payment = ClientPayment.find_by(uni_order_id: uid)
      render json: {resp_code: '12', resp_desc: "无此交易：#{uid}"}
      return
    end
    q.save!
    render json: Biz::PooulApi.query(q)
  end

end
