# require 'swagger_helper'

# RSpec.describe 'api/v1/users', type: :request do

#   path '/api/v1/users' do
#     post('create user') do
#       tags 'Create user'
#       response(200, 'successful') do
#         consumes 'application/json'
#         parameter name: :user, in: :body, schema: {
#           type: :object,
#           properties: {
#             email: { type: :string },
#             password: { type: :string }
#           },
#           required: %w[email password]
#         }
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end
#   end

#   path '/api/v1/users/{id}' do
#     # parameter name: 'id', in: :path, type: :string, description: 'id'
#     # parameter name: :Authorization, in: :header, type: :string

#     patch('update user') do
#       tags 'Update user'
#       consumes 'application/json'
#       security [Bearer: {}]

#       response(200, 'successful') do
#         let(:id) { User.create(email: 'foo@sdf.com', password: '123123').id }
#         let(:access_token) { JSON.parse(response.body)['token'] }
#         # let(:Authorization) { "Bearer #{access_token}" }
#         let(:"Authorization") { "Bearer #{access_token}" }
#         parameter name: :user, in: :body, schema: {
#           type: :object,
#           properties: {
#             name: { type: :string },
#             email: { type: :string }
#           },
#           required: %w[name email]
#         }
#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end

#     delete('delete user') do
#       tags 'Delete user'
#       consumes 'application/json'
#       parameter name: :id, in: :path, type: :string
#       produces 'application/json'
#       response(200, 'successful') do
#         let(:id) { User.create(email: 'foo@sdf.com', password: '123123').id }

#         after do |example|
#           example.metadata[:response][:content] = {
#             'application/json' => {
#               example: JSON.parse(response.body, symbolize_names: true)
#             }
#           }
#         end
#         run_test!
#       end
#     end
#   end
# end
