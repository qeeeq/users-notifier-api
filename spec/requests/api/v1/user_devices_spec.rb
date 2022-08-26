require 'swagger_helper'

RSpec.describe 'api/v1/user_devices', type: :request do

  path '/api/v1/user_devices' do
    post('create user_device') do
      tags 'Create device'
      response(200, 'successful') do
        consumes 'application/json'
        security [Bearer: {}]
        parameter name: :user_device, in: :body, schema: {
          type: :object,
          properties: {
            user_id: { type: :integer },
            token: { type: :string },
            device_type: { type: :string }
          },
          required: %w[user_id token device_type]
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

  path '/api/v1/user_devices/{id}' do
    patch('update user_device') do
      tags 'Update device'
      consumes 'application/json'
      parameter name: :id, :in => :path, :type => :string

      response(200, 'successful') do
        security [Bearer: {}]
        parameter name: :user_device, in: :body, schema: {
          type: :object,
          properties: {
            token: { type: :string },
            device_type: { type: :string }
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

    delete('delete user_device') do
      tags 'Delete device'
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
