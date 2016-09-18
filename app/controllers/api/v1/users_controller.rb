class Api::V1::UsersController < ApplicationController
  respond_to :json
  skip_before_filter  :verify_authenticity_token
  

  def show

  	data = user_params
  	#data_parsed = JSON.parse(data)

  	if (id = User.where(email: data['email'])).exists?
  	#codigo todo bien, mas enviar todas las notas para ese usuario.
  	#User has_many notes
	  	notes = Note.where(id_user: id)

    #time
    time = Time.new
    t = time.strftime("%B %d, %Y")
	    render json: {user: id, notes: notes, date: t}, status: 201
	
  elsif (data['provider'] == 'Google') || (data['provider'] == 'Facebook')
      user=User.new(user_params)
      if user.save

        fuser = User.where(email: data['email'])
        notes = Note.where(id_user: fuser)
        #time
        time = Time.new
        t = time.strftime("%B %d, %Y")
        render json: {user: fuser, notes: notes, date: t}, status: 201
      else
        render json: '{error: "An error just occurred"}', status: 422
      end
  else
     
		render json: '{error: "User not found! Register now."}', status: 422
	end
  end



  # Creating users
  def create
    user=User.new(user_params)

    if user.save 
      render json: user, status: 201 
    else
      render json: { errors: user.errors}, status: 422
    end
  end


  private
  def user_params
  	params.require(:user).permit(:email, :password, :password_confirmation, :provider)
  end
end  