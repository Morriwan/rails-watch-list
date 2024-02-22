class BookmarksController < ApplicationController

  def new
    @bookmark = Bookmark.new
    set_list
  end

  def create
  @bookmark = Bookmark.new(bookmark_params)
  set_list
  @bookmark.list = @list
    if @bookmark.save
      redirect_to list_path(@list)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @bookmark = Bookmark.find(params[:id])
    list_id = @bookmark.list.id
    @bookmark.destroy
    redirect_to list_path(list_id), status: :see_other
  end

  private
  def bookmark_params
    params.require(:bookmark).permit(:comment, :movie_id)
  end

  def set_list
    @list = List.find(params[:list_id])
  end
end
