class Api::V1::NotificationsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :authorize_request
  before_action :set_note, except: :create

  # POST /notifications
  def create
    @note = Notification.new(note_params.merge(user_id: @current_user.id))

    if @note.save
      render json: @note, status: :created
      send_notice(@note) if @note.notify_at
    else
      render json: { errors: @note.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /notifications/:id
  def update
    unless @note.update(shared_params)
      render json: { errors: @device.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/:id
  def destroy
    @note.destroy
  end

  private

  def send_notice(note)
    time = (note.notify_at - Time.now)/1.minute
    SendNoticeJob.set(wait: time.to_i.minutes).perform_later(@current_user, note.title, note.description)
  end

  def set_note
    @note = Notification.find(params[:id])

    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'Note not found' }, status: :not_found
  end

  def set_device
    UserDevice.where(device_type: params[:device_type])
  end

  def note_params
    params.permit(:user_device_id, :title, :description, :notify_at)
  end
end
