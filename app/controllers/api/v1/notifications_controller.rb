class Api::V1::NotificationsController < ApplicationController
  before_action :authorize_request
  skip_before_action :verify_authenticity_token

  # POST /notifications
  def create
    note = Notification.new(note_params.merge(user_id: @current_user.id))

    if note.save
      render json: note, status: :created
      send_notice(note)
    else
      render json: { errors: note.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /notifications/:id
  def update
    note = Notification.find(params[:id])

    if note.update(note_params)
      render json: note, status: :ok
    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # DELETE /notifications/:id
  def destroy
    note = Notification.find(params[:id])

    if note.destroy
      render json: "Note id:#{params[:id]} destroyed", status: :ok
    else
      render json: { errors: note.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def send_notice(note)
    time = (note.notify_at - Time.now)/1.minute
    SendNoticeJob.set(wait: time.to_i.minutes).perform_later(@current_user, note.title, note.description)
  end

  def note_params
    params.permit(:user_device_id, :title, :description, :notify_at)
  end
end
