class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update_xp]

  def show 
  end

  def edit
  end

  def update_xp
    client = Octokit::Client.new(:access_token => current_user.token)
    user = client.user

    all_repos = client.repos #array
    source_repos = user.rels[:repos].get.data #array

    languages_all_repos = get_language_info(all_repos)
    languages_source_repos = get_language_info(source_repos) #an array of hashes
    half_line_counts(languages_all_repos)

    @user.update_xp(languages_all_repos)
    @user.update_xp(languages_source_repos)
  end

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

  def half_line_counts(languages_array)
    self.each {|language, line_count| hash[language] = line_count / 2}
  end

end

