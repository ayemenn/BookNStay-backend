ActiveAdmin.register User do
  # Permit these parameters for mass assignment
  permit_params :name, :email, :phone_no, :age, :password, :password_confirmation

  form do |f|
   
    f.inputs 'User Details' do
      f.input :name
      f.input :email
      f.input :phone_no
      f.input :age
    end

    f.inputs 'Password' do
      f.input :password
      f.input :password_confirmation
    end

    f.actions
  end
  # Customize the index page
  index do
    selectable_column
    id_column
    column :name
    column :email
    column :phone_no
    column :age
    column :created_at
    actions
  end

  # Customize the show page
  show do
    attributes_table do
      row :name
      row :email
      row :phone_no
      row :age
      row :created_at
      row :updated_at
    end
  end

  # Add filters to the index page
  filter :name
  filter :email
  filter :phone_no
  filter :age
  filter :created_at
end
