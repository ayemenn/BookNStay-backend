module Api::V1
    class VouchersController< ApplicationController
        skip_before_action :verify_authenticity_token, only: [:create]
        def index
            @vouchers = Voucher.all
            render json: @vouchers
        end
        
        def create 
            @voucher=Voucher.new(voucher_params)
            if @voucher.save
                render json: @voucher, status: :created
            else
                render json: {errors: @voucher.errors.full_messages}, status: :unprocessable_entity
                puts params.inspect

            end
        end
        private

        def voucher_params
            params.require(:voucher).permit(:name,:discount_percentage,:min_amount)
        end
    end
end
        