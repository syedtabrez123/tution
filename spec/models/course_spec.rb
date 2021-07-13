require 'rails_helper'

RSpec.describe Course, type: :model do
  it { should have_many(:tutors) }

  it { should validate_presence_of(:title) }
end
