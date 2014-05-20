require 'spec_helper'
require 'pry'

describe ActivateMyDirectory do
  describe ".authenticate" do
    subject { described_class.authenticate(*credentials) }

    context "a correct username/password combination" do
      let(:credentials) { Get.credentials }
      it { should be_true }
    end

    context "an incorrect/username combination" do

      context "a nonexistent user" do
        let(:credentials) { ["fake_user", "fake_password"] }
        it { should be_false }
      end

      context "an actual user but a bad password" do
        let(:credentials) { [ Get.username, "fake_password"] }
        it { should be_false }
      end
    end
  end

  describe ".user_is_in_group?" do
    subject { described_class.user_is_in_group?(username, group) }

    context "user is in the group" do
      let(:username) { Get.username }
      let(:group) { "Autobahn" }
      it { should be_true }
    end

    context "user is not in the group" do
      let(:username) { Get.username }
      let(:group) { "Support" }
      it { should be_false }
    end
  end

  describe ".authenticate_and_is_in_group?" do
    subject { described_class.authenticate_and_is_in_group?(username, password, groupname) }

    context "user failed to authenticate" do
      let(:username) { "fake_username" }
      let(:password) { "fake_password" }
      let(:groupname)    { "Autobahn" }
      it { should be_false }
    end

    context "user is authenticated" do
      let(:username) { Get.username }
      let(:password) { Get.password }

      context "but not in group" do
        let(:groupname) { "Nonexistent Group" }
        it { should be_false }
      end

      context "but is in group" do
        let(:groupname) { "Autobahn" }
        it { should be_true }
      end
    end
  end
end
