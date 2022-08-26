require 'swagger_helper'

RSpec.describe 'api/v1/notifications', type: :request do

  path '/api/v1/notifications' do

    post('create notification') do
      tags 'Create notification'
      response(200, 'successful') do
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :notification, in: :body, schema: {
          type: :object,
          properties: {
            user_id: { type: :integer },
            user_device_id: { type: :integer },
            title: { type: :string },
            description: { type: :string },
            notify_at: { type: :string }
          },
          required: %w[user_id user_device_id title description notify_at]
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end

  path '/api/v1/notifications/{id}' do
    patch('update notification') do
      tags 'Update notification'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response(200, 'successful') do
        security [Bearer: {}]
        parameter name: :notification, in: :body, schema: {
          type: :object,
          properties: {
            title: { type: :string },
            description: { type: :string },
            notify_at: { type: :string }
          }
        }
        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end

    delete('delete notification') do
      tags 'Delete notification'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response(200, 'successful') do
        security [Bearer: {}]

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => {
              example: JSON.parse(response.body, symbolize_names: true)
            }
          }
        end
        run_test!
      end
    end
  end
end
