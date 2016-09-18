class Api::V1::NotesController < ApplicationController
	respond_to :json
  

  def create
  	note=Note.new(note_params)

  	if note.save
  		render json: note, status: 201
  	else
  		render json: "{error: 'User not found! Register now.'}", status: 422
  	end
  end

  private
  def note_params
  	params.require(:note).permit(:note1,:note2,:note3,:id_user)
  end
end
