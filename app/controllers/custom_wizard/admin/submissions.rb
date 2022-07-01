# frozen_string_literal: true
class CustomWizard::AdminSubmissionsController < CustomWizard::AdminController
  skip_before_action :preload_json, :check_xhr, only: [:download]
  before_action :find_wizard, except: [:index]

  def index
    render json: ActiveModel::ArraySerializer.new(
      CustomWizard::Wizard.list(current_user),
      each_serializer: CustomWizard::BasicWizardSerializer
    )
  end

  def show
    render_json_dump(
      wizard: CustomWizard::BasicWizardSerializer.new(@wizard, root: false),
      submissions: ActiveModel::ArraySerializer.new(ordered_submissions, each_serializer: CustomWizard::SubmissionSerializer)
    )
  end

  def download
    send_data ordered_submissions.to_json,
      filename: "#{Discourse.current_hostname}-wizard-submissions-#{@wizard.name}.json",
      content_type: "application/json",
      disposition: "attachment"
  end

  protected

  def ordered_submissions
    CustomWizard::Submission.list(@wizard, order_by: 'id')
  end
end
