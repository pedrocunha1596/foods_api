require 'rails_helper'

RSpec.describe "Foods", type: :request do

  #initialize test data
  before {
    #Food category example
    @sugars = FoodCategory.create(name: "Sugar and Sugar products", description: "Sugar and Sugar products")
    #Component category example
    @macro = ComponentCategory.create(name: "Macroconstituintes", description: "Macrocomponents")
    #Food examples
    @yellow_sugar = Food.create(name: "Yellow sugar", edible_portion: 100, code: "IS502", energy_value: 300, food_category: @sugars)
    @white_sugar = Food.create(name: "White sugar", edible_portion: 100, code: "IS503", energy_value: 400, food_category: @sugars)
    #Component example
    @carbohydrate = Component.create(name: "Carbohydrate", component_category: @macro)

    #Composition example
    Composition.create(quantity: 97.5, food: @yellow_sugar , component: @carbohydrate)
    Composition.create(quantity: 2, food: @white_sugar , component: @carbohydrate)
  }

 #request spec to fetch endpoint
 describe 'GET /foods/:id#show' do
   context 'when the specific food exists' do
     before {
       get "/foods/#{@yellow_sugar.id}"
     }

     it 'returns the right info' do
       expect(json['id']).to eq(@yellow_sugar.id)
     end

     it 'returns success code 200' do
       expect(response).to have_http_status(200)
     end
   end

   context 'no such food in the system' do
     before {
       get "/foods/-1"
     }

     it 'returns error message' do
       expect(json['message']).to eq("Couldn't find Food with 'id'=-1")
     end

     it 'returns error code 404' do
       expect(response).to have_http_status(404)
     end
   end
 end

 describe 'GET /foods#index' do
   before {
     get "/foods"
   }

   it 'always returns success code 200' do
     expect(response).to have_http_status(200)
   end

   it 'returns all foods in the system' do
     expect(json.size).to eq(2)
   end
 end

 describe 'Get /foods/search#search' do
   context 'request valid' do
     before {
       get "/foods/search?name='amarelo'&category=1"
     }

     it 'returns success code 200' do
       expect(response).to have_http_status(200)
     end
   end

   context 'request is invalid' do
     before {
       get "/foods/search?name=amarelo"
     }

     it 'returns error code 422' do
       expect(response).to have_http_status(422)
     end

     it 'returns error message' do
       expect(json["message"]).to eq("One or more parameters are missing")
     end
   end
 end

 describe 'POST /foods#post' do
   context "post request valid" do
     before {
       valid_params = {
         :name => "White sugar",
         :edible_portion => 100,
         :code => "ISN234",
         :energy_value => 199,
         :category_id => @sugars.id,
         :composition => [
           {
             :component_id => @macro.id,
             :quantity => 12
           }
         ]
       }
       post "/foods", params: valid_params
     }

    it 'returns success code 201' do
      expect(response).to have_http_status(201)
    end
   end

   context 'post request invalid' do
     before {
       invalid_params = {
         :name => "White sugar"
       }
       post '/foods', params: invalid_params
     }

     it 'returns error code 422' do
       expect(response).to have_http_status(422)
     end

     it 'returns error message' do
       expect(json["message"]).to eq("One or more parameters are missing")
     end
   end
 end

 describe 'PUT /foods/:id#update' do
   context 'when the specific food exists' do
     before {
       update_params = {
         :name => "White sugar"
       }
       put "/foods/#{@yellow_sugar.id}", params: update_params
     }

     it 'returns success code 204' do
       expect(response).to have_http_status(204)
     end
   end

   context 'no such food in the system' do
     before {
       update_params = {
         :edible_portion => 98
       }
       put "/foods/-1", params: update_params
     }

     it 'returns error code 404' do
       expect(response).to have_http_status(404)
     end

     it 'returns error message' do
       expect(json["message"]).to eq("Couldn't find Food with 'id'=-1")
     end
   end
 end

 describe "DELETE /foods/:1" do
   context 'when the specific food exists' do
     before {
       delete "/foods/#{@yellow_sugar.id}"
     }

     it "returns success code 204" do
       expect(response).to have_http_status(204)
     end
   end

   context 'no such food in the system' do
     before {
       delete "/foods/-1"
     }

     it 'returns error code 404' do
       expect(response).to have_http_status(404)
     end

     it 'returns error message' do
       expect(json["message"]).to eq("Couldn't find Food with 'id'=-1")
     end
   end
 end
end
