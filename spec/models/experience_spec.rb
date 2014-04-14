require 'spec_helper'

describe Experience do

 let(:exp){ create(:experience).tap{}}

  describe '#by_tag_category' do
    xit 'can return experiences only from topics' do
      expect(Experience.by_tag_category("topic")).to include(topic_tag)
    end
  end

  describe '#calculate_level' do
    it 'can return its current level' do
      expect(exp.calculate_level).to be_a(Integer)
    end

    it 'can return percent progress to next level' do
      expect(exp.percent_to_next_level).to be <(100)
    end
  end

end
