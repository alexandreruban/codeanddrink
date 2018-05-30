#require_relative '../services/validate_attempt_service'

class AttemptValidationJob < ApplicationJob
  queue_as :default

  def perform(attempt_id)

    attempt = Attempt.find(attempt_id)
    if attempt
      ValidateAttemptService.new(attempt).call
    end
  end
end
