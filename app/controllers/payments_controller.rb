class PaymentsController < InheritedResources::Base
  before_filter :authenticate_user!

  def update
    update! do |success, failure|
      success.js do
        @serialized_payments = Payment.where(loan_id: @payment.loan_id).where('payment_index >= ?', @payment.payment_index).map do |payment|
          PaymentSerializer.new(payment, root: false)
        end

        render 'update'
      end
    end
  end

  def form
    @payment = Payment.find(params[:id])
    render partial: "field_form", layout: false
  end
end
