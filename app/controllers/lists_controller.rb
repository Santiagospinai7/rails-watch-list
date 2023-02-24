class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @new_list = List.new(list_params)
    @new_list.save

    redirect_to lists_path
  end

  def show
    bookmarks = Bookmark.all
    @list_id = params[:id]
    @movies = bookmarks.select do |bookmark|
      bookmark.list["id"] == params[:id].to_i
    end
  end

  private 

  def list_params
    params.require(:list).permit(:name)
  end
end
