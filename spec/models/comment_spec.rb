require 'rails_helper'

describe Comment do
  it { should belong_to(:commentable) }

  it { should validate_presence_of(:commentable_id) }
  it { should validate_presence_of(:commentable_type) }
  it { should validate_presence_of(:user_name) }
  it { should validate_presence_of(:body) }
end
