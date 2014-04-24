require 'spec_helper'

describe Experience do

 let!(:exp1){ create(:experience) }
 let!(:exp2){ create(:experience) }
 let!(:exp3){ create(:experience) }
 let(:topic_tag) { create(:tag, :topic) }
 let(:language_tag) { create(:tag, :language) }

 describe '::order_by_level' do
  it 'returns an activerecord relation' do
    expect(Experience.order_by_level).to be_a(ActiveRecord::Relation)
  end

  it 'can return experiences in descending order by level' do
    expect(Experience.order_by_level.first.level).to be >(Experience.order_by_level.last.level)
  end
 end

  describe '::by_category' do
    it 'can return experiences only from topics' do
      exp1.update(:tag_id => topic_tag.id)
      exp2.update(:tag_id => topic_tag.id)
      exp3.update(:tag_id => language_tag.id)
      expect(Experience.by_category("topic")).to include(exp1)
      expect(Experience.by_category("topic").length).to eq(2)
      expect(Experience.by_category("topic")).to_not include(exp3)
    end
  end

  describe '#percent_to_next_level' do
    it 'can return percent progress to next level' do
      expect(exp1.percent_to_next_level).to be <(100)
    end
  end

end
