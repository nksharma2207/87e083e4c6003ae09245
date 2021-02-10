class RobotController < ApplicationController
  before_action :get_operations, only: [:orders]

  def orders
    result = RobotOperationService.new.perform(@operations)
    render json: {location: result.map{ |key, val| val}}
  end

  private

  def get_operations
    if params[:commands].present?
      @operations = params[:commands]
    else
      render json: {message: 'Invalid command'}
    end
  end

end
