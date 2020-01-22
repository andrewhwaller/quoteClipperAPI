require 'test_helper'

class Api::V1::QuotesControllerTest < ActionDispatch::IntegrationTest

    setup do
        @quote = quotes(:one)
    end

    test "should show quote" do
        get api_v1_quote_url(@quote),
        as: :json
        assert_response :success

        json_response = JSON.parse(self.response.body)
        assert_equal @quote.name, json_response["name"]
    end

    test "should show quotes" do
        get api_v1_quotes_url(),
        as: :json
        assert_response :success
    end


end
