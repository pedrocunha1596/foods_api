class Food < ApplicationRecord
  include Elasticsearch::Model
  include Elasticsearch::Model::Callbacks

  belongs_to :food_category
  has_many :compositions, dependent: :delete_all
  has_many :components, through: :composition

  after_commit :flush_cache

  settings do
    mappings dynamic: false do
      indexes :name, type: :text
      indexes :edible_portion, type: :long
      indexes :code, type: :text
      indexes :energy_value, type: :integer
    end
  end

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :name],
      include: {
        food_category: {
          only: [:id, :name]
        }
      }
    )
  end

  def self.cached_show(id)
    Rails.cache.fetch([name, id]) do
      food = find(id)
      composition = Composition.includes(component: :component_category).where(food: food)
      composition_info = {}
      composition.each do |c|
        component_category = c.component.component_category.name
        if !composition_info.key?(component_category)
          composition_info.store(component_category, [])
        end
        composition_info[component_category].push(component_id: c.component.id, name: c.component.name, quantity: c.quantity)
      end
      complete_info = {
        :id => food.id,
        :name => food.name,
        :edible_portion => food.edible_portion,
        :code => food.code,
        :energy_value => food.energy_value,
        :category_name => {
          :category_id => food.food_category.id,
          :name => food.food_category.name
        },
        :composition => composition_info
      }
    end
  end

  def self.cached_index
    Rails.cache.fetch("foods") do
      all.to_json(:only => [ :id, :name ])
    end
  end


  def self.cached_search(params)
    #Rails.cache.fetch("!/#{params[:name]}/#{params[:category]}") do
      customsearch(params)
    #end
  end

  def self.customsearch(params)
   search_result = __elasticsearch__.search(
   {
     query: {
       bool: {
         must: [
           {
             match: {
               'name': params[:name]
             }
           },
           {
             match: {
               'food_category.id': params[:category]
             }
           }
         ]
       }
     }
   }).results
   filtered_result = []
   search_result.each do |result|
     filtered_result.push({
       :id => result[:_source][:id],
       :name => result[:_source][:name]
       })
   end
   filtered_result
  end

  private

  def flush_cache
    Rails.cache.delete([self.class.name, id])
    Rails.cache.delete("foods")
    #redis_keys = Rails.cache.redis.keys
    #eliminate_keys = []
    #redis_keys.each do |key|
    #  if key.match(/!/)
    #    eliminate_keys.push(key)
    #  end
    #end
    #eliminate_keys.each do |key|
    #  Rails.cache.delete(key)
    #end
  end

end
