class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
  end

  def create
  end

  def show
    bookmarks = Bookmark.all
    @movies = bookmarks.select do |bookmark|
      bookmark.list["id"] == params[:id].to_i
    end
    
  end
end
