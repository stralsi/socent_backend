require 'test_helper'

class EnterpriseTest < ActiveSupport::TestCase

  def setup
    OrganizationScope.current_organization_id = nil
  end

  test "Unscoped all should return all" do
    assert_equal 2, Enterprise.count
  end

  test "Scoped all should return scope" do
    bucuresti = organizations(:bucuresti)
    alba = organizations(:alba)
    one = enterprises(:one)
    two = enterprises(:two)
    with_organization bucuresti do
      assert_equal 1, Enterprise.count
      assert_raise ActiveRecord::RecordNotFound do
        Enterprise.find(one.id)
      end
      assert_not_nil Enterprise.find(two.id)
    end
    with_organization alba do
      assert_equal 1, Enterprise.count
      assert_not_nil Enterprise.find(one.id)
      assert_raise ActiveRecord::RecordNotFound do
        Enterprise.find(two.id)
      end
    end

  end

  test 'should save one headquarters' do
    enterprise = Enterprise.create headquarters: addresses(:one),
                                   name:'asdf', number: '123', application_date: '2017-01-01'
    refute_nil enterprise.headquarters
  end

  test 'should save many work locations' do
    enterprise = Enterprise.create work_locations: [addresses(:one), addresses(:two)],
                                   name:'asdf', number: '123', application_date: '2017-01-01'
    assert_equal 2, enterprise.work_locations.count
  end
end
