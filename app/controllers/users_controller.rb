class UsersController < ApplicationController  
  before_action :set_user, only: [:show, :update_xp]

  def show 
  end

  def update_xp
    client = Octokit::Client.new(:access_token => User.find_by(:nickname => params[:nickname]).token)
    user = client.user

    all_repos = client.repos #array
    source_repos = user.rels[:repos].get.data #array

    languages_all_repos = get_language_info(all_repos)
    languages_source_repos = get_language_info(source_repos) #an array of hashes
    languages_non_source_repos = languages_all_repos.reject {|language_hash| languages_source_repos.include?(language_hash) }
    reduce_line_counts(languages_non_source_repos)

    @user.clear_gh_stats
    @user.update_xp(languages_non_source_repos)
    @user.update_xp(languages_source_repos)

    respond_to do |format|
      format.html { redirect_to "/users/#{@user.nickname}", notice: 'Experience successfully calculated' }
      format.js {}
    end
  end

  # def edit
  # end

  # def update 
  #   @user = User.find_by(nickname: params[:nickname])
  #   @user.update(:email => params[:email])
  #   redirect_to root_path
  # end

  private
  def set_user
    @user = User.find_by(nickname: params[:nickname])
  end

  def get_language_info(repos_array)
    repos_array.map { |repo| repo.rels[:languages].get.data.to_hash }
  end

  def reduce_line_counts(languages_array)
    languages_array.reject! {|language_hash| language_hash == {}}
    languages_array.each do |language_hash|
      language_hash.each {|language, line_count| language_hash[language] = line_count / 2}
    end
  end

end

