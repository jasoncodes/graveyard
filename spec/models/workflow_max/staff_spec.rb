require 'spec_helper'

describe WorkflowMax::Staff do
  describe "retrieving by email" do
    use_vcr_cassette "workflow_max/staff/email", :record => :new_episodes

    it "should retrieve a staff record from a valid email" do
      actual = WorkflowMax::Staff.find_by_email 'lucas.willett@ennova.com.au'
      assert_not_nil actual
      assert_equal "Lucas Willett", actual.name
      assert_equal "13976", actual.id
    end

    it "should return nil when an invalid email is supplied" do
      actual = WorkflowMax::Staff.find_by_email 'fakey.mcfake@fakefake.com'
      assert_nil actual
    end

    it "should return nil when a partial email is supplied" do
      actual = WorkflowMax::Staff.find_by_email '@ennova.com.au'
      assert_nil actual
    end
  end

  describe "retrieving jobs for staff" do
    use_vcr_cassette "workflow_max/staff/jobs", :record => :new_episodes

    before do
      @staff = WorkflowMax::Staff.find_by_email 'lucas.willett@ennova.com.au'
    end

    it "should retrieve all jobs for a valid staff" do
      actual = @staff.jobs
      assert_not_nil actual
    end
  end
end
