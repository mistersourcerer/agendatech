class GadgetsController < ApplicationController
  respond_to :json

  def create
      evento = Evento.find(params[:evento])
      tipo = params[:tipo]
      quase_um_gadget = QuaseUmGadget.new(evento,tipo)
      if user_signed_in?
        @gadget = quase_um_gadget.associa current_user
        respond_with @gadget
      else
        #session[:quase_um_gadget] = quase_um_gadget
        redirect_to '/auth/twitter'
      end
  end
end
