class FoodsController < ApplicationController

rescue_from ActiveRecord::RecordNotFound, with: :food_not_found
rescue_from ActionController::ParameterMissing, with: :parameter_missing
rescue_from ActiveRecord::RecordInvalid, with: :invalid_record

  # GET /foods/:id - An endpoint to fetch a single food from the system given the food ID
  def show
    food = Food.cached_show(params[:id])
    render_json(food)
  end

  # GET /foods - An endpoint to list all the foods available in the system
  def index
    foods = Food.cached_index
    render_json(foods)
  end

  # GET /foods/search - An endpoint to search for foods in the system given a query string
  def search
    params.require([:name, :category])
    result = Food.cached_search(params.permit(:name, :category))
    render_json(result)
  end

  # POST /foods - An endpoint to create a food in the system
  def create
    params.require([:name, :edible_portion, :code, :energy_value, :category_id, :composition])
    if !params[:composition].empty?
      category = FoodCategory.find(params[:category_id])
      food = category.foods.create!(params.permit(:name, :edible_portion, :code, :energy_value))
      params[:composition].each do |c|
        component = Component.find(c[:component_id])
        Composition.create!(quantity: c[:quantity], food: food , component: component)
      end
      head :created
    else
      render_json("A food must have at least one component", :unprocessable_entity)
    end
  end

  # PUT /foods/:id - An endpoint to update a food in the system
  def update
    params.permit(:name, :edible_portion, :code, :energy_value, :category_id, :composition)
    food = Food.find(params[:id])
    food.update(params.permit(:name, :edible_portion, :code, :energy_value))
    if params[:category_id].present?
      category = FoodCategory.find(params[:category_id])
      food.update(food_category: category)
    end
    if params[:composition].present?
        params[:composition].each do |c|
        component = Component.find(c[:component_id])
        Composition.update(quantity: c[:quantity], food: food, component: component)
      end
    end
    head :no_content
  end

  # DELETE /foods/:id - An endpoint to delete a food from the system
  def destroy
    food = Food.find(params[:id])
    food.destroy
    head :no_content
  end

  private

  def render_json(message, status = :ok)
    render json: message, status: status
  end

  def parameter_missing(exception)
    render_json({message:"One or more parameters are missing"}, :unprocessable_entity)
  end

  def food_not_found(exception)
    render_json({message:exception}, :not_found)
  end

  def invalid_record(exception)
    render_json({message:exception}, :unprocessable_entity)
  end

end
