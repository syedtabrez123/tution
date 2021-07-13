require 'rails_helper'

RSpec.describe Tutor, type: :model do
  it { should belong_to(:course) }
end
