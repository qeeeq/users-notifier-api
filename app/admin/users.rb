ActiveAdmin.register User do
  index do
    selectable_column
    column :id
    column :name
    column :email
    column :created_at
    column :updated_at
    actions
  end

  permit_params :name, :email, :password, :password_confirmation

  form do |f|
    f.inputs "User details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
