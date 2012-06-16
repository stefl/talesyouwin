class Tale
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields
  include Mongoid::Slugify

  field :title, :type => String
  field :where, :type => String
  field :description, :type => String
  field :start_the_game, :type => String
  field :embed_url, :type => String

  has_many :steps
  belongs_to :account

  private
    def generate_slug
      title.parameterize
    end
end
