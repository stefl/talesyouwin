class Step
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields
  include Mongoid::Slugify

  field :title, :type => String
  field :where, :type => String
  field :description, :type => String
  field :embed_url
  field :password
  field :ordering, :type => Integer, :default => 0

  belongs_to :tale

  private
    def generate_slug
      slug || (0...12).map{65.+(rand(25)).chr}.join.downcase
    end
end
