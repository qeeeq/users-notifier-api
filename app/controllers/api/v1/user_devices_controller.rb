class Api::V1::UserDevicesController < ApplicationController
  before_action :authorize_request
  skip_before_action :verify_authenticity_token

  # POST /user_devices
  def create
    device = UserDevice.new(device_params.merge(user_id: current_user.id))

    if device.save
      render json: device, status: 201
    else
      render json: { errors: device.errors.full_messages }, status: 422
    end
  end

  # PUT /user_devices/:id
  def update
    device = UserDevice.find(params[:id])

    if device.update(device_params)
      render json: device, status: :ok
    else
      render json: { errors: device.errors.full_messages }, status: 422
    end
  end

  # DELETE /user_devices/:id
  def destroy
    device = UserDevice.find(params[:id])

    if device.destroy
      render json: device, status: :ok
    else
      render json: { errors: device.errors.full_messages }, status: 422
    end
  end

  private

  def device_params
    params.permit(:token, :device_type)
  end
end
