require 'test_helper'

class Api::V1::QuotesControllerTest < ActionDispatch::IntegrationTest

    setup do
        @quote = quotes(:one)
    end

    test "should create quote" do
        assert_difference('Quote.count') do
            post api_v1_quotes_url,
            params: { quote: { name: @quote.name, text: @quote.text, source_title: @quote.source_title, source_author: @quote.source_author, source_publication_year: @quote.source_publication_year } },
            headers: { Authorization: JsonWebToken.encode(user_id: @quote.user_id) },
            as: :json
        end
        assert_response :created
    end

    test "should forbid create quote" do
        assert_no_difference("Quote.count") do
            post api_v1_quotes_url,
            params: { quote: { name: @quote.name, text: @quote.text, source_title: @quote.source_title, source_author: @quote.source_author, source_publication_year: @quote.source_publication_year } },
            as: :json
        end
        assert_response :forbidden
    end

    test "should show quote" do
        get api_v1_quote_url(@quote),
        as: :json
        assert_response :success

        json_response = JSON.parse(self.response.body, symbolize_names: true)
        assert_equal @quote.name, json_response.dig(:data, :attributes, :name)
        assert_equal @quote.user.id.to_s, json_response.dig(:data, :relationships, :user, :data, :id)
        assert_equal @quote.user.email, json_response.dig(:included, 0, :attributes, :email)
    end

    test "should show quotes" do
        get api_v1_quotes_url(),
        as: :json
        assert_response :success
    end

    test "should update quote" do
        patch api_v1_quote_url(@quote),
        params: { quote: { name: @quote.name } },
        headers: { Authorization: JsonWebToken.encode(user_id: @quote.user_id) },
        as: :json
        assert_response :success
    end

    test "should forbid update quote" do
        patch api_v1_quote_url(@quote),
        params: { quote: { name: @quote.name } },
        headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) },
        as: :json
        assert_response :forbidden
    end

    test "should destroy quote" do
        assert_difference("Quote.count", -1) do
            delete api_v1_quote_url(@quote),
            headers: { Authorization: JsonWebToken.encode(user_id: @quote.user_id) },
            as: :json
        end
        assert_response :no_content
    end

    test "should forbid destroy quote" do
        assert_no_difference("Quote.count") do
            delete api_v1_quote_url(@quote),
            headers: { Authorization: JsonWebToken.encode(user_id: users(:two).id) },
            as: :json
        end
        assert_response :forbidden
    end
end
