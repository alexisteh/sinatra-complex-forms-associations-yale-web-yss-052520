class PetsController < ApplicationController

  get '/pets' do
    @pets = Pet.all
    erb :'/pets/index' 
  end 

  get '/pets/new' do 
    @owners = Owner.all 
    erb :'/pets/new'
  end

  post '/pets' do 
    name = params[:pet_name] 
    if params[:owner_id] && params[:owner_id] != "none"
      owner_num = params[:owner_id] 
    else 
      new_owner = Owner.create(name: params[:owner_name])  
      owner_num = new_owner.id 
    end 
    @pet = Pet.create(name: name) 
    @pet.update_attribute(:owner_id, owner_num) 
    redirect to "pets/#{@pet.id}" 
  end 

  get '/pets/:id' do 
    @pet = Pet.find(params[:id])
    erb :'/pets/show'
  end 

  get '/pets/:id/edit' do 
    @pet = Pet.find(params[:id])
    @owners = Owner.all 
    erb :'/pets/edit'
  end 

  patch '/pets/:id' do  
    name = params[:pet_name] 
    if params[:owner_name] != ""  
      new_owner = Owner.create(name: params[:owner_name])    
      owner_num = new_owner.id  
    else 
      owner_num = Owner.find_by(name: params[:owner][:name]).id 
    end 
    @pet = Pet.find(params[:id])  
    @pet.update_attribute(:owner_id, owner_num) 
    @pet.update_attribute(:name, name) 
    redirect to "pets/#{@pet.id}" 
  end

end