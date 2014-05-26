require "spec_helper"

describe UsersController do
  
  let(:user) { FactoryGirl.create(:user) }

  render_views
  
  describe "#new" do
    it "should render the signup template" do
      get :new
      expect(response).to render_template(:new)
    end

    it "should assigns @user to User.new" do
      get :new
      expect(assigns(:user)).to be_a_new User
    end
  end

  describe "#create" do
    subject {post :create, user: FactoryGirl.attributes_for(:user)}

    it "should create user valid attributes" do
      expect{post :create, user: FactoryGirl.attributes_for(:user)}.to change { User.count }.by(1)
    end

    xit "should redirect to profile page after creating user" do
      expect{ post :create, user: FactoryGirl.attributes_for(:user)
        }.to redirect_to(profile_path) 
    end

    xit "should not create user with invalid email" do
      expect {
        post :create, user: {username: user.username, email: '123@', password: 'password', password_confirmation: 'password'}
        
        }.to change { User.count }.by(0)
    end
  end


  describe "#edit" do
    before { session[:user_id] = user.id }

    it "is successful" do
      get :edit, id: user.id
      expect {
        put :edit, user: FactoryGirl.attributes_for(:user)
        expect(response).to be_success
        }
    end

    it "is unsuccessful" do
      get :edit, id: user.id
      expect {
        put :edit, user: {email: "bob@bob"}
        expect(response).to_not be_success
        }
    end

  end
end