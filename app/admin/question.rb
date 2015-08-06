ActiveAdmin.register Question do
  actions :all, except: [:edit]
  permit_params :user_id, :exclusive, :limit, :category_id, options_attributes:[:option]
  index do
    column :id
    column :exclusive
    column :created_at
    column :limit
    column :total_votes
    column :active
    column :category
    actions
  end

  form do |f|
    f.semantic_errors(*f.object.errors.keys)
    f.inputs 'Question Details' do
      f.input :user_id, label: 'User',
                     as: :select, include_blank: 'Select User',
                     collection: User.pluck(:device_token, :id), required: true
      f.input :exclusive, required: true
      f.input :limit, required: true

      f.input :category_id, label: 'Category',
                          as: :select, include_blank: 'Select Category',
                          collection: Category.pluck(:name, :id)

      f.inputs do
        f.has_many :options, heading: 'Options', new_record: true do |a|
          a.input :option
        end
      end

    end
    f.actions
  end

	show do |question|
	  h3 'General Details'
	  attributes_table do
      row :id
      row :user
      row :limit
      row :exclusive
      row :active
      row :category
      row :total_votes
      panel 'Fotos' do
        table_for question.options do
          column :image do |image|
            link_to(image_tag(image.option, width: 100, height: 100), image.option)
          end
          column :votes
        end
      end
    end
  end
end
