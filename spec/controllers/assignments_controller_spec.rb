# == Schema Information
#
# Table name: assignments
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  image_id   :integer          not null
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_assignments_on_image_id  (image_id)
#  index_assignments_on_user_id   (user_id)
#

RSpec.describe AssignmentsController do
  let(:assignment) { build_stubbed(:assignment) }

  before do
    allow(Assignment).to receive(:find).with('1').and_return(assignment)
  end

  context "GET #index" do
    context "as an admin" do
      include_context "signed-in admin"
      before { get :index }
      it_behaves_like "a successful controller response"
    end

    context "as a non-admin" do
      include_context "signed-in editor"
      before { get :index }
      it_behaves_like "an unsuccessful controller response"
    end
  end

  context "GET #show" do
    context "as an admin" do
      include_context "signed-in admin"
      before { get :show, id: 1 }
      it_behaves_like "a successful controller response"
    end

    context "as a non-admin" do
      include_context "signed-in editor"
      before { get :show, id: 1 }
      it_behaves_like "an unsuccessful controller response"
    end
  end

  context "GET #new" do
    context "as an admin" do
      include_context "signed-in admin"
      before { get :new }
      it_behaves_like "a successful controller response"
    end

    context "as a non-admin" do
      include_context "signed-in editor"
      before { get :new }
      it_behaves_like "an unsuccessful controller response"
    end
  end

  context "GET #edit" do
    context "as an admin" do
      include_context "signed-in admin"
      before { get :edit, id: 1 }
      it_behaves_like "a successful controller response"
    end

    context "as a non-admin" do
      include_context "signed-in editor"
      before { get :edit, id: 1 }
      it_behaves_like "an unsuccessful controller response"
    end
  end

  context "POST #create" do
    let(:creation_params) do
      { "user_id" => "1", "image_id" => "1" }
    end

    before do
      allow(Assignment).to receive(:create).with(creation_params).and_return(assignment)
    end

    context "as an admin" do
      include_context "signed-in admin"

      before { post :create, assignment: creation_params }
      specify { expect(response).to redirect_to(assignment_path(assignment)) }
    end

    context "as a non-admin" do
      include_context "signed-in editor"

      before { post :create, assignment: creation_params }

      it_behaves_like "an unsuccessful controller response"

      it "does not allow an Assignment to be created" do
        expect(Assignment).not_to have_received(:create)
      end
    end
  end
end
