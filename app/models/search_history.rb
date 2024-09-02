class SearchHistory < ApplicationRecord
  belongs_to :user

  validates :search_query, presence: true
end
