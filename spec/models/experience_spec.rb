require 'spec_helper'

describe Experience do

  # let(:exp1){ create(:experience).tap{}}

  describe '#by_tag_category' do
    xit 'can return experiences only from topics' do
      expect(Experience.by_tag_category("topic")).to include(topic_tag)
    end
  end

end
