class InformesController < ApplicationController
 def index
 @informes=Informes.all
 end
 
 def show
 #@informes=Informes.find(params[:id])
 end 
 def new
 
 end
 def create
 
 end
end
