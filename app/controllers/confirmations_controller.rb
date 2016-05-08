class ConfirmationsController < ApplicationController
  attr_accessor :user

  # GET /account/confirmation/new
  def new
    self.user = User.new
  end

  # POST /account/confirmation
  def create
    user_params = params.require(:user).permit(:email)
    self.user = User.find_by email: user_params[:email]

    if user && user.confirmed_at.blank?
      confirmation_token = user.regenerate_confirmation_digest
      # TODO: send email with confirmation token
      user.save!
    end

    flash[:success] = "If the user exists and requires confirmation, instructions have been re-sent."
    redirect_to root_path
  end

  # GET /account/confirmation?&user_id=1&confirmation_token=abcdef
  def show
    self.user = User.find_by(id: params[:user_id]) || User.new

    begin
      confirmation_authenticated = user.authenticate_confirmation_digest(params[:confirmation_token])
    rescue => e
      confirmation_authenticated = false
    end

    if confirmation_authenticated && (user.confirmed_at.blank? || user.unconfirmed_email.present?)
      if user.unconfirmed_email.present?
        user.assign_attributes \
          email: user.unconfirmed_email,
          unconfirmed_email: nil
      end
      user.assign_attributes \
        confirmed_at: Time.zone.now,
        confirmation_digest: nil
      user.save!
      flash[:success] = "Your account has been confirmed."
      redirect_to root_path
    else
      flash.now[:danger] = 'Unable to confirm account.'
      render :new, status: :unprocessable_entity
    end
  end
end
